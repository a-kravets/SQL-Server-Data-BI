/*ЗАДАНИЕ 1.
C помощью меню SSMS создайте таблицу exchange_rate со столбцами cur_name nchar(3) и rate numeric(4,2). Вставте в неё строку со
значениями 'USD' и 25*/

SELECT * FROM exchange_rate

INSERT INTO exchange_rate (cur_name, rate)
VALUES ('USD', 25)


/*ЗАДАНИЕ 2.
Напишите SQL-запрос, который соединяет таблицы phone_price и exchange_rate неявным соединением. Запрос должен возвращать
все столбцы из таблицы phone_price, кроме столбца price. Создайте вычисляемый столбец с выражением round(price/rate,0) as price.
Создайте представление (VIEW) с именем phone_price_usd на основе написанного запроса*/

CREATE VIEW phone_price_usd
AS
SELECT 
	phone_id
	,color_id
	,merchant_id
	,ROUND(price/rate, 0) AS price_usd
FROM phone_price, exchange_rate


/*ЗАДАНИЕ 3.
Вставьте в таблицу exchange_rate новую строку со значениями 'EUR' и 27. Проверьте что возвращает запрос выбирающий все строки
и столбцы из представления phone_price_usd*/

INSERT INTO exchange_rate (cur_name, rate)
VALUES ('EUR', 27)

SELECT * FROM phone_price_usd

/*ЗАДАНИЕ 4.
Добавьте в запрос из задания 2 условие WHERE cur_name=’USD’. С помощью команды ALTER VIEW измените представление
phone_price_usd на основе запроса с фильтром cur_name=’USD’*/

ALTER VIEW phone_price_usd
AS
SELECT 
	phone_id
	,color_id
	,merchant_id
	,ROUND(price/rate, 0) AS price_usd
FROM phone_price, exchange_rate
WHERE cur_name = 'USD'

/*ЗАДАНИЕ 5.
Создайте представление с именем phone_price_eur, которое будет возвращать прайс-лист с ценами пересчитанными в
евро*/

CREATE VIEW phone_price_eur
AS
SELECT 
	phone_id
	,color_id
	,merchant_id
	,ROUND(price/rate, 0) AS price_eur
FROM phone_price, exchange_rate
WHERE cur_name = 'EUR'

/*ЗАДАНИЕ 6.
С помощью команды ALTER TABLE в таблицу exchange_rate добавьте (ADD) новые столбцы: date_from date и date_to
date. Заполните столбец date_from значением DATEFROMPARTS(2020,1,1), а столбец date_to значением
DATEFROMPARTS(2100,12,31) . Вставьте в таблицу exchange_rate две новые строки со значениями 'USD' ,24,
DATEFROMPARTS(2019,1,1), DATEFROMPARTS(2019,12,31) и 'EUR' ,26, DATEFROMPARTS(2019,1,1) ,
DATEFROMPARTS(2019,12,31) в столбцы cur_name,currency,date_from,date_to*/

ALTER TABLE exchange_rate
ADD date_from date,
	date_to date;

INSERT INTO exchange_rate (date_from, date_to)
VALUES (DATEFROMPARTS(2020,1,1), DATEFROMPARTS(2100,12,31))

INSERT INTO exchange_rate (cur_name, rate, date_from, date_to)
VALUES	('USD' ,24, DATEFROMPARTS(2019,1,1), DATEFROMPARTS(2019,12,31)),
		('EUR' ,26, DATEFROMPARTS(2019,1,1), DATEFROMPARTS(2019,12,31));

SELECT * from exchange_rate

/*ЗАДАНИЕ 7.
Измените представления phone_price_usd и phone_price_eur так, чтобы в них содержались только те строки, которые
соответствуют курсу валют на сегодня*/

ALTER VIEW phone_price_usd
AS
SELECT 
	phone_id
	,color_id
	,merchant_id
	,ROUND(price/rate, 0) AS price_usd
FROM phone_price, exchange_rate
WHERE cur_name = 'USD'
	AND GETDATE() BETWEEN date_from AND date_to

ALTER VIEW phone_price_eur
AS
SELECT 
	phone_id
	,color_id
	,merchant_id
	,ROUND(price/rate, 0) AS price_usd
FROM phone_price, exchange_rate
WHERE cur_name = 'EUR'
	AND GETDATE() BETWEEN date_from AND date_to