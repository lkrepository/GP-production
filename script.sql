-- Active: 1748493723238@@127.0.0.1@5432@postgres
SELECT
*
FROM
    gasp;

-- comprobation of null values 
SELECT * FROM
gasproduction
WHERE
    anio is NULL OR mes is NULL or provincia is null or produccion_petroleo_promedio_dia_m3 is null

--CHECKING FOR missing/duplicate/inconsistent values
    --initial revision of both tables
    SELECT
        COUNT(*) value_counts
    FROM
        gasproduction
    UNION ALL
    SELECT
        COUNT(*)
    FROM
        petroleumproduction

    -- check if there are duplicate values
    SELECT DISTINCT
        COUNT(*) value_counts
    FROM
        gasproduction
    UNION ALL
    SELECT DISTINCT
        COUNT(*)
    FROM
        petroleumproduction

    -- Check for name of provincias
    SELECT DISTINCT provincia as provincia_unique
    FROM
        gasproduction;

    SELECT DISTINCT provincia as provincia_unique
    FROM
        petroleumproduction;

-- Calculo produccion anual por provincia 
WITH anualprod_gas AS (
    SELECT
    anio, provincia, SUM(produccion_petroleo_promedio_dia_m3) prod_total
    FROM
        gasproduction
    GROUP BY
        provincia, anio
), anualprod_petroleum AS (
    SELECT
    anio, provincia, SUM(produccion_petroleo_promedio_dia_m3) prod_total
    FROM
        petroleumproduction
    GROUP BY
        provincia, anio
)
SELECT ap.provincia,ag.prod_total gas_total, ap.prod_total petroleum_totaal
FROM
    anualprod_gas ag
JOIN
    anualprod_petroleum ap
ON
    ag.provincia = ap.provincia
WHERE
    ag.anio = 2013

SELECT
    anio, sum(produccion_petroleo_promedio_dia_m3)
FROM
    petroleumproduction
GROUP BY
    provincia, anio
HAVING
    provincia = 'San Juan'