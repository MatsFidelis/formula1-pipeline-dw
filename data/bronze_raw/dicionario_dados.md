# Dicionário de Dados - Formula 1 World Championship (1950-2024)

## constructor_standings.csv

### Visão Geral

Posições e pontos dos construtores por corrida.

### Estrutura Geral

| Característica | Detalhe |
|---|---|
| **Formato** | CSV |
| **Encoding** | UTF-8 |
| **Separador** | ',' |
| **Total de Colunas** | 7 |
| **Total de Registros** | 13391 |

### Campos do Dicionário

| Campo | Tipo de Dado (Pandas) | Descrição |
|---|---|---|
| `constructorStandingsId` | `int64` | Chave primária. Identificador único da classificação do construtor. |
| `raceId` | `int64` | Chave estrangeira. Identificador único da corrida. |
| `constructorId` | `int64` | Chave estrangeira. Identificador único do construtor. |
| `points` | `float64` | Total de pontos acumulados pelo construtor até aquela corrida. |
| `position` | `int64` | Posição na classificação do campeonato de construtores após a corrida. |
| `positionText` | `object` | Posição na classificação em formato de texto. |
| `wins` | `int64` | Número de vitórias do construtor até aquela corrida. |

---
## constructors.csv

### Visão Geral

Detalhes sobre os construtores (equipes), como nome e nacionalidade.

### Estrutura Geral

| Característica | Detalhe |
|---|---|
| **Formato** | CSV |
| **Encoding** | UTF-8 |
| **Separador** | ',' |
| **Total de Colunas** | 5 |
| **Total de Registros** | 212 |

### Campos do Dicionário

| Campo | Tipo de Dado (Pandas) | Descrição |
|---|---|---|
| `constructorId` | `int64` | Chave primária. Identificador único do construtor. |
| `constructorRef` | `object` | Referência única para o construtor (usada em URLs, etc.). |
| `name` | `object` | Nome oficial do construtor. |
| `nationality` | `object` | Nacionalidade do construtor. |
| `url` | `object` | Link para a página do construtor na Wikipedia. |

---
## driver_standings.csv

### Visão Geral

Posições e pontos dos pilotos por corrida.

### Estrutura Geral

| Característica | Detalhe |
|---|---|
| **Formato** | CSV |
| **Encoding** | UTF-8 |
| **Separador** | ',' |
| **Total de Colunas** | 7 |
| **Total de Registros** | 34863 |

### Campos do Dicionário

| Campo | Tipo de Dado (Pandas) | Descrição |
|---|---|---|
| `driverStandingsId` | `int64` | Chave primária. Identificador único da classificação do piloto. |
| `raceId` | `int64` | Chave estrangeira. Identificador único da corrida. |
| `driverId` | `int64` | Chave estrangeira. Identificador único do piloto. |
| `points` | `float64` | Total de pontos acumulados pelo piloto até aquela corrida. |
| `position` | `int64` | Posição na classificação do campeonato de pilotos após a corrida. |
| `positionText` | `object` | Posição na classificação em formato de texto. |
| `wins` | `int64` | Número de vitórias do piloto até aquela corrida. |

---
## drivers.csv

### Visão Geral

Detalhes sobre os pilotos, como nome, data de nascimento e nacionalidade.

### Estrutura Geral

| Característica | Detalhe |
|---|---|
| **Formato** | CSV |
| **Encoding** | UTF-8 |
| **Separador** | ',' |
| **Total de Colunas** | 9 |
| **Total de Registros** | 861 |

### Campos do Dicionário

| Campo | Tipo de Dado (Pandas) | Descrição |
|---|---|---|
| `driverId` | `int64` | Chave primária. Identificador único do piloto. |
| `driverRef` | `object` | Referência única para o piloto (usada em URLs, etc.). |
| `number` | `float64` | Número permanente do piloto. |
| `code` | `object` | Código de três letras do piloto. |
| `forename` | `object` | Primeiro nome do piloto. |
| `surname` | `object` | Sobrenome do piloto. |
| `dob` | `object` | Data de nascimento do piloto (formato YYYY-MM-DD). |
| `nationality` | `object` | Nacionalidade do piloto. |
| `url` | `object` | Link para a página do piloto na Wikipedia. |

---
## lap_times.csv

### Visão Geral

Tempos de volta por piloto em cada volta de uma corrida.

### Estrutura Geral

| Característica | Detalhe |
|---|---|
| **Formato** | CSV |
| **Encoding** | UTF-8 |
| **Separador** | ',' |
| **Total de Colunas** | 6 |
| **Total de Registros** | 589081 |

### Campos do Dicionário

| Campo | Tipo de Dado (Pandas) | Descrição |
|---|---|---|
| `raceId` | `int64` | Chave estrangeira. Identificador único da corrida. |
| `driverId` | `int64` | Chave estrangeira. Identificador único do piloto. |
| `lap` | `int64` | Número da volta. |
| `position` | `int64` | Posição do piloto na volta. |
| `time` | `object` | Tempo da volta em formato de texto (min:seg.mili). |
| `milliseconds` | `int64` | Tempo da volta em milissegundos. |

---
## pit_stops.csv

### Visão Geral

Informações sobre as paradas nos boxes (pit stops) por piloto em uma corrida.

### Estrutura Geral

| Característica | Detalhe |
|---|---|
| **Formato** | CSV |
| **Encoding** | UTF-8 |
| **Separador** | ',' |
| **Total de Colunas** | 7 |
| **Total de Registros** | 11371 |

### Campos do Dicionário

| Campo | Tipo de Dado (Pandas) | Descrição |
|---|---|---|
| `raceId` | `int64` | Chave estrangeira. Identificador único da corrida. |
| `driverId` | `int64` | Chave estrangeira. Identificador único do piloto. |
| `stop` | `int64` | Número da parada nos boxes. |
| `lap` | `int64` | Volta em que a parada nos boxes ocorreu. |
| `time` | `object` | Hora do dia em que a parada ocorreu. |
| `duration` | `object` | Duração da parada nos boxes em formato de texto (seg.mili). |
| `milliseconds` | `int64` | Duração da parada nos boxes em milissegundos. |

---
## qualifying.csv

### Visão Geral

Resultados da sessão de qualificação (grid de largada).

### Estrutura Geral

| Característica | Detalhe |
|---|---|
| **Formato** | CSV |
| **Encoding** | UTF-8 |
| **Separador** | ',' |
| **Total de Colunas** | 9 |
| **Total de Registros** | 10494 |

### Campos do Dicionário

| Campo | Tipo de Dado (Pandas) | Descrição |
|---|---|---|
| `qualifyId` | `int64` | Chave primária. Identificador único do resultado da qualificação. |
| `raceId` | `int64` | Chave estrangeira. Identificador único da corrida. |
| `driverId` | `int64` | Chave estrangeira. Identificador único do piloto. |
| `constructorId` | `int64` | Chave estrangeira. Identificador único do construtor. |
| `number` | `int64` | Número do carro do piloto. |
| `position` | `int64` | Posição final na qualificação (posição no grid de largada). |
| `q1` | `object` | Melhor tempo do piloto na Qualificação 1. |
| `q2` | `object` | Melhor tempo do piloto na Qualificação 2. |
| `q3` | `object` | Melhor tempo do piloto na Qualificação 3. |

---
## races.csv

### Visão Geral

Informações sobre as corridas, incluindo ano, circuito, nome e datas.

### Estrutura Geral

| Característica | Detalhe |
|---|---|
| **Formato** | CSV |
| **Encoding** | UTF-8 |
| **Separador** | ',' |
| **Total de Colunas** | 18 |
| **Total de Registros** | 1125 |

### Campos do Dicionário

| Campo | Tipo de Dado (Pandas) | Descrição |
|---|---|---|
| `raceId` | `int64` | Chave primária. Identificador único da corrida. |
| `year` | `int64` | Ano da temporada. |
| `round` | `int64` | Rodada da corrida na temporada. |
| `circuitId` | `int64` | Chave estrangeira. Identificador único do circuito. |
| `name` | `object` | Nome oficial da corrida (e.g., 'Australian Grand Prix'). |
| `date` | `object` | Data da corrida (formato YYYY-MM-DD). |
| `time` | `object` | Horário de início da corrida. |
| `url` | `object` | Link para a página da corrida na Wikipedia. |
| `fp1_date` | `object` | Data do Treino Livre 1 (Free Practice 1). |
| `fp1_time` | `object` | Horário do Treino Livre 1. |
| `fp2_date` | `object` | Data do Treino Livre 2 (Free Practice 2). |
| `fp2_time` | `object` | Horário do Treino Livre 2. |
| `fp3_date` | `object` | Data do Treino Livre 3 (Free Practice 3). |
| `fp3_time` | `object` | Horário do Treino Livre 3. |
| `quali_date` | `object` | Data da Qualificação. |
| `quali_time` | `object` | Horário da Qualificação. |
| `sprint_date` | `object` | Data da Corrida Sprint. |
| `sprint_time` | `object` | Horário da Corrida Sprint. |

---
## results.csv

### Visão Geral

Resultados detalhados de cada corrida, incluindo posição final, pontos e tempo.

### Estrutura Geral

| Característica | Detalhe |
|---|---|
| **Formato** | CSV |
| **Encoding** | UTF-8 |
| **Separador** | ',' |
| **Total de Colunas** | 18 |
| **Total de Registros** | 26759 |

### Campos do Dicionário

| Campo | Tipo de Dado (Pandas) | Descrição |
|---|---|---|
| `resultId` | `int64` | Chave primária. Identificador único do resultado. |
| `raceId` | `int64` | Chave estrangeira. Identificador único da corrida. |
| `driverId` | `int64` | Chave estrangeira. Identificador único do piloto. |
| `constructorId` | `int64` | Chave estrangeira. Identificador único do construtor. |
| `number` | `float64` | Número do carro. |
| `grid` | `int64` | Posição no grid de largada. |
| `position` | `float64` | Posição final da corrida (pode ser nulo se não classificado). |
| `positionText` | `object` | Posição final em formato de texto. |
| `positionOrder` | `int64` | Ordem final da posição (incluindo desclassificados). |
| `points` | `float64` | Pontos ganhos na corrida. |
| `laps` | `int64` | Número de voltas completadas. |
| `time` | `object` | Tempo final em formato de texto. |
| `milliseconds` | `float64` | Tempo final em milissegundos. |
| `fastestLap` | `float64` | Número da volta mais rápida. |
| `rank` | `float64` | Classificação da volta mais rápida. |
| `fastestLapTime` | `object` | Tempo da volta mais rápida em formato de texto. |
| `fastestLapSpeed` | `float64` | Velocidade média da volta mais rápida. |
| `statusId` | `int64` | Chave estrangeira. Identificador do status final do carro (e.g., completou a corrida, acidente). |

---
## seasons.csv

### Visão Geral

Lista dos anos das temporadas de Fórmula 1.

### Estrutura Geral

| Característica | Detalhe |
|---|---|
| **Formato** | CSV |
| **Encoding** | UTF-8 |
| **Separador** | ',' |
| **Total de Colunas** | 2 |
| **Total de Registros** | 75 |

### Campos do Dicionário

| Campo | Tipo de Dado (Pandas) | Descrição |
|---|---|---|
| `year` | `int64` | Chave primária. Ano da temporada. |
| `url` | `object` | Link para a página da temporada na Wikipedia. |

---