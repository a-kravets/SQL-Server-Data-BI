/*
ЗАДАНИЕ 1.
Напишите SQL-запрос, который выводит столбцы brand_name, brand_id , color_name и color_id из таблиц brands и
colors связанных неявно (CROSS JOIN) . Вывести только те строки где значение столбца reg_country (страна
регистрации бренда) равен 'Украина’*/SELECT	brand_name	,brand_id	,color_name	,color_idFROM	brands b, colors cWHERE b.reg_country = 'Украина'/*ЗАДАНИЕ 2.
Напишите SQL-запрос, который выводит все строки и все столбцы из таблицы phone_price и столбец brand_id из
таблицы phones. Связать таблицы так, что бы гарантированно получить все строки из таблицы phone_price
*/

SELECT
	pr.*
	,ph.brand_id
FROM phone_price pr
LEFT JOIN phones ph ON pr.phone_id = ph.phone_id

/*
ЗАДАНИЕ 3.
Напишите SQL-запрос, который связывает запрос из задачи 1 и запрос из задачи 2 по столбцам brand_id и color_id так
чтобы гарантированно получить все строки из запроса с названиями брендов и цветов
*/

SELECT	a.Brand_name	,a.color_nameFROM(SELECT	brand_name	,brand_id	,color_name	,color_idFROM	brands b, colors cWHERE b.reg_country = 'Украина') aLEFT JOIN

(SELECT
	pr.*
	,ph.brand_id
FROM phone_price pr
LEFT JOIN phones ph ON pr.phone_id = ph.phone_id) b

ON a.brand_id = b.brand_id AND a.color_id = b.color_id

/*
ЗАДАНИЕ 4.
Напишите SQL-запрос, который группирует строки запроса получившегося в задаче 3 по столбцам brand_name ,
color_name и находит минимальную и максимальную цену для каждого цвета
*/

SELECT	a.Brand_name	,a.color_name	,MIN(b.price)	,MAX(b.price)FROM(SELECT	brand_name	,brand_id	,color_name	,color_idFROM	brands b, colors cWHERE b.reg_country = 'Украина') aLEFT JOIN

(SELECT
	pr.*
	,ph.brand_id
FROM phone_price pr
LEFT JOIN phones ph ON pr.phone_id = ph.phone_id) b

ON a.brand_id = b.brand_id AND a.color_id = b.color_id
GROUP BY Brand_name, color_name

/*
ЗАДАНИЕ 5.
Напишите SQL-запрос, который выводит все строки столбца price таблицы phone_price. Установите связь с другими
таблицами что бы вывести столбцы с названием торговца (merchant_name), названием бренда (brand_name) и
названием телефона (phone_name) . Строки отсортировать по столбцам merchant_name, brand_name и phone_name
*/

SELECT
	pr.price
	,m.merchant_name
	,b.brand_name
	,ph.phone_name
FROM phone_price pr
LEFT JOIN merchants m ON m.merchant_id = pr.merchant_id
LEFT JOIN phones ph ON ph.phone_id = pr.phone_id
LEFT JOIN brands b ON ph.brand_id = b.brand_id
ORDER BY merchant_name, brand_name, phone_name

/*ЗАДАНИЕ 6.
В SQL-запрос из задачи 5 добавьте новый столбец с номером каждой строки. Порядок нумерации строк должен быть
задан по столбцам merchant_name, brand_name и phone_name*/

SELECT
	pr.price
	,m.merchant_name
	,b.brand_name
	,ph.phone_name
	,ROW_NUMBER() OVER(ORDER BY merchant_name, brand_name, phone_name) AS row_number
FROM phone_price pr
LEFT JOIN merchants m ON m.merchant_id = pr.merchant_id
LEFT JOIN phones ph ON ph.phone_id = pr.phone_id
LEFT JOIN brands b ON ph.brand_id = b.brand_id
ORDER BY merchant_name, brand_name, phone_name

/*
ЗАДАНИЕ 7.
В SQL-запрос из задачи 6 добавьте новый столбец с номером каждой строки. Нумерация должна вестись для каждого
торговца отдельно. Порядок нумерации строк должен быть задан по столбцам merchant_name, brand_name и
phone_name
*/

SELECT
	pr.price
	,m.merchant_name
	,b.brand_name
	,ph.phone_name
	,ROW_NUMBER() OVER(ORDER BY merchant_name, brand_name, phone_name) AS row_number
	,ROW_NUMBER() OVER(PARTITION BY merchant_name ORDER BY merchant_name, brand_name, phone_name) AS row_number_merch
FROM phone_price pr
LEFT JOIN merchants m ON m.merchant_id = pr.merchant_id
LEFT JOIN phones ph ON ph.phone_id = pr.phone_id
LEFT JOIN brands b ON ph.brand_id = b.brand_id
ORDER BY merchant_name, brand_name, phone_name

/*ЗАДАНИЕ 8.
В SQL-запрос из задачи 7 добавьте новый столбец с номером каждой строки. Нумерация должна вестись отдельно для
каждого бренда внутри каждого торговца. Порядок нумерации строк должен быть задан по столбцам merchant_name,
brand_name и phone_name*/SELECT
	pr.price
	,m.merchant_name
	,b.brand_name
	,ph.phone_name
	,ROW_NUMBER() OVER(ORDER BY merchant_name, brand_name, phone_name) AS row_number
	,ROW_NUMBER() OVER(PARTITION BY merchant_name ORDER BY merchant_name, brand_name, phone_name) AS row_number_merch
	,ROW_NUMBER() OVER(PARTITION BY merchant_name, brand_name ORDER BY merchant_name, brand_name, phone_name) AS row_number_merch_br
FROM phone_price pr
LEFT JOIN merchants m ON m.merchant_id = pr.merchant_id
LEFT JOIN phones ph ON ph.phone_id = pr.phone_id
LEFT JOIN brands b ON ph.brand_id = b.brand_id
ORDER BY merchant_name, brand_name, phone_name/*ЗАДАНИЕ 9.
В SQL-запрос из задачи 8 добавьте новый столбец с номером каждой строки. Нумерация должна вестись отдельно для
каждого бренда и независимо от торговца (сквозная нумерация внутр. бренда ). Порядок нумерации строк должен
быть задан по столбцам merchant_name, brand_name и phone_name*/SELECT
	pr.price
	,m.merchant_name
	,b.brand_name
	,ph.phone_name
	,ROW_NUMBER() OVER(ORDER BY merchant_name, brand_name, phone_name) AS row_number
	,ROW_NUMBER() OVER(PARTITION BY merchant_name ORDER BY merchant_name, brand_name, phone_name) AS row_number_merch
	,ROW_NUMBER() OVER(PARTITION BY merchant_name, brand_name ORDER BY merchant_name, brand_name, phone_name) AS row_number_merch_br
	,ROW_NUMBER() OVER(PARTITION BY brand_name ORDER BY merchant_name, brand_name, phone_name) AS row_number_merch_br2
FROM phone_price pr
LEFT JOIN merchants m ON m.merchant_id = pr.merchant_id
LEFT JOIN phones ph ON ph.phone_id = pr.phone_id
LEFT JOIN brands b ON ph.brand_id = b.brand_id
ORDER BY merchant_name, brand_name, phone_name
