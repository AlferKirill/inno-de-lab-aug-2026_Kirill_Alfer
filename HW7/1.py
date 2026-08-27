# Исходная необработанная строка из источника данных
from locale import normalize

raw_user_record = " 10827 ; aLeXanDer_vLaDimiRov ; mInSk ; ACTIVE "
# Ваш код здесь
split_user_record = raw_user_record.split(";")
clean_user_record = raw_user_record.strip()
id_user = raw_user_record[1:6]
format_user_record = 'UID-{}'.format(id_user)
user_name = raw_user_record[9:29]
cl_user_name = user_name.strip()
normalized_user_name = cl_user_name.lower().replace("_", " ").title()
city_id = raw_user_record[32:37]
normalized_city_id = city_id.upper()
status = raw_user_record[40:46]
normalized_status = status.lower()
normalized_raw = f'{format_user_record} {normalized_user_name} {normalized_city_id} {normalized_status}'
split_normalized_raw = normalized_raw.replace(" ", "|")
print(split_normalized_raw)