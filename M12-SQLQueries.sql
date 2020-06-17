-- 1. ******* Функции YEAR(), MONTH(), DATEPART() ****************
select
	b.brand_name
	,count(*) as q_sell
	,sum(s.price) as tot_grn
from purchases s
	left join phones p on s.phone_id=p.phone_id 
	left join brands b on p.brand_id=b.brand_id 
where s.phone_id=916472 and s.color_id=17
	and year(s.date_purch)=2019 
	--and month(date_purch) between 10 and 12
	and datepart(qq,date_purch)=4
	and datepart(mm,date_purch)=12
	and datepart(dd,date_purch)=31
group by b.brand_name


-- 2. ******* Функции DATEFROMPARTS() и DATETIMEFROMPARTS() ********
select
	c.client_name
	,m.merchant_name
	,date_purch 
	--,cast(date_purch as date)
	--,CAST('12.10.2019' AS datetime)
	--,DATEFROMPARTS(2019,2,2)
from purchases p
left join merchants m on p.merchant_id=m.merchant_id
left join clients c on p.client_id=c.client_id
where p.phone_id=916472 and p.color_id=17
	and date_purch>=DATEFROMPARTS(2019,2,2) 
	--and  date_purch<=DATEFROMPARTS(2019,2,27)
	--and  date_purch<DATEFROMPARTS(2019,2,28)
	and date_purch<=datetimefromparts(2019,2,27,23,59,59,999)
order by date_purch


-- 3. ******* Функции GETDATE(), DATENAME() ************
select getdate() as c_d
	,eomonth(getdate()) as last_d	--Первая дата текущего месяца
	,datefromparts(year(getdate()),month(getdate()),1)	-- Последняя дата текущего месяца
	,datename(mm,getdate()) as name_m	-- Название текущего месяца
	,datename(dw,getdate()) as name_d	-- Название текущего дня недели


-- 4. ******* Функции DAY(), DATEADD() *****************
select client_name
	,birth_date
	,client_tlf
	--,dateadd(day,5,getdate())
from  clients
where 
	--day(birth_date)=day(GETDATE())
	--and month(birth_date)=month(GETDATE())
	day(dateadd(day,5,getdate()))=day(birth_date) 
	and month(dateadd(day,5,getdate()))=month(birth_date)


-- 5. ********* Функция DATEDIFF() **************************
select client_id
	,count(price) as qu_sell
	,min(date_purch) as f_p
	,max(date_purch) as last_p
	,datediff(dd,min(date_purch), max(date_purch)) as d_b_p -- к-во дней между двумя покупками
from purchases
where year(date_purch)=2019
group by client_id
having count(price)=2
order by d_b_p


-- 6. ********* Приемы усечения дат **************************
select 
	getdate() as c_d
	,dateadd(dd, datediff(dd,0, getdate()), 0) as trunc_d -- усеченная до полуночи
	,datediff(dd,0, getdate())	-- к-во суток между началом отсчета дат и текущей датой
	,dateadd(dd, (-1)*datediff(dd,0, getdate()), getdate()) -- дата - начало отсчета
	,dateadd(mm, datediff(mm,0, getdate()), 0) as trunc_m	-- усеченная до 1-го дня текущего месяца
	,dateadd(yy, datediff(yy,0, getdate()), 0) as trunc_y	-- усеченная до 1-го дня текущего года
