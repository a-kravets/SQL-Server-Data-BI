-- *********************************************************************************
-- ****************** ИСПОЛЬЗОВАНИЕ МАТЕМАТИЧЕСКИХ ФУНКЦИЙ *************************
-- *********************************************************************************

-- 1. ********* ISNUMERIC() - какой результат возвращает? ******
select isnumeric('22')	-- результат 1: строку '22' можно преобразовать в число 22
select isnumeric('2ee')	-- результат 0: строка '2ee' не является числом (преобразовать в число нельзя)

-- 2. ********* Как можно использовать ISNUMERIC ***************
select phone_name
	,review  
	,PATINDEX('%20__ г%',review) as c_p
	,PATINDEX('%2___%',review) as c_p1
	--,substring(review,PATINDEX('%20__ г%',review),4)
	,substring(review,PATINDEX('%2___%',review),4) as str1
from phones
where review is not null 
	and PATINDEX('%20__ г%',review)=0
	and PATINDEX('%2___%',review)<>0
	and ISNUMERIC(substring(review,PATINDEX('%2___%',review),4))=1


-- 3. ************* Функция ABS() - модуль числа ******************
select phone_id
	,price
	,price-3000 as diff
	,abs(price-3000) as abs_diff
from phone_price
where price <=3100 and price>=2900


-- 4. ************** Функции CEILING() и FLOOR() ******************
select phone_id
	,price
	,price-3000 as diff
	,abs(price-3000) as abs_diff
	,price/25 as m_p
	,ceiling(price/25) as ce
	,floor(price/25) as fl
from phone_price
where price <=3100 and price>=2900
	and ceiling(price/25)=floor(price/25)

-- 5. ********* Функция RAND() *****************************
select phone_id
	,price
	,price-3000 as diff
	,abs(price-3000) as abs_diff
	,rand() as ran
	,(price-2900)/200 as n_p
	--,price/25 as m_p
	--,ceiling(price/25) as ce
	--,floor(price/25) as fl
from phone_price
where price <=3100 and price>=2900
	and ceiling(price/25)=floor(price/25)
order by price

-- *********************************************************************************
-- ****************** ФУНКЦИИ ПРЕОБРАЗОВАНИЯ ТИПОВ ДАННЫХ **************************
-- *********************************************************************************

-- 6. ********* Автоматическое (неявное) преобразование типов данных в SQL *********
select dateadd(mm,2,'01.02.2018') as date_1	-- строка, похожа на дату -> результат - дата
	,concat(dateadd(mm,2,'01.02.2018'),' текст') as date_txt	-- дата + текст -> текстовая строка
	,concat(dateadd(mm,2,'01.02.2018'),2) as date_n	-- дата + число -> дата
	,2+2 as four1	-- целое число + челое число -> целое число
	,'2'+2 as four2	-- строка как целое число + целое число -> целое число
	,concat('2',2) as four3	-- текстовая операция сцепления к тексту и чеслу -> текстовая строка
	,'2'+'2' as four4	-- текст как число + текст как число = текстовая операция сцепления -> текстовая строка
	,'22'/4 as res0	-- строка как целое число разделить на целое число -> целое число
	,22/4 as res1	-- целое число разделить на целое число -> целое число
	,22.0/4 as res2	-- дробное число разделить на дробное число -> дробное число
--,'22.0'/4 as res3 -- строка как дробное число разделить на целое число -> дает ошибку (не преобразует неявно)


-- 7. ********** Функции CAST() и CONVERT(): строки, похожие на числа в числа *******
select
	cast('123' as numeric(7,4)) as cs1
	,cast('123.4588' as numeric(7,4)) as cs2
	,cast('123.4588' as numeric(7,2)) as cs3
	--,cast('123.4588' as numeric(6,4)) as cs4 -–ошибка
	--,cast('123.4588' as int) as cs5 --ошибка
	,cast('123' as int) as cs6
	,cast(123.6588 as int) as cs7
	,cast('123.4588' as float(1)) as cs8
	,cast('65123.4588' as float(1)) as cs9
--- аналог:
	,convert(numeric(7,4),'123.4588') as con_1


-- 8. ******** Функция STR() - преобразование чисел в тектсовые строки ******
select
	'*'+str(123.4588)+'*' as str1_
	,str(123.4588,8,4) as str2  
	,str(123.4588,2) as str3 
	,cast(123.4588 as nvarchar) as cs1
	,convert(nvarchar,123.4588) as co1


-- 9. ******** Функции CAST() и CONVERT(): преобразования дат в текстовые строки *******
select
	getdate()
	,cast(getdate() as nvarchar) as cs1
	,convert(nvarchar,getdate() ) as co2
-- третий аргумет задаёт в какой культурной традиции представлять преобраз.выр
	,convert(nvarchar,getdate(),1) as co3
	,convert(nvarchar,getdate(),101) as co101	-- U.S.
	,convert(nvarchar,getdate(),2) as co02
	,convert(nvarchar,getdate(),102) as co102   -- как в базе
	,convert(nvarchar,getdate(),3) as co03
	,convert(nvarchar,getdate(),103) as co103   --British/French
	,convert(nvarchar,getdate(),4) as co04
	,convert(nvarchar,getdate(),104) as co104   --German


-- 10. ******** Функции CAST() и CONVERT(): преобразование текстовых строк в даты *******
select
	cast('01.02.2020' as date) as cs1
	,cast('01.02.2020' as datetime) as cs2
	,convert(date,'01.02.2020') as co1
	--,convert(date,'01.02.2020',1) as co2_us
	,convert(date,'01.02.20',1) as co3	-- -> US
	,convert(date,'01.02.2020',101) as co4	-- -> US
	,convert(date,'01.02.2020',104) as co5	-- -> Ger


-- 11. ******** Функция FORMAT() - преобразование дат и чисел в текстовые строки ***
select
	FORMAT ( getdate(), 'd', 'en-US' ) AS 'US English Result'   
	,FORMAT ( getdate(), 'd', 'de-de' ) AS 'German Result'  
       
	,FORMAT ( getdate(), 'D', 'en-US' ) AS 'US English Result'  
	,FORMAT ( getdate(), 'D', 'de-de' ) AS 'German Result'  
	,FORMAT ( getdate(), 'D', 'ru-ru' ) AS 'RU'  

	,FORMAT(112263.225, 'N', 'en-us') AS 'Number Format'  
	,FORMAT(112263.225, 'C', 'en-us') AS 'Currency Format'  
	,FORMAT(112263.225, 'C', 'ua-ua') AS 'Currency Format'