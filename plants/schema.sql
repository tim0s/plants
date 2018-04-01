DROP TABLE IF EXISTS lights;
DROP TABLE IF EXISTS temperature_sensors;
DROP TABLE IF EXISTS temperatures;
DROP TABLE IF EXISTS fans;
DROP TABLE IF EXISTS fan_config;
DROP TABLE IF EXISTS humidities;
DROP TABLE IF EXISTS humidity_sensors;


CREATE TABLE lights (
	id INTEGER PRIMARY KEY NOT NULL UNIQUE,
	pin INTEGER,
	high_active BOOLEAN,
	auto_on TEXT,
	auto_off TEXT,
	description TEXT
);

CREATE TABLE temperature_sensors(
	id INTEGER PRIMARY KEY NOT NULL UNIQUE,
	fpath TEXT,
	description TEXT
);

CREATE TABLE humidity_sensors(
	id INTEGER PRIMARY KEY NOT NULL UNIQUE,
	power_pin INTEGER,
	sense_pin INTEGER,
	description TEXT
);

CREATE TABLE humidities(
	id INTEGER PRIMARY KEY NOT NULL UNIQUE,
	sensor_id INTEGER,
	time TEXT,
	humidity REAL,
	FOREIGN KEY(sensor_id) REFERENCES humidity_sensors(id)
);

CREATE TABLE temperatures(
	id INTEGER PRIMARY KEY NOT NULL UNIQUE,
	sensor_id INTEGER,
	time TEXT,
	temperature REAL,
	FOREIGN KEY(sensor_id) REFERENCES temperature_sensors(id)
);

CREATE TABLE fans(
	id INTEGER PRIMARY KEY NOT NULL UNIQUE,
	pin INTEGER,
	description TEXT
);

CREATE TABLE fan_config(
	id INTEGER PRIMARY KEY,
	fan_id INTEGER,
	temp_thresh REAL,
	thresh_sensor INTEGER,
	hourly_time INTEGER,
	FOREIGN KEY(fan_id) REFERENCES fans(id)
	FOREIGN KEY(thresh_sensor) REFERENCES temperature_sensors(id)
);


INSERT INTO lights (id, pin, high_active, auto_on, auto_off, description)
       VALUES (1,  2, 0, "18:00", "10:00", "Ikea Lamp front-left");
INSERT INTO lights (id, pin, high_active, auto_on, auto_off, description)
       VALUES (2,  3, 0, "18:00", "10:00", "Ikea Lamp front-right");
INSERT INTO lights (id, pin, high_active, auto_on, auto_off, description)
       VALUES (3, 17, 0, "18:00", "10:00", "Ikea Lamp back-left");
INSERT INTO lights (id, pin, high_active, auto_on, auto_off, description)
       VALUES (4, 27, 0, "18:00", "10:00", "Ikea Lamp back-right");

INSERT INTO temperature_sensors (id, fpath, description)
       VALUES (1, "/sys/bus/w1/devices/28-0417c1dab8ff/w1_slave", "");

INSERT INTO fans (id, pin, description) VALUES (1, 20, "Intake fan");
INSERT INTO fans (id, pin, description) VALUES (2, 21, "Exhaust fan");

INSERT INTO fan_config (id, fan_id, temp_thresh, thresh_sensor, hourly_time)
       VALUES (1, 1, 27.0, 1, 15);
INSERT INTO fan_config (id, fan_id, temp_thresh, thresh_sensor, hourly_time)
       VALUES (2, 2, 27.0, 1, 15);
