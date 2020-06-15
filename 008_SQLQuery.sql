/*В результирующем наборе вам понадобятся столбцы:
- Имя клиента (таблица clients, столбец client_name)
- Дата покупки (таблица purchases, столбец date_purch)
- Название бренда телефона (таблица brands, столбец Brand_name)
- Название модели телефона (таблица phones, столбец phone_name)
- Цвет корпуса телефона (таблица colors, столбец color_name)
- Стоимость покупки (таблица purchases, столбец price)

Вас не интересуют повторные покупки клиентов, покупающих самые дешевые телефоны, поэтому вы решили, что
нужно, чтобы отбирались продажи только тем клиентам, кто совершил две и более покупки за все время и со
средней ценой покупки больше, чем 3000 (столбец price в таблице purchases).*/

SELECT
	cl.client_name
	,p.date_purch
	,b.Brand_name
	,ph.phone_name
	,c.color_name
	,p.price
FROM phones ph
LEFT JOIN purchases p ON p.phone_id = ph.phone_id
LEFT JOIN clients cl ON cl.client_id = p.client_id
LEFT JOIN brands b ON b.brand_id = ph.brand_id
LEFT JOIN colors c ON c.color_id = p.color_id
WHERE c.color_id IN (
	SELECT client_id FROM purchases
	GROUP BY client_id
	HAVING COUNT(client_id) >= 2 --только с двумя и больше покупками
	AND AVG(price) > 3000
	)