/*ЗАДАНИЕ 1.
Напишите SQL-запрос, который связывает таблицы phones и phone_comment. Запрос должен выводить только те
строки из обеих таблиц, для которых phones.phone_id равен phone_comment.phone_id*/

SELECT
	*
FROM phones
JOIN phone_comment ON phones.phone_id = phone_comment.phone_id

/*ЗАДАНИЕ 2.
Напишите SQL-запрос, который связывает таблицы phones и phone_comment. Запрос должен выводить все строки из
таблицы phones и только те строки из таблицы phone_comment, для которых phones.phone_id равен
phone_comment.phone_id. Использовать оператор LEFT JOIN*/

SELECT
	*
FROM phones
LEFT JOIN phone_comment ON phones.phone_id = phone_comment.phone_id

/*ЗАДАНИЕ 3.
Напишите SQL-запрос, который связывает таблицы phones и phone_comment. Запрос должен выводить все строки из
таблицы phones и только те строки из таблицы phone_comment, для которых phones.phone_id равен
phone_comment.phone_id. Использовать оператор RIGHT JOIN*/

SELECT
	*
FROM phone_comment
RIGHT JOIN phones ON phones.phone_id = phone_comment.phone_id

/*ЗАДАНИЕ 4.
Напишите SQL-запрос, который связывает таблицы phones и phone_comment. Запрос должен выводить все строки из
обеих таблиц. Связь установите по столбцам phones.phone_id и phone_comment.phone_id*/SELECT
	*
FROM phones
FULL JOIN phone_comment ON phones.phone_id = phone_comment.phone_id

/*ЗАДАНИЕ 5.
Напишите SQL-запрос, который выбирает все строки и все столбцы из таблицы colors. Добавьте столбец, который
содержит максимальную цену телефона каждого цвета. Цены телефонов соответствующего цвета выбирать из таблицы
phone_price. Отсортируйте выборку по этому столбцу*/

SELECT
	color_name
	,color_id
	,(SELECT MAX(price) FROM phone_price WHERE phone_price.color_id = colors.color_id) AS max_price
FROM colors
ORDER BY max_price DESC

/*ЗАДАНИЕ 6.
Напишите SQL-запрос, который находит максимальную цену среди телефонов одинакового цвета для каждого цвета
(color_id) по таблице phone_price. Дайте название столбцу образованному агрегатной функцией. Используйте
получившийся запрос как источник данных в операторе FROM для нового запроса, который найдёт среднее значение
столбца с максимальными ценами*/

SELECT AVG(max_p.max_price)
FROM (
	SELECT
		DISTINCT color_name
		,color_id
		,(SELECT MAX(price) FROM phone_price WHERE phone_price.color_id = colors.color_id) AS max_price
	FROM colors) max_p

/*ЗАДАНИЕ 7.
Напишите SQL-запрос, который находит максимальную цену телефона у merchant_id=1 в таблице phone_price.
Используйте этот запрос в операторе WHERE другого запроса, который выбирает все строки из таблицы phone_price у
которых цена телефона больше чем эта максимальная цена*/

SELECT
	*
FROM phone_price
WHERE price > (SELECT MAX(price) FROM phone_price WHERE merchant_id = 1)

/*ЗАДАНИЕ 8.
Напишите SQL-запрос, который выводит столбец price из таблицы phone_price для merchant_id=1. Используйте этот
запрос в качестве подзапроса в операторе where price>any(подзапрос) другого запроса, который выводит все столбцы
из таблицы phone_price для merchant_id=1*/

SELECT
	*
FROM phone_price
WHERE price > ANY (SELECT price FROM phone_price WHERE merchant_id = 1)
	AND merchant_id = 1

/*ЗАДАНИЕ 9.
Напишите SQL-запрос, который выводит столбец price из таблицы phone_price для merchant_id=1. Используйте этот
запрос в качестве подзапроса в операторе where price>=all(подзапрос) другого запроса, который выводит все
столбцы из таблицы phone_price для merchant_id=1*/

SELECT
	*
FROM phone_price
WHERE price >= ALL (SELECT price FROM phone_price WHERE merchant_id = 1)
	AND merchant_id = 1