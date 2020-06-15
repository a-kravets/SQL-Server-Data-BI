USE P_STORE

--SELECT COUNT(phone_name) FROM m_phones
--SELECT DISTINCT(brand_name) FROM m_phones
SELECT brand_name, phone_name, price
,AVG(price) OVER() AS total_avg_price
,AVG(price) OVER(PARTITION BY brand_name) AS avg_price
,COUNT(phone_name) OVER() AS total_total_count
,COUNT(phone_name) OVER(PARTITION BY brand_name) AS abrand_count
,ROW_NUMBER() OVER(ORDER BY brand_name) AS row_num
,ROW_NUMBER() OVER(PARTITION BY brand_name ORDER BY brand_name) AS int_row_num
FROM m_phones
WHERE memory = 256
	AND price IS NOT NULL
ORDER BY brand_name, price