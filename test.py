import time
import RPi.GPIO as GPIO
from flask import Flask, request, url_for

lights = [2,3,4,17]
on_times = ["18:00", "18:00", "18:00", "18:00"]
off_times = ["10:00", "10:00", "10:00", "10:00"]

app = Flask(__name__)

@app.route('/')
def mainpage(name=None):
    header = "<html><title> Tiola Plant Management</title>\n<body>\n"
    form = "<form action=\"/light\" method=\"post\">\n"
    form += "<table><tr><th>On/Off</th> <th>Auto-On</th> <th>Auto-Off</th></tr>"
    for i,l in enumerate(lights):
        form += "<tr>"
        form += "<td><button type=\"submit\" name=\"pin\" value=\""+str(l)+"\">\n"
        if GPIO.input(int(l)):
            form += "<img height=\"100\" src=\"" + url_for('static', filename="light_on.png") + "\" />\n"
        else:
            form += "<img height=\"100\" src=\"" + url_for('static', filename="light_off.png") + "\">\n"
        form += "Light "+str(i)+"\n</button></td>\n"
        form += "<td><input onChange=\"this.form.submit()\" type=\"time\" height=\"100\" name=\"autoon_" + \
                 str(i) + "\" value=\"" + on_times[i] + "\" size=\"8\" maxlength=\"8\"></td>"
        form += "<td><input onChange=\"this.form.submit()\" type=\"time\" height=\"100\" name=\"autooff_" + \
                str(i) + "\" value=\"" + off_times[i] + "\" size=\"8\" maxlength=\"8\"></td>"
    form += "</table>"
    time += "Current Time: " + time.strftime("%H:%M:%S", time.gmtime()) + "<br />\n"
    footer = "</body>\n"
    return header + form + footer

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

def toggle_pin(pin):
    GPIO.output(pin, not GPIO.input(pin))

if __name__ == "__main__":
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(lights, GPIO.OUT)
    GPIO.output(lights, GPIO.LOW)
    app.run('0.0.0.0')
    GPIO.cleanup()
