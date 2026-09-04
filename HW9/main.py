class Trainee:
    """Класс для отслеживания прогресса и успеваемости стажера"""

    def __init__(self, name: str, surname: str, score: int = 0, passing_grade: int = 10):
        """
        Инициализация стажера

        Args:
            name: Имя стажера
            surname: Фамилия стажера
            score: Начальный балл (по умолчанию 0)
            passing_grade: Проходной балл (по умолчанию 10)
        """
        self.name: str = name
        self.surname: str = surname
        self.passing_grade: int = passing_grade
        self.__score: int = score

    @property
    def score(self) -> int:
        """Геттер для получения текущего балла"""
        return self.__score

    @score.setter
    def score(self, value: int) -> None:
        """
        Сеттер для установки балла с валидацией

        Args:
            value: Новое значение балла

        Raises:
            ValueError: Если значение не является int или меньше 0
        """
        if not isinstance(value, int):
            raise ValueError(f"Expected value of type int, got {type(value)}")
        if value < 0:
            raise ValueError("The score shouldn't be less than 0!")
        self.__score = value

    def do_homework(self) -> None:
        """Increases score by 1"""
        self.score += 1

    def miss_homework(self) -> None:
        """Decreases score by 1"""
        self.score -= 1

    def visit_lecture(self) -> None:
        """Increases score by 1"""
        self.score += 1

    def miss_lecture(self) -> None:
        """Decreases score by 1"""
        self.score -= 1

    def is_passing(self) -> bool:
        """
        Проверяет, набирает ли стажер проходной балл

        Returns:
            True, если текущий балл >= проходному, иначе False
        """
        return self.score >= self.passing_grade


# Тестирование
if __name__ == "__main__":
    print("=== ПРОВЕРКА УСПЕВАЕМОСТИ СТАЖЕРА ===")

    # 1. Создание стажера с начальным баллом 9 и проходным баллом 10
    trainee = Trainee(name="Иван", surname="Иванов", score=9, passing_grade=10)

    # 2. Выполнение домашнего задания и проверка статуса
    trainee.do_homework()
    print(f"Баллы: {trainee.score}, Прошел курс: {trainee.is_passing()}")

    # 3. Пропуск лекции и проверка статуса
    trainee.miss_lecture()
    print(f"Баллы: {trainee.score}, Прошел курс: {trainee.is_passing()}")

    # 4. Проверка валидации (попытка задать неверный тип или отрицательное значение)
    try:
        trainee.score = -5
    except ValueError as e:
        print(f"Ошибка: {e}")