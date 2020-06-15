
USE P_STORE
/*
SELECT
	a.merchant_name
	,a.Brand_name
	,a.phone_name
	,b.q_sold
FROM 

(SELECT
	b.merchant_name
	,a.Brand_name
	,a.phone_name
	,b.merchant_id
	,a.phone_id
FROM

(SELECT 
	b.brand_name
	,ph.phone_name
	,ph.phone_id
FROM brands b, phones ph
WHERE ph.brand_id = 5) a
,
(SELECT
	m.merchant_name
	,m.merchant_id
FROM merchants m
WHERE m.merchant_id IN (44, 88)) b
--ORDER BY b.merchant_name
) a

LEFT JOIN

(SELECT
	p.merchant_id
	,ph.phone_id
	,COUNT(price) AS q_sold
FROM purchases p
LEFT JOIN phones ph ON ph.phone_id = p.phone_id
WHERE
	p.merchant_id IN (44, 88)
	AND ph.brand_id = 5
GROUP BY
	p.merchant_id
	,ph.phone_id
) b
ON a.merchant_id = b.merchant_id AND a.phone_id = b.phone_id

------------------------------------------------------
*/


/*
SELECT
	merchant_name
	,Brand_name
	,color_name
	,q_sold
	,SUM(q_sold) OVER() AS total -- overall and the same total specified in every row
	-- we don't need to group results to see aggregate result
	,SUM(q_sold) OVER(PARTITION BY merchant_name) AS total_merch --total by merchant name will show total of the merchant name category 
	,SUM(q_sold) OVER(PARTITION BY merchant_name, brand_name) AS total_merch_brand
	,SUM(q_sold) OVER(PARTITION BY merchant_name, brand_name ORDER BY brand_name, q_sold) AS total_merch_brand_ordered
	-- ORDER BY in OVER means that summs should be calculated by accuring total step by step in specified order
	,AVG(q_sold*1.0) OVER(PARTITION BY merchant_name, brand_name ORDER BY brand_name, q_sold) AS avg_merch_brand_ordered
	,SUM(q_sold) OVER(PARTITION BY merchant_name, brand_name ORDER BY brand_name, q_sold
		ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS total_q1
	,SUM(q_sold) OVER(PARTITION BY merchant_name, brand_name ORDER BY brand_name, q_sold
		ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS total_q2
	,COUNT(q_sold) OVER(PARTITION BY merchant_name, brand_name ORDER BY brand_name, q_sold) AS count_merch_brand_ordered
	,RANK() OVER(PARTITION BY merchant_name, brand_name ORDER BY brand_name, q_sold) AS rank
	,DENSE_RANK() OVER(PARTITION BY merchant_name, brand_name ORDER BY brand_name, q_sold) AS dense_rank
	,ROW_NUMBER() OVER(PARTITION BY merchant_name, brand_name ORDER BY brand_name, q_sold) AS row_number
	,NTILE(2) OVER(PARTITION BY merchant_name, brand_name ORDER BY brand_name, q_sold) AS ntile
	,LAG(q_sold, 1, 999) OVER(PARTITION BY merchant_name, brand_name ORDER BY brand_name, q_sold) AS lag
	,LEAD(q_sold, 1, 999) OVER(PARTITION BY merchant_name, brand_name ORDER BY brand_name, q_sold) AS lag
	,LAST_VALUE(q_sold) OVER(PARTITION BY merchant_name, brand_name ORDER BY brand_name, q_sold) AS last_value
	,FIRST_VALUE(q_sold) OVER(PARTITION BY merchant_name, brand_name ORDER BY brand_name, q_sold) AS first_value
FROM

(SELECT
	m.merchant_name
	,b.Brand_name
	,c.color_name
	,COUNT(*) AS q_sold
FROM purchases p
LEFT JOIN phones ph ON p.phone_id = ph.phone_id
LEFT JOIN brands b ON b.brand_id = ph.brand_id
LEFT JOIN merchants m ON m.merchant_id = p.merchant_id
LEFT JOIN colors c ON c.color_id = p.color_id
GROUP BY
	m.merchant_name
	,b.Brand_name
	,c.color_name
) a

ORDER BY
	merchant_name
	,Brand_name
	,q_sold
*/



SELECT
	c.client_name
	,c.client_tlf
	,c.birth_date
	,'no sales' AS col1
FROM clients c
LEFT JOIN purchases p ON p.client_id = c.client_id
WHERE p.client_id IS NULL

UNION

SELECT
	c.client_name
	,c.client_tlf
	,c.birth_date
	,'>= 50000' AS col1
FROM clients c
WHERE EXISTS (
	SELECT *
	FROM purchases p
	WHERE p.client_id = c.client_id
		AND p.price >= 50000)