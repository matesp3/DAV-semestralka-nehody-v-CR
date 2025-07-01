BEGIN
    dbms_output.put_line('Running gather_schema_stats...');
    dbms_stats.gather_schema_stats('POLJAK');
    dbms_output.put_line('Done.');
END;


SELECT * -- table with all accidents
 FROM cr_nehody
 WHERE EXTRACT(YEAR FROM cas) = 2024;

SELECT * -- finding out whether alcohol was present during accident or not
 FROM cr_nehody acc
 JOIN cr_pritomnost_alko alco ON acc.id_alko_prit = alco.id_stav;

SELECT	id_stav AS state_id, -- presence OF alcohol - states
		pritomny AS present,
		CASE pritomny
        WHEN 'A' THEN 'Yes'
        WHEN 'N' THEN 'No'
        WHEN 'O' THEN 'Refused'
        WHEN 'X' THEN 'Not observed'
    END AS was_present,
    OBSAH_PERC AS amount_perc
  FROM CR_PRITOMNOST_ALKO
   ORDER BY was_present desc NULLS LAST, state_id;

SELECT	'Alco-ratio (accidents): ' || round(100*alco_acc_cnt/accidents_count, 2) || '%' 
		||' ['||alco_acc_cnt||' / '|| accidents_count||']'AS ratio_accidents_count,
		'Alco-ratio (vehicles): '  || round(100*alco_veh_cnt/vehicles_count, 2) || '%' 
		||' ['||alco_veh_cnt||' / '|| vehicles_count||']' AS ratio_vehicles_count
 FROM (
	SELECT	lag(accidents_count) OVER (ORDER BY id) AS alco_acc_cnt,
			accidents_count,
			lag(vehicles_count) OVER (ORDER BY id) AS alco_veh_cnt,
			vehicles_count
	 FROM (
		select 1 AS id, -- Accidents with alcohol (2024)
		 count(*) as accidents_count,
		 sum(acc2.poc_vozidiel) AS vehicles_count
		 from cr_nehody acc2 JOIN cr_pritomnost_alko alco ON acc2.id_alko_prit = alco.id_stav
		  WHERE EXTRACT(YEAR FROM acc2.cas) = 2024 AND 
		   alco.pritomny IS NOT NULL AND alco.pritomny LIKE 'A'
		UNION ALL
		select 2 AS id, -- All accidents (2024)
		 count(*) as accidents_count,
		 sum(acc1.poc_vozidiel) AS vehicles_count
		 from cr_nehody acc1
		  WHERE EXTRACT(YEAR FROM acc1.cas) = 2024)
) WHERE alco_acc_cnt IS NOT null;  
 
--  statistics of alcohol level in blood during an accident
select case when alco.pritomny='A' then 'Yes'
            when alco.pritomny='N' then 'No'
            when alco.pritomny='O' then 'Refused'
            when alco.pritomny='X' then 'Not observed'
            else 'Other' end as alco_present,
    alco.obsah_perc as alco_value_in_blood,
    count(*) as accidents_count,
    round(count(*)/
    (SELECT count(*) AS overall_cnt FROM cr_nehody WHERE EXTRACT(YEAR FROM cas)=2024)
    ,4)*100 || '%' AS ratio
 from cr_nehody n
 join cr_pritomnost_alko alco on n.id_alko_prit = alco.id_stav
  where extract(year from cas)=2024
   group by alco.id_stav, alco.pritomny, alco.obsah_perc
    order by accidents_count DESC;
  
-- monthly ratio of accidents with confirmed alcohol usage among all accidents
select mon_name, ' Amounts: ' as desc1, alco_yes, alco_no, refused, not_found_out,
        ' Percentage: ' as desc2,
        round(100 * alco_yes		/month_sum,2) ||'%' as p_yes,
        round(100 * alco_no			/month_sum,2) ||'%' as p_no,
        round(100 * refused			/month_sum,2) ||'%' as p_refused,
        round(100 * not_found_out	/month_sum,2) ||'%' as p_not_found_out
 from (
     select extract(month from cas) as month_id,
                TO_CHAR(cas, 'Month','NLS_DATE_LANGUAGE=English') as mon_name,
                sum(case alco.pritomny when 'A' then 1 else 0 end) as alco_yes,
                sum(case alco.pritomny when 'N' then 1 else 0 end) as alco_no,
                sum(case alco.pritomny when 'O' then 1 else 0 end) as refused,
                sum(case alco.pritomny when 'X' then 1 else 0 end) as not_found_out,
                count(*) as month_sum
      from cr_nehody acc
      join cr_pritomnost_alko alco on acc.id_alko_prit = alco.id_stav
       where extract(year from cas)=2024
        group by extract(month from cas), TO_CHAR(cas, 'Month','NLS_DATE_LANGUAGE=English')
 )
  order by month_id;
 
 -- 3. month with greatest amount of accidents due to alcohol usage
 --v1: listing of all months with corresponding accident counts
 select TO_CHAR(acc.cas, 'Month','NLS_DATE_LANGUAGE=English') as month_id, count(*) as accidents
  from cr_nehody acc
   JOIN CR_PRITOMNOST_ALKO alco ON acc.ID_ALKO_PRIT = alco.ID_STAV
   where extract(year from acc.cas)=2024 AND alco.PRITOMNY IS NOT NULL AND alco.PRITOMNY LIKE 'A'
    group by TO_CHAR(acc.cas, 'Month','NLS_DATE_LANGUAGE=English')
     order by accidents desc;
    
--v1: cost: 771  | nested selects to get local maximum
-- top 3 months with greatest amount of accidents related to alcohol usage
select
 TO_CHAR(acc.cas, 'Month','NLS_DATE_LANGUAGE=English') as month_id, count(*) as accidents
  from cr_nehody acc JOIN CR_PRITOMNOST_ALKO alco ON acc.ID_ALKO_PRIT = alco.ID_STAV
   where extract(year from acc.cas)=2024 AND alco.PRITOMNY IS NOT NULL AND alco.PRITOMNY LIKE 'A'
    group by TO_CHAR(acc.cas, 'Month','NLS_DATE_LANGUAGE=English')
     having count(*) >= (select max(count(*))
                        from cr_nehody accLvl1 JOIN CR_PRITOMNOST_ALKO alco1 ON accLvl1.ID_ALKO_PRIT = alco1.ID_STAV
                         where extract(year from accLvl1.cas)=2024 AND alco1.PRITOMNY IS NOT NULL AND alco1.PRITOMNY LIKE 'A'
                          group by extract(month from accLvl1.cas)
                           having count(*) < (select max(count(*))
                                              from cr_nehody accLvl2 JOIN CR_PRITOMNOST_ALKO alco2 ON accLvl2.ID_ALKO_PRIT = alco2.ID_STAV
                                               where extract(year from accLvl2.cas)=2024 AND alco2.PRITOMNY IS NOT NULL AND alco2.PRITOMNY LIKE 'A'
                                                group by extract(month from accLvl2.cas)
                                                 having count(*) < (select max(count(*))
                                                                    from cr_nehody accLvl3 JOIN CR_PRITOMNOST_ALKO alco3 ON accLvl3.ID_ALKO_PRIT = alco3.ID_STAV
                                                                     where extract(year from accLvl3.cas)=2024 AND alco3.PRITOMNY IS NOT NULL AND alco3.PRITOMNY LIKE 'A'
                                                                      group by extract(month from accLvl3.cas)
                                                                    )
                                              )
                       ) ORDER BY accidents desc;
                       
 --v2: cost: 3322 | ordering results of 'fetch'
 select TO_CHAR(acc.cas, 'Month','NLS_DATE_LANGUAGE=English') as month_id,
  count(*) as accidents
  from cr_nehody acc JOIN CR_PRITOMNOST_ALKO alco ON acc.ID_ALKO_PRIT = alco.ID_STAV
   where extract(year from acc.cas)=2024 AND alco.PRITOMNY IS NOT NULL AND alco.PRITOMNY LIKE 'A'
    group by TO_CHAR(acc.cas, 'Month','NLS_DATE_LANGUAGE=English')
     order by accidents desc
      fetch first 3 rows with ties;
     
 --v3: cost: 1569 | analytic funcion 'dense_rank'
 select month_id, accidents
 from (
     select month_id, accidents,
            dense_rank() over (order by accidents desc) rnk
     from (
         select TO_CHAR(acc.cas, 'Month','NLS_DATE_LANGUAGE=English') as month_id, count(*) as accidents
          from cr_nehody acc JOIN CR_PRITOMNOST_ALKO alco ON acc.id_alko_prit = alco.id_stav
           where extract(year from acc.cas)=2024 AND alco.PRITOMNY IS NOT NULL AND alco.PRITOMNY LIKE 'A'
            group by TO_CHAR(acc.cas, 'Month','NLS_DATE_LANGUAGE=English')
       )
) where rnk <= 3;

     
 --v4: cost: 2444 | vyuzitie analytickej funkcie dense_rank a analytickej funkcie count namiesto agregacnej count
SELECT month_id, accidents
 FROM
(
	 select distinct month_id, accidents
	 from (
	     select month_id, accidents,
	            dense_rank() over (order by accidents desc) rnk
	     from (
	         select TO_CHAR(acc.cas, 'Month','NLS_DATE_LANGUAGE=English') as month_id, count(*) over (partition by extract(month from acc.cas) order by null) as accidents
	          from cr_nehody acc JOIN CR_PRITOMNOST_ALKO alco ON acc.ID_ALKO_PRIT = alco.ID_STAV
	           WHERE EXTRACT(YEAR FROM acc.cas) = 2024 AND alco.PRITOMNY IS NOT NULL AND alco.PRITOMNY LIKE 'A'
	       )
	) where rnk <= 3
);

--===================================================================================================
-- task 1: what's the percentage ratio of the most devastating accidents damage with alcohol usage among TOP 1000 most devastating accidents of any kind
select damage_alco, damage_overall, round(100 * damage_alco/damage_overall, 2) || '%' as perc_ratio from (
 select
 (select 1 from dual) as damage_alco,
 (select 2 from dual) as damage_overall
  from dual
);

-- v1 - overall damage computed from 1000 biggest accidents of any kind
select damage_overall          --v1(analytic) cost: 1256
 from (
     select acc.celk_skoda_kc as damage,
        row_number() over(order by acc.celk_skoda_kc desc, acc.id_nehoda) as rn, -- must be id_nehoda, because OF possible different results FOR rolling sum
        sum(acc.celk_skoda_kc) over (order by acc.celk_skoda_kc desc, acc.id_nehoda) as damage_overall 
      from cr_nehody acc
       where extract(year from acc.cas)=2024
 ) where rn = 1000;
  
-- v2 - overall damage computed from 1000 biggest accidents of any kind
select sum(damage) damage_overall --v2(aggregate) cost: 1256
 from (
    select acc.celk_skoda_kc as damage,
        row_number() over(order by acc.celk_skoda_kc desc, acc.id_nehoda) as rn
      from cr_nehody acc
       where extract(year from acc.cas)=2024
 ) where rn <= 1000;   


-- v1 overall damage computed from 1000 biggest accidents caused by an alcohol usage
select sum(damage) over() as damage_alco --v1(analytic) cost: 1260;
 from (
    select alco.pritomny as alco_present, celk_skoda_kc as damage,
        row_number() over(order by celk_skoda_kc desc) as rn
      from cr_nehody acc
       join cr_pritomnost_alko alco on acc.id_alko_prit = alco.id_stav
        where extract(year from acc.cas)=2024
 ) where rn <= 1000 and alco_present ='A'
   fetch first row only;

-- v2 overall damage computed from 1000 biggest accidents caused by an alcohol usage
select sum(damage) damage_alco    --v2(aggregate) cost: 1260
 from (
    select alco.pritomny as alco_present, celk_skoda_kc as damage,
        row_number() over(order by acc.celk_skoda_kc desc) as rn
      from cr_nehody acc
       join cr_pritomnost_alko alco on acc.id_alko_prit = alco.id_stav
        where extract(year from acc.cas)=2024
 ) where rn <= 1000 and alco_present='A';
 
-- FINAL - combination
-- from first 1000 most costly accidents, how much alcohol accidents participate in overall damage
-- Overally, we have over 90000 accidents, so we are working just with 1.1 % of all in 2024
-- cost: 1531
select 'Share of alcohol damage among TOP 1000 most costly damages:' as description,
 round(100*(damage_alco/damage_overall),3) || '%' as perc, damage_alco, damage_overall from ( 
  select 
    (select sum(damage) damage_alc    --v2(aggregate) cost: 766
      from (
        select alco.pritomny as alco_present, acc.celk_skoda_kc as damage,
            row_number() over(order by acc.celk_skoda_kc desc) as rn
          from cr_nehody acc
           join cr_pritomnost_alko alco on acc.id_alko_prit = alco.id_stav
            where extract(year from acc.cas)=2024
           ) where rn <= 1000 and alco_present='A'
    ) AS damage_alco, 
    (select sum(damage) damage_ovrl --v2(aggregate) cost: 763
      from (
        select celk_skoda_kc as damage,
            row_number() over(order by acc.celk_skoda_kc desc) as rn
          from cr_nehody acc
           where extract(year from acc.cas)=2024
           ) where rn <= 1000
     ) AS damage_overall
   from dual);
   
--===================================================================================================
-- 2.5-month moving median of amount of injured (slightly + seriously) for 2024 (frequency = half-month)
-- cost: 816
with 
 month_nr as (
    select 1 as month_id from dual
    union select 2 from dual
    union select 3 from dual
    union select 4 from dual
    union select 5 from dual
    union select 6 from dual
    union select 7 from dual
    union select 8 from dual
    union select 9 from dual
    union select 10 from dual
    union select 11 from dual
    union select 12 from dual
 ),
 months as (
     select month_id, to_date('2024-'||month_id||'-01', 'yyyy-mm-dd') as month_bt 
      from month_nr
 ),
 halfmonths as (
    select month_bt as halfmon from months
     union
    select month_bt + floor((last_day(month_bt)-month_bt+1)/2) as month_half from months
 ),
 halfmon_data as (
 select halfmon, sum(count_injured) as count_injured
 from (
     select halfmon, count_injured
      from (
         select acc.id_nehoda, trunc(acc.cas)as date_trunc, hms.halfmon, (acc.lahko_zraneni+acc.tazko_zraneni) as count_injured, 
          row_number() over (partition by id_nehoda order by 
           (case when trunc(acc.cas)-hms.halfmon>=0 then trunc(acc.cas)-hms.halfmon else 10000 end)) as hms_priority
          from cr_nehody acc
           join halfmonths hms on trunc(acc.cas, 'MM')=trunc(hms.halfmon, 'MM')
            where extract(year from acc.cas)=2024
      ) where hms_priority=1 -- each record is going to have assigned 1 halfmon, so the number of halfmonths = count(*)
 )
  group by halfmon -- development of injuries number with frequency equal to halfmon
 )
select halfmon, median(count_injured) median_injured
 from (
    select halfmon, count_injured from halfmon_data
     union all select halfmon, lag(count_injured,1) over(order by halfmon) from halfmon_data
     union all select halfmon, lag(count_injured,2) over(order by halfmon) from halfmon_data
     union all select halfmon, lag(count_injured,3) over(order by halfmon) from halfmon_data
     union all select halfmon, lag(count_injured,4) over(order by halfmon) from halfmon_data
) group by halfmon order by halfmon; 


-- which 3 regions appeared most times in top 3 greatest numbers of alco-accidents in 2024 with monthly interval
SELECT id_region, region_name, being_in_top_3, RANK() OVER (ORDER BY being_in_top_3 desc) AS ranking
 FROM
(
	SELECT id_region, region_name, count(*) AS being_in_top_3
	 FROM
	 (
		SELECT id_region, region_name, rank() OVER (PARTITION BY month_id ORDER BY alco_accidents) AS rnk, alco_accidents
		 FROM
		 (
			SELECT count(*) AS alco_accidents,
			 regions.id_kraj AS id_region, regions.nazov AS region_name, extract(MONTH FROM acc.cas) AS month_id
			 from cr_nehody acc
			 JOIN CR_KRAJE regions ON acc.id_kraj = regions.id_kraj
			 JOIN CR_PRITOMNOST_ALKO alco ON acc.id_alko_prit = alco.id_stav
			  WHERE EXTRACT(YEAR FROM acc.cas) = 2024 AND alco.pritomny LIKE 'A'
			   GROUP BY regions.id_kraj, regions.nazov, extract(MONTH FROM acc.cas)
		)
	) WHERE rnk <= 3
	 GROUP BY id_region, region_name
);

SELECT EXTRACT(DAY FROM LAST_DAY(TO_DATE('2025-' || 2 || '-01', 'YYYY-MM-DD'))) AS days_in_month
FROM dual;

SELECT trunc(to_date('2025-01-01', 'yyyy-mm-dd') - to_date('2024-01-01', 'yyyy-mm-dd')) AS days_between --366 FOR 2024 - leap year
 FROM dual;

-- ranking of regions regarding their wavg ratio of alco accidents in relation with all accidents for given month
SELECT DENSE_RANK() OVER (ORDER BY wavg_ratio desc) AS ranking,
      region_name, round(wavg_ratio, 3) || '%' wavg_ratio, round(avg_ratio, 3) || '%' avg_ratio
 FROM 
(
	SELECT id_region, region_name,
		avg((alco_amount/overall_amount)*100) AS avg_ratio,
		sum(days_in_month * (alco_amount/overall_amount)*100/365) AS wavg_ratio
	FROM
	(
		SELECT 
		 id_region,
		 region_name,
		 month_id,
		 max(CASE WHEN amount_type_id = 1 THEN accidents ELSE NULL END) AS alco_amount,
		 max(CASE WHEN amount_type_id = 2 THEN accidents ELSE NULL END) AS overall_amount,
		 extract(DAY FROM last_day(to_date('2024-' || month_id || '-01', 'YYYY-MM-DD'))) AS days_in_month
		 FROM
		(
			(SELECT 1 AS amount_type_id, count(*) AS accidents, -- alco amounts
			 regions.id_kraj AS id_region, regions.nazov AS region_name, extract(MONTH FROM acc.cas) month_id 
			 from cr_nehody acc
			 JOIN CR_KRAJE regions ON acc.id_kraj = regions.id_kraj
			 JOIN CR_PRITOMNOST_ALKO alco ON acc.id_alko_prit = alco.id_stav
			  WHERE EXTRACT(YEAR FROM acc.cas) = 2024 AND alco.pritomny LIKE 'A'
			   GROUP BY regions.id_kraj, regions.nazov, extract(MONTH FROM cas))
			UNION ALL
			(SELECT 2 AS amount_type_id, count(*) AS accidents, -- overall amounts
			 regions.id_kraj AS id_region, regions.nazov AS region_name, extract(MONTH FROM acc.cas) month_id 
			 from cr_nehody acc
			 JOIN CR_KRAJE regions ON acc.id_kraj = regions.id_kraj
			  WHERE EXTRACT(YEAR FROM acc.cas) = 2024
			   GROUP BY regions.id_kraj, regions.nazov, extract(MONTH FROM acc.cas))
		) GROUP BY id_region, region_name, month_id
	) GROUP BY id_region, region_name
	  ORDER BY wavg_ratio
);
	




SELECT * FROM cr_NEHODY acc
 WHERE POC_VOZIDIEL  = 0;
--  JOIN cr_vozidla vec ON acc.id_nehoda = vec.ID_NEHODA 
--   GROUP BY acc.id_nehoda, acc.poc_vozidiel
--    HAVING count(*) = 0;