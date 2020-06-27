/*ЗАДАНИЕ 1.
Модифицируйте запрос расчёта динамики продаж так чтобы получить динамику продаж за 2019 год поквартально, 2-й квартал по сравнению с 1-м, 3-й по сравнению
со 2-м и 4-й по сравнению с 3-м. Используйте функцию NULLIF() чтобы избежать ситуации деления на 0*/

select b.brand_name,count(*) as q_sell,sum(s.price) as total_grn
	,sum(case when month(s.date_purch) between 1 and 6 then s.price else 0 end) as hy1
	,sum(case when month(s.date_purch) between 7 and 12 then s.price else 0 end) as hy2
	,round(100*(sum(case when month(date_purch) between 7 and 12 then s.price else 0 end)/
	sum(case when month(date_purch) between 1 and 6 then s.price else 0 end)-1),2) as dnm

	,SUM(CASE WHEN DATEPART(qq, s.date_purch) = 1 THEN s.price ELSE 0 END) AS q_1
	,SUM(CASE WHEN DATEPART(qq, s.date_purch) = 2 THEN s.price ELSE 0 END) AS q_2
	,SUM(CASE WHEN DATEPART(qq, s.date_purch) = 3 THEN s.price ELSE 0 END) AS q_3
	,SUM(CASE WHEN DATEPART(qq, s.date_purch) = 4 THEN s.price ELSE 0 END) AS q_4

	,ROUND(100*(SUM(CASE WHEN DATEPART(qq, s.date_purch) = 2 THEN s.price ELSE 0 END)/
	NULLIF(SUM(CASE WHEN DATEPART(qq, s.date_purch) = 1 THEN s.price ELSE 0 END), 0)-1),2) AS dnm_q2_q1

	,ROUND(100*(SUM(CASE WHEN DATEPART(qq, s.date_purch) = 3 THEN s.price ELSE 0 END)/
	NULLIF(SUM(CASE WHEN DATEPART(qq, s.date_purch) = 2 THEN s.price ELSE 0 END), 0)-1),2) AS dnm_q3_q2

	,ROUND(100*(SUM(CASE WHEN DATEPART(qq, s.date_purch) = 4 THEN s.price ELSE 0 END)/
	NULLIF(SUM(CASE WHEN DATEPART(qq, s.date_purch) = 3 THEN s.price ELSE 0 END), 0)-1),2) AS dnm_q4_q3

from purchases s left join phones p on s.phone_id=p.phone_id
	left join brands b on p.brand_id=b.brand_id
where year(s.date_purch)=2019
group by b.brand_name
/*ЗАДАНИЕ 2.
Измените запрос, который производит расчёты для АВС анализа по брендам:
так, чтобы он выполнял АВС анализ по каждому наименованию телефона независимо от бренда
*/

select a.phone_name,a.total_b,a.total,a.dol,a.dol_ni
	,case
		when a.dol_ni<=0.8 then 'A'
		when a.dol_ni>0.8 and a.dol_ni<=0.95 then 'B'
		when a.dol_ni>0.95 then 'C'
		else '*'
	end as kat
from (
	select a.phone_name,a.total_b,c.total
		,a.total_b/c.total as dol
		,sum(a.total_b/c.total) over(order by a.total_b/c.total desc) as dol_ni
	from (
		select p.phone_name
			,sum(s.price) as total_b
		from purchases s left join phones p on s.phone_id=p.phone_id left join brands b on p.brand_id=b.brand_id
		where year(s.date_purch)=2019 and month(s.date_purch) between 1 and 3
		group by p.phone_name
		) a
	,(
		select sum(price) as total
		from purchases 
		where year(date_purch)=2019 and month(date_purch) between 1 and 3) c
		) a
order by kat
/*ЗАДАНИЕ 3.
Измените запрос, который производит расчёт равномерности спроса:
так чтобы он проводил расчёт равномерности спроса по наименованиям телефонов относящихся к бренду SAMSUNG*/

select a.brand_name,a.phone_name,a.m01,a.m02,a.m03,a.m04,a.m05,a.m06,a.total_avg
	,sqrt((square(m01-total_avg)+square(m02-total_avg)+square(m03-total_avg)+square(m04-total_avg)+square(m05-total_avg)+square(m06-total_avg))/6)/total_avg as k_xyz
	,case
		when sqrt((square(m01-total_avg)+square(m02-total_avg)+square(m03-total_avg)+square(m04-total_avg)+square(m05-total_avg)+square(m06-total_avg))/6)/total_avg<=0.1 then 'X'
		when sqrt((square(m01-total_avg)+square(m02-total_avg)+square(m03-total_avg)+square(m04-total_avg)+square(m05-total_avg)+square(m06-total_avg))/6)/total_avg<=0.25 then 'Y'
		else 'Z' 
	end as kat
from (
	select b.brand_name, p.phone_name
		,sum(case when month(date_purch)=1 then 1 else 0 end) as m01
		,sum(case when month(date_purch)=2 then 1 else 0 end) as m02
		,sum(case when month(date_purch)=3 then 1 else 0 end) as m03
		,sum(case when month(date_purch)=4 then 1 else 0 end) as m04
		,sum(case when month(date_purch)=5 then 1 else 0 end) as m05
		,sum(case when month(date_purch)=6 then 1 else 0 end) as m06
		,count(*)/6 as total_avg
	from purchases s left join phones p on s.phone_id=p.phone_id left join brands b on p.brand_id=b.brand_id
	where year(s.date_purch)=2019 and month(s.date_purch) between 1 and 6 and b.Brand_name = 'Samsung'
	group by b.brand_name, p.phone_name
	having count(*)/6<>0
	) a
order by kat


/*ЗАДАНИЕ 4.
Измените запрос, который производит анализ среднего чека по торговцам:
так чтобы он производил анализ среднего чека по наименованию бренда*/

select a.brand_name,count(a.phone_id) qu_t,sum(a.tot_pr) as tot_pr,sum(a.q_s) as q_s
	,sum(a.tot_pr)/sum(a.q_s) as avg_ch
from (
	select b.brand_name,s.phone_id,sum(s.price) as tot_pr,count(*) as q_s
	from purchases s left join phones ph on s.phone_id = ph.phone_id left join brands b on ph.brand_id=b.brand_id
	where year(s.date_purch)=2019 and month(s.date_purch) between 1 and 6
	group by b.brand_name,s.phone_id
	) a
group by a.brand_name
order by qu_t desc

/*ЗАДАНИЕ 5.
Измените запрос, который строит статистику продаж по торговцам:
так чтобы он строил статистику продаж по каждому наименованию телефона бренда xiaomi*/

select ph.phone_name,sum(s.price) as tot_pr
	,sum(iif(month(s.date_purch)=1,s.price,0)) as m01
	,sum(iif(month(s.date_purch)=2,s.price,0)) as m02
	,sum(iif(month(s.date_purch)=3,s.price,0)) as m03
	,sum(iif(month(s.date_purch)=4,s.price,0)) as m04
	,sum(iif(month(s.date_purch)=5,s.price,0)) as m05
	,sum(iif(month(s.date_purch)=6,s.price,0)) as m06
	,sum(iif(month(s.date_purch)=7,s.price,0)) as m07
	,sum(iif(month(s.date_purch)=8,s.price,0)) as m08
	,sum(iif(month(s.date_purch)=9,s.price,0)) as m09
	,sum(iif(month(s.date_purch)=10,s.price,0)) as m10
	,sum(iif(month(s.date_purch)=11,s.price,0)) as m11
	,sum(iif(month(s.date_purch)=12,s.price,0)) as m12
from purchases s left join phones ph on s.phone_id = ph.phone_id left join brands b on ph.brand_id=b.brand_id
where year(s.date_purch)=2019 and b.Brand_name = 'xiaomi'
group by ph.phone_name
order by tot_pr desc

/*ЗАДАНИЕ 6.
Измените запрос, который строит рейтинг продаж по брендам:
так, что бы он строил рейтинг продаж по наименованиям телефонов, не зависимо от брендов*/

select p.phone_name, b.brand_name,count(*) as q_sell,sum(s.price) as tot_grn
from purchases s left join phones p on s.phone_id=p.phone_id left join brands b on p.brand_id=b.brand_id
where year(s.date_purch)=2019 and month(date_purch) between 10 and 12
group by p.phone_name, b.brand_name
order by count(*) desc
