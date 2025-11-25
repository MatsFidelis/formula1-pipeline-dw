DROP SCHEMA IF EXISTS dw CASCADE;
CREATE SCHEMA dw;

CREATE TABLE dw.DIM_PILOTO (
    piloto_pk BIGINT PRIMARY KEY, 
    driver_ref TEXT NOT NULL,
    code TEXT,
    forename TEXT,
    surname TEXT,
    dob DATE,
    nationality TEXT
);

CREATE TABLE dw.DIM_EQUIPE (
    equipe_pk BIGINT PRIMARY KEY, 
    constructor_ref TEXT NOT NULL,
    name TEXT,
    nationality TEXT
);

CREATE TABLE dw.DIM_CIRCUITO (
    circuito_pk BIGINT PRIMARY KEY, 
    circuit_ref TEXT NOT NULL,
    name TEXT,
    location TEXT,
    country TEXT,
    lat DOUBLE PRECISION,
    lng DOUBLE PRECISION,
    alt INT
);

CREATE TABLE dw.DIM_STATUS (
    status_pk BIGINT PRIMARY KEY,
    status TEXT NOT NULL
);

CREATE TABLE dw.DIM_CORRIDA (
    corrida_pk BIGINT PRIMARY KEY, 
    year INT NOT NULL,
    round INT,
    circuit_id BIGINT,             
    name TEXT,
    date DATE,
    time TEXT
);

CREATE TABLE dw.FAT_RESULTADOS (
    resultado_pk BIGINT PRIMARY KEY,
    
    srk_corrida_fk BIGINT NOT NULL, 
    srk_piloto_fk BIGINT NOT NULL,  
    srk_equipe_fk BIGINT NOT NULL,  
    srk_status_fk BIGINT NOT NULL,   
    
    grid INT,
    position_order INT,
    points DOUBLE PRECISION,
    laps INT,
    milliseconds BIGINT,             
    rank TEXT,
        
    CONSTRAINT fk_corrida
        FOREIGN KEY (srk_corrida_fk)
        REFERENCES dw.DIM_CORRIDA (corrida_pk)
        ON DELETE RESTRICT,
        
    CONSTRAINT fk_piloto
        FOREIGN KEY (srk_piloto_fk)
        REFERENCES dw.DIM_PILOTO (piloto_pk)
        ON DELETE RESTRICT,
        
    CONSTRAINT fk_equipe
        FOREIGN KEY (srk_equipe_fk)
        REFERENCES dw.DIM_EQUIPE (equipe_pk)
        ON DELETE RESTRICT,
        
    CONSTRAINT fk_status
        FOREIGN KEY (srk_status_fk)
        REFERENCES dw.DIM_STATUS (status_pk)
        ON DELETE RESTRICT
);