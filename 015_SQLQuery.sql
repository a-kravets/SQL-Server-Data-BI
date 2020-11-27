/*ЗАДАНИЕ 1.
Вставьте в таблицу new_phone_price новую строку со значениями столбца price равным 2222 , столбца merchant_id равным 55,
столбца color_id равным 19, столбца phone_id равным 10002. Напишите SQL запрос, выводящий вставленную строку*/

INSERT INTO new_phone_price (price, merchant_id, color_id, phone_id)
VALUES (2222, 55, 19, 10002)

SELECT * FROM new_phone_price
WHERE phone_id = 10002

/*ЗАДАНИЕ 2.
Напишите SQL запрос, выбирающий из таблицы phones связанной с таблицей phone_price по столбцу phone_id строки, у которых
столбец phone_id из таблицы phone_price является пустым. Оставьте в выборке только те строки, у которых brand_id=6.
Используйте данные, возвращаемые этим запросом для вставки в таблицу new_phone_price. Задайте значение столбца merchant_id
равным 55, столбца color_id равным 19, столбца price на своё усмотрение.
Напишите SQL запрос, выбирающий вставленные строки*/

INSERT INTO new_phone_price (phone_id, color_id, merchant_id, price)

SELECT 
	p.phone_id
	,19
	,55
	,CASE
		WHEN p.phone_id = 833013 THEN 5999
		WHEN p.phone_id = 1031654 THEN 8590
		ELSE 0
	END AS price
FROM phones p
LEFT JOIN phone_price pp ON pp.phone_id = p.phone_id
WHERE pp.phone_id IS NULL
	AND p.brand_id = 6


SELECT 
	*
FROM new_phone_price
WHERE phone_id = 833013 OR phone_id = 1031654
	AND merchant_id = 55
	AND color_id = 19


/*ЗАДАНИЕ 3.
Напишите UPDATE SQL запрос, который уменьшает цену телефонов добавленных в таблицу new_phone_price в предыдущем
задании на 100 грн. Напишите SQL запрос, выводящий изменённые строки*/

UPDATE new_phone_price
SET price = price - 100
FROM new_phone_price
WHERE phone_id = 833013 OR phone_id = 1031654
	AND merchant_id = 55
	AND color_id = 19

SELECT 
	*
FROM new_phone_price
WHERE phone_id = 833013 OR phone_id = 1031654
	AND merchant_id = 55
	AND color_id = 19

/*ЗАДАНИЕ 4.
Напишите SQL запрос, выбирающий из таблицы new_phone_price строки для которых объём запасов на складе=1 (таблица stock,
столбец amount). С помощью команды UPDATE увеличьте цены выбранных телефонов на 10 грн. Проверьте результат изменений*/

UPDATE new_phone_price
SET price = price + 10
FROM new_phone_price npp
JOIN stock s ON npp.phone_id = s.phone_id AND npp.merchant_id = s.merchant_id AND npp.color_id = s.color_id
WHERE s.amount = 1

SELECT *
FROM new_phone_price npp
JOIN stock s ON npp.phone_id = s.phone_id AND npp.merchant_id = s.merchant_id AND npp.color_id = s.color_id
WHERE s.amount = 1


/*ЗАДАНИЕ 5.
Измените UPDATE SQL запрос из предыдущего задания так, чтобы он изменял цены телефонов в таблице
new_phone_price на максимальную цену (-каждого телефона соответствующего цвета), найденную в таблице
phone_price. Напишите SQL запрос, который выводит изменённые строки*/

UPDATE new_phone_price
SET new_phone_price.price = 
	(	SELECT MAX(price) AS max_price
		FROM new_phone_price npp
		JOIN stock s ON npp.phone_id = s.phone_id AND npp.color_id = s.color_id
		WHERE s.color_id = npp.color_id AND s.amount = 1)


SELECT s.*
	,(	SELECT MAX(price) AS max_price
		FROM new_phone_price npp
		WHERE s.color_id = npp.color_id)
FROM new_phone_price npp
JOIN stock s ON npp.phone_id = s.phone_id AND npp.color_id = s.color_id
WHERE s.amount = 1


/*ЗАДАНИЕ 6.
Напишите SQL запрос, выбирающий из таблицы new_phone_price строки по условию merchant_id=2 and color_id=20. На
основе этого запроса напишите DELETE SQL запрос, удаляющий строки по заданному условию. Проверьте результат
удаления*/

SELECT *
FROM new_phone_price
WHERE merchant_id = 2 AND color_id = 20

DELETE new_phone_price
WHERE merchant_id = 2 AND color_id = 20

/*ЗАДАНИЕ 7.
Напишите SQL запрос, выбирающий из таблицы phone_price первые две строки (сортировка по столбцу price) , условие
отбора merchant_id=2 and color_id=23. Используя данный запрос как подзапрос, свяжите его с таблицей
new_phone_price с помощью команды JOIN в новом запросе, который выберет соответствующие две строки из
таблицы new_phone_price. Преобразуйте созданный запрос в DELETE SQL запрос, который удалит выбранные две
строки из таблицы new_phone_price. Проверьте результат*/SELECT TOP 2 *FROM phone_priceWHERE merchant_id = 2 AND color_id = 23ORDER BY price DESCSELECT *FROM new_phone_price nppJOIN (	SELECT TOP 2 *		FROM phone_price		WHERE merchant_id = 2 AND color_id = 23		ORDER BY price DESC) ppON npp.phone_id=pp.phone_id and npp.merchant_id=pp.merchant_id and npp.color_id=pp.color_idDELETE FROM nppFROM new_phone_price nppJOIN (	SELECT TOP 2 *		FROM phone_price		WHERE merchant_id = 2 AND color_id = 23		ORDER BY price DESC) ppON npp.phone_id=pp.phone_id and npp.merchant_id=pp.merchant_id and npp.color_id=pp.color_idSELECT *FROM new_phone_price nppJOIN (	SELECT TOP 2 *		FROM phone_price		WHERE merchant_id = 2 AND color_id = 23		ORDER BY price DESC) ppON npp.phone_id=pp.phone_id and npp.merchant_id=pp.merchant_id and npp.color_id=pp.color_id