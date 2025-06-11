-- Active: 1748493723238@@127.0.0.1@5432@postgres
SELECT
*
FROM
    gasp;

-- comprobation of null values 
SELECT
	*
FROM
	gasp
WHERE
    anio is NULL OR mes is NULL or provincia is null or produccion_gas is null

--CHECKING FOR missing/duplicate/inconsistent values
    --initial revision of both tables
    SELECT
        COUNT(*) value_counts
    FROM
        gasp
    UNION ALL
    SELECT
        COUNT(*)
    FROM
        petrp

-- comprobation of null values 
SELECT
	*
FROM
	gasp
WHERE
	anio is NULL OR mes is NULL or provincia is null or produccion_gas is null
---
SELECT
	*
FROM
	petrp
WHERE
    anio is NULL OR mes is NULL or provincia is null or produccion_gas is null

-- check if there are duplicate values
    SELECT DISTINCT
        COUNT(*) value_counts
    FROM
        gasp
    UNION ALL

    SELECT DISTINCT
        COUNT(*)
    FROM
        petrp

    -- Check for name of provincias
    SELECT DISTINCT provincia as provincia_unique
    FROM
        gasp;

    SELECT DISTINCT provincia as provincia_unique
    FROM
        petrp;

-- Anual Production of Gas (in certain year)
WITH anualprod_gas AS (
    SELECT
    anio, provincia, SUM(produccion_gas) prod_total
    FROM
        gasp
    GROUP BY
        provincia, anio
), anualprod_petroleum AS (
    SELECT
    anio, provincia, SUM(produccion_petroleo) prod_total
    FROM
        petrp
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
    anio, sum(produccion_petroleo)
FROM
    petrp
GROUP BY
    provincia, anio
HAVING
    provincia = 'San Juan'


--Correlation (example year)

WITH anualprod_gas AS (
    SELECT
    anio, provincia, SUM(produccion_gas) prod_total_gas
    FROM
        gasp
    GROUP BY
        provincia, anio
), anualprod_petroleum AS (
    SELECT
    anio, provincia, SUM(produccion_petroleo) prod_total_oil
    FROM
        petrp
    GROUP BY
        provincia, anio
)
SELECT
	provincia, corr(prod_total_gas,prod_total_oil) Correlation
FROM
    anualprod_gas ag
JOIN
    anualprod_petroleum ap
ON
    ag.provincia = ap.provincia
WHERE
    ag.anio = 2013
