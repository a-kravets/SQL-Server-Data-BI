-- Будьте внимательны! Некорорые скрипты ниже приводят к изменениям данных в объектах БД
-- а также к изменеию объектов БД

-- 1. ********** Заполняем данными созданные таблицы **********************
--insert into crm_operator select * from t4
--insert into crm_evaluate select * from t3
--insert into crm_cont_type select * from t2
--insert into crm_contacts select * from t1


-- Проверяем наличие вставленных данных
select * from crm_operator
select * from crm_evaluate
select * from crm_cont_type
select * from crm_contacts


-- 2. ********** Создаем ограничения NOT NULL и первичные ключи ***********

-- Ограничение NOT NULL и первичный ключ в таблице crm_operator:
/*
alter table crm_operator alter column operator_id smallint not null

alter table crm_operator
add constraint PK_Operator_Id primary key (operator_id)
*/

-- Ограничение NOT NULL и первичный ключ в таблице crm_evaluate:
select * from crm_evaluate
/*
alter table crm_evaluate alter column evaluate_id smallint not null
alter table crm_evaluate add constraint PK_evaluate_Id primary key (evaluate_id)
*/

-- Ограничение NOT NULL и первичный ключ в таблице crm_cont_type:
select * from crm_cont_type
/*
alter table crm_cont_type alter column contact_id smallint not null
alter table crm_cont_type add constraint PK_contact_Id primary key (contact_id)
-- !!! ошибка из-за неуникальность значений в столбце contact_id
*/
-- исправление ошибки через создание промежуточной таблицы и удаление дубликатов
--select distinct contact_id,io,contact_descriptor into crm_cont_type2 from crm_cont_type
--delete from crm_cont_type
--insert into crm_cont_type select * from crm_cont_type2
--drop table crm_cont_type2
select * from crm_cont_type

-- создаем заново первичный ключ в таблице crm_cont_type:
/*
alter table crm_cont_type add constraint PK_contact_Id primary key (contact_id)
*/


-- 3. ***** Создание ограничений NOT NULL и внешних ключей в таблице crm_contacts ****
select * from crm_contacts

-- Создание ограничений NOT NULL для 3-х столбцов crm_contacts:
/*
alter table crm_contacts alter column date_cont smalldatetime not null
alter table crm_contacts alter column client_id int not null
alter table crm_contacts alter column contact_id smallint not null
*/

-- Создание 4 внешних ключа в таблице crm_contacts:
/*
alter table crm_contacts add constraint FK_client_Id foreign key (client_id)
	references clients (client_id)

alter table crm_contacts add constraint FK_evaluate_Id foreign key (evaluate_id)
	references crm_evaluate (evaluate_id)

alter table crm_contacts add constraint FK_operator_Id foreign key (operator_id)
	references crm_operator (operator_id)

alter table crm_contacts add constraint FK_contact_Id foreign key (contact_id)
	references crm_cont_type (contact_id)
*/


-- 4. ************ Создание первичного ключа в таблице crm_contacts **************
/*
alter table crm_contacts add id int primary key identity
*/

select * from crm_contacts