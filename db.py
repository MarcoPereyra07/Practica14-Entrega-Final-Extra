import mysql.connector

def crear_conexion():
    return mysql.connector.connect(
        host='localhost',
        user='root',         # Cambia por tu usuario MySQL
        password='07032005Ma', # Cambia por tu password MySQL
        database='extra2'
    )