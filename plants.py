__emulation_mode__ = False

import re
import time
import sqlite3
if not __emulation_mode__: import RPi.GPIO as GPIO
from flask import Flask, g, request, url_for, render_template


lights = [2,3,17,27]
on_times = ["18:00", "18:00", "18:00", "18:00"]
off_times = ["10:00", "10:00", "10:00", "10:00"]

app = Flask(__name__)

DATABASE = './database.db'

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
    return db

@app.teardown_appcontext
def close_connection(exception):
    db = getattr(g, '_database', None)
    if db is not None:
        db.close()

def get_temperature():
    if __emulation_mode__:
        return 24.7
    else:
        f = open("/sys/bus/w1/devices/28-0417c1dab8ff/w1_slave", "r")
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

def initialize_pi():
    if not __emulation_mode__:
        GPIO.setmode(GPIO.BCM)
        GPIO.setup(lights, GPIO.OUT)
        GPIO.output(lights, GPIO.LOW)

def cleanup_pi():
    if not __emulation_mode__:
        GPIO.cleanup()

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
    for k in request.form.keys():
        print("k: "+ str(k) + "v: "+str(request.form[k]))
    if 'pin' in request.form:
        pin = int(request.form['pin'])
        toggle_pin(pin)
    else:
        for i,_ in enumerate(lights):
            on_times[i] = request.form['autoon_'+str(i)]
            off_times[i] = request.form['autooff_'+str(i)]
    return mainpage()

def toggle_pin(pin):
    GPIO.output(pin, not GPIO.input(pin))

if __name__ == "__main__":
    initialize_pi()
    app.run('0.0.0.0')
    cleanup_pi()
