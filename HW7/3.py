# Конфигурационный словарь, полученный от сервиса инициализации
db_config = {
"connection": {
"host": "production-db.internal",
"port": 5432,
"user": "postgres"
}
}
# Ваш код здесь
db_host = db_config["connection"]["host"]
db_port = db_config["connection"]["port"]
print("db_host:", db_host)
print("db_port:", db_port)
# Безопасное получение ssl_mode с дефолтным значением
ssl_mode = db_config.get("connection", {}).get("ssl_settings", {}).get("ssl_mode", "verify-full")
print(f"ssl_mode: {ssl_mode}")  # ssl_mode: require
#изменяем значение user на admin
db_config["connection"]["user"] = 'admin'
print(f"db_user: {db_config['connection']['user']}")
#добавляем новый параметр max_connections со значением 100 непосредственно во вложенный словарь connection
db_config["connection"]["max_connections"] = 100
print(f"db_max_connections: {db_config['connection']['max_connections']}")

# Выводим обновлённое содержимое
print("Обновлённая конфигурация connection:")
for key, value in db_config["connection"].items():
    print(f"{key}: {value}")

