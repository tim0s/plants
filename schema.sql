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
	pin INTEGER,
	description TEXT
);

CREATE TABLE temperatures(
	id INTEGER PRIMARY KEY NOT NULL UNIQUE,
	sensor_id INTEGER,
	time TEXT,
	temperature REAL,
	FOREIGN KEY(sensor_id) REFERENCES temperature_sensors(id)
);

CREATE TABLE light_events(
	id INTEGER PRIMARY KEY NOT NULL UNIQUE,
	light_id INTEGER,
	on_off TEXT,
	time TEXT,
	FOREIGN KEY(light_id) REFERENCES lights(id)
);

CREATE TABLE fans(
	id INTEGER PRIMARY KEY NOT NULL UNIQUE,
	pin INTEGER,
	description TEXT
);

CREATE TABLE fan_config(
	id INTEGER PRIMARY KEY,
	fan_id INTEGER,
	temperature REAL,
	intensity REAL,
	FOREIGN KEY(fan_id) REFERENCES fans(id)
);

CREATE TABLE users(
	id INTEGER PRIMARY KEY NOT NULL UNIQUE,
	name TEXT,
	passwd TEXT,
	admin BOOLEAN
);

