number = int(input('Введите своё число '))
numberch = number % 2
if numberch == 0:
    print('Число', number, "- чётное")
else:
    print('Число', number, "- не чётное")
