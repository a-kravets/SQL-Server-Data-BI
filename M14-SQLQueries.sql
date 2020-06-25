-- 1. *********** Êåéñ-1. Àíàëèç äèíàìèêè ïðîäàæ ****************
select
	b.brand_name,count(*) as q_sell
	,sum(s.price) as total_grn
	,sum(case when  month(date_purch) between 1 and 6 then s.price else 0 end) as hy1_grn
	,sum(case when  month(date_purch) between 7 and 12 then s.price else 0 end) as hy2_grn
	,round(100*
			(sum(case when  month(date_purch) between 7 and 12 then s.price else 0 end)/
			sum(case when  month(date_purch) between 1 and 6 then s.price else 0 end)-1),2
	) as dnm
from purchases s
left join phones p on s.phone_id=p.phone_id
left join brands b on p.brand_id=b.brand_id 
where year(s.date_purch)=2019 
group by b.brand_name
order by sum(s.price) desc


-- 2. ****************** Êåéñ-2. ABC-àíàëèç **********************************
select
	a.brand_name
	,a.total_b
	,a.total,a.dol
	,a.dol_ni
	,case 
		when a.dol_ni<=0.8 then 'A'
		when a.dol_ni>0.8 and a.dol_ni<=0.95 then 'B'
		else 'C'
	end as kat
from (
		select a.brand_name
			,a.total_b
			,c.total
			,a.total_b/c.total as dol
			,sum(a.total_b/c.total) over(order by a.total_b/c.total desc) as dol_ni
		from (
				select b.brand_name
					,sum(s.price) as total_b
				from purchases s left join phones p on s.phone_id=p.phone_id
				left join brands b on p.brand_id=b.brand_id 
				where year(s.date_purch)=2019 and month(s.date_purch) between 1 and 3
				group by b.brand_name
			) a
			,(select sum(price) as total
				from purchases
				where year(date_purch)=2019 and month(date_purch) between 1 and 3
			) c
		--order by dol desc
	) a
order by kat


-- 3. ******************** Êåéñ-3. XYZ-àíàëèç ************************
select
	a.brand_name
	,a.m01,a.m02
	,a.m03
	,a.m04
	,a.m05
	,a.m06
	,a.total_avg
	,sqrt((square(m01-total_avg)+square(m02-total_avg)+
		square(m03-total_avg)+square(m04-total_avg)+
		square(m05-total_avg)+square(m06-total_avg))/6)/total_avg as k_xyz
	,case 
		when sqrt((square(m01-total_avg)+square(m02-total_avg)+
					square(m03-total_avg)+square(m04-total_avg)+
					square(m05-total_avg)+square(m06-total_avg)
				)/6)/total_avg<=0.1 then 'X'
		when sqrt((square(m01-total_avg)+square(m02-total_avg)+
					square(m03-total_avg)+square(m04-total_avg)+
					square(m05-total_avg)+square(m06-total_avg)
				)/6)/total_avg<=0.25 then 'Y'
		else 'Z'
	end as kat
from (
	select b.brand_name
		,sum(iif(month(date_purch)=1,1,0)) as m01
		,sum(iif(month(date_purch)=2,1,0)) as m02
		,sum(iif(month(date_purch)=3,1,0)) as m03
		,sum(iif(month(date_purch)=4,1,0)) as m04
		,sum(iif(month(date_purch)=5,1,0)) as m05
		,sum(iif(month(date_purch)=6,1,0)) as m06
		,count(*) as tot
		,count(*)/6 as total_avg
	from purchases s
	left join phones p on s.phone_id=p.phone_id
	left join brands b on p.brand_id=b.brand_id 
	where year(s.date_purch)=2019 and month(s.date_purch) between 1 and 6
	group by b.brand_name
	having count(*)/6<>0
	) a
order by k_xyz


-- 4. *************** Êåéñ-4. Àíàëèç ñðåäíåãî ÷åêà **********************
select
	a.merchant_name
	,count(a.phone_id) q_t
	,sum(a.tot_pr) as tot_pr
	,sum(a.q_s) as q_s
	,sum(a.tot_pr)/sum(a.q_s) as avg_ch
from (
		select
			m.merchant_name
			,s.phone_id
			,sum(s.price) as tot_pr
			,count(*) as q_s
		from purchases s
		left join merchants m on s.merchant_id=m.merchant_id
		where year(s.date_purch)=2019 and month(s.date_purch) between 1 and 6
		group by
			m.merchant_name
			,s.phone_id
	) a
group by a.merchant_name
order by q_t desc


-- 5. *************** Êåéñ-5. Ñòàòèñòèêà ïðîäàæ ******************************
select
	m.merchant_name
	,sum(s.price) as tot_pr
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
from purchases s
left join merchants m on s.merchant_id=m.merchant_id
where year(s.date_purch)=2019 
group by m.merchant_name
order by tot_pr desc


-- 6. ************* Êåéñ-6. Ðåéòèíãè ïðîäàæ **************************
select
	b.brand_name
	,count(*) as q_sell
	,sum(s.price) as total_grn
from purchases s
left join phones p on s.phone_id=p.phone_id
left join brands b on p.brand_id=b.brand_id 
where year(s.date_purch)=2019 and month(date_purch) between 10 and 12
group by b.brand_name
order by count(*) desc