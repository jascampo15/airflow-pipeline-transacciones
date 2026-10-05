FROM apache/airflow:3.0.0

USER root
# Requerido si dbt necesita git para paquetes
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER airflow

# 1. Crear el entorno virtual aislado exclusivo para dbt
RUN python -m venv /opt/airflow/dbt_venv && \
    /opt/airflow/dbt_venv/bin/pip install --no-cache-dir dbt-snowflake==1.8.3

# 2. Instalar Cosmos y providers en el entorno principal de Airflow 3.0
COPY requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt