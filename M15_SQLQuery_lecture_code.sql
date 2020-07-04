-- БУДЬТЕ ВНИМАТЕЛЬНЫ!!!
-- Выполнение этих скриптов приведет к изменению/удалению
-- некоторых данных в вашей базе данных

-- 1. ***************** INSERT: вставка одной строки в таблицу *******************
/*
	insert into new_phone_price (phone_id,merchant_id,color_id,price)
		values (10001,44,9,1111)
*/


-- 2. ***************** INSERT: вставка многих строк на основе запроса ***********
/*
	insert into new_phone_price (phone_id,merchant_id,color_id,price)
		select
			p.phone_id
			,m.merchant_id
			,c.color_id
			,case
				when phone_id=157759 then 8877
				when phone_id=157763 then 6655
				else 0
			end as price
		from phones p, merchants m ,colors c
		where not exists (select * from phone_price r where p.phone_id=r.phone_id) 
		and p.brand_id=5
		and m.merchant_id=77
		and c.color_id=23
		order by brand_id
*/


-- 3. *********** UPDATE: изменение данных *********************************
/* уменьшение цен двух телефонов на 10 грн.:
	update new_phone_price set price=price-10
	where phone_id in(157759,157763)
*/


-- 4. **** UPDATE: изменение данных по условию, заданному по другой таблице ***
-- ШАГ-1. Выбрать строки которые необходимо изменить
	select p.*,s.* 
	from new_phone_price p 
	join stock s on p.phone_id=s.phone_id
		and p.merchant_id=s.merchant_id
		and p.color_id=s.color_id
	where s.amount=199
-- ШАГ-2. Заменяем SELECT на UPDATE
/*
	update p set p.price=p.price-0.5
	from new_phone_price p 
	join stock s on p.phone_id=s.phone_id
		and p.merchant_id=s.merchant_id
		and p.color_id=s.color_id
	where s.amount=199
*/
-- ШАГ-3. Проверяем результат
	select * from new_phone_price where price-floor(price)=0.5


-- 5. ****** UPDATE: замена значений данными, взятыми из другой таблицы *******
-- ШАГ-1. Выбираем строки, которые нужно заменить и минимальную цену из другой таблицы
	select p.* 
		,(	select min(price)
			from phone_price r
			where p.phone_id=r.phone_id
		) as min_pr
	from new_phone_price p where price-floor(price)=0.5
	order by merchant_id,color_id,phone_id
-- ШАГ-2. Заменяем цены в одной таблице минимальными ценами из другой таблицы
/*
	update new_phone_price
	set new_phone_price.price=(
			select min(r.price)
			from phone_price r
			where new_phone_price.phone_id=r.phone_id
		)
	where new_phone_price.price-floor(new_phone_price.price)=0.5
*/
-- ШАГ-3. Проверяем
	select p.*,s.*
	from new_phone_price p 
	join stock s on p.phone_id=s.phone_id
		and p.merchant_id=s.merchant_id
		and p.color_id=s.color_id
	where s.amount=199


-- 6. *********** DELETE: удаление строк по условиям на столбцах таблицы ********
-- ШАГ-1. Смотрим, что хотим удалить
	select *
	from new_phone_price
	where merchant_id=1 and color_id=20
	order by price desc
-- ШАГ-2. Удаляем самый дорогой телефон
/*
	delete from new_phone_price
	where merchant_id=1 and color_id=20 and phone_id=1500327
*/
-- ШАГ-3. Проверяем
	select *
	from new_phone_price
	where merchant_id=1 and color_id=20
	order by price desc


-- 7. ******* DELETE: удаление по условию, основываясь на данных в других таблицах ******
-- ШАГ-1. Смотрим что хотим удалить
	select *
	from new_phone_price n
	where exists (select * from
			(select top 2 *
			from phone_price
			where merchant_id=1 and color_id=20
			order by price desc) a 
			where n.phone_id=a.phone_id and n.merchant_id=a.merchant_id and n.color_id=a.color_id
		)
-- ШАГ-2. Удаление
/*
	delete from p
	from new_phone_price p
	join (select top 2 *
			from phone_price
			where merchant_id=1 and color_id=20
			order by price desc
		) a
	on p.phone_id=a.phone_id and p.merchant_id=a.merchant_id and p.color_id=a.color_id
*/
-- ШАГ-3. Проверяем
	select *
	from new_phone_price
	where merchant_id=1 and color_id=20
	order by price desc


-- 8. ********* TRANSACTION (транзакция) *************************
select *
from new_phone_price n
join phones p on n.phone_id=p.phone_id
where p.brand_id=5 and n.color_id=18 and n.merchant_id=3
/*
begin transaction
	delete from n 
	from new_phone_price n
	join phones p on n.phone_id=p.phone_id 
	where p.brand_id=5 and n.color_id=18 and n.merchant_id=3
*/
--commit transaction
--rollback transaction