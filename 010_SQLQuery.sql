/*ЗАДАНИЕ 1.
Напишите SQL-запрос, который выбирает из таблицы phones столбец os. Используя операцию сравнения like
отобрать только те строки, которые начинаются с «android v»*/

SELECT
	os
FROM phones
WHERE os LIKE 'android v%'

/*ЗАДАНИЕ 2.
Используя функцию charindex() добавьте в запрос из задачи 1 столбец с номером позиции символа «.» в os*/

SELECT
	os
	,CHARINDEX('.', os) AS dot_pos
FROM phones
WHERE os LIKE 'android v%'

/*ЗАДАНИЕ 3.
Используя функцию charindex() добавьте в запрос из задачи 2 столбец с номером позиции символа «v» в os*/

SELECT
	os
	,CHARINDEX('.', os) AS dot_pos
	,CHARINDEX('v', os) AS v_pos
FROM phones
WHERE os LIKE 'android v%'

/*ЗАДАНИЕ 4.
Используя функцию substring() добавьте в запрос из задачи 3 столбец c подстрокой из столбца os которая начинается
с номера позиции символа «v» плюс 1 и имеет длину: номер позиции символа «.» минус номер позиции символа
«v» минус 1. Дайте название столбцу*/

SELECT
	os
	,CHARINDEX('.', os) AS dot_pos
	,CHARINDEX('v', os) AS v_pos
	,SUBSTRING(os, CHARINDEX('v', os) + 1, CHARINDEX('.', os) - (CHARINDEX('v', os))-1) AS ss_vdot
FROM phones
WHERE os LIKE 'android v%'

/*ЗАДАНИЕ 5.
Используя функцию substring() добавьте в запрос из задачи 4 столбец c подстрокой из столбца os которая начинается
с номера позиции символа «.» плюс 1 длиной 1 символ. Дайте название столбцу*/

SELECT
	os
	,CHARINDEX('.', os) AS dot_pos
	,CHARINDEX('v', os) AS v_pos
	,SUBSTRING(os, CHARINDEX('v', os) + 1, CHARINDEX('.', os) - (CHARINDEX('v', os))-1) AS ss_vdot
	,SUBSTRING(os, CHARINDEX('.', os) + 1, 1) AS ss_dot_1
FROM phones
WHERE os LIKE 'android v%'

/*ЗАДАНИЕ 6.
В запрос из задачи 5 добавьте сортировку по двум последним добавленным столбцам*/

SELECT
	os
	,CHARINDEX('.', os) AS dot_pos
	,CHARINDEX('v', os) AS v_pos
	,SUBSTRING(os, CHARINDEX('v', os) + 1, CHARINDEX('.', os) - (CHARINDEX('v', os))-1) AS ss_vdot
	,SUBSTRING(os, CHARINDEX('.', os) + 1, 1) AS ss_dot_1
FROM phones
WHERE os LIKE 'android v%'
ORDER BY ss_vdot, ss_dot_1

/*ЗАДАНИЕ 7.
В запросе из задачи 6 умножте два последних добавленных столбца на 1. Как изменился порядок сортировки?*/

SELECT
	os
	,CHARINDEX('.', os) AS dot_pos
	,CHARINDEX('v', os) AS v_pos
	,(SUBSTRING(os, CHARINDEX('v', os) + 1, CHARINDEX('.', os) - (CHARINDEX('v', os))-1)) * 1 AS ss_vdot
	,(SUBSTRING(os, CHARINDEX('.', os) + 1, 1)) * 1 AS ss_dot_1
FROM phones
WHERE os LIKE 'android v%'
ORDER BY ss_vdot, ss_dot_1

/*ЗАДАНИЕ 8.
Напишите SQL-запрос, который группирует строки таблицы clients по первой букве столбца client_name. (Группировку
необходимо делать по вычисляемому с помощью функции столбцу). Добавте сортировку строк полученного запроса*/

SELECT
	SUBSTRING(client_name, 1, 1)
FROM clients
GROUP BY SUBSTRING(client_name, 1, 1)
ORDER BY SUBSTRING(client_name, 1, 1)

/*ЗАДАНИЕ 9.
Напишите SQL-запрос, который выбирает из таблицы clients строки, где первые 5 символов столбца client_name
читаются одинаково с права на лево. Использовать функцию REVERSE()*/

SELECT
	client_name
	,SUBSTRING(client_name, 1, 5) AS ss
	,REVERSE(SUBSTRING(client_name, 1, 5)) AS r_ss
FROM clients
WHERE SUBSTRING(client_name, 1, 5) = REVERSE(SUBSTRING(client_name, 1, 5))


/*ЗАДАНИЕ 10.
Используя функцию replace() добавьте в запрос из задачи 1 новый столбец, который представляет собой столбец os с
буквой «v» заменённой на «версия»*/

SELECT
	os
	,REPLACE(os, 'v', 'версия') AS repl_v
FROM phones
WHERE os LIKE 'android v%'

