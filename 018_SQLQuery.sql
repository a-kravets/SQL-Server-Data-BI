/*ЗАДАНИЕ 1.
Добавьте в скрипт, разработанный на занятии, объявление (declare) новой табличной переменной со столбцами
(phone_id int, n_mon smallint, qu int)*/

DECLARE @t_var TABLE (phone_id int, n_mon smallint, qu int)

/*ЗАДАНИЕ 2.
Напишите SQL-запрос, выводящий количество проданных телефонов по каждому phone_id, в каждом месяце за 2019
год*/

DECLARE @cur_year int

SET @cur_year = 2019

SELECT 
	phone_id
	,MONTH(date_purch) AS month
	,COUNT(phone_id) AS quantity
FROM purchases
WHERE YEAR(date_purch) = @cur_year
GROUP BY MONTH(date_purch), phone_id
ORDER BY phone_id, MONTH(date_purch)


/*ЗАДАНИЕ 3.
Добавьте в скрипт, разработанный на занятии, вставку строк запроса из задания 2 в таблицу (табличную
переменную) созданную в задании 1*/

INSERT INTO @t_var (phone_id, n_mon, qu)
SELECT 
	phone_id
	,MONTH(date_purch) AS month
	,COUNT(phone_id) AS quantity
FROM purchases
WHERE YEAR(date_purch) = @cur_year
GROUP BY MONTH(date_purch), phone_id
ORDER BY phone_id, MONTH(date_purch)

SELECT * FROM @t_var

/*ЗАДАНИЕ 4.
Замените в скрипте, разработанном на занятии, все SQL-запросы к таблице PURCHASES на запросы к таблице
(табличной переменной) созданной и заполненной в заданиях 1 и 3*/--declare @cur_year int
declare @qu_ph int
declare @cur_ph_id int
declare @qu_sell int
declare @cur_mon int
declare @qu_sell_p int
declare @Best_sellers table(phone_id int,mon smallint)

set @cur_year = 2019
set @cur_ph_id=190241
set @cur_ph_id=1600000

select @qu_ph=count(distinct phone_id) from @t_var --where year(date_purch)=@cur_year

while isnull(@cur_ph_id,0)<>0
	begin
		select @cur_ph_id=min(phone_id) from @t_var where /*year(date_purch)=@cur_year and*/ phone_id>@cur_ph_id
		print('Phone_id'+str(@cur_ph_id))
		set @cur_mon=1
		set @qu_sell_p=0
		while @cur_mon<=12
			begin
				select /*@qu_sell=count(qu)*/ @qu_sell=qu from @t_var where /*year(date_purch)=@cur_year and*/ phone_id=@cur_ph_id and n_mon=@cur_mon
				print('месяц'+str(@cur_mon,2)+' продано:'+str(@qu_sell))
				if @qu_sell>@qu_sell_p
					begin
						set @qu_sell_p=@qu_sell
					end
				else
					begin
						break
					end
		
				set @cur_mon = @cur_mon+1
			end
		print('Кол-во месяцев непрерывного роста продаж начиная с 1:'+str(@cur_mon-1,4))
		if @cur_mon-1>=3
			begin
				insert into @Best_sellers (phone_id,mon) values(@cur_ph_id,@cur_mon-1)
			end
	end
print('В '+str(@cur_year,4)+' году')
print('Продано '+str(@qu_ph,4)+' наименований телефонов')
select * from  @Best_sellers
