USE P_STORE

SELECT
	m.merchant_name
	,b.Brand_name
	,ph.phone_name
	,c.color_name
	,p.price
	,IIF(p.color_id = 11, 'Sales*', '') AS sales
	,IIF(s.amount < 10, IIF(s.amount != 0, 'Last phones', 'Out of stock'), '') AS stock
FROM phone_price p
LEFT JOIN merchants m ON m.merchant_id = p.merchant_id
LEFT JOIN phones ph ON ph.phone_id = p.phone_id
LEFT JOIN brands b ON b.brand_id = ph.brand_id
LEFT JOIN colors c ON c.color_id = p.color_id
LEFT JOIN stock s ON p.merchant_id = s.merchant_id AND p.phone_id = s.phone_id AND c.color_id = s.color_id
ORDER BY m.merchant_name, b.Brand_name, ph.phone_name, c.color_name



SELECT
	ph.phone_name
	,ph.battery_type
	,CASE trim(battery_type)
		WHEN 'Li-Ion' THEN '1st'
		WHEN 'Li-Pol' THEN '2nd'
		ELSE 'na'
	END AS b_type
FROM phones ph




SELECT
	a.Brand_name
	,a.phone_name
	,a.avg_price
	,CASE
		WHEN a.avg_price >= 20000 THEN 'Premium'
		WHEN a.avg_price >= 10000 AND a.avg_price < 20000 THEN 'Standard2'
		WHEN a.avg_price >= 6000 AND a.avg_price < 10000 THEN 'Standard'
		WHEN a.avg_price >= 2000 AND a.avg_price < 6000 THEN 'Budget'
		WHEN a.avg_price < 2000 THEN 'Free'
		ELSE '***'
	END AS class
FROM (

SELECT
	b.Brand_name
	,ph.phone_name
	,ROUND(AVG(p.price), 0) AS avg_price
FROM phone_price p
LEFT JOIN phones ph ON p.phone_id = ph.phone_id
LEFT JOIN brands b ON b.brand_id = ph.brand_id
GROUP BY b.Brand_name, ph.phone_name
) AS a
ORDER BY class




SELECT
	pc.phone_id
	,pc.negative
	,pc.neutral
	,pc.positive
	,pc.enthusiastic
	,ISNULL(pc.negative * (-1), 0) + ISNULL(pc.neutral * (-1), 0) + ISNULL(pc.positive, 0) + ISNULL(pc.enthusiastic * (0.5), 0) AS comm_points
	,COALESCE(pc.enthusiastic, pc.positive, 0) / COALESCE(pc.negative, pc.neutral, 1) AS comm_ratio
	--,COALESCE() AS 
FROM phone_comment pc
ORDER BY comm_ratio DESC




SELECT
	COUNT(*) -- all rows
	,COUNT(brand_id) -- all except null
	,COUNT(NULLIF(brand_id, 5)) -- if brand_id = 5, returns NULL
FROM phones
