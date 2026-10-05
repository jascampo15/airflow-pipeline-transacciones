import pandas as pd
import numpy as np

def limpiar_amount(series: pd.Series) -> pd.Series:
    """Simula la lógica de transformación del campo amount aplicada en Silver"""
    numeric_series = pd.to_numeric(series, errors='coerce').fillna(0)
    return (numeric_series / 100).astype(int)

def limpiar_ceros_izquierda(series: pd.Series) -> pd.Series:
    """Simula la limpieza de ceros a la izquierda para id_line y veh_id"""
    return series.astype(str).str.lstrip('0').replace('', '0')

def test_limpieza_amount():
    df_input = pd.Series(['000000350000', '000000125000', '000000000000', None])
    resultado = limpiar_amount(df_input)
    esperado = pd.Series([3500, 1250, 0, 0])
    pd.testing.assert_series_equal(resultado, esperado, check_dtype=False)

def test_limpieza_ceros_id_line():
    df_input = pd.Series(['0101', '0045', '000'])
    resultado = limpiar_ceros_izquierda(df_input)
    esperado = pd.Series(['101', '45', '0'])
    pd.testing.assert_series_equal(resultado, esperado)