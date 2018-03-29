__emulation_mode__ = False
import os
import re
import time
import signal
import sqlite3
import logging
import datetime
import time, threading

try:
    import RPi.GPIO as GPIO
except ImportError:
    __emulation_mode__ = True

from flask import Flask, g, request, url_for, render_template

app = Flask(__name__)
worker_thread = None
logging.basicConfig(level=10)
DATABASE = './database.db'


###### DB STUFF #######

def init_db():
    with app.app_context():
        db = get_db()
        with app.open_resource('schema.sql', mode='r') as f:
            db.cursor().executescript(f.read())
        db.commit()

def get_db():
    db = getattr(g, '_database', None)
    if db is None:
        db = g._database = sqlite3.connect(DATABASE)
        db.row_factory = sqlite3.Row
    return db

def query_db(query, args=(), one=False):
    cur = get_db().execute(query, args)
    rv = cur.fetchall()
    cur.close()
    return (rv[0] if rv else None) if one else rv

def insert_db(table, fields=(), values=()):
    db = get_db()
    cur = db.cursor()
    query = 'INSERT INTO %s (%s) VALUES (%s)' % (
        table,
        ', '.join(fields),
        ', '.join(['?'] * len(values))
    )
    cur.execute(query, values)
    db.commit()
    id = cur.lastrowid
    cur.close()
    return id

@app.teardown_appcontext
def close_connection(exception):
    db = getattr(g, '_database', None)
    if db is not None:
        db.close()

###################### END DB STUFF ###############


########### HW INTERFACE ################

def get_temperature(fpath):
    if __emulation_mode__:
        return 24.7
    else:
        f = open(fpath, "r")
        contents = f.read()
        f.close()
        m = re.search("t=(\d+)", contents)
        if m is not None:
            result = m.group(1)
            return int(result)/1000


def get_time():
    return time.strftime("HH:MM", time.gmtime())

def get_pin_state(pin):
    if __emulation_mode__:
        return 0
    else:
        return GPIO.input(pin)

def toggle_pin(pin):
    if __emulation_mode__ != True:
        GPIO.output(pin, not GPIO.input(pin))

def initialize_pi():
    if not __emulation_mode__:
        with app.app_context():
            GPIO.setmode(GPIO.BCM)
            lights = build_lights_state(assume_off=True)
            for l in lights:
                initial_state = GPIO.HIGH
                if l['high_active']:
                    initial_state = GPIO.LOW
                GPIO.setup( l['pin'], GPIO.OUT)
                GPIO.output(l['pin'], initial_state)
            fans = build_fans_state(assume_off=True)
            for f in fans:
                GPIO.setup( f['pin'], GPIO.OUT)
                GPIO.output(f['pin'], GPIO.LOW)

def cleanup_pi():
    if not __emulation_mode__:
        GPIO.cleanup()


############ END HW INTERFACE ##################


def build_current_state():
    state = {
        "lights"       : build_lights_state(),
        "fans"         : build_fans_state(),
        "humidities"   : build_humidity_state(),
        "temperatures" : build_temperature_state(),
    }
    return state

def build_lights_state(assume_off=False):
    # Use assume_off=True to avoid interaction with HW, i.e., to just get the
    # pins during setup.
    lights_state = []
    for light in query_db('select * from lights'):
        on = False
        if assume_off == False:
            on = bool(get_pin_state(light['pin'])) == \
                 bool(light['high_active'])
        light_state = {
            "id"          : light['id'],
            "on"          : on, 
            "pin"         : light['pin'],
            "high_active" : light['high_active'],
            "auto_on"     : light['auto_on'],
            "auto_off"    : light['auto_off']
        }
        lights_state.append(light_state)
    return lights_state

def build_fans_state(assume_off=False):
    fans_state = []
    for fan in query_db('select * from fans'):
        on = False
        if assume_off == False:
            on = bool(get_pin_state(fan['pin'])) 
        fan_state = {
            "id"      : fan['id'],
            "on"      : on,
            "pin"     : fan['pin']
        }
        fans_state.append(fan_state)
    return fans_state

def build_temperature_state():
    temps_state = []
    for temp in query_db('select * from temperature_sensors'):
        temp_state = {
            "id"    : temp['id'],
            "fpath" : temp['fpath'],
            "temp"  : get_last_temp_from_db()
        }
        temps_state.append(temp_state)
    return temps_state


def build_humidity_state():
    humiditys_state = []
    for hum in query_db('select * from humidity_sensors'):
        hum_state = {
            "id"       : hum['id'],
            "pin"      : hum['sense_pin'],
            "humidity" : get_last_hum_from_db()
        }
        humiditys_state.append(hum_state)
    return humiditys_state

def get_last_temp_from_db():
    q = 'select temperature from temperatures order by id desc limit 1;'
    t = query_db(q)
    val = t[0]['temperature']
    return val
    


@app.route('/')
def mainpage(name=None):
    return render_template('index.html', currstate=build_current_state())

@app.route('/light', methods=['GET', 'POST'])
def light():
    if 'pin' in request.form:
        pin = int(request.form['pin'])
        toggle_pin(pin)
    return mainpage()

def sighandler(signum, frame):
    logging.warning("Received signal " + str(signum) + ", shutting down")
    if worker_thread is not None:
        worker_thread.cancel()
    cleanup_pi()
    os._exit(0)

def periodic_work():
    logging.info("Periodic worker worke up")
    with app.app_context():

        # toggle the lights if we need to
        for light in query_db('select * from lights'):
            now = datetime.datetime.now().time()
            on = datetime.datetime.strptime(light['auto_on'], '%H:%M').time()
            off = datetime.datetime.strptime(light['auto_off'], '%H:%M').time()
            should_be_on = False
            if on < off:
                should_be_on = ((on < now) and (now < off))
            elif on > off:
                should_be_on = ((now < off) or (now > on))
            pin_should_be = (should_be_on == bool(light['high_active']))
            if bool(get_pin_state(light['pin'])) != pin_should_be:
                logging.info("Toggling light pin " + str(light['pin']))
                toggle_pin(light['pin'])

        # insert the temperature into the database
        for sensor in query_db('select * from temperature_sensors'):
            fname = sensor['fpath']
            temp = float(get_temperature(fname))
            insert_db("temperatures", ("sensor_id", "time", "temperature"),
                     (sensor['id'], str(datetime.datetime.now()), temp))

        # turn on the fan (based on an hourly schedule) or if the temperature
        # is above a certain threshold
        # TODO

        # read the humidity sensor and put the value into the database
        # TODO

    worker_thread = threading.Timer(10, periodic_work).start()




if __name__ == "__main__":
    initialize_pi()
    periodic_work()
    signal.signal(signal.SIGINT, sighandler)
    app.run('0.0.0.0')
    cleanup_pi()
