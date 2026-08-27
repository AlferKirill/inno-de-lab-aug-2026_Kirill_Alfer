raw_transactions = ["SUCCESS:100", "FAILED:50", "SUCCESS:-10", "SUCCESS:0", "SUCCESS:250", "ERROR:200"]

successful_raw_transactions = [
    t.replace("SUCCESS:", "") for t in raw_transactions
    if t.startswith("SUCCESS") and int(t.split(":")[1]) > 0
]
print(f"Успешные транзакции {successful_raw_transactions}")
# Используем list comprehension для фильтрации успешных транзакций
# startswith("SUCCESS") - проверяем, что строка начинается с "SUCCESS"
# split(":")[1] - извлекаем сумму после двоеточия
# int() - преобразуем строку в число для сравнения
# > 0 - оставляем только транзакции с положительной суммой
