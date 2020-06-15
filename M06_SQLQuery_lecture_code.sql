USE P_STORE

--SELECT COUNT(*) FROM phones --1581
--SELECT COUNT(*) FROM brands --92

--SELECT * FROM phones INNER JOIN brands ON phones.brand_id = brands.brand_id --1579

/*
SELECT * FROM phones LEFT JOIN brands ON phones.brand_id = brands.brand_id --1581
WHERE brands.brand_id IS NULL --2 */

/*
SELECT * FROM phones RIGHT JOIN brands ON phones.brand_id = brands.brand_id --1582
WHERE phones.phone_id IS NULL --3 */

/*
SELECT * FROM phones FULL JOIN brands ON phones.brand_id = brands.brand_id --1584
WHERE phones.phone_id IS NULL OR brands.brand_id IS NULL --5 */

/*
SELECT
	b.brand_name
	,b.brand_id
	,(SELECT COUNT(*) FROM phones AS p WHERE p.brand_id = b.brand_id) AS phone_count
	,(SELECT COUNT(*) FROM phones) AS q_total
FROM brands b */

/*
SELECT
	a.Brand_name
	,phone_count
	,q_total
	,ROUND(CAST(phone_count AS FLOAT)/q_total * 100, 1) AS procent
FROM (
SELECT
	b.brand_name
	,b.brand_id
	,(SELECT COUNT(*) FROM phones AS p WHERE p.brand_id = b.brand_id) AS phone_count
	,(SELECT COUNT(*) FROM phones) AS q_total
FROM brands b
) a
ORDER BY procent DESC */

/*
SELECT
	m.merchant_name
	,c.color_name
	,ph.phone_name
	,Brand_name
	,p.price
FROM phone_price p
LEFT JOIN merchants m ON p.merchant_id = m.merchant_id
LEFT JOIN colors c ON p.color_id = c.color_id
LEFT JOIN phones ph ON p.phone_id = ph.phone_id
LEFT JOIN brands b ON ph.brand_id = b.brand_id
WHERE p.price >= (SELECT AVG(price) FROM phone_price)-100
	AND p.price <= (SELECT AVG(price) FROM phone_price)+100 */

/*SELECT
	m.merchant_name
	,c.color_name
	,ph.phone_name
	,Brand_name
	,p.price
	,ph.memory
FROM phone_price p
LEFT JOIN merchants m ON p.merchant_id = m.merchant_id
LEFT JOIN colors c ON p.color_id = c.color_id
LEFT JOIN phones ph ON p.phone_id = ph.phone_id
LEFT JOIN brands b ON ph.brand_id = b.brand_id
WHERE ph.memory > ALL
	(SELECT DISTINCT memory FROM phones
	WHERE brand_id = 5 AND memory IS NOT NULL) */

SELECT
	m.merchant_name
	,c.color_name
	,ph.phone_name
	,Brand_name
	,p.price
	,ph.memory
FROM phone_price p
LEFT JOIN merchants m ON p.merchant_id = m.merchant_id
LEFT JOIN colors c ON p.color_id = c.color_id
LEFT JOIN phones ph ON p.phone_id = ph.phone_id
LEFT JOIN brands b ON ph.brand_id = b.brand_id
WHERE ph.memory = ANY
	(SELECT DISTINCT memory FROM phones
	WHERE brand_id = 5 AND memory IS NOT NULL)
ORDER BY ph.memory DESC