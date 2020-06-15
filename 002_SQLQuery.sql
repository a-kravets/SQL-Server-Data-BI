/*ЗАДАНИЕ 1.
Напишите SQL-запрос, который выбирает из таблицы M_PHONES все строки из столбцов brand_name, phone_name,
ram, price. Строки должны быть отсортированы по столбцу price в порядке возрастания*/

SELECT
	brand_name + ' (' + phone_name + ')'
	,phone_name
	,ram
	,price
FROM m_phones
ORDER BY price


/*ЗАДАНИЕ 2.
Напишите SQL-запрос, который выбирает из таблицы M_PHONES все строки из столбцов brand_name, phone_name,
ram, price. Строки должны быть отсортированы по столбцу ram в порядке убывания*/

SELECT
	brand_name
	,phone_name
	,ram
	,price	
FROM m_phones
ORDER BY ram DESC

/*ЗАДАНИЕ 3.
Напишите SQL-запрос, который выбирает из таблицы M_PHONES все строки из столбцов brand_name, phone_name,
ram, price. Строки должны быть отсортированы по столбцу ram в порядке убывания. Строки с одинаковыми
значениями столбца ram должны быть отсортированы по столбцу price в порядке возрастания*/

SELECT
	brand_name
	,phone_name
	,ram
	,price	
FROM m_phones
ORDER BY ram DESC, price

/*ЗАДАНИЕ 4.
Напишите SQL-запрос, который выбирает из таблицы M_PHONES все строки из столбцов brand_name, phone_name,
ram, price. Строки должны быть отсортированы по столбцу price в порядке возрастания. Строки с одинаковыми
значениями столбца price должны быть отсортированы по столбцу ram в порядке убывания*/

SELECT
	brand_name
	,phone_name
	,ram
	,price	
FROM m_phones
ORDER BY price, ram DESC

/*ЗАДАНИЕ 5.
Напишите SQL-запрос, который выбирает из таблицы M_PHONES все строки из столбцов brand_name, phone_name,
battery_capacity, weight. Создайте вычисляемый столбец, который показывает емкость батареи каждого телефона
приходящуюся на единицу его веса. Расчёт сделать по формуле: емкость батареи/вес. Дайте название
получившемуся вычисляемому столбцу. Строки должны быть отсортированы по вычисляемому столбцу в порядке
убывания. Не используйте псевдоним в операторе ORDER BY*/

SELECT
	brand_name
	,phone_name
	,battery_capacity
	,weight
	,battery_capacity/weight AS capacity_per_gr
FROM m_phones
ORDER BY battery_capacity/weight DESC

/*ЗАДАНИЕ 6.
В запросе созданном в задании 5 используйте псевдоним вычисляемого столбца в операторе ORDER BY*/

SELECT
	brand_name
	,phone_name
	,battery_capacity
	,weight
	,battery_capacity/weight AS capacity_per_gr
FROM m_phones
ORDER BY capacity_per_gr DESC

/*ЗАДАНИЕ 7.
В запросе созданном в задании 6 добавьте округление значения вычисляемого столбца до 0 цифр после запятой*/

SELECT
	brand_name
	,phone_name
	,battery_capacity
	,weight
	,ROUND(battery_capacity/weight, 0) AS capacity_per_gr
FROM m_phones
ORDER BY capacity_per_gr DESC


/*ЗАДАНИЕ 8.
Напишите SQL-запрос, используя агрегатные функции по таблице M_PHONES для нахождения:
- минимального веса телефона
- максимального веса телефона
- среднего веса телефона с помощью агрегатной функции avg()
- среднего веса телефона с помощью агрегатных функций sum() и count()
- результата деления суммы весов всех телефонов на количество строк в таблице.
Дайте название каждому столбцу получившейся выборки. Вес телефона содержится в столбце weight*/

SELECT
	MIN(weight) AS min_weight
	,MAX(weight) AS max_weight
	,AVG(weight) AS avg_weight
	,SUM(weight)/COUNT(weight) AS avg_weight_alt
	,SUM(weight)/COUNT(*) AS avg_weight_3
FROM m_phones

/*ЗАДАНИЕ 9.
Напишите SQL-запрос, который из таблицы M_PHONES выбирает все строки столбцов brand_name, phone_name.
Создайте вычисляемый столбец, который показывает емкость батареи каждого телефона приходящуюся на единицу
его веса. Расчёт сделать по формуле: емкость батареи/вес. Вес телефона содержится в столбце weight, емкость
батареи содержится в столбце battery_capacity. Дайте название получившемуся вычисляемому столбцу*/

SELECT
	brand_name
	,phone_name
	,battery_capacity/weight AS capacity_per_gr
FROM m_phones

