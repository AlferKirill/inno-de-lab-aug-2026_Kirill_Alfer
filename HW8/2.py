import time
from typing import Any, Callable

# Константы
PERFORMANCE_LOG_PREFIX = "[PERF_LOG]"
TIME_DECIMALS = 8

# Функция без переменных для печати шапки
def print_header():
    print('=== ТЕСТИРОВАНИЕ ПРОИЗВОДИТЕЛЬНОСТИ === ')
print_header()

# Декоратор
def perfomance_logger(
        func: Callable[..., Any], # Декорируемая функция, принимает любые аргументы
) -> Callable[..., Any]: # Возвращает обёрнутую функцию
    """
    Декоратор для измерения времени выполнения функции.
    Args:
        func: Функция, время выполнения которой необходимо измерить.
    Returns:
        Обёрнутая функция, которая измеряет время выполнения оригинальной функции,
        выводит информацию о производительности и возвращает результат её работы.
    """
    def wrapper(*args: Any, **kwargs: Any) -> Any:
        """
        Обёртка, которая выполняет замер времени.
        Args:
            *args: Позиционные аргументы, переданные в декорируемую функцию
            **kwargs: Именованные аргументы, переданные в декорируемую функцию
        Returns:
            Результат выполнения декорируемой функции
        """
        start_time = time.perf_counter()
        result = func(*args, **kwargs)
        end_time = time.perf_counter()
        execution_time = round((end_time - start_time) * TIME_DECIMALS)

        print(f"{PERFORMANCE_LOG_PREFIX} "
            f"Функция '{func.__name__}' выполнена " 
              f"за {execution_time} сек." )
        return result
    return wrapper

@perfomance_logger
def get_sorted_report( revenue_data: list[dict[str, str | float]] ) -> list[dict[str, str | float]]:
    """
    Сортирует данные о выручке жанров по убыванию общей выручки.
    Args:
        revenue_data: Список словарей с данными о выручке жанров.
         Каждый словарь содержит название жанра и значение общей выручки в поле total_sales.
         Returns:
             Отсортированный по убыванию общей выручки список словарей.
    """
    return sorted(
        revenue_data,
        key=lambda item: item["total_sales"],
        reverse=True )



revenue_data_1 = [
    {"category": "Action", "total_sales": 4311.85},
    {"category": "Animation", "total_sales": 4656.30},
    {"category": "Children", "total_sales": 3655.55}
 ]

sorted_report = get_sorted_report(revenue_data_1)
print("\nОтсортированный отчет:")
for item in sorted_report:
    print( f"Жанр: {item['category']}, " f"Выручка: {item['total_sales']}" )

revenue_data_2 = [
{"category": "Classics", "total_sales": 1200.10},
{"category": "Comedy", "total_sales": 4000.00},
{"category": "Documentary", "total_sales": 4000.00}]

sorted_report = get_sorted_report(revenue_data_2)
print("\nОтсортированный отчет:")
for item in sorted_report:
    print( f"Жанр: {item['category']}, " f"Выручка: {item['total_sales']}" )

revenue_data_3 = [{"category": "Drama", "total_sales": 500.00} ]

sorted_report = get_sorted_report(revenue_data_3)
print("\nОтсортированный отчет:")
for item in sorted_report:
    print( f"Жанр: {item['category']}, " f"Выручка: {item['total_sales']}" )

