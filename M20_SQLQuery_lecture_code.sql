
-- 1. ********** Проверка и установка основных параметров БД ***************

-- Проверка SET ANSI_NULLS
select * from phones 
SELECT   SESSIONPROPERTY ('ANSI_NULLS')
select * from phones where review=null
--SET ANSI_NULLS OFF

-- Проверка SET CONCAT_NULL_YIELDS_NULL ON/OFF
SELECT   SESSIONPROPERTY ('CONCAT_NULL_YIELDS_NULL')
select concat(null,'abc')
--SET CONCAT_NULL_YIELDS_NULL OFF
--SET CONCAT_NULL_YIELDS_NULL ON
select null+'abc'

-- Проверка SET QUOTED_IDENTIFIER ON/OFF 
select 'abc'
select "abc"
SELECT   SESSIONPROPERTY ('QUOTED_IDENTIFIER')
--SET QUOTED_IDENTIFIER OFF
select "O'Brien"
-- select 'O'Brien'
select "Мар'яна"


-- 2.  ************** COLLATION ******************************************
SELECT DatabasePropertyEx(db_name(),'Collation')   -- системная ф-я

-- проверка
select * from clients where client_name like '%ё%'
select * from clients where client_name like 'л%'

-- Все возможные collations:
SELECT name, description
FROM fn_helpcollations()
where name like 'UKR%'

-- collation можно задать для каждого столбца индивидуально
select name, collation from syscolumns where id=object_id('phones')


-- 3. ********** Язык по умолчанию **************************************************
-- Через пользовательский интерфейс SSMS: сервер-свойства-язык
SELECT @@LANGUAGE  -- для текущего user


-- 4. ****************** Формат даты для текущего user ******************************
SELECT  date_format
FROM  sys.dm_exec_sessions 
WHERE  session_id = @@spid ----- dmy


-- 5. ****************** Инструкция, возвращающая текущие настройки: ****************
DBCC USEROPTIONS
-- Системная процедура:
exec sp_helplanguage @@language  ---- название месяцев и дней недели
-- или то же самое:
SELECT * FROM sys.syslanguages



-- 6. ************ Создание пользователя, схемы, роли. Назначение привилегий ********
--CREATE USER Antuan WITHOUT LOGIN  -- 	Пользователь без имени входа
--CREATE SCHEMA  French_Wine
--CREATE TABLE French_Wine.cellar(bottle_id int,bottle_name nvarchar(20),vintage smallint)
--select * from French_Wine.cellar   ---схема по умолчанию dbo
--CREATE ROLE  Sommelier
--GRANT INSERT,UPDATE, DELETE ON SCHEMA :: French_Wine  TO  Sommelier 
--ALTER ROLE Sommelier  ADD MEMBER Antuan    


-- 7. *********** Удаление пользователя, привилегий, роли и схемы *******************
--ALTER ROLE Sommelier  DROP MEMBER Antuan 
--DENY INSERT,UPDATE, DELETE ON SCHEMA :: French_Wine  TO  Sommelier
--DROP ROLE Sommelier
--DROP Table French_Wine.cellar
--DROP SCHEMA  French_Wine
--DROP USER Antuan