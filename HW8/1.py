# Исходные значения (константы)
MAX_RENTAL_BATCH_LIMIT = 150.0

# Функция без параметров для шапки
def print_header():
    print('=== ОТЧЕТ ПО ПАРТИЯМ АРЕНДЫ ===')

# Функция расчёта
def calculate_rental_branch(quantity: int, rental_rate: float, discount: float = 0.0) -> tuple[float, bool]:
    """
    Рассчитывает итоговую стоимость партии дисков с учетом скидки
    и проверяет превышение максимального лимита.
    Args:
        quantity: Количество дисков в партии.
        rental_rate: Стоимость аренды одного диска.
        discount: Размер скидки в виде десятичной дроби. По умолчанию скидка составляет 0.0.

    Returns:
        Кортеж, содержащий итоговую стоимость партии и признак превышения максимального лимита.
        Первый элемент имеет тип float, второй — bool.

    """
    final_sum = quantity * rental_rate * (1 - discount)
    final_sum = round(final_sum, 2)
    is_limit_exceeded = final_sum >= MAX_RENTAL_BATCH_LIMIT
    return final_sum, is_limit_exceeded

print_header()
# Заказ 1 с позиционными аргументами
order_1 = calculate_rental_branch(30, 2.99, 0)
# Вывод в консоль с соблюдением индексации
print(f'Партия 1 (Academy Dinosaur): ' f'Сумма {order_1[0]}$. ' f'Превышение лимита: {order_1[1]}' )

# Заказ 2 с именованными аргументами
order_2 = calculate_rental_branch(
    quantity = 40,
    rental_rate = 4.99,
    discount = 0.1
)
print(f'Партия 2 (Affair Prejudice): ' f'Сумма {order_2[0]}$. ' f'Превышение лимита: {order_2[1]}' )

order_3 = calculate_rental_branch(10, 1.99, 0)
print(f'Партия 3 (Agent Truman): ' f'Сумма {order_3[0]}$. ' f'Превышение лимита: {order_3[1]}')

order_4 = calculate_rental_branch(50, 3.5, 0.2)
print(f'Партия 4 (African Egg): ' f'Сумма {order_4[0]}$. ' f'Превышение лимита: {order_4[1]}')