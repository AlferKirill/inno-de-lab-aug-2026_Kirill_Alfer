from typing import Any

# Константы
DEFAULT_RETURN_INDEX_BASE = 10.0

# Функция расчёта
def calculate_overdue_fine(
    days_overdue: Any,
    fine_rate: Any
) -> tuple[float, float] | None:
    """
    Рассчитывает штраф за просрочку возврата и технический индекс
    оборачиваемости.

    Обрабатывает TypeError, ValueError и ZeroDivisionError.
    """
# Обработка ошибок
    try:
        numeric_days = float(days_overdue)

        total_fine = numeric_days * fine_rate
        return_index = DEFAULT_RETURN_INDEX_BASE / numeric_days

        return total_fine, return_index

    except TypeError as error: # Ошибка данных
        print(f"[ОШИБКА ТИПА] Невозможно обработать данные: {error}")

    except ValueError as error: # Ошибка значений
        print(
            f"[ОШИБКА ЗНАЧЕНИЯ] Невозможно преобразовать дни в число: "
            f"{error}"
        )

    except ZeroDivisionError as error: # Ошибка деления на 0
        print(
            f"[ОШИБКА ДЕЛЕНИЯ НА НОЛЬ] Возврат без просрочки: "
            f"{error}"
        )

    finally:
        print("--- Проверка транзакции возврата завершена ---")

    return None

# Проверки
print("=== ПРОВЕРКА ВОЗВРАТОВ ===")


# 1. Matrix — успешный расчет
result_1 = calculate_overdue_fine(5, 1.5)
print(
    f"Фильм: 'Matrix' | "
    f"Итоговый штраф: {result_1[0]}$ | "
    f"Индекс: {result_1[1]}"
)


# 2. Inception — ValueError
result_2 = calculate_overdue_fine("пять", 2.0)
print("Фильм: 'Inception' | Результат:", result_2)


# 3. Avatar — ZeroDivisionError
result_3 = calculate_overdue_fine(0, 2.5)
print("Фильм: 'Avatar' | Результат:", result_3)


# 4. Interstellar — TypeError
result_4 = calculate_overdue_fine([3], 3.0)
print("Фильм: 'Interstellar' | Результат:", result_4)
