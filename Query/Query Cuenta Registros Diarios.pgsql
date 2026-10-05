SELECT 
    TO_CHAR(a.fecha_ingesta, 'DD-MM-YYYY') AS fecha,
    COUNT(*) AS total_registros
FROM usos_raw a
GROUP BY TO_CHAR(a.fecha_ingesta, 'DD-MM-YYYY')
ORDER BY MIN(a.fecha_ingesta) DESC;

SELECT 
    TO_CHAR(a.last_modified, 'DD-MM-YYYY') AS fecha,
    COUNT(*) AS total_registros
FROM usos_raw a
WHERE a.last_modified IS NOT NULL
GROUP BY TO_CHAR(a.last_modified, 'DD-MM-YYYY')
ORDER BY MIN(a.last_modified) DESC;

SELECT 
    TO_CHAR(a.date_time, 'YYYY-MM-DD') AS fecha,
    COUNT(*) AS total_registros
FROM usos_silver a
WHERE a.date_time IS NOT NULL
GROUP BY TO_CHAR(a.date_time, 'YYYY-MM-DD')
ORDER BY MIN(a.date_time) DESC;

select * from usos_silver a
where a.date_time < '2026-09-30'
;

select a.id_txn, a.* from usos_raw a 
order by a.id_txn asc;

select * from lines_raw;

--DELETE from usos_silver;
--DELETE from lines_raw;

SELECT 'usos_raw' AS tabla, COUNT(*) AS total_registros FROM usos_raw
UNION ALL
SELECT 'usos_silver' AS tabla, COUNT(*) AS total_registros FROM usos_silver;

SELECT MAX(CAST(id_txn AS INTEGER)) FROM usos_raw;

SELECT 
    TO_CHAR(a.date_time, 'YYYY-MM-DD') AS fecha,
    TO_CHAR(a.date_time, 'HH24') AS hola,
    a.id_line AS id_linea,
    b.ld_descshort AS name_linea,
    a.type_intg AS integracion,
    a.veh_id AS veh_id,
    a.terminal_id AS sn_terminal,
    a.amount As valor,
    COUNT(*) AS total_trx
FROM usos_silver a
INNER JOIN lines_silver b ON CAST(b.ld_id AS BIGINT) = CAST(a.id_line AS BIGINT)
WHERE a.date_time IS NOT NULL
GROUP BY TO_CHAR(a.date_time, 'YYYY-MM-DD'),
TO_CHAR(a.date_time, 'HH24'), 
a.id_line,
b.ld_descshort,
a.type_intg,
a.veh_id ,
a.terminal_id, 
a.amount
ORDER BY MIN(a.date_time) DESC;


/*
DELETE from usos_silver;
DELETE from usos_raw;

DROP TABLE IF EXISTS usos_silver;
DROP TABLE IF EXISTS usos_raw;

DELETE from lines_raw;
*/