DROP SCHEMA IF EXISTS silver CASCADE;

CREATE SCHEMA IF NOT EXISTS silver;

CREATE TABLE silver.circuits_silver (
    circuit_id INT PRIMARY KEY,
    circuit_ref TEXT NOT NULL,
    name TEXT NOT NULL,
    location TEXT,
    country TEXT,
    lat DOUBLE PRECISION,
    lng DOUBLE PRECISION,
    alt INT
);

CREATE TABLE silver.constructors_silver (
    constructor_id INT PRIMARY KEY,
    constructor_ref TEXT NOT NULL,
    name TEXT NOT NULL,
    nationality TEXT
);

CREATE TABLE silver.drivers_silver (
    driver_id INT PRIMARY KEY,
    driver_ref TEXT NOT NULL,
    number INT,
    code TEXT,
    forename TEXT NOT NULL,
    surname TEXT NOT NULL,
    dob DATE,
    nationality TEXT
);

CREATE TABLE silver.status_silver (
    status_id INT PRIMARY KEY,
    status TEXT NOT NULL
);

CREATE TABLE silver.races_silver (
    race_id INT PRIMARY KEY,
    year INT NOT NULL,
    round INT,
    circuit_id INT,
    name TEXT NOT NULL,
    date DATE,
    time TEXT
);

CREATE TABLE silver.seasons_silver (
    year INT PRIMARY KEY
);

CREATE TABLE silver.results_silver (
    result_id INT PRIMARY KEY,
    race_id INT NOT NULL,
    driver_id INT NOT NULL,
    constructor_id INT NOT NULL,
    number INT,
    grid INT,
    position TEXT,
    position_text TEXT,
    position_order INT,
    points DOUBLE PRECISION,
    laps INT,
    time TEXT,
    milliseconds INT,
    fastest_lap TEXT,
    rank TEXT,
    fastest_lap_time TEXT,
    fastest_lap_speed TEXT,
    status_id INT
);

CREATE TABLE silver.constructor_results_silver (
    constructor_results_id INT PRIMARY KEY,
    race_id INT NOT NULL,
    constructor_id INT NOT NULL,
    points DOUBLE PRECISION,
    status TEXT
);

CREATE TABLE silver.driver_standings_silver (
    driver_standings_id INT PRIMARY KEY,
    race_id INT NOT NULL,
    driver_id INT NOT NULL,
    points DOUBLE PRECISION,
    position INT,
    position_text TEXT,
    wins INT
);

CREATE TABLE silver.constructor_standings_silver (
    constructor_standings_id INT PRIMARY KEY,
    race_id INT NOT NULL,
    constructor_id INT NOT NULL,
    points DOUBLE PRECISION,
    position INT,
    position_text TEXT,
    wins INT
);

CREATE TABLE silver.qualifying_silver (
    qualify_id INT PRIMARY KEY,
    race_id INT NOT NULL,
    driver_id INT NOT NULL,
    constructor_id INT NOT NULL,
    number INT,
    position INT,
    q1 TEXT,
    q2 TEXT,
    q3 TEXT
);

CREATE TABLE silver.sprint_results_silver (
    result_id INT PRIMARY KEY,
    race_id INT NOT NULL,
    driver_id INT NOT NULL,
    constructor_id INT NOT NULL,
    number INT,
    grid INT,
    position TEXT,
    position_text TEXT,
    position_order INT,
    points DOUBLE PRECISION,
    laps INT,
    time TEXT,
    milliseconds INT,
    fastest_lap TEXT,
    fastest_lap_time TEXT,
    status_id INT
);

CREATE TABLE silver.lap_times_silver (
    race_id INT NOT NULL,
    driver_id INT NOT NULL,
    lap INT NOT NULL,
    position INT,
    time TEXT,
    milliseconds INT,
    PRIMARY KEY (race_id, driver_id, lap)
);

CREATE TABLE silver.pit_stops_silver (
    race_id INT NOT NULL,
    driver_id INT NOT NULL,
    stop INT NOT NULL,
    lap INT,
    time TEXT,
    duration TEXT,
    milliseconds INT,
    PRIMARY KEY (race_id, driver_id, stop)
);