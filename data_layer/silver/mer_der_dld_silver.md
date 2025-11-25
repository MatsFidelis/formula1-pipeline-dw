# Modelo Entidade Relacionamento (MER)

### Entidades

circuits_silver

constructor_results_silver

constructor_standings_silver

constructors_silver

driver_standings_silver

drivers_silver

lap_times_silver

pit_stops_silver

qualifying_silver

races_silver

results_silver

seasons_silver

sprint_results_silver

status_silver

### Atributos

### circuits_silver
- alt (integer)
- circuit_id (integer)
- circuit_ref (text)
- country (text)
- lat (double precision)
- lng (double precision)
- location (text)
- name (text)

### constructor_results_silver
- constructor_id (integer)
- constructor_results_id (integer)
- points (double precision)
- race_id (integer)
- status (text)

### constructor_standings_silver
- constructor_id (integer)
- constructor_standings_id (integer)
- points (double precision)
- position (integer)
- position_text (text)
- race_id (integer)
- wins (integer)

### constructors_silver
- constructor_id (integer)
- constructor_ref (text)
- name (text)
- nationality (text)

### driver_standings_silver
- driver_id (integer)
- driver_standings_id (integer)
- points (double precision)
- position (integer)
- position_text (text)
- race_id (integer)
- wins (integer)

### drivers_silver
- code (text)
- dob (date)
- driver_id (integer)
- driver_ref (text)
- forename (text)
- nationality (text)
- number (integer)
- surname (text)

### lap_times_silver
- driver_id (integer)
- lap (integer)
- milliseconds (integer)
- position (integer)
- race_id (integer)
- time (text)

### pit_stops_silver
- driver_id (integer)
- duration (text)
- lap (integer)
- milliseconds (integer)
- race_id (integer)
- stop (integer)
- time (text)

### qualifying_silver
- constructor_id (integer)
- driver_id (integer)
- number (integer)
- position (integer)
- q1 (text)
- q2 (text)
- q3 (text)
- qualify_id (integer)
- race_id (integer)

### races_silver
- circuit_id (integer)
- date (date)
- name (text)
- race_id (integer)
- round (integer)
- time (text)
- year (integer)

### results_silver
- constructor_id (integer)
- driver_id (integer)
- fastest_lap (text)
- fastest_lap_speed (text)
- fastest_lap_time (text)
- grid (integer)
- laps (integer)
- milliseconds (integer)
- number (integer)
- points (double precision)
- position (text)
- position_order (integer)
- position_text (text)
- race_id (integer)
- rank (text)
- result_id (integer)
- status_id (integer)
- time (text)

### seasons_silver
- year (integer)

### sprint_results_silver
- constructor_id (integer)
- driver_id (integer)
- fastest_lap (text)
- fastest_lap_time (text)
- grid (integer)
- laps (integer)
- milliseconds (integer)
- number (integer)
- points (double precision)
- position (text)
- position_order (integer)
- position_text (text)
- race_id (integer)
- result_id (integer)
- status_id (integer)
- time (text)

### status_silver
- status (text)
- status_id (integer)
