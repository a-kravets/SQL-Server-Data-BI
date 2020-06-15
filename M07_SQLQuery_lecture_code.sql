USE P_STORE
/*
SELECT merchant_name, Brand_name, phone_name, color_name, price
FROM phone_price
LEFT JOIN merchants ON phone_price.merchant_id = merchants.merchant_id
LEFT JOIN colors ON colors.color_id = phone_price.color_id
LEFT JOIN phones ON phones.phone_id = phone_price.phone_id
LEFT JOIN brands ON brands.brand_id = phones.brand_id
WHERE phones.phone_id IN (
	SELECT phone_id FROM stock
	GROUP BY phone_id
	HAVING SUM(amount) <= 10
	)
*/

/*
SELECT merchant_name, Brand_name, phone_name, color_name, price
FROM phone_price
LEFT JOIN merchants ON phone_price.merchant_id = merchants.merchant_id
LEFT JOIN colors ON colors.color_id = phone_price.color_id
LEFT JOIN phones ON phones.phone_id = phone_price.phone_id
LEFT JOIN brands ON brands.brand_id = phones.brand_id
WHERE EXISTS (
	SELECT * FROM stock s
	WHERE s.merchant_id = merchants.merchant_id
		AND phones.phone_id = s.phone_id
		AND s.color_id = colors.color_id
		AND s.amount <= 5)
*/

/*
SELECT
	*
FROM brands, phones
*/

/*
SELECT b.Brand_name, p.phone_name
FROM phones p
LEFT JOIN brands b ON p.brand_id = b.brand_id
WHERE p.memory = 512
UNION ALL
SELECT b.Brand_name, p.phone_name
FROM phones p
LEFT JOIN brands b ON p.brand_id = b.brand_id
WHERE p.ram = 8
*/


