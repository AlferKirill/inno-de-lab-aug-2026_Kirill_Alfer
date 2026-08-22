import random

secret_number = random.randint(1, 20)

attempts = 5

print("Я загадал число от 1 до 20. У тебя 5 попыток!")

# Цикл, пока есть попытки
while attempts > 0:
    # Показываем номер текущей попытки
    print(f"\nПопытка {6 - attempts}. Введите число: ", end="")

    try:
        guess = int(input())
    except ValueError:
        print("Пожалуйста, введите целое число.")
        continue

    if guess == secret_number:
        print("Ты угадал! Отличная работа.")
        break
    elif guess < secret_number:
        attempts -= 1
        if attempts > 0:
            print(f"Слишком мало! Осталось попыток: {attempts}")
        else:
            print("Слишком мало! Попытки закончились.")
    else:  
        attempts -= 1
        if attempts > 0:
            print(f"Слишком много! Осталось попыток: {attempts}")
        else:
            print("Слишком много! Попытки закончились.")

if attempts == 0 and guess != secret_number:
    print(f"\nИгра окончена. Загаданное число было: {secret_number}")