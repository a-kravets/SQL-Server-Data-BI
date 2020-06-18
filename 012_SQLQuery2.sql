/*ЗАДАНИЕ 1.
Напишите SQL-запрос, который выбирает из таблицы clients все столбцы. Задайте условие отбора строк, которое выведет только те
строки, у которых год в столбце birth_date равен 2000 или 2001.
Отсортируйте выборку по месяцу даты birth_date, по возрастанию. Внутри каждого месяца отсортируйте выборку по дню даты
birth_date по убыванию. Использовать функции YEAR(), MONTH(),DAY()*/

SELECT
	*
FROM clients
WHERE YEAR(birth_date) = 2000 OR YEAR(birth_date) = 2001
ORDER BY MONTH(birth_date), DAY(birth_date)


/*ЗАДАНИЕ 2.
Напишите SQL-запрос, который выводит столбец с кварталом даты из столбца birth_date (дата рождения) таблицы clients. Задайте
условие отбора строк , которое выведет только те строки, у которых год в столбце birth_date находится в промежутке между 1990 и
1995. Сгруппируйте выборку по кварталу даты из столбца birth_date. Подсчитайте количество клиентов с датой рождения в каждом
квартале. Использовать функцию DATEPART()*/

SELECT
	DATEPART(qq, birth_date)
	,COUNT(*) AS cl_num
FROM clients
WHERE YEAR(birth_date) = 1990 OR YEAR(birth_date) = 1995
GROUP BY DATEPART(qq, birth_date)


/*ЗАДАНИЕ 3.
Напишите SQL-запрос, который выводит все столбцы из таблицы purchases. Задайте условие отбора строк, которое выведет только
те строки, у которых дата в столбце date_purch будет в промежутке с 15:00 20 августа 2019 г. по 09:00 21 августа 2019 г. Отсортируйте
выборку по столбцу date_purch*/

SELECT
	*
FROM purchases
WHERE date_purch BETWEEN DATETIMEFROMPARTS(2019, 08, 20, 15, 00, 00, 000) AND DATETIMEFROMPARTS(2019, 08, 21, 09, 00, 00, 000)
ORDER BY date_purch


/*ЗАДАНИЕ 4.
Напишите SQL-запрос, который выбирает все столбцы из таблиц purchases и clients связанных по столбцу client_id. Задайте условие
отбора строк, которое выведет только те строки, у которых месяц даты из столбцов date_purch и birth_date будет одинаковым и
день даты из этих же столбцов будет одинаковым*/

SELECT
	*
FROM purchases p
LEFT JOIN clients c ON p.client_id = c.client_id
WHERE MONTH(p.date_purch) = MONTH(c.birth_date)
	AND DAY(p.date_purch) = DAY(c.birth_date)


/*ЗАДАНИЕ 5.
В запрос написанный в предыдущем задании добавьте столбец , который вычисляет количество лет между birth_date и
date_purch*/

SELECT
	*
	,DATEDIFF(yy, birth_date, date_purch) AS dates_diff
FROM purchases p
LEFT JOIN clients c ON p.client_id = c.client_id
WHERE MONTH(p.date_purch) = MONTH(c.birth_date)
	AND DAY(p.date_purch) = DAY(c.birth_date)


/*ЗАДАНИЕ 6.
Напишите SQL-запрос без оператора FROM, который вернет одну строку с результатами выполнения функции
DATETIMEFROMPARTS(). Задать следующие аргументы: год – 2019, месяц - 8, день – 31, час -23, минута – 59, секунда –
59, миллисекунда – 999. Создайте второй столбец с результатами выполнения функции DATETIMEFROMPARTS(). Задать
следующие аргументы: год – 2019, месяц - 8, день – 31, час -23, минута – 59, секунда – 59, миллисекунда – 998.
Создайте третий столбец с результатами выполнения функции DATEDIFF(), которая посчитает разницу в миллисекундах
между датами из двух первых столбцов*/

SELECT
	DATETIMEFROMPARTS(2019, 8, 31, 23, 59, 59, 999) AS first
	,DATETIMEFROMPARTS(2019, 8, 31, 23, 59, 59, 998) AS second
	,DATEDIFF(ms, DATETIMEFROMPARTS(2019, 8, 31, 23, 59, 59, 998), DATETIMEFROMPARTS(2019, 8, 31, 23, 59, 59, 999)) AS diff

/*ЗАДАНИЕ 7.
Напишите SQL-запрос без оператора FROM, который вернет одну строку с датой равной первому дню текущего месяца.
Использовать функции GETDATE(), DATEADD(),DATEDIFF(). Создайте второй столбец, в котором преобразуйте выражение
из первого столбца так, чтобы оно вернуло первый день следующего месяца*/

SELECT
	DATEADD(mm, DATEDIFF(mm, 0, GETDATE()), 0)
	,DATEADD(mm, 1+DATEDIFF(mm, 0, GETDATE()), 0)