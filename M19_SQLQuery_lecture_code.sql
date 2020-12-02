-- Внимание! Выполнение скриптов в этом файле приводит к созданию новых объектов в БД ----

-- 1. ****** Создание скалярной пользовательской функции ****************
/*declare @my_d datetime
declare @my_named nchar(12)

set @my_d=getdate()
 if datepart(dw,@my_d)=1 set @my_named='Понедельник'
 if datepart(dw,@my_d)=2 set @my_named='Вторник'
 if datepart(dw,@my_d)=3 set @my_named='Среда'
 if datepart(dw,@my_d)=4 set @my_named='Четверг'
 if datepart(dw,@my_d)=5 set @my_named='Пятница'
 if datepart(dw,@my_d)=6 set @my_named='Суббота'
 if datepart(dw,@my_d)=7 set @my_named='Воскресенье'
 
 print(@my_named)
 Print(datename(dw,@my_d))
*/

/*create function my_dayweek(@my_date datetime) returns nchar(15)
begin
 if datepart(dw,@my_date)=1 return 'Понедельник'
 if datepart(dw,@my_date)=2 return 'Вторник'
 if datepart(dw,@my_date)=3 return 'Среда'
 if datepart(dw,@my_date)=4 return 'Четверг'
 if datepart(dw,@my_date)=5 return 'Пятница'
 if datepart(dw,@my_date)=6 return 'Суббота'
 if datepart(dw,@my_date)=7 return 'Воскресенье'
 return '***'
end*/

--select a.*,dbo.my_dayweek(date_purch) as dw from purchases a


-- 2. ******** Усовершенствование созданной скалярной функции **************
/*alter function my_dayweek(@tp_ret tinyint,@my_date datetime) returns nchar(15)
begin
if @tp_ret=1
begin
 if datepart(dw,@my_date)=1 return 'Понедельник'
 if datepart(dw,@my_date)=2 return 'Вторник'
 if datepart(dw,@my_date)=3 return 'Среда'
 if datepart(dw,@my_date)=4 return 'Четверг'
 if datepart(dw,@my_date)=5 return 'Пятница'
 if datepart(dw,@my_date)=6 return 'Суббота'
 if datepart(dw,@my_date)=7 return 'Воскресенье'
 end
if @tp_ret=2
begin
 if datepart(dw,@my_date)=1 return 'Пн'
 if datepart(dw,@my_date)=2 return 'Вт'
 if datepart(dw,@my_date)=3 return 'Ср'
 if datepart(dw,@my_date)=4 return 'Чт'
 if datepart(dw,@my_date)=5 return 'Пт'
 if datepart(dw,@my_date)=6 return 'Сб'
 if datepart(dw,@my_date)=7 return 'Вс'
 end
 return '***'
end*/

--пример использования
--select a.*,dbo.my_dayweek(1,date_purch) as dw,dbo.my_dayweek(2,date_purch) as short_dw from purchases a

--- inline


-- 3. ********* Создание функции, возвращающей таблицу ************************************
/*
create function cl_birth_day(@month_n tinyint,@day_n tinyint) returns table
return select client_id,client_name,client_tlf,birth_date from clients where month(birth_date)=@month_n and day(birth_date)=@day_n
*/

--пример использования
--select * from dbo.cl_birth_day(2,29)
--select * from purchases p join dbo.cl_birth_day(2,29) c on p.client_id=c.client_id


-- 4. ************** Создание многооператорной функции ***********************************
/*
--create function my_period(@begin_date date,@end_date date) returns @month_period table(p_year smallint,p_month tinyint)
alter function my_period(@begin_date date,@end_date date) returns @month_period table(p_year smallint,p_month tinyint)
begin
declare @cur_date date
set @cur_date=@begin_date
while datediff(mm,@cur_date,@end_date)>=0
begin
insert into @month_period(p_year,p_month) values(year(@cur_date),month(@cur_date))
set @cur_date=dateadd(mm,1,@cur_date)
end
return
end
*/

--select * from dbo.my_period('01.01.2019','31.12.2019')

--примеры использования
/*
select month(date_purch) as mp,count(price) as col from purchases 
where date_purch between datetimefromparts(2019,1,1,0,0,0,0) and datetimefromparts(2019,12,31,23,59,59,999) 
and merchant_id=10 and phone_id=161337
group by month(date_purch)
*/

/*
select a.p_year,a.p_month,isnull(b.col,0) as col from dbo.my_period('01.01.2019','31.12.2019') a
left join
(select month(date_purch) as mp,count(price) as col from purchases 
where date_purch between datetimefromparts(2019,1,1,0,0,0,0) and datetimefromparts(2019,12,31,23,59,59,999) and merchant_id=10 and phone_id=161337
group by month(date_purch)) b on a.p_month=b.mp
*/


-- 5. **************** Создание хранимой процедуры **************************************
/*
create procedure add_purch @v_phone_id int,@v_color_id tinyint,@v_merchant_id tinyint,@v_client_id int,@v_price numeric(18,0)
as
insert into purchases (phone_id,color_id,merchant_id,client_id,price,date_purch)
values(@v_phone_id,@v_color_id,@v_merchant_id,@v_client_id,@v_price,getdate())
*/

--пример использования
--exec add_purch 161337,23,10,1,1111


-- 6. ****************** Создание триггера в таблице purchases **************************
/*
create trigger TR_purchases_insert on purchases
after insert
as
update s set s.amount=s.amount-1
from stock s join inserted i on s.phone_id=i.phone_id and s.color_id=i.color_id and s.merchant_id=i.merchant_id
*/

--пример использования
--select * from stock where phone_id=161337 and color_id=23 and merchant_id=10
--select * from purchases where phone_id=161337 and color_id=23 and merchant_id=10 and client_id=1 order by date_purch desc