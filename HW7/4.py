# Список ролей, переданный в запросе на авторизацию (содержит повторы)
requested_roles = ["guest", "developer", "guest", "admin",
"developer", "guest"]
# Набор обязательных ролей для выполнения административных функций

#преобразуем список запрошенных ролей во множество для мгновенного удаления дубликатов.
set_requesred_roles = set(requested_roles)

#Определяем роли, которые одновременно присутствуют как в списке уникальных
#запрошенных, так и в списке обязательных административных ролей (пересечение
#множеств).
required_admin_roles = {"admin", "security_officer",
"audit_manager"}
common_roles = required_admin_roles and set_requesred_roles
print(f"Общие роли{common_roles}")

#Вычисляем недостающие административные роли, которые не были запрошены
#пользователем (разность множеств).

uncommon_roles = required_admin_roles - set_requesred_roles
print(f'Незапрошенные роли: {uncommon_roles}')

#Проверяем наличие роли security_officer в дедуплицированном множестве
#запрошенных ролей с помощью высокопроизводительного оператора членства,
#выполняющегося за время O(1).

if 'security_officer' in required_admin_roles:
    print('security_officer есть в запросе')
else:
    print('security_officer нет в запросе')