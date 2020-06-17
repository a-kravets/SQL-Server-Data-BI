USE P_STORE

SELECT
	b.brand_name
	,COUNT(*) AS q_sell
	,SUM(s.price) AS tot_grn
	,s.date_purch
FROM purchases s
	LEFT JOIN phones p ON s.phone_id = p.phone_id 
	LEFT JOIN brands b ON p.brand_id = b.brand_id 
WHERE s.phone_id = 916472 AND s.color_id = 17
	AND YEAR(s.date_purch)=2019
	--and MONTH(date_purch) between 10 and 12
	AND DATEPART(qq, date_purch) = 4/*
	AND DATEPART(mm, date_purch) = 12
	AND DATEPART(dd, date_purch) = 31*/
GROUP BY b.brand_name, s.date_purch




SELECT
	c.client_name
	,m.merchant_name
	,date_purch 
	--,CAST(date_purch as date)
	--,CAST('12.10.2019' AS datetime)
	--,DATEFROMPARTS(2019, 2, 2)
FROM purchases p
LEFT JOIN merchants m ON p.merchant_id = m.merchant_id
LEFT JOIN clients c ON p.client_id = c.client_id
WHERE p.phone_id = 916472 AND p.color_id = 17
	AND date_purch >= DATEFROMPARTS(2019, 2, 2) 
	--AND  date_purch <= DATEFROMPARTS(2019, 2, 27)
	--AND  date_purch < DATEFROMPARTS(2019, 2, 28)
	AND date_purch <= DATETIMEFROMPARTS(2019, 2, 27, 23, 59, 59, 999)
ORDER BY date_purch




SELECT GETDATE() AS c_d
	,EOMONTH(GETDATE()) AS last_d	--last day of the current month
	,DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()),1)	AS last_d -- first day
	,DATENAME(mm, GETDATE()) AS name_m	-- month name
	,DATENAME(dw, GETDATE()) AS name_d	-- weekday name




SELECT
	client_name
	,birth_date
	,client_tlf
	--,DATEADD(DAY,5,GETDATE())
FROM  clients
WHERE 
	--DAY(birth_date) = DAY(GETDATE())
	--AND MONTH(birth_date) = MONTH(GETDATE())
	DAY(DATEADD(DAY,5,GETDATE())) = DAY(birth_date) 
	AND MONTH(DATEADD(DAY,5,GETDATE())) = MONTH(birth_date)



SELECT
	client_id
	,COUNT(price) AS qu_sell
	,MIN(date_purch) AS f_p
	,MAX(date_purch) AS last_p
	,DATEDIFF(dd, MIN(date_purch), MAX(date_purch)) AS d_b_p -- diff between 2 purchases
FROM purchases
WHERE YEAR(date_purch) = 2019
GROUP BY client_id
HAVING COUNT(price) = 2
ORDER BY d_b_p



SELECT 
	GETDATE() AS c_d
	,DATEADD(dd, DATEDIFF(dd, 0, GETDATE()), 0) AS trunc_d -- усеченная до полуночи
	,DATEDIFF(dd, 0, GETDATE()) AS trunc_d2	-- к-во суток между началом отсчета дат и текущей датой
	,DATEADD(dd, (-1)*DATEDIFF(dd, 0, GETDATE()), GETDATE()) AS trunc_start-- дата - начало отсчета
	,DATEADD(mm, DATEDIFF(mm, 0, GETDATE()), 0) AS trunc_m	-- усеченная до 1-го дня текущего месяца
	,DATEADD(yy, DATEDIFF(yy, 0, GETDATE()), 0) AS trunc_y	-- усеченная до 1-го дня текущего года