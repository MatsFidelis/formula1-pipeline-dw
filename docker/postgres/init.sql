-- ==========================================================
--  SCHEMA: silver
--  Descrição: Estrutura dimensional (modelo estrela) para
--  armazenar dados tratados (nível Silver) de Fórmula 1.
-- ==========================================================

CREATE SCHEMA IF NOT EXISTS silver;
SET search_path TO silver;

CREATE TABLE DIM_STATUS (
    status_sk        SERIAL PRIMARY KEY,
    status_id        VARCHAR(10) UNIQUE NOT NULL, -- Chave natural
    descricao_status VARCHAR(100)
);

CREATE TABLE DIM_CIRCUITO (
    circuito_sk      SERIAL PRIMARY KEY,
    circuito_id      VARCHAR(10) UNIQUE NOT NULL, -- Chave natural
    nome             VARCHAR(150),
    localidade       VARCHAR(100),
    pais             VARCHAR(100),
    latitude         NUMERIC,
    longitude        NUMERIC,
    altitude         NUMERIC
);

CREATE TABLE DIM_CONSTRUTOR (
    construtor_sk    SERIAL PRIMARY KEY,
    construtor_id    VARCHAR(10) UNIQUE NOT NULL, -- Chave natural
    nome             VARCHAR(150),
    nacionalidade    VARCHAR(100)
);

CREATE TABLE DIM_PILOTO (
    piloto_sk        SERIAL PRIMARY KEY,
    piloto_id        VARCHAR(10) UNIQUE NOT NULL, -- Chave natural
    nome             VARCHAR(100),
    sobrenome        VARCHAR(100),
    data_nascimento  DATE,
    nacionalidade    VARCHAR(100),
    codigo           VARCHAR(3)
);

CREATE TABLE DIM_CORRIDA (
    corrida_sk       SERIAL PRIMARY KEY,
    corrida_id       VARCHAR(10) UNIQUE NOT NULL, -- Chave natural
    circuito_sk      INTEGER REFERENCES DIM_CIRCUITO(circuito_sk) ON DELETE SET NULL,
    ano              INTEGER,
    rodada           INTEGER,
    nome_gp          VARCHAR(255),
    data_gp          DATE,
    tipo_evento      VARCHAR(50)
);

CREATE TABLE DIM_QUALIFICACAO (
    qualificacao_sk  SERIAL PRIMARY KEY,
    qualify_id       VARCHAR(10) UNIQUE NOT NULL, -- Chave natural (DD no Fato)
    corrida_id       VARCHAR(10) NOT NULL,
    piloto_id        VARCHAR(10) NOT NULL,
    posicao_grid     INTEGER,
    tempo_q1         VARCHAR(20),
    tempo_q2         VARCHAR(20),
    tempo_q3         VARCHAR(20)
);

CREATE TABLE FATO_RESULTADOS_CORRIDA (
    resultado_sk            SERIAL PRIMARY KEY,

    corrida_sk              INTEGER NOT NULL REFERENCES DIM_CORRIDA(corrida_sk) ON DELETE CASCADE,
    piloto_sk               INTEGER REFERENCES DIM_PILOTO(piloto_sk) ON DELETE SET NULL,
    construtor_sk           INTEGER REFERENCES DIM_CONSTRUTOR(construtor_sk) ON DELETE SET NULL,
    status_sk               INTEGER REFERENCES DIM_STATUS(status_sk) ON DELETE SET NULL,
    qualificacao_sk         VARCHAR(10), -- Dimensão degenerada (chave natural)

    grid                    INTEGER,
    rank                    INTEGER,

    pontos                  NUMERIC(5, 2),
    posicao_final_ordenada  INTEGER,
    voltas_completadas      INTEGER,
    tempo_total_ms          NUMERIC,
    volta_mais_rapida       INTEGER,
    velocidade_maxima       NUMERIC(7, 3),
    is_sprint               INTEGER,

    resultado_brz_id_auditoria INTEGER
);

CREATE TABLE FATO_PONTUACAO_CAMPEONATO (
    posicao_sk              SERIAL PRIMARY KEY,

    corrida_sk              INTEGER NOT NULL REFERENCES DIM_CORRIDA(corrida_sk) ON DELETE CASCADE,
    piloto_sk               INTEGER REFERENCES DIM_PILOTO(piloto_sk) ON DELETE SET NULL,
    construtor_sk           INTEGER REFERENCES DIM_CONSTRUTOR(construtor_sk) ON DELETE SET NULL,

    total_pontos            NUMERIC(6, 2),
    posicao_campeonato      INTEGER,
    total_vitorias          INTEGER
);

-- ==========================================================
--  COMENTÁRIOS
-- ==========================================================

COMMENT ON SCHEMA silver IS 'Camada Silver - Dados tratados e estruturados para análises de F1.';
COMMENT ON TABLE DIM_STATUS IS 'Dimensão de status das corridas.';
COMMENT ON TABLE DIM_CIRCUITO IS 'Dimensão de circuitos de Fórmula 1.';
COMMENT ON TABLE DIM_CONSTRUTOR IS 'Dimensão de construtores (equipes).';
COMMENT ON TABLE DIM_PILOTO IS 'Dimensão de pilotos.';
COMMENT ON TABLE DIM_CORRIDA IS 'Dimensão de corridas (eventos de GP).';
COMMENT ON TABLE DIM_QUALIFICACAO IS 'Dimensão de sessões de qualificação.';
COMMENT ON TABLE FATO_RESULTADOS_CORRIDA IS 'Tabela fato com resultados detalhados das corridas.';
COMMENT ON TABLE FATO_PONTUACAO_CAMPEONATO IS 'Tabela fato com pontuações agregadas por corrida e piloto/construtor.';
