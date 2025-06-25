BEGIN
    dbms_output.put_line('Running gather_schema_stats...');
    dbms_stats.gather_schema_stats('POLJAK');
    dbms_output.put_line('Done.');
END;

SELECT * FROM cr_nehody;

-- 

select 'Accidents (2024):' as description,
 count(*) as amount
 from cr_nehody
  WHERE EXTRACT(YEAR FROM cas) = 2024
 UNION ALL
select 'Car-accidents (2024):' as description,
 count(DISTINCT ID_NEHODA) as amount
 from cr_nehody join cr_vozidla using(id_nehoda)
  WHERE EXTRACT(YEAR FROM cas) = 2024
 UNION ALL
select 'Accidents with alcohol (2024):' as description,
 count(*) as amount
 from cr_nehody acc1 JOIN CR_PRITOMNOST_ALKO alco1 ON acc1.ID_ALKO_PRIT = alco1.ID_STAV
  WHERE EXTRACT(YEAR FROM cas) = 2024 AND alco1.PRITOMNY IS NOT NULL AND alco1.PRITOMNY LIKE 'A'
 UNION ALL
select 'Car-accidents with alcohol (2024):' as description,
 count(DISTINCT ID_NEHODA) as amount
 from cr_nehody acc2 
  join cr_vozidla car2 using(id_nehoda)
  JOIN CR_PRITOMNOST_ALKO alco2 ON acc2.ID_ALKO_PRIT = ALCO2.ID_STAV
  WHERE EXTRACT(YEAR FROM cas) = 2024 AND ALCO2.PRITOMNY IS NOT NULL AND ALCO2.PRITOMNY LIKE 'A';
 UNION ALL
select 'Accidents with alcohol (2024):' as description,
 count(*) as amount
 from cr_nehody acc3 JOIN CR_PRITOMNOST_ALKO alco1 ON acc3.ID_ALKO_PRIT = alco1.ID_STAV
  WHERE EXTRACT(YEAR FROM cas) = 2024 AND alco1.PRITOMNY IS NOT NULL AND alco1.PRITOMNY LIKE 'A'

 SELECT * FROM CR_PRITOMNOST_ALKO
  WHERE pritomny IS NULL OR pritomny NOT LIKE 'A'
  
  
--  statistika pre obsah alkoholu pocas nehody
select case when alco.pritomny='A' then 'Yes'
            when alco.pritomny='N' then 'No'
            when alco.pritomny='O' then 'Refused'
            when alco.pritomny='X' then 'Not observed'
            else 'Other' end as alco_present,
    alco.obsah_perc as alco_value_in_blood,
    count(*) as accidents_count
 from cr_nehody n
 join cr_pritomnost_alko alco on n.id_alko_prit = alco.id_stav
  where extract(year from cas)=2024
   group by alco.id_stav, alco.pritomny, alco.obsah_perc
    order by accidents_count desc;
  
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
    
--v1: cost: 763 | nested selects to get local maximum
select 'Top 3. most accidents (2024): ' as description,
 TO_CHAR(acc.cas, 'Month','NLS_DATE_LANGUAGE=English') as month_id, count(*) as accidents
  from cr_nehody acc
   where extract(year from acc.cas)=2024
    group by TO_CHAR(acc.cas, 'Month','NLS_DATE_LANGUAGE=English')
     having count(*) = (select max(count(*))
                        from cr_nehody accLvl1
                         where extract(year from accLvl1.cas)=2024
                          group by extract(month from accLvl1.cas)
                           having count(*) < (select max(count(*))
                                              from cr_nehody accLvl2
                                               where extract(year from accLvl2.cas)=2024
                                                group by extract(month from accLvl2.cas)
                                                 having count(*) < (select max(count(*))
                                                                    from cr_nehody accLvl3
                                                                     where extract(year from accLvl3.cas)=2024
                                                                      group by extract(month from accLvl3.cas)
                                                                    )
                                              )
                       );
                       
 --v2: cost: 766 | ordering results of 'fetch'
 select 'Top 3. most accidents (2024): ' as description, TO_CHAR(acc.cas, 'Month','NLS_DATE_LANGUAGE=English') as month_id,
  count(*) as accidents
  from cr_nehody acc
   where extract(year from acc.cas)=2024
    group by TO_CHAR(acc.cas, 'Month','NLS_DATE_LANGUAGE=English')
     order by accidents desc 
      offset 2 rows fetch first row with ties;
     
 --v3: cost: 764 | analytic funcion 'dense_rank'
 select 'Top 3. most accidents (2024): ' as description, month_id, accidents
 from (
     select month_id, accidents,
            dense_rank() over (order by accidents desc) rnk
     from (
         select TO_CHAR(acc.cas, 'Month','NLS_DATE_LANGUAGE=English') as month_id, count(*) as accidents
          from cr_nehody acc
           where extract(year from acc.cas)=2024
            group by TO_CHAR(acc.cas, 'Month','NLS_DATE_LANGUAGE=English')
       )
) where rnk = 3;

     
 --v4: cost: 2383 | vyuzitie analytickej funkcie dense_rank a analytickej funkcie count namiesto agregacnej count
SELECT 'Top 3. most accidents (2024): ' as description, month_id, accidents
 FROM
(
	 select distinct month_id, accidents
	 from (
	     select month_id, accidents,
	            dense_rank() over (order by accidents desc) rnk
	     from (
	         select TO_CHAR(acc.cas, 'Month','NLS_DATE_LANGUAGE=English') as month_id, count(*) over (partition by extract(month from acc.cas) order by null) as accidents
	          from cr_nehody acc
	           WHERE EXTRACT(YEAR FROM acc.cas) = 2024
	       )
) where rnk = 3
);