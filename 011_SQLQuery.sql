/*ЗАДАНИЕ 1. Напишите SQL-запрос, который выбирает все строки из таблицы phones. Используя функцию ISNULL() создайте вычисляемый столбец, который будет показывать значение столбца battery_capacity если он не пуст и 0 если он равен NULL. Используя функцию ISNULL() создайте второй вычисляемый столбец вычисляемый столбец, который будет показывать значение столбца battery_type если он не пуст и текст «Нет данных» если он равен NULL. Дайте новым столбцам имена battery_capacity и battery_type*/  SELECT 	* 	,ISNULL(battery_capacity, 0) AS b_cap 	,ISNULL(battery_type, 'Нет данных') AS b_type FROM phones  /*ЗАДАНИЕ 2. Используйте запрос из задачи 1 в операторе FROM для нового нового запроса. Создайте вычисляемый столбец используя выражение CASE WHEN. Если battery_capacity=0 значение столбца должно быть «Нет данных» , если battery_capacity<1000 0 значение столбца должно быть «0-1000» , если battery_capacity<5000 0 значение столбца должно быть «1000-5000» , если battery_capacity<10000 0 значение столбца должно быть «5000-10000» и если battery_capacity>=10000 значение столбца должно быть «>10000». Дайте новому столбцу имя battery_capacity. Второй столбец запроса - battery_type – оставьте без изменений*/  SELECT 	* 	,ISNULL(battery_capacity, 0) AS b_cap 	,ISNULL(battery_type, 'Нет данных') AS b_type 	,CASE 		WHEN battery_capacity = 0 THEN 'Нет данных' 		WHEN battery_capacity < 1000 THEN '0-1000' 		WHEN battery_capacity < 5000 THEN '1000-5000' 		WHEN battery_capacity < 10000 THEN '5000-10000' 		WHEN battery_capacity >= 10000 THEN '>10000' 	END AS b_cap2 FROM phones  /*ЗАДАНИЕ 3. Используйте запрос из задачи 2 в операторе FROM для нового нового запроса . Сгруппируйте строки по столбцу battery_capacity . Добавьте столбец с количеством строк в каждой группе. Добавьте новый столбец используя агрегатную функцию SUM(). Вместо аргумента функции напишите функцию IIF (), которая сравнивает значение столбца battery_type со строкой «Li-Ion». Если равенство выполняется IIF() должен вернуть 1 , если нет, то 0. Добавьте новый столбец используя агрегатную функцию SUM(). Вместо аргумента функции напишите функцию IIF (), которая сравнивает значение столбца battery_type со строкой «Li-Pol». Если равенство выполняется IIF() должен вернуть 1 , если нет, то 0*/   SELECT
	a.battery_capacity
    ,SUM(IIF(trim(battery_type) = 'Li-Ion', 1, 0)) AS sum_ion
	,SUM(IIF(trim(battery_type) = 'Li-Pol', 1, 0)) AS sum_pol
FROM (
	SELECT
	CASE
		WHEN battery_capacity = 0 THEN 'Нет данных'
		WHEN battery_capacity < 1000 THEN '0-1000'
		WHEN battery_capacity < 5000 THEN '1000-5000'
		WHEN battery_capacity < 10000 THEN '5000-10000'
		WHEN battery_capacity >= 10000 THEN '>10000'
	END AS battery_capacity
	,battery_type
	FROM (
		SELECT
			ISNULL(battery_capacity, 0) AS battery_capacity
			,ISNULL(battery_type, 'Нет данных') AS battery_type
		FROM phones
		) a
	) a
GROUP BY a.battery_capacity
ORDER BY a.battery_capacity   /*ЗАДАНИЕ 4. Напишите SQL-запрос, который выбирает все строки столбцов conn_type01, conn_type, conn_type2, conn_type3, conn_type0 из таблицы phones. Используя функцию COALESCE() создайте вычисляемый столбец, в котором будет выводится первое непустое значение из списка столбцов: conn_type01, conn_type, conn_type2, conn_type3. Если все они пусты, вывести «Нет данных»*/  SELECT 	conn_type01 	,conn_type 	,conn_type2 	,conn_type3 	,conn_type0 	,COALESCE(conn_type01, conn_type, conn_type2, conn_type3, 'Нет данных') FROM phones  /*ЗАДАНИЕ 5. Напишите SQL-запрос, который выбирает столбцы phone_name,main_camera из таблицы phones. Используя функцию NULLIF() в условии WHERE выберите только те строки, где значение столбца main_camera не равно нулю и не пусто*/  SELECT 	phone_name 	,main_camera FROM phones WHERE main_camera = NULLIF(main_camera, 0) ORDER BY main_camera