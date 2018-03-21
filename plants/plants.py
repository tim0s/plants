__emulation_mode__ = True

import re
import time
import sqlite3
if not __emulation_mode__: import RPi.GPIO as GPIO
from flask import Flask, g, request, url_for, render_template
import datetime
import time, threading

app = Flask(__name__)
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
    GPIO.output(pin, not GPIO.input(pin))

def initialize_pi():
    if not __emulation_mode__:
        GPIO.setmode(GPIO.BCM)
        GPIO.setup(lights, GPIO.OUT)
        GPIO.output(lights, GPIO.LOW)

def cleanup_pi():
    if not __emulation_mode__:
        GPIO.cleanup()


############ END HW INTERFACE ##################

def get_lights_info():
    light_info = []
    for i,l in enumerate(lights):
        d = {}
        d['index'] = i
        d['pin'] = l
        d['state'] = get_pin_state(l)
        d['on_time'] = "18:00"
        d['off_time'] = "12:00"
        light_info.append(d)
    return light_info

@app.route('/')
def mainpage(name=None):
    return render_template('index.html', currtemp=get_temperature(),
                           currtime=get_time(), lights=get_lights_info())

@app.route('/light', methods=['GET', 'POST'])
def light():
    if 'pin' in request.form:
        pin = int(request.form['pin'])
        toggle_pin(pin)
    else:
        for i,_ in enumerate(lights):
            on_times[i] = request.form['autoon_'+str(i)]
            off_times[i] = request.form['autooff_'+str(i)]
    return mainpage()


def periodic_work():
    now = datetime.datetime.now().time()
    with app.app_context():

        # toggle the lights if we need to
        for light in query_db('select * from lights'):
            on = datetime.datetime.strptime(light['auto_on'], '%H:%M').time()
            off = datetime.datetime.strptime(light['auto_off'], '%H:%M').time()
            should_be_on = False
            if on < off:
                should_be_on = ((on < now) and (now < off))
            elif off > on:
                should_be_on = ((now < off) or (on < now))
            pin_should_be = (should_be_on != bool(light['high_active']))
            toggle_pin = bool(get_pin_state(light['pin'])) != pin_should_be
            if toggle_pin:
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

    # TODO make this exit cleanly on sig kill
    threading.Timer(10, periodic_work).start()

periodic_work()



if __name__ == "__main__":
    initialize_pi()
    app.run('0.0.0.0')
    cleanup_pi()
