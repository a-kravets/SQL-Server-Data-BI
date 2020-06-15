/*ЗАДАНИЕ 1.
Напишите SQL-запрос, который неявно связывает таблицы brands и colors. Выберите только те строки, в которых
brand_id=1*/

SELECT
	*
FROM brands, colors
WHERE brand_id = 1

/*ЗАДАНИЕ 2.
Напишите SQL-запрос, который неявно связывает таблицы brands и colors. Выберите только те строки, в которых
color_id=1*/

SELECT
	*
FROM brands, colors
WHERE color_id = 1

/*ЗАДАНИЕ 3.
Напишите SQL-запрос, который выводит все столбцы из таблицы phones по тем phone_id, у которых в таблице
phone_comment значение столбца enthusiastic>100. Используйте конструкцию where phone_id in (подзапрос)*/

SELECT
	*
FROM phones
WHERE phone_id IN (
	SELECT
		phone_id
	FROM phone_comment
	WHERE enthusiastic > 100
	)

/*ЗАДАНИЕ 4.
Напишите SQL-запрос, который выводит все столбцы из таблицы phones по тем phone_id, у которых в таблице
phone_comment значение столбца enthusiastic>100. Используйте конструкцию where exists (подзапрос)*/
SELECT
	*
FROM phones
WHERE EXISTS (
	SELECT
		*
	FROM phone_comment
	WHERE enthusiastic > 100
		AND phones.phone_id = phone_comment.phone_id
	)

/*ЗАДАНИЕ 5.
Напишите три SQL-запроса:
1. Выбирает brand_name из таблицы brands для brand_id=1
2. Выбирает merchant_name из таблицы merchants для merchant_id=1
3. Выбирает color_name из таблицы colors для color_id=1
Объедините результаты всех трёх запросов в один с помощью оператора UNION*/

SELECT brand_name
FROM brands
WHERE brand_id = 1
UNION
SELECT merchant_name
FROM merchants
WHERE merchant_id = 1
UNION
SELECT color_name
FROM colors
WHERE color_id = 1

/*ЗАДАНИЕ 6.
Напишите два SQL-запроса:
1. Выбирает phone_id, color_id из таблицы phone_price для merchant_id =1
2. Выбирает phone_id, color_id из таблицы phone_price для merchant_id =8
Найдите строки, которые есть в результатах обоих запросов с помощью intersect*/

SELECT
	phone_id, color_id
FROM phone_price
WHERE merchant_id = 1
INTERSECT
SELECT
	phone_id, color_id
FROM phone_price
WHERE merchant_id = 8

/*ЗАДАНИЕ 7.
Напишите два SQL-запроса:
1. Выбирает phone_id, color_id из таблицы phone_price для merchant_id =1
2. Выбирает phone_id, color_id из таблицы phone_price для merchant_id =8
Найдите строки, которые есть в результатах одного запроса, но нет в результатах другого с помощью except*/

SELECT
	phone_id, color_id
FROM phone_price
WHERE merchant_id = 1
EXCEPT
SELECT
	phone_id, color_id
FROM phone_price
WHERE merchant_id = 8

