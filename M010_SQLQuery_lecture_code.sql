USE P_STORE
/*
SELECT
	phone_name
	,memory
	,CHARINDEX('GB', phone_name) AS pos_gb
	,SUBSTRING(phone_name, CHARINDEX('GB', phone_name)-2, 2 )
FROM
	phones
WHERE memory IS NULL
	AND CHARINDEX('GB', phone_name) <> 0
*/

/*
SELECT
	phone_name
	,review
	,PATINDEX('%20__ г%', review) AS i_year
	,SUBSTRING(review, PATINDEX('%20%', review), 4) AS year
FROM phones
WHERE review IS NOT NULL
	AND PATINDEX('%201%', review) <> 0
*/

/*
SELECT
	b.brand_name
	,f.phone_name
	,CONCAT(UPPER(TRIM(b.brand_name)), SPACE(1), f.phone_name) AS brand_phone
FROM
	phones f
	LEFT JOIN brands b ON b.brand_id = f.brand_id
*/

SELECT
	color_name
	,SUBSTRING(color_name, 2, LEN(color_name)-1) -- word except 1st letter
	,UPPER(LEFT(color_name, 1)) -- first letter uppercase
	,CONCAT(UPPER(LEFT(color_name, 1)), SUBSTRING(color_name, 2, LEN(color_name)-1))
FROM colors