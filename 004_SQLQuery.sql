/*ЗАДАНИЕ 1.
Напишите SQL-запрос, который группирует строки таблицы M_PHONES по столбцу os, подсчитывает количество
наименований телефонов в каждой группе и сортирует строки получившейся выборки по этому количеству в порядке
убывания. Дайте название столбцу образуемому агрегатной функцией*/

SELECT
	os
	,COUNT(phone_name) AS q_p
FROM m_phones
GROUP BY os
ORDER BY q_p DESC

/*ЗАДАНИЕ 2.
Напишите SQL-запрос, который находит максимальную и минимальную цену телефона по каждой операционной
системе (столбец os) у каждого бренда из таблицы M_PHONES. Используйте оператор HAVING для исключения
значений NULL. Дайте название столбцам образуемым агрегатными функциями*/

SELECT
	brand_name
	,os
	,MAX(price) AS max_price
	,MIN(price) AS min_price
FROM m_phones
GROUP BY brand_name, os
HAVING (MAX(price) IS NOT NULL) AND (MIN(price) IS NOT NULL)
ORDER BY brand_name


/*ЗАДАНИЕ 3.
Напишите SQL-запрос, который находит среднюю цену телефона по каждому типу батареи (столбец battery_type) у
каждого бренда из таблицы M_PHONES. Учитывать только телефоны с емкостью батареи (столбец battery_capacity)
больше чем 3000. Показывать среднюю цену, только если количество телефонов с данным типом батареи у данного
бренда два и больше. Дайте название столбцам, образуемым агрегатными функциями*/

SELECT
	brand_name
	,battery_type
	,AVG(price) AS avg_price
	,COUNT(battery_type) AS count_battery -- столбец для проверки
FROM m_phones
WHERE battery_capacity > 3000
GROUP BY brand_name, battery_type
HAVING COUNT(battery_type) >= 2
ORDER BY brand_name, count_battery -- для удобства

/*ЗАДАНИЕ 4.
Напишите SQL-запрос, который группирует строки таблицы M_PHONES по столбцам brand_name, battery_type, ram и
подсчитывает количество строк в каждой группе. Отобрать только строки в которых столбец brand_name может быть
равен только 'huawei' или 'xiaomi', а столбец ram может быть равен только 4 или 8. Выборка должна быть
отсортирована по столбцам brand_name, battery_type, ram. Дайте название столбцу образуемому агрегатной
функцией. Добавьте к оператору группировки with rollup*/

SELECT
	brand_name
	,battery_type
	,ram
	,COUNT(*) AS counts
FROM m_phones
WHERE
	brand_name IN ('huawei', 'xiaomi')
	AND ram IN (4, 8)
GROUP BY 
	brand_name, battery_type, ram WITH ROLLUP
ORDER BY brand_name, battery_type, ram


/*ЗАДАНИЕ 5.
Напишите SQL-запрос, который группирует строки таблицы M_PHONES по столбцам brand_name, battery_type, ram и
подсчитывает количество строк в каждой группе. Отобрать только строки, в которых столбец brand_name может быть
равен только 'huawei' или 'xiaomi', а столбец ram может быть равен только 4 или 8. Выборка должна быть
отсортирована по столбцам brand_name, battery_type, ram. Дайте название столбцу образуемому агрегатной
функцией. Добавьте к оператору группировки with cube*/

SELECT
	brand_name
	,battery_type
	,ram
	,COUNT(*) AS counts
FROM m_phones
WHERE
	brand_name IN ('huawei', 'xiaomi')
	AND ram IN (4, 8)
GROUP BY brand_name, battery_type, ram WITH CUBE
ORDER BY brand_name, battery_type, ram

/*ЗАДАНИЕ 6.
Напишите SQL-запрос, который группирует строки таблицы M_PHONES по столбцам brand_name, battery_type, ram и
подсчитывает количество строк в каждой группе. Отобрать только строки в которых столбец brand_name может быть
равен только 'huawei' или 'xiaomi', а столбец ram может быть равен только 4 или 8. Выборка должна быть
отсортирована по столбцам brand_name, battery_type, ram. Дайте название столбцу образуемому агрегатной
функцией. Примените с оператором группировки grouping sets*/
SELECT
	brand_name
	,battery_type
	,ram
	,COUNT(*) AS counts
FROM m_phones
WHERE
	brand_name IN ('huawei', 'xiaomi')
	AND ram IN (4, 8)
GROUP BY GROUPING SETS(brand_name, battery_type, ram)
ORDER BY brand_name, battery_type, ram

/*ЗАДАНИЕ 7.
Напишите SQL-запрос, который выбирает из таблицы M_PHONES столбцы brand_name, phone_name, memory, price.
Отобрать только те строки, где столбец brand_name равен 'apple'. Отсортировать строки по столбцам memory, price.
Добавьте столбец, который в каждой строке выборки будет показывать количество наименований телефонов для
соответствующего объёма памяти (применить over(partition by)). Добавьте столбец, который в каждой строке
выборки будет показывать среднюю цену телефона для соответствующего объёма памяти (применить over(partition
by)). Дайте названия добавленным столбцам*/

SELECT
	brand_name
	,phone_name
	,memory
	,price
	,COUNT(phone_name) OVER(PARTITION BY memory) AS count_memory
	,AVG(price) OVER(PARTITION BY memory) AS avg_price
FROM m_phones
WHERE
	brand_name = 'apple'
ORDER BY memory, price


/*ЗАДАНИЕ 8.
Напишите SQL-запрос, который выбирает из таблицы M_PHONES столбцы brand_name, phone_name, memory, price.
Отобрать только те строки, где столбец brand_name равен 'samsung', а столбец price не является NULL .
Отсортировать строки по столбцам memory, price. Используя over() добавьте столбец c порядковым номером строки,
порядок сортировки - memory, price. Используя over() добавьте ещё один столбец c порядковым номером строки,
порядок сортировки – price по убыванию. Дайте названия добавленным столбцам*/

SELECT
	brand_name
	,phone_name
	,memory
	,price
	,ROW_NUMBER() OVER(ORDER BY memory, price) AS row_number
	,ROW_NUMBER() OVER(ORDER BY price DESC) AS row_number_price
FROM m_phones
WHERE
	brand_name = 'samsung'
	AND price IS NOT NULL
ORDER BY memory, price