-- Будьте внимательны! Некорорые скрипты ниже приводят к изменениям данных в объектах БД
-- а также к изменеию объектов БД

-- 1. *********** Заполнение созданной таблицы phone_feedback данными *************
select * from phone_feedback
/*
insert into phone_feedback (phone_id,date_fdbk,nick_name,phone_adv,phone_dsa,phone_comm)
values(1647950,
	'01.01.2020',
	'Ivan','Хорошая камера',
	'Нет нфс',
	'За свои деньги великолепный выбор')
*/
/*
insert into phone_feedback (phone_id,date_fdbk,nick_name,phone_adv,phone_dsa,phone_comm)
values(1647950,
	'02.02.2020',
	'B52',
	'фэйс айди',
	'Плохая автономность',
	'Смартфон топ за свои деньги')
*/

-- 2. ********** Создание таблицы phone_feedback1 средствами DDL ******************
/*
CREATE TABLE phone_feedback1
(
	phone_id	INT
	,date_fdbk	DATE
	,nick_name	NVARCHAR(20)
	,phone_adv	NVARCHAR(1000)
	,phone_dsa	NVARCHAR(1000)
	,phone_comm	NVARCHAR(1000)
)
*/

select * from phone_feedback1


-- 3. ************ Создание таблицы с помощью INSERT INTO *************************
SELECT b.brand_name, a.phone_name, a.phone_id, b.brand_id
--INTO my_phones_t
FROM phones a
JOIN brands b ON a.brand_id=b.brand_id

select * from my_phones_t


-- 4. ************ Создание представления my_phones_v *****************************
/*
CREATE VIEW my_phones_v
AS
SELECT b.brand_name
	,a.phone_name
	,a.phone_id
	,b.brand_id 
FROM phones a 
JOIN brands b ON a.brand_id=b.brand_id
*/

select * from my_phones_v