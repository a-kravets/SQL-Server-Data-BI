use P_STORE

declare @cur_year int
declare @qu_ph int
declare @cur_ph_id int
declare @qu_sell int
declare @cur_mon int
declare @qu_sell_p int
declare @Best_sellers table(phone_id int,mon smallint)

set @cur_year = 2019
set @cur_ph_id=190241
set @cur_ph_id=1600000

select  @qu_ph=count(distinct phone_id) from purchases where year(date_purch)=@cur_year

while isnull(@cur_ph_id,0)<>0
	begin
		select @cur_ph_id=min(phone_id) from purchases where year(date_purch)=@cur_year and phone_id>@cur_ph_id
		print('Phone_id'+str(@cur_ph_id))
		set @cur_mon=1
		set @qu_sell_p=0
		while @cur_mon<=12
			begin
				select @qu_sell=count(price) from purchases where year(date_purch)=@cur_year and phone_id=@cur_ph_id and month(date_purch)=@cur_mon
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

go

 --Разделение скрипта на пакеты
declare @cur_year int
declare @cur_ph_id int

set @cur_year=2019
select @cur_ph_id=min(phone_id) from purchases where year(date_purch)=@cur_year
go
select phone_name from phones where phone_id=@cur_ph_id

