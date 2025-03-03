BEGIN
	dbms_stats.gather_schema_stats('POLJAK');
END;
/

--===================================================================================================
--                A N A L Y T I C K E   S P R A C O V A N I E   D A T
--===================================================================================================

--00
select 'Pocet autonehod za rok:' as popis,
 sum(case extract(year from cas) when 2023 then 1 else 0 end) as count_2023,
 sum(case extract(year from cas) when 2024 then 1 else 0 end) as count_2024,
 sum(case extract(year from cas) when 2025 then 1 else 0 end) as count_2025
from cr_nehody
    UNION ALL
select 'Pocet vozidiel za rok:' as popis,
 sum(case extract(year from cas) when 2023 then 1 else 0 end) as count_2023,
 sum(case extract(year from cas) when 2024 then 1 else 0 end) as count_2024,
 sum(case extract(year from cas) when 2025 then 1 else 0 end) as count_2025
from cr_vozidla
 join cr_nehody using(id_nehoda);

--01===================================================================================================
-- mesiace s najviac umrtiami pre kazdy kraj za rok 2024
--v1: cost 1530
SELECT kraj, mesiac, mrtvych
FROM (
	SELECT kk.id_kraj, kk.nazov kraj, TO_CHAR(nn.cas, 'Mon','NLS_DATE_LANGUAGE=Slovak') AS mesiac,
    extract(month from cas) as mesiac_id,
    sum(nn.mrtvi) AS mrtvych
	 FROM CR_NEHODY nn
	  JOIN cr_kraje kk ON nn.id_kraj = kk.id_kraj
       where extract(year from cas)=2024
	    GROUP BY kk.id_kraj, kk.nazov, extract(month from cas), TO_CHAR(nn.cas, 'Mon','NLS_DATE_LANGUAGE=Slovak')
 ) main
  WHERE EXISTS (SELECT 1
  				FROM (
                      SELECT id_kraj, max(poc_mrtvi) AS mrtvych
                       FROM (
                            SELECT ID_KRAJ, sum(mrtvi) AS poc_mrtvi
                             FROM cr_nehody
                              where extract(year from cas)=2024
                               GROUP BY ID_KRAJ, EXTRACT(MONTH FROM cas)
                            )
                        GROUP BY id_kraj
                     ) tmp
                 WHERE main.id_kraj = tmp.id_kraj AND main.mrtvych = tmp.mrtvych
                )
    ORDER BY mrtvych desc, kraj, mesiac_id;


 --v2: cost 769
select kraj, mesiac, mrtvych
 from (
    SELECT DISTINCT kraj, mesiac, mrtvych, mesiac_id
     FROM (
        SELECT kraj, mesiac, mrtvych, dense_rank() OVER (PARTITION BY kraj ORDER BY mrtvych desc) AS rnk, 
                mesiac_id
        FROM (
            SELECT k.nazov AS kraj, TO_CHAR(n.cas, 'Mon','NLS_DATE_LANGUAGE=Slovak') AS mesiac, 
             sum(n.mrtvi) OVER (PARTITION BY k.id_kraj, EXTRACT(MONTH FROM cas) ORDER BY null) AS mrtvych,
             extract (month from n.cas) as mesiac_id
             FROM cr_nehody n
              JOIN cr_kraje k ON n.id_kraj = k.id_kraj
               where extract(year from cas)=2024
         )
     ) WHERE rnk = 1
      ORDER BY mrtvych DESC, kraj, mesiac_id
 );
 
 --v3: cost 768
SELECT kraj, mesiac, mrtvych
FROM (
	SELECT kraj, mesiac, mrtvych, dense_rank() OVER (PARTITION BY kraj ORDER BY mrtvych desc) AS rnk,
            mesiac_id
	FROM (
		 SELECT k.nazov AS kraj, TO_CHAR(n.cas, 'Mon','NLS_DATE_LANGUAGE=Slovak') AS mesiac, 
		 sum(n.mrtvi) AS mrtvych, extract(month from cas) as mesiac_id
		 FROM cr_nehody n
		  JOIN cr_kraje k ON n.id_kraj = k.id_kraj
           where extract(year from cas)=2024
            group by k.nazov, extract(month from cas), TO_CHAR(n.cas, 'Mon','NLS_DATE_LANGUAGE=Slovak') -- redukcia nepotrebnych duplicit, ktore su dosledkom analytickej fcie
	 ) 
) WHERE rnk = 1
 ORDER BY mrtvych DESC, kraj, mesiac_id;
 --===================================================================================================
 --02=================================================================================================
 -- 3. mesiac s najvacsim poctom nehod
 
 --v1: na skontrolovanie 3. v poradi s vypisom umiestneni pre vsetky mesiace
 select extract(month from cas) as month, count(*) as poc_nehod
  from cr_nehody
   where extract(year from cas)=2024
    group by extract(month from cas)
     order by poc_nehod desc;
    
--v1: cost: 763 | vnorene selecty na ziskanie lokalneho maxima
select 'Top 3. najviac nehod (2024): ' as popis,
 TO_CHAR(cas, 'Mon','NLS_DATE_LANGUAGE=Slovak') as mesiac, count(*) as poc_nehod
  from cr_nehody
   where extract(year from cas)=2024
    group by TO_CHAR(cas, 'Mon','NLS_DATE_LANGUAGE=Slovak')
     having count(*) = (select max(count(*))
                        from cr_nehody
                         where extract(year from cas)=2024
                          group by extract(month from cas)
                           having count(*) < (select max(count(*))
                                              from cr_nehody
                                               where extract(year from cas)=2024
                                                group by extract(month from cas)
                                                 having count(*) < (select max(count(*))
                                                                    from cr_nehody
                                                                     where extract(year from cas)=2024
                                                                      group by extract(month from cas)
                                                                    )
                                              )
                       );
                       
 --v2: cost: 766 | pouzitie fetch so zoradenim
 select 'Top 3. najviac nehod (2024): ' as popis, TO_CHAR(cas, 'Mon','NLS_DATE_LANGUAGE=Slovak') as month,
  count(*) as poc_nehod
  from cr_nehody
   where extract(year from cas)=2024
    group by TO_CHAR(cas, 'Mon','NLS_DATE_LANGUAGE=Slovak')
     order by poc_nehod desc 
      offset 2 rows fetch first row with ties;
     
 --v3: cost: 764 | vyuzitie analytickej funkcie dense_rank
 select 'Top 3. najviac nehod (2024): ' as popis, mesiac, poc_nehod
 from (
     select mesiac, poc_nehod,
            dense_rank() over (order by poc_nehod desc) rnk
     from (
         select TO_CHAR(cas, 'Mon','NLS_DATE_LANGUAGE=Slovak') as mesiac, count(*) as poc_nehod
          from cr_nehody
           where extract(year from cas)=2024
            group by TO_CHAR(cas, 'Mon','NLS_DATE_LANGUAGE=Slovak')
       )
) where rnk = 3;

     
 --v4: cost: 2383 | vyuzitie analytickej funkcie dense_rank a analytickej funkcie count namiesto agregacnej count
 select distinct mesiac, poc_nehod
 from (
     select mesiac, poc_nehod,
            dense_rank() over (order by poc_nehod desc) rnk
     from (
         select extract(month from cas) as mesiac, count(*) over (partition by extract(month from cas) order by null) as poc_nehod
          from cr_nehody
       )
) where rnk = 3;
--===================================================================================================
--03=================================================================================================
--  statistika pre obsah alkoholu pocas nehody
select case when al.pritomny='A' then 'Ano'
            when al.pritomny='N' then 'Nie'
            when al.pritomny='O' then 'Odmietnute'
            when al.pritomny='X' then 'Nezistovane'
            else 'Nezname' end as alkohol_bol_pritomny,
    al.obsah_perc as obsah_alkoholu_v_krvi_pri_nehode,
    count(*) as poc_zavinenych_nehod
 from cr_nehody n
 join cr_pritomnost_alko al on n.id_alko_prit = al.id_stav
  where extract(year from cas)=2024
   group by al.id_stav, al.pritomny, al.obsah_perc
    order by poc_zavinenych_nehod desc;
 
--===================================================================================================
-- pivotova transformacia pre mesiace
select mesiac, ' Pocty: ' as popis1, alko_ano, alko_nie, alko_odm, alko_nez,
        ' Percenta: ' as popis2,
        round(100*alko_ano/mes_all,2)||'%' as p_alko_ano,
        round(100*alko_nie/mes_all,2)||'%' as p_alko_nie,
        round(100*alko_odm/mes_all,2)||'%' as p_alko_odm,
        round(100*alko_nez/mes_all,2)||'%' as p_alko_nez
 from (
     select extract(month from cas) as mesiac_id,
                TO_CHAR(cas, 'Month','NLS_DATE_LANGUAGE=Slovak') as mesiac,
                sum(case al.pritomny when 'A' then 1 else 0 end) as alko_ano,
                sum(case al.pritomny when 'N' then 1 else 0 end) as alko_nie,
                sum(case al.pritomny when 'O' then 1 else 0 end) as alko_odm,
                sum(case al.pritomny when 'X' then 1 else 0 end) as alko_nez,
                count(*) as mes_all
      from cr_nehody n
      join cr_pritomnost_alko al on n.id_alko_prit = al.id_stav
       where extract(year from cas)=2024
        group by extract(month from cas), TO_CHAR(cas, 'Month','NLS_DATE_LANGUAGE=Slovak')
 )
  order by mesiac_id;
  
--===================================================================================================
-- uloha 1: aky je percentualny pomer najhorsich skod sposobenych alkoholom z TOP 1000 vseobecne k tymto TOP 1000 najhorsich skod sposobenych lubovolnym druhom 
select skoda_alko, skoda_celkom, round(100*skoda_alko/skoda_celkom, 2) as perc_podiel from (
 select
 (select 1 from dual) as skoda_alko,
 (select 2 from dual) as skoda_celkom
  from dual
);

-- v1 - celkova skoda vypocitana z 1000 najvacsich nehod lubovolneho druhu
select suma_kc          --v1(analytic) cost: 763
 from (
     select celk_skoda_kc as skoda,
        row_number() over(order by celk_skoda_kc desc) as rn,
        sum(celk_skoda_kc) over (order by celk_skoda_kc desc) as suma_kc
      from cr_nehody
       where extract(year from cas)=2024
 ) where rn = 1000;
  
-- v2 - celkova skoda vypocitana z 1000 najvacsich nehod lubovolneho druhu
select sum(skoda) suma_kc --v2(aggregate) cost: 763
 from (
    select celk_skoda_kc as skoda,
        row_number() over(order by celk_skoda_kc desc) as rn
      from cr_nehody
       where extract(year from cas)=2024
 ) where rn <= 1000;   


-- v1 celkova skoda vypocitana z 1000 najvacsich nehod so zistenym obsahom alkoholu v krvi
select sum(skoda) over() as suma_kc --v1(analytic) cost: 766;
 from (
    select a.pritomny as alko_pritomny, celk_skoda_kc as skoda,
        row_number() over(order by celk_skoda_kc desc) as rn
      from cr_nehody n
       join cr_pritomnost_alko a on n.id_alko_prit = a.id_stav
        where extract(year from cas)=2024
 ) where rn <= 1000 and alko_pritomny='A'
   fetch first row only;

-- v2 celkova skoda vypocitana z 1000 najvacsich nehod so zistenym obsahom alkoholu v krvi
select sum(skoda) suma_kc    --v2(aggregate) cost: 766
 from (
    select a.pritomny as alko_pritomny, celk_skoda_kc as skoda,
        row_number() over(order by celk_skoda_kc desc) as rn
      from cr_nehody n
       join cr_pritomnost_alko a on n.id_alko_prit = a.id_stav
        where extract(year from cas)=2024
 ) where rn <= 1000 and alko_pritomny='A';
 
-- FINAL - spojenie
-- z prvych 1000 najnakladnejsich nehod kolkymi percentami sa na nich podielali nehody s pritomnostou alkoholu. Celkovo vyse 90000 nehod, cize vyberame len z 1.1 % nehod zo vsetkych
-- cost: 1531
select 'Podiel skody s pritom. alko vramci TOP 1000:' as popis,
 round(100*(sum_kc_alko/sum_kc_celk),3) || '%' as perc, sum_kc_alko, sum_kc_celk
from ( 
  select 
    (select sum(skoda) suma_kc    --v2(aggregate) cost: 766
      from (
        select a.pritomny as alko_pritomny, celk_skoda_kc as skoda,
            row_number() over(order by celk_skoda_kc desc) as rn
          from cr_nehody n
           join cr_pritomnost_alko a on n.id_alko_prit = a.id_stav
            where extract(year from cas)=2024
           ) where rn <= 1000 and alko_pritomny='A'
    ) sum_kc_alko, 
    (select sum(skoda) suma_kc --v2(aggregate) cost: 763
      from (
        select celk_skoda_kc as skoda,
            row_number() over(order by celk_skoda_kc desc) as rn
          from cr_nehody
           where extract(year from cas)=2024
           ) where rn <= 1000
     ) sum_kc_celk
      from dual);
   

--===================================================================================================   
-- kazdy mesiac: 1-riadk. vypis s informaciou a pocetnostou TOP 3 najcastejsie zrazenych zveri
-- cost: 762
select mesiac,
    listagg('(' || rnk || ')' || nazov || ' [' || pocet || 'x]', ' | ') 
     within group (order by rnk) as TOP_3_pocetnosti,
     sum(pocet)||'x' as celkovo
 from (
    select id_mesiac, mesiac, nazov, pocet,
     rank() over (partition by id_mesiac order by pocet desc) as rnk
     from (
         select extract(month from n.cas) as id_mesiac, to_char(n.cas, 'Mon') as mesiac, z.nazov,
         count(*) as pocet
          from cr_nehody n
           join cr_druh_zviera z on n.id_zviera=z.id_druh
            where id_druh_nehody=5 and extract(year from cas)=2024 -- id=5 pre zrazku so zverou
             group by z.id_druh, z.nazov, to_char(cas, 'Mon'), extract(month from cas)
     )
 ) where rnk <= 3
  group by id_mesiac, mesiac
   order by id_mesiac;
   
  
--===================================================================================================
-- 2.5 mesačný kĺzavý medián počtu zranených(ľahko + ťažko zranení) pre rok 2024 (s frekvenciou polmesiac)
-- cost: 816
with 
 cislo_mesiac as (
    select 1 as id_mesiac from dual
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
 mesiace as (
     select id_mesiac, to_date('2024-'||id_mesiac||'-01', 'yyyy-mm-dd') as zac_mes 
      from cislo_mesiac
 ),
 polmesiace as (
    select zac_mes as polmesiac from mesiace
     union
    select zac_mes + floor((last_day(zac_mes)-zac_mes+1)/2) as stred_mes from mesiace
 ),
 polmes_data as (
 select polmesiac, sum(pocet_zraneni) as pocet_zraneni
 from (
     select polmesiac, pocet_zraneni
      from (
         select n.id_nehoda, trunc(n.cas)as datum, pm.polmesiac, (n.lahko_zraneni+n.tazko_zraneni) as pocet_zraneni, 
          row_number() over (partition by id_nehoda order by 
           (case when trunc(cas)-pm.polmesiac>=0 then trunc(cas)-pm.polmesiac else 10000 end)) as pm_priorita
          from cr_nehody n
           join polmesiace pm on trunc(n.cas, 'MM')=trunc(pm.polmesiac, 'MM')
            where extract(year from cas)=2024
      ) where pm_priorita=1 --kazdy zaznam bude mat teraz priradeny prave 1 polmesiac, takze pocet zaznamov = count(*)
 )
  group by polmesiac -- vyvoj poctu zranenych s frekvenciou polmesiac
 )
select polmesiac, median(pocet_zraneni)
 from (
    select polmesiac, pocet_zraneni from polmes_data
     union all select polmesiac, lag(pocet_zraneni,1) over(order by polmesiac) from polmes_data
     union all select polmesiac, lag(pocet_zraneni,2) over(order by polmesiac) from polmes_data
     union all select polmesiac, lag(pocet_zraneni,3) over(order by polmesiac) from polmes_data
     union all select polmesiac, lag(pocet_zraneni,4) over(order by polmesiac) from polmes_data
) group by polmesiac order by polmesiac; 

--===================================================================================================
--              O P T I M A L I Z A C I A   D O P Y T O V  -  I N D E X Y
--===================================================================================================
-- z prvych 1000 najnakladnejsich nehod kolkymi percentami sa na nich podielali nehody s pritomnostou alkoholu. Celkovo vyse 90000 nehod, cize vyberame len z 1.1 % nehod zo vsetkych
-- cost: 1531
select 'Podiel skody s pritom. alko vramci TOP 1000:' as popis,
 round(100*(sum_kc_alko/sum_kc_celk),3) || '%' as perc, sum_kc_alko, sum_kc_celk
from ( 
  select 
    (select sum(skoda) suma_kc    --v2(aggregate) cost: 766
      from (
        select a.pritomny as alko_pritomny, celk_skoda_kc as skoda,
            row_number() over(order by celk_skoda_kc desc) as rn
          from cr_nehody n
           join cr_pritomnost_alko a on n.id_alko_prit = a.id_stav
            where extract(year from cas)=2024
--            where to_number(to_char(cas, 'YYYY'))=2024
           ) where rn <= 1000 and alko_pritomny='A'
    ) sum_kc_alko, 
    (select sum(skoda) suma_kc --v2(aggregate) cost: 763
      from (
        select celk_skoda_kc as skoda,
            row_number() over(order by celk_skoda_kc desc) as rn
          from cr_nehody
           where extract(year from cas)=2024
--           where to_number(to_char(cas, 'YYYY'))=2024
           ) where rn <= 1000
     ) sum_kc_celk
      from dual);
  
select ui.table_name, ui.index_name, ui.index_type, ui.uniqueness, ui.status, ui.visibility, 
       uc.constraint_type, uc.owner, uc.constraint_name, uc.status, uc.generated, uc.index_name
 from user_indexes ui
  left join user_constraints uc on ui.index_name=uc.constraint_name
  where ui.table_name='CR_NEHODY'; -- SYS_C00197691
  
--CR_NEHODY > iba PK index-> cost: 1531

create index idx1_btree_nehody_year on cr_nehody(cas); -- nepouzije sa
drop index idx1_btree_nehody_year;

create index idx2_btree_nehody_year on cr_nehody(extract(year from cas)); -- cost: 295
drop index idx2_btree_nehody_year;

create index idx3_btree_nehody_year on cr_nehody(to_number(to_char(cas, 'YYYY'))); -- cost: 295
drop index idx3_btree_nehody_year;

select distinct extract(year from cas) rok -- iba 3 zaznamy: 2023, 2024, 2025
 from cr_nehody;
 
create bitmap index idx_bitmap_nehody_year on cr_nehody(extract(year from cas)); -- cost: 640
drop index idx_bitmap_nehody_year;

--===================================================================================================   
-- kazdy mesiac: 1-riadk. vypis s informaciou a pocetnostou TOP 3 najcastejsie zrazenych zveri
-- cost: 762
select mesiac,
    listagg('(' || rnk || ')' || nazov || ' [' || pocet || 'x]', ' | ') 
     within group (order by rnk) as TOP_3_pocetnosti,
     sum(pocet)||'x' as celkovo
 from (
    select id_mesiac, mesiac, nazov, pocet,
     rank() over (partition by id_mesiac order by pocet desc) as rnk
     from (
         select extract(month from n.cas) as id_mesiac, to_char(n.cas, 'Mon') as mesiac, z.nazov,
         count(*) as pocet
          from cr_nehody n
           join cr_druh_zviera z on n.id_zviera=z.id_druh
            where id_druh_nehody=5 and extract(year from cas)=2025 -- id=5 pre zrazku so zverou
             group by z.id_druh, z.nazov, to_char(cas, 'Mon'), extract(month from cas)
     )
 ) where rnk <= 3
  group by id_mesiac, mesiac
   order by id_mesiac;
   
select count(distinct id_druh_nehody) from cr_nehody; --10 roznych typov

create bitmap index idx_bitmap_neh_druh_nehody on cr_nehody(id_druh_nehody);
create index idx_btree_neh_druh_nehody on cr_nehody(id_druh_nehody);

create index idx_btree_neh_year on cr_nehody(extract(year from cas)); -- cost: 150

create index idx_btree_nehody_rok_druh on cr_nehody(extract(year from cas), id_druh_nehody); -- cost: 32

--===================================================================================================
select * from user_ind_columns where index_name=upper('idx_bitmap_neh_druh_nehody');

select ui.table_name, ui.index_name, ui.index_type, ui.uniqueness, ui.status, ui.visibility, 
       uc.constraint_type, uc.owner, uc.constraint_name, uc.status, uc.generated, uc.index_name
 from user_indexes ui
  left join user_constraints uc on ui.index_name=uc.constraint_name
  where ui.table_name='CR_VOZIDLA'; -- SYS_C00197691
  
-- spajanie tabuliek cez FK
-- cost: 1793
select 'Pocet autonehod za rok:' as popis,
 sum(case extract(year from cas) when 2023 then 1 else 0 end) as count_2023,
 sum(case extract(year from cas) when 2024 then 1 else 0 end) as count_2024,
 sum(case extract(year from cas) when 2025 then 1 else 0 end) as count_2025
from cr_nehody
    UNION ALL
select 'Pocet vozidiel za rok:' as popis,
 sum(case extract(year from cas) when 2023 then 1 else 0 end) as count_2023,
 sum(case extract(year from cas) when 2024 then 1 else 0 end) as count_2024,
 sum(case extract(year from cas) when 2025 then 1 else 0 end) as count_2025
from cr_vozidla
 join cr_nehody using(id_nehoda);

create index ind_btree_voz_id_nehoda_fk on cr_vozidla(id_nehoda);

-- spajanie tabuliek cez FK
-- cost: 1541
select 'Pocet autonehod za rok:' as popis,
 sum(case extract(year from cas) when 2023 then 1 else 0 end) as count_2023,
 sum(case extract(year from cas) when 2024 then 1 else 0 end) as count_2024,
 sum(case extract(year from cas) when 2025 then 1 else 0 end) as count_2025
from cr_nehody
    UNION ALL
select /*+Use_Merge(CR_VOZIDLA IND_BTREE_VOZ_ID_NEHODA_FK)*/'Pocet vozidiel za rok:' as popis, -- hint nezohladnuje
 sum(case extract(year from cas) when 2023 then 1 else 0 end) as count_2023,
 sum(case extract(year from cas) when 2024 then 1 else 0 end) as count_2024,
 sum(case extract(year from cas) when 2025 then 1 else 0 end) as count_2025
from cr_vozidla
 join cr_nehody using(id_nehoda);
 
-- the end:)