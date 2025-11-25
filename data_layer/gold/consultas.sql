-- Pilotos com mais vitórias na carreira - Performance Histórica

SELECT
    dp.forename || ' ' || dp.surname AS nome_piloto,
    dp.nationality AS nacionalidade,
    COUNT(CASE WHEN fr.position_order = 1 THEN 1 END) AS total_vitorias,
    SUM(fr.points) AS total_pontos_carreira
FROM
    dw.FAT_RESULTADOS fr
JOIN
    dw.DIM_PILOTO dp ON fr.srk_piloto_fk = dp.piloto_pk
GROUP BY
    1, 2
ORDER BY
    total_pontos_carreira DESC
LIMIT 10;

----------------------------------------------------------------------------

-- Taxa de abandono (DNF) por equipes | Determinado por Década

WITH Resultados AS (
    SELECT
        fr.srk_equipe_fk,
        dc.year,
        CASE WHEN ds.status IN ('Finished', 'Disqualified') THEN 0 ELSE 1 END AS is_dnf
    FROM
        dw.FAT_RESULTADOS fr
    JOIN
        dw.DIM_STATUS ds ON fr.srk_status_fk = ds.status_pk
    JOIN
        dw.DIM_CORRIDA dc ON fr.srk_corrida_fk = dc.corrida_pk
    WHERE
        dc.year >= 2010
)
SELECT
    de.name AS nome_equipe,
    SUM(r.is_dnf) AS total_dnf,
    COUNT(*) AS total_corridas,
    CAST(SUM(r.is_dnf) AS FLOAT) * 100 / COUNT(*) AS taxa_dnf_percentual
FROM
    Resultados r
JOIN
    dw.DIM_EQUIPE de ON r.srk_equipe_fk = de.equipe_pk
GROUP BY
    1
ORDER BY
    taxa_dnf_percentual DESC;

----------------------------------------------------------------------------

-- Piloto com mais vitória em um determinado circuito

WITH CircuitoVitorias AS (
    SELECT
        fr.srk_piloto_fk,
        dc.circuit_id, 
        COUNT(*) AS vitorias_no_circuito
    FROM
        dw.FAT_RESULTADOS fr
    JOIN
        dw.DIM_CORRIDA dc ON fr.srk_corrida_fk = dc.corrida_pk
    WHERE
        fr.position_order = 1
    GROUP BY
        1, 2
),
Rankeamento AS (
    SELECT
        cv.srk_piloto_fk,
        dci.name AS nome_circuito,
        cv.vitorias_no_circuito,
        RANK() OVER (PARTITION BY dci.circuito_pk ORDER BY cv.vitorias_no_circuito DESC) AS rank_circuito
    FROM
        CircuitoVitorias cv
    JOIN
        dw.DIM_CIRCUITO dci ON cv.circuit_id = dci.circuito_pk
)
SELECT
    nome_circuito,
    (SELECT forename || ' ' || surname FROM dw.DIM_PILOTO WHERE piloto_pk = r.srk_piloto_fk) AS piloto_mestre,
    vitorias_no_circuito
FROM
    Rankeamento r
WHERE
    rank_circuito = 1;

----------------------------------------------------------------------------

-- Top 5 maiores motivos de DNF (Não Classificação)

SELECT
    ds.status,
    COUNT(fr.resultado_pk) AS total_ocorrencias
FROM
    dw.FAT_RESULTADOS fr
JOIN
    dw.DIM_STATUS ds ON fr.srk_status_fk = ds.status_pk
WHERE
    ds.status NOT IN ('Finished', 'Disqualified', '+1 Lap', 'Engine', 'Accident', 'Brakes')
    AND ds.status_pk > 1 
GROUP BY
    1
ORDER BY
    total_ocorrencias DESC
LIMIT 5;

----------------------------------------------------------------------------

-- Comparativo de pontuação por título (Maior pontuador do ano)

WITH PontosAnuais AS (
    SELECT
        dp.surname AS piloto,
        dc.year,
        SUM(fr.points) AS pontos_acumulados
    FROM
        dw.FAT_RESULTADOS fr
    JOIN
        dw.DIM_PILOTO dp ON fr.srk_piloto_fk = dp.piloto_pk
    JOIN
        dw.DIM_CORRIDA dc ON fr.srk_corrida_fk = dc.corrida_pk
    GROUP BY
        1, 2
),
CampeaoAnual AS (
    SELECT
        pa.year,
        pa.piloto,
        pa.pontos_acumulados,
        RANK() OVER (PARTITION BY pa.year ORDER BY pa.pontos_acumulados DESC) AS rank_ano
    FROM
        PontosAnuais pa
)
SELECT
    year AS ano_campeao,
    piloto AS campeao_pontos,
    pontos_acumulados
FROM
    CampeaoAnual
WHERE
    rank_ano = 1
ORDER BY
    year DESC;

----------------------------------------------------------------------------

-- Probabilidade de pódio de um Piloto ao longo de sua carreira

SELECT
    dp.forename || ' ' || dp.surname AS nome_piloto,
    SUM(CASE WHEN fr.position_order BETWEEN 1 AND 3 THEN 1 ELSE 0 END) AS total_podios,
    COUNT(fr.resultado_pk) AS total_corridas_validas,
    CAST(SUM(CASE WHEN fr.position_order BETWEEN 1 AND 3 THEN 1 ELSE 0 END) AS FLOAT) * 100 / COUNT(fr.resultado_pk) AS pct_podio
FROM
    dw.FAT_RESULTADOS fr
JOIN
    dw.DIM_PILOTO dp ON fr.srk_piloto_fk = dp.piloto_pk
WHERE
    fr.position_order > 0 
GROUP BY
    1
HAVING
    COUNT(fr.resultado_pk) > 30 
ORDER BY
    pct_podio DESC;

----------------------------------------------------------------------------

-- Média de pontos por temporada por piloto

SELECT
    dc.year AS temporada,
    dp.surname AS piloto,
    AVG(fr.points) AS media_pontos_por_corrida
FROM
    dw.FAT_RESULTADOS fr
JOIN
    dw.DIM_CORRIDA dc ON fr.srk_corrida_fk = dc.corrida_pk
JOIN
    dw.DIM_PILOTO dp ON fr.srk_piloto_fk = dp.piloto_pk
GROUP BY
    1, 2
ORDER BY
    temporada DESC, media_pontos_por_corrida DESC;

----------------------------------------------------------------------------

-- Ranking de pilotos por Década

SELECT
    t1.decada,
    t1.piloto_mais_pontos,
    t1.pontos_totais
FROM (
    SELECT
        dp.surname AS piloto_mais_pontos,
        (dc.year / 10) * 10 AS decada,
        SUM(fr.points) AS pontos_totais,
        RANK() OVER (PARTITION BY (dc.year / 10) * 10 ORDER BY SUM(fr.points) DESC) as rank_decada
    FROM
        dw.FAT_RESULTADOS fr
    JOIN
        dw.DIM_PILOTO dp ON fr.srk_piloto_fk = dp.piloto_pk
    JOIN
        dw.DIM_CORRIDA dc ON fr.srk_corrida_fk = dc.corrida_pk
    GROUP BY
        1, 2
) t1
WHERE
    t1.rank_decada = 1
ORDER BY
    t1.decada DESC;

----------------------------------------------------------------------------

-- Equipes com maior percentual de top 5 em corridas recentes

WITH CorridasRecentes AS (
    SELECT 
        corrida_pk, year 
    FROM 
        dw.DIM_CORRIDA 
    ORDER BY year DESC, round DESC 
    LIMIT 20 -- Limita as últimas 20 corridas (aprox. 1 temporada)
)
SELECT
    de.name AS nome_equipe,
    SUM(CASE WHEN fr.position_order BETWEEN 1 AND 5 THEN 1 ELSE 0 END) AS total_top5,
    COUNT(fr.resultado_pk) AS total_participacoes,
    CAST(SUM(CASE WHEN fr.position_order BETWEEN 1 AND 5 THEN 1 ELSE 0 END) AS FLOAT) * 100 / COUNT(fr.resultado_pk) AS pct_top5
FROM
    dw.FAT_RESULTADOS fr
JOIN
    dw.DIM_EQUIPE de ON fr.srk_equipe_fk = de.equipe_pk
JOIN
    CorridasRecentes cr ON fr.srk_corrida_fk = cr.corrida_pk
GROUP BY
    1
ORDER BY
    pct_top5 DESC;

----------------------------------------------------------------------------

-- Coerência do piloto - Desvio Padrão da posição final

-- Esta consulta calcula o desvio padrão (STDDEV) da posição final dos pilotos.
-- Um desvio padrão baixo indica que o piloto é mais consistente e termina sempre
-- em torno da sua média de posição, enquanto um desvio alto indica resultados 
-- imprevisíveis.

SELECT
    dp.forename || ' ' || dp.surname AS nome_piloto,
    ROUND(AVG(fr.position_order), 2) AS posicao_media_carreira,
    ROUND(STDDEV(fr.position_order), 2) AS desvio_padrao_posicao
FROM
    dw.FAT_RESULTADOS fr
JOIN
    dw.DIM_PILOTO dp ON fr.srk_piloto_fk = dp.piloto_pk
WHERE
    fr.position_order > 0 
GROUP BY
    1
HAVING
    COUNT(fr.resultado_pk) > 50 
ORDER BY
    desvio_padrao_posicao ASC,
    posicao_media_carreira ASC
LIMIT 10;