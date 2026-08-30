# Исходная необработанная строка из источника данных
from locale import normalize

raw_user_record = " 10827 ; aLeXanDer_vLaDimiRov ; mInSk ; ACTIVE "
# Ваш код здесь
# Разбиваем строку по разделителю ";"
split_user_record = raw_user_record.split(";")

# Извлекаем данные, убирая лишние пробелы
id_user = split_user_record[0].strip()
user_name = split_user_record[1].strip()
city_id = split_user_record[2].strip()
status = split_user_record[3].strip()

# Приводим к нужному формату
format_user_record = f'UID-{id_user}'
normalized_user_name = user_name.lower().replace("_", " ").title()
normalized_city_id = city_id.upper()
normalized_status = status.lower()

# Собираем результат через join()
result_parts = [format_user_record, normalized_user_name, normalized_city_id, normalized_status]
normalized_raw = "|".join(result_parts)

print(normalized_raw)