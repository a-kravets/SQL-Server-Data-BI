/*ЗАДАНИЕ 1.
Напишите SQL запрос, который выбирает из таблицы M_PHONES все строки из столбцов brand_name , phone_name ,
sim,ram*/

SELECT brand_name, phone_name, sim, ram
FROM m_phones

/*ЗАДАНИЕ 2.
Напишите SQL запрос, который выбирает из таблицы M_PHONES строки с уникальными значениями столбца sim*/

SELECT DISTINCT sim
FROM m_phones

/*ЗАДАНИЕ 3.
Напишите SQL запрос, который выбирает из таблицы M_PHONES строки с уникальными комбинациями значений
столбцов sim и ram*/

SELECT DISTINCT sim, ram
FROM m_phones

/*ЗАДАНИЕ 4.
Напишите SQL
запрос, который выбирает из таблицы CLIENTS все строки из всех столбцов*/

SELECT *
FROM clients

/*ЗАДАНИЕ 5.
Напишите SQL
запрос, который определяет минимальную и максимальную даты рождения клиентов (столбец
birth_date таблицы CLIENTS ), использую соответствующие агрегатные функции*/

SELECT MIN(birth_date), MAX(birth_date)
FROM clients

/*ЗАДАНИЕ 6.
Напишите SQL запрос, используя соответствующие агрегатные функции по таблице M_PHONES для подсчёта:
-количества уникальных значений в столбце sim
-количества уникальных значений в столбце ram
-количества непустых значений в столбце sim
-количества непустых значений в столбце ram*/

SELECT COUNT(DISTINCT sim), COUNT(DISTINCT ram), COUNT(sim), COUNT(ram)
FROM m_phones



