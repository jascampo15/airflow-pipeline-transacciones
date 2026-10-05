# Pipeline ETL de Transacciones y Líneas - Apache Airflow

Este proyecto implementa una arquitectura Medallion (Raw, Silver, Gold) en Apache Airflow 3 para el procesamiento incremental de transacciones y catálogos de líneas.

## Arquitectura del Pipeline

El pipeline consta de 5 DAGs orquestados secuencialmente mediante `TriggerDagRunOperator`:

1. **`ingesta_usos_api`**: Ingesta incremental desde API REST a `usos_raw`.
2. **`ingesta_lineas`**: Carga del catálogo desde Excel a `lines_raw`.
3. **`dag_transformacion_lines`**: Estandarización del catálogo en `lines_silver`.
4. **`dag_transformacion_usos`**: Limpieza y cálculo de zonas horarias en `usos_silver`.
5. **`dag_usos_gold`**: Agregación final y cruce de datos en `usos_gold`.

## Requisitos
- Apache Airflow 3.x
- PostgreSQL (`postgres_default`)
- Python 3.10+ (`pandas`, `requests`, `sqlalchemy`)