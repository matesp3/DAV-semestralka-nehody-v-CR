--popisne tabulky
create table cr_kraje(
    id_kraj integer primary key,
    nazov varchar2(30)
);
/

insert into cr_kraje(id_kraj, nazov) values(0, 'hl.mesto Praha');
insert into cr_kraje(id_kraj, nazov) values(1, 'Středočeský kraj');
insert into cr_kraje(id_kraj, nazov) values(2, 'Jihočeský kraj');
insert into cr_kraje(id_kraj, nazov) values(3, ' Plzeňský kraj');
insert into cr_kraje(id_kraj, nazov) values(4, ' Ústecký kraj');
insert into cr_kraje(id_kraj, nazov) values(5, ' Královéhradecký kraj');
insert into cr_kraje(id_kraj, nazov) values(6, ' Jihomoravský kraj');
insert into cr_kraje(id_kraj, nazov) values(7, ' Moravskoslezský kraj');

insert into cr_kraje(id_kraj, nazov) values(14, 'Olomoucký kraj');
insert into cr_kraje(id_kraj, nazov) values(15, 'Zlínský kraj');
insert into cr_kraje(id_kraj, nazov) values(16, 'kraj Vysočina');
insert into cr_kraje(id_kraj, nazov) values(17, 'Pardubický kraj');
insert into cr_kraje(id_kraj, nazov) values(18, ' Liberecký kraj');
insert into cr_kraje(id_kraj, nazov) values(19, 'Karlovarský kraj');

update cr_kraje set nazov=LTRIM(nazov,' ');
select * from cr_kraje;
--commit;

create table cr_druh_nehody(
    id_druh number primary key,
    popis varchar2(100)
);
/

insert into cr_druh_nehody(id_druh, popis) values (1,'zrážka - s idúcim nekoľajovým vozidlom');
insert into cr_druh_nehody(id_druh, popis) values (2,'zrážka - s vozidlom zaparkovaný, odstaveným');
insert into cr_druh_nehody(id_druh, popis) values (3,'zrážka - s pevnou prekážkou');
insert into cr_druh_nehody(id_druh, popis) values (4,'zrážka - s chodcom');
insert into cr_druh_nehody(id_druh, popis) values (5,'zrážka - s lesnou zverou');
insert into cr_druh_nehody(id_druh, popis) values (6,'zrážka - s domácim zvieraťom');
insert into cr_druh_nehody(id_druh, popis) values (7,'zrážka - s vlakom');
insert into cr_druh_nehody(id_druh, popis) values (8,'zrážka - s električkou');
insert into cr_druh_nehody(id_druh, popis) values (9,'havária');
insert into cr_druh_nehody(id_druh, popis) values (0,'iný druh nehody');

select * from cr_druh_nehody;
--commit;
select distinct(extract(month from cas)) from cr_vozidla join cr_nehody using(id_nehoda) where extract(year from cas)=2023;
create table cr_druh_zrazky_vozidiel(
    id_druh number primary key,
    popis varchar2(22)
);
/

insert into cr_druh_zrazky_vozidiel(id_druh, popis) values (1, 'čelná');
insert into cr_druh_zrazky_vozidiel(id_druh, popis) values (2, 'bočná');
insert into cr_druh_zrazky_vozidiel(id_druh, popis) values (3, 'z boku');
insert into cr_druh_zrazky_vozidiel(id_druh, popis) values (4, 'zozadu');
insert into cr_druh_zrazky_vozidiel(id_druh, popis) values (0, 'neprichádza v úvahu');

select * from cr_druh_zrazky_vozidiel;
--commit;

create table cr_druh_pevnej_zrazky(
    id_druh number primary key,
    popis varchar2(50),
    detail varchar2(120)
);
/
alter table cr_druh_pevnej_zrazky modify popis not null;

insert into cr_druh_pevnej_zrazky(id_druh, popis, detail) values(1,'strom','');
insert into cr_druh_pevnej_zrazky(id_druh, popis, detail) values(2,'sloup','telefonní, veřejného osvětlení, elektrického vedení, signalizace apod. ');
insert into cr_druh_pevnej_zrazky(id_druh, popis, detail) values(3,'odrazník, patník,','sloupek směrový, sloupek dopravní značky apod. ');
insert into cr_druh_pevnej_zrazky(id_druh, popis, detail) values(4,'svodidlo','');
insert into cr_druh_pevnej_zrazky(id_druh, popis, detail) values(5,'překážka vzniklá provozem jiného vozidla','(např. ztráta náikladu , výstroje vozidla nebo jeho části)');
insert into cr_druh_pevnej_zrazky(id_druh, popis, detail) values(6,'zeď, pevná část mostů, ','podjezdů, tunelů apod. ');
insert into cr_druh_pevnej_zrazky(id_druh, popis, detail) values(7,'závory železničního přejezdu','');
insert into cr_druh_pevnej_zrazky(id_druh, popis, detail) values(8,'překážka vzniklá stavební činností','(přenosné dopravní značky, hromada štěrku, písku nebo jiného stavebního materiálu apod.)');
insert into cr_druh_pevnej_zrazky(id_druh, popis, detail) values(9,'jiná překážka','(zábradlí, oplocení, násep, nástupní ostrůvek apod.)');
insert into cr_druh_pevnej_zrazky(id_druh, popis, detail) values(0,'nepříchází v úvahu','nejedná se o srážku s pevnou překážkou');

select * from cr_druh_pevnej_zrazky;
--commit;

create table cr_druh_zviera(
    id_druh number primary key,
    nazov varchar2(15)
);
/
alter table cr_druh_zviera modify nazov varchar2(30) not null;

insert into cr_druh_zviera(id_druh, nazov) values(1,'srna, srnec');
insert into cr_druh_zviera(id_druh, nazov) values(2,'jelen, laň');
insert into cr_druh_zviera(id_druh, nazov) values(3,'daněk');
insert into cr_druh_zviera(id_druh, nazov) values(4,'muflon');
insert into cr_druh_zviera(id_druh, nazov) values(5,'zajíc');
insert into cr_druh_zviera(id_druh, nazov) values(6,'bažant');
insert into cr_druh_zviera(id_druh, nazov) values(7,'divoké prase');
insert into cr_druh_zviera(id_druh, nazov) values(8,'liška');
insert into cr_druh_zviera(id_druh, nazov) values(9,'sob');
insert into cr_druh_zviera(id_druh, nazov) values(10,'vlk');
insert into cr_druh_zviera(id_druh, nazov) values(11,'medvěd');
insert into cr_druh_zviera(id_druh, nazov) values(12,'jiná zvěř');
insert into cr_druh_zviera(id_druh, nazov) values(13,'vepř');
insert into cr_druh_zviera(id_druh, nazov) values(14,'kráva, tele');
insert into cr_druh_zviera(id_druh, nazov) values(15,'kůň');
insert into cr_druh_zviera(id_druh, nazov) values(16,'koza');
insert into cr_druh_zviera(id_druh, nazov) values(17,'ovce');
insert into cr_druh_zviera(id_druh, nazov) values(18,'pes');
insert into cr_druh_zviera(id_druh, nazov) values(19,'kočka');
insert into cr_druh_zviera(id_druh, nazov) values(20,'slepice, kohout');
insert into cr_druh_zviera(id_druh, nazov) values(21,'kachna, husa');
insert into cr_druh_zviera(id_druh, nazov) values(22,'jiné zvíře');
insert into cr_druh_zviera(id_druh, nazov) values(0,'nejde o srážku se zvířetem');

select * from cr_druh_zviera;
--commit;

create table cr_charakter_nehody(
    id_charakter number primary key,
    popis varchar2(22)
);
/
alter table cr_charakter_nehody modify popis varchar2(25) not null;

insert into cr_charakter_nehody(id_charakter, popis) values(1, 's následky na životě');
insert into cr_charakter_nehody(id_charakter, popis) values(2, 'pouze s hmotnou škodou');

select * from cr_charakter_nehody;
--commit;

create table cr_zavinenie_nehody(
    id_zavinenie number primary key,
    pricina varchar2(50) not null
);
/

insert into cr_zavinenie_nehody(id_zavinenie, pricina) values(1,'řidičem motorového vozidla');
insert into cr_zavinenie_nehody(id_zavinenie, pricina) values(2,'řidičem nemotorového vozidla');
insert into cr_zavinenie_nehody(id_zavinenie, pricina) values(3,'chodcem');
insert into cr_zavinenie_nehody(id_zavinenie, pricina) values(4,'lesní zvěří, domácím zvířectvem');
insert into cr_zavinenie_nehody(id_zavinenie, pricina) values(5,'jiným účastníkem silničního provozu');
insert into cr_zavinenie_nehody(id_zavinenie, pricina) values(6,'závadou komunikace');
insert into cr_zavinenie_nehody(id_zavinenie, pricina) values(7,'technickou závadou vozidla');
insert into cr_zavinenie_nehody(id_zavinenie, pricina) values(0,'jiné zavinění');

select * from cr_zavinenie_nehody;
--commit;

create table cr_pritomnost_alko(
    id_stav number primary key,
    pritomny char(1), -- 'A'-ano, 'N'-nie, 'O'-odmietnute, 'X'-nezistovane, null
    obsah_perc varchar(45),
    constraint check_stav_pritomnosti check (pritomny in ('A','N','O','X',null))
);
/

insert into cr_pritomnost_alko(id_stav, pritomny, obsah_perc) values(1,'A','obsah alkoholu v krvi do 0.24 %');
insert into cr_pritomnost_alko(id_stav, pritomny, obsah_perc) values(2,'N',null);
insert into cr_pritomnost_alko(id_stav, pritomny, obsah_perc) values(3,'A', 'obsah alkoholu v krvi od 0.24 % do 0.5 %');
insert into cr_pritomnost_alko(id_stav, pritomny, obsah_perc) values(4,'O',null);
insert into cr_pritomnost_alko(id_stav, pritomny, obsah_perc) values(5,null,null);
insert into cr_pritomnost_alko(id_stav, pritomny, obsah_perc) values(6,'A','obsah alkoholu v krvi od 0.5 % do 0.8 %');
insert into cr_pritomnost_alko(id_stav, pritomny, obsah_perc) values(7,'A','obsah alkoholu v krvi od 0.8 % do 1.0 %');
insert into cr_pritomnost_alko(id_stav, pritomny, obsah_perc) values(8,'A','obsah alkoholu v krvi od 1.0 % do 1.5 %');
insert into cr_pritomnost_alko(id_stav, pritomny, obsah_perc) values(9,'A','obsah alkoholu v krvi 1.5 % a více');
insert into cr_pritomnost_alko(id_stav, pritomny, obsah_perc) values(0,'X',null);

select * from cr_pritomnost_alko;
--commit;

create table cr_vinnik_drogy(
    id_droga number primary key,
    droga varchar2(30) not null
);
/

insert into cr_vinnik_drogy(id_droga, droga) values(1,'THC (tetrahydrokanabinol)');
insert into cr_vinnik_drogy(id_droga, droga) values(2,'AMP (amfetamin)');
insert into cr_vinnik_drogy(id_droga, droga) values(3,'MET (metamfetamin)');
insert into cr_vinnik_drogy(id_droga, droga) values(4,'OPI (opiáty)');
insert into cr_vinnik_drogy(id_droga, droga) values(5,'benzodiazepin');
insert into cr_vinnik_drogy(id_droga, droga) values(6,'jiné');
insert into cr_vinnik_drogy(id_droga, droga) values(7,'odmítnuto');
insert into cr_vinnik_drogy(id_droga, droga) values(8,'nezjišťováno');
insert into cr_vinnik_drogy(id_droga, droga) values(0,'ne');


select * from cr_vinnik_drogy;
--commit;

create table cr_pricina_nehody(
    id_pricina number primary key,
    kategoria varchar2(120) not null,
    detail varchar2(120)
);
/

insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(100,'nezaviněná řidičem','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(201,'nepřizpůsobení rychlosti','intenzitě (hustotě) provozu');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(202,'nepřizpůsobení rychlosti','viditelnosti (mlha, soumrak, jízda v noci na tlumená světla apod.)');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(203,'nepřizpůsobení rychlosti','vlastnostem vozidla a nákladu');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(204,'nepřizpůsobení rychlosti','stavu vozovky (náledí, výtluky, bláto, mokrý povrch apod.)');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(205,'nepřizpůsobení rychlosti','dopravně technickému stavu vozovky (zatáčka, klesání, stoupání, šířka vozovky apod.)');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(206,'překročení předepsané rychlosti stanovené pravidly','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(207,'překročení rychlosti stanovené dopravní značkou','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(208,'nepřizpůsobení rychlosti','bočnímu, nárazovému větru (i při míjení, předjíždění vozidel)');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(209,'jiný druh nepřiměřené rychlosti','');

insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(301,'předjíždění','vpravo');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(302,'předjíždění ','bez dostatečného bočního odstupu');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(303,'předjíždění','bez dostatečného rozhledu (v nepřehledné zatáčce nebo její blízkosti, před vrcholem stoupání apod.)');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(304,'při předjíždění','došlo k ohrožení protijedoucího řidiče vozidla (špatný odhad vzdálenosti potřebné k předjetí apod.)');
alter table cr_pricina_nehody modify detail varchar2(160);
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(305,'při předjíždění','došlo k ohrožení předjížděného řidiče vozidla (vynucené zařazení, předjížděný řidič musel prudce brzdit, měnit směr jízdy apod.)');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(306,'předjíždění','vlevo vozidla odbočujícího vlevo');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(307,'předjíždění','v místech, kde je to zakázáno dopravní značkou');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(308,'při předjíždění','byla přejeta podélná čára souvislá');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(309,'bránění v předjíždění','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(310,'přehlédnutí již předjíždějícícho souběžně jedoucího vozidla','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(311,'jiný druh nesprávného předjíždění','');

insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(401,'jízda na "červenou" 3-barevného semaforu','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(402,'proti příkazu dopravní značky ','STŮJ DEJ PŘEDNOST');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(403,'proti příkazu dopravní značky ','DEJ PŘEDNOST');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(404,'vozidlu přijíždějícímu zprava','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(405,'při odbočování vlevo','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(406,'tramvají, která odbočuje','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(407,'protijedoucímu vozidlu při objíždění překážky','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(408,'při zařazování do proudu jedoucích vozidel ze stanice, místa zastavení nebo stání','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(409,'při vjíždění na silnici','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(410,'při otáčení nebo couvání','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(411,'při přejíždění z jednoho jízdního pruhu do druhého','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(412,'chodci na vyznačeném přechodu','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(413,'při odbočování vlevo','souběžně jedoucímu vozidlu');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(414,'jiné nedání přednosti','');

insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(501,'jízda po nesprávné straně vozovky, vjetí do protisměru','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(502,'vyhýbání bez dostatečného bočního odstupu (vůle)','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(503,'nedodržení bezpečné vzdálenosti za vozidlem','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(504,'nesprávné otáčení nebo couvání ','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(505,'chyby při udání směru jízdy','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(506,'bezohledná, agresivní, neohleduplná jízda','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(507,'náhlé bezdůvodné snížení rychlosti jízdy, zabrzdění nebo zastavení ','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(508,'řidič se plně nevěnoval řízení vozidla','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(509,'samovolné rozjetí nezajištěného vozidla','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(510,'vjetí na nezpevněnou komunikaci','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(511,'nezvládnutí řízení vozidla','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(512,'jízda (vjetí) jednosměrnou ulicí, silnicí (v protisměru)','');
alter table cr_pricina_nehody modify kategoria varchar2(140);
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(513,'nehoda v důsledku  použití (policií) prostředků k násilnému zastavení vozidla (zastavovací pásy, zábrana, vozidlo atp.)','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(514,'nehoda v důsledku použití služební zbraně (policií)','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(515,'nehoda při provádění služebního zákroku (pronásledování pachatele atd.)','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(516,'jiný druh nesprávného způsobu jízdy','');

insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(601,'závada řízení','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(602,'závada provozní brzdy','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(603,'neúčinná nebo nefungující parkovací brzda','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(604,'opotřebení běhounu pláště pod stanovenou mez','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(605,'defekt pneumatiky způsobený průrazem nebo náhlým únikem vzduchu','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(606,'závada osvětlovací soustavy vozidla (neúčinná, chybějící, znečištěná apod.)','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(607,'nepřipojená nebo poškozená spojovací hadice pro bzrdění přípojného vozidla','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(608,'nesprávné uložení nákladu','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(609,'upadnutí, ztráta kola vozidla (i rezervního)','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(610,'zablokování kol v důsledku mechanické závady vozidla (zadřený motor, převodovka, rozvodovka, spadlý řetěz apod.)','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(611,'lom závěsu kola, pružiny','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(612,'nezajištěná nebo poškozená bočnice (i u přívěsu)','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(613,'závada závěsu pro přívěs','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(614,'utržená spojovací hřídel','');
insert into cr_pricina_nehody(id_pricina, kategoria, detail) values(615,'jiná technická závada (vztahuje se i na přípojná vozidla)','');


select * from cr_pricina_nehody order by id_pricina;
--commit;

create table cr_povrch_vozovky(
    id_povrch number primary key,
    popis varchar2(30) not null
);
/

insert into cr_povrch_vozovky(id_povrch, popis) values(1,'dlažba');
insert into cr_povrch_vozovky(id_povrch, popis) values(2,'živice');
insert into cr_povrch_vozovky(id_povrch, popis) values(3,'beton');
insert into cr_povrch_vozovky(id_povrch, popis) values(4,'panely');
insert into cr_povrch_vozovky(id_povrch, popis) values(5,'štěrk');
insert into cr_povrch_vozovky(id_povrch, popis) values(6,'jiný nezpevněný povrch');

select * from cr_povrch_vozovky;
--commit;

create table cr_stav_vozovky(
    id_stav number primary key,
    popis varchar2(40) not null,
    detail varchar2(45)
);
/

insert into cr_stav_vozovky(id_stav, popis, detail) values(1,'povrch suchý','neznečištěný');
alter table cr_stav_vozovky modify detail varchar2(55);
insert into cr_stav_vozovky(id_stav, popis, detail) values(2,'povrch suchý','znečištěný (písek, prach, listí, štěrk atd.)');
insert into cr_stav_vozovky(id_stav, popis, detail) values(3,'povrch mokrý','');
insert into cr_stav_vozovky(id_stav, popis, detail) values(4,'na vozovce je bláto','');
insert into cr_stav_vozovky(id_stav, popis, detail) values(5,'na vozovce je náledí, ujetý sníh ',' - posypané');
insert into cr_stav_vozovky(id_stav, popis, detail) values(6,'na vozovce je náledí, ujetý sníh ',' - neposypané');
alter table cr_stav_vozovky modify popis varchar2(45);
insert into cr_stav_vozovky(id_stav, popis, detail) values(7,'na vozovce je rozlitý olej, nafta apod. ','');
insert into cr_stav_vozovky(id_stav, popis, detail) values(8,'souvislá sněhová vrstva, rozbředlý sníh','');
insert into cr_stav_vozovky(id_stav, popis, detail) values(9,'náhlá změna stavu vozovky','(námraza na mostu, místní náledí)');
insert into cr_stav_vozovky(id_stav, popis, detail) values(0,'jiný stav povrchu vozovky v době nehody','');

select * from cr_stav_vozovky;
--commit;

create table cr_stav_komunikacie(
    id_stav number primary key,
    popis varchar2(65) not null
);
/

alter table cr_stav_komunikacie modify popis varchar2(75);
insert into cr_stav_komunikacie(id_stav, popis) values(1,'dobrý, bez závad');
insert into cr_stav_komunikacie(id_stav, popis) values(2,'podélný sklon vyšší než 8 %');
insert into cr_stav_komunikacie(id_stav, popis) values(3,'nesprávně umístěná, znečištěná, chybějící dopravní značka');
insert into cr_stav_komunikacie(id_stav, popis) values(4,'zvlněný povrch v podélném směru');
insert into cr_stav_komunikacie(id_stav, popis) values(5,'souvislé výtluky');
insert into cr_stav_komunikacie(id_stav, popis) values(6,'nesouvislé výtluky');
insert into cr_stav_komunikacie(id_stav, popis) values(7,'trvalé zúžení vozovky');
insert into cr_stav_komunikacie(id_stav, popis) values(8,'příčná stružka, hrbol, vystouplé, propadlé kolejnice');
insert into cr_stav_komunikacie(id_stav, popis) values(9,'neoznačená nebo nedostatečně označená překážka na komunikaci');
insert into cr_stav_komunikacie(id_stav, popis) values(10,'přechodná uzavírka jednoho jízdního pruhu');
insert into cr_stav_komunikacie(id_stav, popis) values(11,'přechodná uzavírka komunikace nebo jízdního pásu');
insert into cr_stav_komunikacie(id_stav, popis) values(12,'jiný (neuvedený) stav nebo závada komunikace');

select * from cr_stav_komunikacie;
--commit;

create table cr_pocasie_podmienky(
    id_pocasie number primary key,
    popis varchar2(55) not null
);
/

insert into cr_pocasie_podmienky(id_pocasie, popis) values(1,'neztížené');
insert into cr_pocasie_podmienky(id_pocasie, popis) values(2,'mlha');
insert into cr_pocasie_podmienky(id_pocasie, popis) values(3,'na počátku deště, slabý déšť, mrholení apod.');
insert into cr_pocasie_podmienky(id_pocasie, popis) values(4,'déšť');
insert into cr_pocasie_podmienky(id_pocasie, popis) values(5,'sněžení');
insert into cr_pocasie_podmienky(id_pocasie, popis) values(6,'tvoří se námraza, náledí');
insert into cr_pocasie_podmienky(id_pocasie, popis) values(7,'nárazový vítr (boční, vichřice apod.)');
insert into cr_pocasie_podmienky(id_pocasie, popis) values(0,'jiné ztížené');

select * from cr_pocasie_podmienky;
--commit;

create table cr_viditelnost(
    id_viditelnost number primary key,
    kedy varchar2(8) not null,
    detail varchar2(120) not null
);
/

insert into cr_viditelnost(id_viditelnost, kedy, detail) values(1,'ve dne','viditelnost nezhoršená vlivem povětrnostních podmínek');
insert into cr_viditelnost(id_viditelnost, kedy, detail) values(2,'ve dne','zhoršená viditelnost (svítání, soumrak)');
insert into cr_viditelnost(id_viditelnost, kedy, detail) values(3,'ve dne','zhoršená viditelnost vlivem povětrnostních podmínek (mlha, sněžení, déšť apod.)');
insert into cr_viditelnost(id_viditelnost, kedy, detail) values(4,'v noci','s veřejným osvětlením, viditelnost nezhoršená vlivem povětrnostních podmínek');
insert into cr_viditelnost(id_viditelnost, kedy, detail) values(5,'v noci','s veřejným osvětlením, zhoršená viditelnost vlivem povětrnostních podmínek (mlha, déšť, sněžení apod.)');
insert into cr_viditelnost(id_viditelnost, kedy, detail) values(6,'v noci','bez veřejného osvětlení, viditelnost nezhoršená vlivem povětrnostních podmínek');
insert into cr_viditelnost(id_viditelnost, kedy, detail) values(7,'v noci','bez veřejného osvětlení, viditelnost zhoršená vlivem povětrnostních podmínek (mlha, déšť, sněžení apod.)');

select * from cr_viditelnost;
--commit;

create table  cr_rozhladove_pomery(
    id_rozhlad number primary key,
    rozhlad varchar2(35) not null,
    detail varchar2(130)
);
/

insert into cr_rozhladove_pomery(id_rozhlad, rozhlad, detail) values(1,'dobré','');
insert into cr_rozhladove_pomery(id_rozhlad, rozhlad, detail) values(2,'špatné','vlivem okolní zástavby (budovy, plné zábradlí apod.)');
alter table cr_rozhladove_pomery modify detail varchar2(135);
insert into cr_rozhladove_pomery(id_rozhlad, rozhlad, detail) values(3,'špatné','vlivem průběhu komunikace, nebo podéllného profilu nebo trasování (nepřehledný vrchol stoupání, zářez komunikace apod.)');
insert into cr_rozhladove_pomery(id_rozhlad, rozhlad, detail) values(4,'špatné','vlivem vegetace - trvale (stromy, keře apod.)');
insert into cr_rozhladove_pomery(id_rozhlad, rozhlad, detail) values(5,'špatné','vlivem vegetace - přechodně (tráva, obilí apod.)');
insert into cr_rozhladove_pomery(id_rozhlad, rozhlad, detail) values(6,'výhled zakryt stojícím vozidlem','');
insert into cr_rozhladove_pomery(id_rozhlad, rozhlad, detail) values(0,'jiné špatné','');

select * from cr_rozhladove_pomery;
--commit;

create table cr_delenie_komunikacie(
    id_delenie number primary key,
    typ_kom varchar2(35) not null
);
/

insert into cr_delenie_komunikacie(id_delenie, typ_kom) values(1,'dvoupruhová');
insert into cr_delenie_komunikacie(id_delenie, typ_kom) values(2,'třípruhová');
insert into cr_delenie_komunikacie(id_delenie, typ_kom) values(3,'čtyřpruhová s dělícím pásem');
insert into cr_delenie_komunikacie(id_delenie, typ_kom) values(4,'čtyřpruhová s dělící čarou');
insert into cr_delenie_komunikacie(id_delenie, typ_kom) values(5,'vícepruhová');
insert into cr_delenie_komunikacie(id_delenie, typ_kom) values(6,'rychlostní komunikace');
insert into cr_delenie_komunikacie(id_delenie, typ_kom) values(0,'žádná z uvedených');

select * from cr_delenie_komunikacie;
--commit;

create table cr_v_oblasti_komunikacie(
    id_miesto number primary key,
    kde varchar2(40) not null
);
/

insert into cr_v_oblasti_komunikacie(id_miesto, kde) values(1,'na jízdním pruhu');
insert into cr_v_oblasti_komunikacie(id_miesto, kde) values(2,'na odstavném pruhu');
insert into cr_v_oblasti_komunikacie(id_miesto, kde) values(3,'na krajnici');
insert into cr_v_oblasti_komunikacie(id_miesto, kde) values(4,'na odbočovacím, připojovacím pruhu');
insert into cr_v_oblasti_komunikacie(id_miesto, kde) values(5,'na pruhu pro pomalá vozidla');
insert into cr_v_oblasti_komunikacie(id_miesto, kde) values(6,'na chodníku nebo ostrůvku');
insert into cr_v_oblasti_komunikacie(id_miesto, kde) values(7,'na kolejích tramvaje');
insert into cr_v_oblasti_komunikacie(id_miesto, kde) values(8,'mimo komunikaci');
insert into cr_v_oblasti_komunikacie(id_miesto, kde) values(9,'na stezce pro cyklisty');
insert into cr_v_oblasti_komunikacie(id_miesto, kde) values(0,'žádné z uvedených');

select * from cr_v_oblasti_komunikacie;
--commit;

create table cr_riadenie_premavky(
    id_riadenie number primary key,
    typ_riadenia varchar2(45) not null
);
/

insert into cr_riadenie_premavky(id_riadenie, typ_riadenia) values(1,'policistou nebo jiným pověřeným orgánem');
insert into cr_riadenie_premavky(id_riadenie, typ_riadenia) values(2,'světelným signalizačním zařízením');
insert into cr_riadenie_premavky(id_riadenie, typ_riadenia) values(3,'místní úprava ');
insert into cr_riadenie_premavky(id_riadenie, typ_riadenia) values(0,'žádný způsob řízení provozu');

select * from cr_riadenie_premavky;
--commit;

create table cr_uprava_prednosti(
    id_uprava number primary key,
    popis varchar2(70) not null
);
/

insert into cr_uprava_prednosti(id_uprava, popis) values(1,'světelná signalizace přepnuta na přerušovanou žlutou');
insert into cr_uprava_prednosti(id_uprava, popis) values(2,'světelná signalizace mimo provoz');
insert into cr_uprava_prednosti(id_uprava, popis) values(3,'přednost vyznačena dopravními značkami');
alter table cr_uprava_prednosti modify popis varchar2(75);
insert into cr_uprava_prednosti(id_uprava, popis) values(4,'přednost vyznačena přenosnými dopravními značkami nebo zařízením');
insert into cr_uprava_prednosti(id_uprava, popis) values(5,'přednost nevyznačena - vyplývá z pravidel silníčního provozu');
insert into cr_uprava_prednosti(id_uprava, popis) values(0,'žádná místní úprava');

select * from cr_uprava_prednosti;
--commit;

create table cr_oblast(
    id_oblast number primary key,
    miesto varchar2(60) not null
);
/

insert into cr_oblast(id_oblast, miesto) values(1,'přechod pro chodce');
insert into cr_oblast(id_oblast, miesto) values(2,'v blízkosti přechodu pro chodce (do vzdálenosti 20 m)');
alter table cr_oblast modify miesto varchar2(95);
insert into cr_oblast(id_oblast, miesto) values(3,'železniční přejezd nezabezpečený závorami ani světelným výstražným zařízením ');
insert into cr_oblast(id_oblast, miesto) values(4,'železniční přejezd zabezpečený');
insert into cr_oblast(id_oblast, miesto) values(5,'most, nadjezd, podjezd, tunel');
insert into cr_oblast(id_oblast, miesto) values(6,'zastávka autobusu, trolejbusu, tramvaje s nástup. ostrůvkem');
insert into cr_oblast(id_oblast, miesto) values(7,'zastávka tramvaje, autobusu, trolejbusu bez nástup. ostrůvku');
insert into cr_oblast(id_oblast, miesto) values(8,'výjezd z parkoviště, lesní cesty apod.  (pol. 36 = 7,8)');
insert into cr_oblast(id_oblast, miesto) values(9,'čerpadlo pohonných hmot');
insert into cr_oblast(id_oblast, miesto) values(10,'parkoviště přiléhající ke komunikaci');
insert into cr_oblast(id_oblast, miesto) values(0,'žádné nebo žádné z uvedených');

select * from cr_oblast;
--commit;

create table cr_smerove_pomery(
    id_pomery number primary key,
    pomery varchar2(40) not null,
    detail varchar2(60)
);
/

insert into cr_smerove_pomery(id_pomery, pomery, detail) values(1,'přímý úsek','');
insert into cr_smerove_pomery(id_pomery, pomery, detail) values(2,'přímý úsek po projetí zatáčkou ','(do vzdálenosti cca 100 m od optického konce zatáčky)');
insert into cr_smerove_pomery(id_pomery, pomery, detail) values(3,'zatáčka','');
alter table cr_smerove_pomery modify pomery varchar2(45);
insert into cr_smerove_pomery(id_pomery, pomery, detail) values(4,'křižovatka průsečná - čtyřramenná','');
insert into cr_smerove_pomery(id_pomery, pomery, detail) values(5,'křižovatka styková - tříramenná','');
insert into cr_smerove_pomery(id_pomery, pomery, detail) values(6,'křižovatka pěti a víceramenná','');
insert into cr_smerove_pomery(id_pomery, pomery, detail) values(7,'kruhový objezd','');

select * from cr_smerove_pomery;
--commit;

create table cr_miesto_nehody(
    id_miesto number primary key,
    kde varchar2(70) not null,
    detail varchar2(160)
);
/

insert into cr_miesto_nehody(id_miesto, kde, detail) values(0,'mimo křižovatku','');
insert into cr_miesto_nehody(id_miesto, kde, detail) values(10,'na kžižovatce','jedná-li se o křížení místních komunikací, účelových komunikací nebo jde o mezilehlou křižovatku (na sledovaném úseku ve sledovaných městech)');
insert into cr_miesto_nehody(id_miesto, kde, detail) values(11,'uvnitř zóny 1 předmětné křižovatky','');
insert into cr_miesto_nehody(id_miesto, kde, detail) values(12,'uvnitř zóny 2 předmětné křižovatky','');
insert into cr_miesto_nehody(id_miesto, kde, detail) values(13,'uvnitř zóny 3 předmětné křižovatky','');
insert into cr_miesto_nehody(id_miesto, kde, detail) values(14,'uvnitř zóny 4 předmětné křižovatky','');
insert into cr_miesto_nehody(id_miesto, kde, detail) values(15,'uvnitř zóny 5 předmětné křižovatky','');
insert into cr_miesto_nehody(id_miesto, kde, detail) values(16,'uvnitř zóny 6 předmětné křižovatky','');
insert into cr_miesto_nehody(id_miesto, kde, detail) values(17,'uvnitř zóny 7 předmětné křižovatky','');
insert into cr_miesto_nehody(id_miesto, kde, detail) values(18,'uvnitř zóny 8 předmětné křižovatky','');
insert into cr_miesto_nehody(id_miesto, kde, detail) values(19,'na křižovatce','uvnitř hranic křižovatky definovaných pro systém evidence nehod (zóna 9)');
alter table cr_miesto_nehody modify kde varchar2(85);
insert into cr_miesto_nehody(id_miesto, kde, detail) values(22,'(1) na vjezdové nebo výjezdové části větve při mimoúrovňovém křížení','');
insert into cr_miesto_nehody(id_miesto, kde, detail) values(23,'(2) na vjezdové nebo výjezdové části větve při mimoúrovňovém křížení','');
insert into cr_miesto_nehody(id_miesto, kde, detail) values(24,'(3) na vjezdové nebo výjezdové části větve při mimoúrovňovém křížení','');
insert into cr_miesto_nehody(id_miesto, kde, detail) values(25,'(4) na vjezdové nebo výjezdové části větve při mimoúrovňovém křížení','');
insert into cr_miesto_nehody(id_miesto, kde, detail) values(26,'(5) na vjezdové nebo výjezdové části větve při mimoúrovňovém křížení','');
insert into cr_miesto_nehody(id_miesto, kde, detail) values(27,'(6) na vjezdové nebo výjezdové části větve při mimoúrovňovém křížení','');
insert into cr_miesto_nehody(id_miesto, kde, detail) values(28,'(7) na vjezdové nebo výjezdové části větve při mimoúrovňovém křížení','');
insert into cr_miesto_nehody(id_miesto, kde, detail) values(29,'mimo zónu 11-19 a 22-28','');

select * from cr_miesto_nehody;
--commit;

create table cr_pozem_komunikacie(
    id_druh number primary key,
    typ varchar2(25) not null,
    detail varchar2(50)
);
/

insert into cr_pozem_komunikacie(id_druh, typ, detail) values(0,'dálnice','');
insert into cr_pozem_komunikacie(id_druh, typ, detail) values(1,'silnice 1. třídy','');
insert into cr_pozem_komunikacie(id_druh, typ, detail) values(2,'silnice 2. třídy','');
insert into cr_pozem_komunikacie(id_druh, typ, detail) values(3,'silnice 3. třídy','');
insert into cr_pozem_komunikacie(id_druh, typ, detail) values(4,'uzel ','tj. křižovatka sledovaná ve vybraných městech');
insert into cr_pozem_komunikacie(id_druh, typ, detail) values(5,'komunikace sledovaná ','(ve vybraných městech)');
insert into cr_pozem_komunikacie(id_druh, typ, detail) values(6,'komunikace místní','');
insert into cr_pozem_komunikacie(id_druh, typ, detail) values(7,'komunikace účelová','polní a lesní cesty atd. ');
insert into cr_pozem_komunikacie(id_druh, typ, detail) values(8,'komunikace účelová','ostatní (parkoviště, odpočívky apod.)');

select * from cr_pozem_komunikacie;
--commit;

create table cr_krizujuca_komunikacia(
    id_druh number primary key,
    typ varchar2(35) not null 
);
/

insert into cr_krizujuca_komunikacia(id_druh, typ) values(1,'silnice 1. třídy');
insert into cr_krizujuca_komunikacia(id_druh, typ) values(2,'silnice 2. třídy');
insert into cr_krizujuca_komunikacia(id_druh, typ) values(3,'silnice 3. třídy');
insert into cr_krizujuca_komunikacia(id_druh, typ) values(6,'místní komunikace');
insert into cr_krizujuca_komunikacia(id_druh, typ) values(7,'účelová komunikace');
insert into cr_krizujuca_komunikacia(id_druh, typ) values(9,'větev mimoúrovňové křižovatky');

select * from cr_krizujuca_komunikacia;
--commit;

create table cr_nehody(
    id_nehoda number not null,
    cas timestamp(2) not null,
    id_kraj number not null, -- fk
    v_obci char(1) not null, -- boolean 'A'*-ano, 'N'-nie, teda mimo obce
    id_druh_nehody number not null, --fk
    id_zraz_voz number not null, --fk
    id_zraz_pev number not null, --fk
    id_zviera number not null, --fk
    id_char_nehod number not null, --fk
    id_zavinenie number not null, --fk
    id_alko_prit number not null, --fk
    id_droga number not null, --fk
    id_pricina number not null, --fk
    mrtvi number not null,         -- pocet
    tazko_zraneni number not null, -- pocet
    lahko_zraneni number not null, -- pocet
    celk_skoda_kc number not null,   -- Kč
    id_povrch_voz number not null, --fk
    id_stav_voz number not null, --fk
    id_stav_kom number not null, --fk
    id_pocasie number not null, --fk
    id_viditelnost number not null, --fk
    id_rozhlad number not null, --fk
    id_del_kom number not null, --fk
    id_obl_kom number not null, --fk miesto nehody
    id_riadenie number not null, --fk riadenie premavky
    id_upr_prednost number not null, --fk miestna uprava prednosti
    id_oblast number not null, --fk
    id_smer_pom number not null, --fk smerove pomery
    poc_vozidiel number not null, -- pocet vozidiel zucastnenych v nehode
    id_miesto number not null, --fk miesto dopravnej nehody
    id_druh_kom number not null, --fk druh pozemnej komunikacie
    cislo_kom number, -- cislo pozem. komunikacie (vyplna sa len pre dialnicu a silnice 1.,2. a 3. triedy
    id_kriz_kom number, --fk druh krizujucej komunikacie
    primary key (id_nehoda),
    foreign key (id_kraj) references cr_kraje(id_kraj),
    foreign key (id_druh_nehody) references cr_druh_nehody(id_druh),
    foreign key (id_zraz_voz) references cr_druh_zrazky_vozidiel(id_druh),
    foreign key (id_zraz_pev) references cr_druh_pevnej_zrazky(id_druh),
    foreign key (id_zviera) references cr_druh_zviera(id_druh),
    foreign key (id_char_nehod) references cr_charakter_nehody(id_charakter),
    foreign key (id_zavinenie) references cr_zavinenie_nehody(id_zavinenie),
    foreign key (id_alko_prit) references cr_pritomnost_alko(id_stav),
    foreign key (id_droga) references cr_vinnik_drogy(id_droga),
    foreign key (id_pricina) references cr_pricina_nehody(id_pricina),
    foreign key (id_povrch_voz) references cr_povrch_vozovky(id_povrch),
    foreign key (id_stav_voz) references cr_stav_vozovky(id_stav),
    foreign key (id_stav_kom) references cr_stav_komunikacie(id_stav),
    foreign key (id_pocasie) references cr_pocasie_podmienky(id_pocasie),
    foreign key (id_viditelnost) references cr_viditelnost(id_viditelnost),
    foreign key (id_rozhlad) references cr_rozhladove_pomery(id_rozhlad),
    foreign key (id_del_kom) references cr_delenie_komunikacie(id_delenie),
    foreign key (id_obl_kom) references cr_v_oblasti_komunikacie(id_miesto),
    foreign key (id_riadenie) references cr_riadenie_premavky(id_riadenie),
    foreign key (id_upr_prednost) references cr_uprava_prednosti(id_uprava),
    foreign key (id_oblast) references cr_oblast(id_oblast),
    foreign key (id_smer_pom) references cr_smerove_pomery(id_pomery),
    foreign key (id_miesto) references cr_miesto_nehody(id_miesto),
    foreign key (id_druh_kom) references cr_pozem_komunikacie(id_druh),
    foreign key (id_kriz_kom) references cr_krizujuca_komunikacia(id_druh)
);
/

--create table t4(id number primary key);
--insert into t4(id) values(5);
--select * from t4;
--
--create table t5(id number,
--id_fk number not null,
--foreign key(id_fk) references t4(id)
--);
--/
--
--insert into t5(id, id_fk) values(1,5);
--insert into t5(id, id_fk) values(1,4);
--select * from t5;
--drop table t4;

select count(cas) from cr_nehody;

select * from user_constraints where constraint_name = 'SYS_C00197712'; -- SYS_C00197583
select * from user_constraints where constraint_name = 'SYS_C00197634';
select * from CR_DRUH_NEHODY where id_druh_nehody=10;
--------------------------------------------------------------------------------------

create table cr_druh_vozidla(
    id_typ number primary key,
    popis varchar2(75) not null
);
/
drop table cr_druh_vozidla;
insert into cr_druh_vozidla values(2,'motocykl (včetně sidecarů, skútrů apod.)');
insert into cr_druh_vozidla values(3,'osobní automobil bez přívěsu');
insert into cr_druh_vozidla values(4,'osobní automobil s přívěsem');
insert into cr_druh_vozidla values(5,'nákladní automobil (včetně multikáry, autojeřábu, cisterny atd.)');
insert into cr_druh_vozidla values(6,'nákladní automobil s přívěsem');
insert into cr_druh_vozidla values(7,'nákladní automobil s návěsem');
insert into cr_druh_vozidla values(8,'autobus');
insert into cr_druh_vozidla values(9,'traktor (i s přívěsem)');
insert into cr_druh_vozidla values(10,'tramvaj  ');
insert into cr_druh_vozidla values(11,'trolejbus');
insert into cr_druh_vozidla values(12,'jiné motorové vozidlo ');
insert into cr_druh_vozidla values(13,'jízdní kolo');
insert into cr_druh_vozidla values(14,'povoz, jízda na koni');
insert into cr_druh_vozidla values(15,'jiné nemotorové vozidlo');
insert into cr_druh_vozidla values(16,'vlak');
insert into cr_druh_vozidla values(17,'nezjištěno, řidič ujel');
insert into cr_druh_vozidla values(18,'jiný druh vozidla');
insert into cr_druh_vozidla values(19,'koloběžka');
--commit;
select * from cr_druh_vozidla;

create table cr_znacka_vozidla(
    id_znacka number primary key,
    nazov varchar2(15) not null
);
/

insert into cr_znacka_vozidla values(1,'ALFA-ROMEO');
insert into cr_znacka_vozidla values(2,'AUDI');
insert into cr_znacka_vozidla values(3,'AVIA');
insert into cr_znacka_vozidla values(4,'BMW');
insert into cr_znacka_vozidla values(5,'CHEVROLET');
insert into cr_znacka_vozidla values(6,'CHRYSLER');
insert into cr_znacka_vozidla values(7,'CITROEN');
insert into cr_znacka_vozidla values(8,'DACIA');
insert into cr_znacka_vozidla values(9,'DAEWOO');
insert into cr_znacka_vozidla values(10,'DAF');
insert into cr_znacka_vozidla values(11,'DODGE');
insert into cr_znacka_vozidla values(12,'FIAT ');
insert into cr_znacka_vozidla values(13,'FORD');
insert into cr_znacka_vozidla values(14,'GAZ, VOLHA');
insert into cr_znacka_vozidla values(15,'FERRARI');
insert into cr_znacka_vozidla values(16,'HONDA');
insert into cr_znacka_vozidla values(17,'HYUNDAI');
insert into cr_znacka_vozidla values(18,'IFA');
insert into cr_znacka_vozidla values(19,'IVECO');
insert into cr_znacka_vozidla values(20,'JAGUAR');
insert into cr_znacka_vozidla values(21,'JEEP');
insert into cr_znacka_vozidla values(22,'LANCIA');
insert into cr_znacka_vozidla values(23,'LAND ROVER');
insert into cr_znacka_vozidla values(24,'LIAZ');
insert into cr_znacka_vozidla values(25,'MAZDA');
insert into cr_znacka_vozidla values(26,'MERCEDES');
insert into cr_znacka_vozidla values(27,'MITSUBISHI');
insert into cr_znacka_vozidla values(28,'MOSKVIČ');
insert into cr_znacka_vozidla values(29,'NISSAN');
insert into cr_znacka_vozidla values(30,'OLTCIT');
insert into cr_znacka_vozidla values(31,'OPEL');
insert into cr_znacka_vozidla values(32,'PEUGEOT');
insert into cr_znacka_vozidla values(33,'PORSCHE');
insert into cr_znacka_vozidla values(34,'PRAGA');
insert into cr_znacka_vozidla values(35,'RENAULT');
insert into cr_znacka_vozidla values(36,'ROVER');
insert into cr_znacka_vozidla values(37,'SAAB');
insert into cr_znacka_vozidla values(38,'SEAT');
insert into cr_znacka_vozidla values(39,'ŠKODA');
insert into cr_znacka_vozidla values(40,'SCANIA');
insert into cr_znacka_vozidla values(41,'SUBARU');
insert into cr_znacka_vozidla values(42,'SUZUKI');
insert into cr_znacka_vozidla values(43,'TATRA');
insert into cr_znacka_vozidla values(44,'TOYOTA');
insert into cr_znacka_vozidla values(45,'TRABANT');
insert into cr_znacka_vozidla values(46,'VAZ');
insert into cr_znacka_vozidla values(47,'VOLKSWAGEN');
insert into cr_znacka_vozidla values(48,'VOLVO');
insert into cr_znacka_vozidla values(49,'WARTBURG');
insert into cr_znacka_vozidla values(50,'ZASTAVA');
insert into cr_znacka_vozidla values(51,'AGM');
insert into cr_znacka_vozidla values(52,'ARO');
insert into cr_znacka_vozidla values(53,'AUSTIN');
insert into cr_znacka_vozidla values(54,'BARKAS');
insert into cr_znacka_vozidla values(55,'DAIHATSU');
insert into cr_znacka_vozidla values(56,'DATSUN');
insert into cr_znacka_vozidla values(57,'DESTACAR');
insert into cr_znacka_vozidla values(58,'ISUZU');
insert into cr_znacka_vozidla values(59,'KAROSA');
insert into cr_znacka_vozidla values(60,'KIA');
insert into cr_znacka_vozidla values(61,'LUBLIN');
insert into cr_znacka_vozidla values(62,'MAN');
insert into cr_znacka_vozidla values(63,'MASERATI');
insert into cr_znacka_vozidla values(64,'MULTICAR');
insert into cr_znacka_vozidla values(65,'PONTIAC');
insert into cr_znacka_vozidla values(66,'ROSS');
insert into cr_znacka_vozidla values(67,'SIMCA');
insert into cr_znacka_vozidla values(68,'SSANGYONG');
insert into cr_znacka_vozidla values(69,'TALBOT');
insert into cr_znacka_vozidla values(70,'TAZ');
insert into cr_znacka_vozidla values(71,'ZAZ');
insert into cr_znacka_vozidla values(3,'AVIA');
insert into cr_znacka_vozidla values(10,'DAF');
insert into cr_znacka_vozidla values(12,'FIAT ');
insert into cr_znacka_vozidla values(13,'FORD');
insert into cr_znacka_vozidla values(19,'IVECO');
insert into cr_znacka_vozidla values(26,'MERCEDES');
insert into cr_znacka_vozidla values(35,'RENAULT');
insert into cr_znacka_vozidla values(39,'ŠKODA');
insert into cr_znacka_vozidla values(40,'SCANIA');
insert into cr_znacka_vozidla values(48,'VOLVO');
insert into cr_znacka_vozidla values(59,'KAROSA');
insert into cr_znacka_vozidla values(62,'MAN');
insert into cr_znacka_vozidla values(72,'BOVA');
insert into cr_znacka_vozidla values(73,'IKARUS');
insert into cr_znacka_vozidla values(74,'NEOPLAN');
insert into cr_znacka_vozidla values(75,'OASA');
insert into cr_znacka_vozidla values(76,'RAF');
insert into cr_znacka_vozidla values(77,'SETRA');
insert into cr_znacka_vozidla values(78,'SOR');
insert into cr_znacka_vozidla values(4,'BMW');
insert into cr_znacka_vozidla values(16,'HONDA');
insert into cr_znacka_vozidla values(32,'PEUGEOT');
insert into cr_znacka_vozidla values(42,'SUZUKI');
insert into cr_znacka_vozidla values(79,'APRILIA');
insert into cr_znacka_vozidla values(80,'CAGIVA');
insert into cr_znacka_vozidla values(81,'ČZ');
insert into cr_znacka_vozidla values(82,'DERBI');
insert into cr_znacka_vozidla values(83,'DUCATI');
insert into cr_znacka_vozidla values(84,'GILERA');
insert into cr_znacka_vozidla values(85,'HARLEY');
insert into cr_znacka_vozidla values(86,'HERO');
insert into cr_znacka_vozidla values(87,'HUSQVARNA');
insert into cr_znacka_vozidla values(88,'JAWA');
insert into cr_znacka_vozidla values(89,'KAWASAKI');
insert into cr_znacka_vozidla values(90,'KTM');
insert into cr_znacka_vozidla values(91,'MALAGUTI');
insert into cr_znacka_vozidla values(92,'MANET');
insert into cr_znacka_vozidla values(93,'MZ');
insert into cr_znacka_vozidla values(94,'PIAGGIO');
insert into cr_znacka_vozidla values(95,'SIMSON');
insert into cr_znacka_vozidla values(96,'VELOREX');
insert into cr_znacka_vozidla values(97,'YAMAHA');
alter table cr_znacka_vozidla modify nazov varchar2(25);
insert into cr_znacka_vozidla values(98,'jiné vyrobené v ČR');
insert into cr_znacka_vozidla values(99,'jiné vyrobené mimo ČR');
insert into cr_znacka_vozidla values(0,'žádná z uvedených ');

--commit;
select * from cr_znacka_vozidla;

create table cr_druh_pohonu(
    id_druh number primary key,
    popis varchar2(22) not null
);
/

insert into cr_druh_pohonu values(1,'diesel');
insert into cr_druh_pohonu values(2,'benzín');
insert into cr_druh_pohonu values(3,'LPG');
insert into cr_druh_pohonu values(4,'CNG');
insert into cr_druh_pohonu values(5,'elektro');
insert into cr_druh_pohonu values(6,'hybridní');
insert into cr_druh_pohonu values(7,'vodík');
insert into cr_druh_pohonu values(0,'nezjištěno/žádné');
--commit;
select * from cr_druh_pohonu;

create table cr_voz_vyuzitie(
    id_typ number primary key,
    vyuzitie varchar2(50) not null
);
/

insert into cr_voz_vyuzitie values(1,'soukromé');
insert into cr_voz_vyuzitie values(2,'soukromé');
insert into cr_voz_vyuzitie values(3,'soukromá organizace');
insert into cr_voz_vyuzitie values(4,'veřejná hromadná doprava');
insert into cr_voz_vyuzitie values(5,'městská hromadná doprava');
insert into cr_voz_vyuzitie values(6,'mezinárodní kamionová doprava');
insert into cr_voz_vyuzitie values(7,'TAXI');
insert into cr_voz_vyuzitie values(8,'státní podnik, státní organizace');
insert into cr_voz_vyuzitie values(9,'registrované mimo území ČR');
insert into cr_voz_vyuzitie values(10,'zastupitelský úřad');
insert into cr_voz_vyuzitie values(11,'ministerstvo vnitra');
insert into cr_voz_vyuzitie values(12,'policie ČR');
insert into cr_voz_vyuzitie values(13,'městská, obecní policie');
insert into cr_voz_vyuzitie values(14,'soukromé bezpečnostní agentury');
insert into cr_voz_vyuzitie values(15,'ministerstvo obrany');
insert into cr_voz_vyuzitie values(16,'jiné');
insert into cr_voz_vyuzitie values(17,'odcizené');
insert into cr_voz_vyuzitie values(18,'vozidlo AUTOŠKOLY provádějící výcvik');
insert into cr_voz_vyuzitie values(19,'hasiči');
insert into cr_voz_vyuzitie values(20,'sanita RZS');
insert into cr_voz_vyuzitie values(21,'sanita ostatní (ne RZS)');
insert into cr_voz_vyuzitie values(0,'nezjištěno');
--commit;
select * from cr_voz_vyuzitie;

create table cr_voz_po_nehode(
    id_stav number primary key,
    detail varchar2(25) not null
);
/

insert into cr_voz_po_nehode values(1,'nedošlo k požáru');
insert into cr_voz_po_nehode values(2,'došlo k požáru');
insert into cr_voz_po_nehode values(3,'řidič ujel');
insert into cr_voz_po_nehode values(4,'řidič ujel (utekl)');
insert into cr_voz_po_nehode values(0,'žádná z uvedených');
--commit;
select * from cr_voz_po_nehode;

create table cr_vodic_kategoria(
    id_kategoria number primary key,
    kategoria varchar2(50) not null,
    detail varchar2(50)
);
/

insert into cr_vodic_kategoria values(1,'s řidičským oprávněním skupiny','A');
insert into cr_vodic_kategoria values(2,'s řidičským oprávněním skupiny','B');
insert into cr_vodic_kategoria values(3,'s řidičským oprávněním skupiny','C ');
insert into cr_vodic_kategoria values(4,'s řidičským oprávněním skupiny','D');
insert into cr_vodic_kategoria values(5,'s řidičským oprávněním skupiny','T');
insert into cr_vodic_kategoria values(6,'s řidičským oprávněním skupiny','A a s omezením do 50 ccm');
insert into cr_vodic_kategoria values(7,'bez příslušného řidičského oprávnění','');
insert into cr_vodic_kategoria values(8,'ostatní řidiči vozidel','(např. cyklisté, vozkové, strojvedoucí atd.)');
insert into cr_vodic_kategoria values(9,'nezjištěno, řidič místo nehody opustil','(u p44 je kód 17, nebo u p50a je kód 4)');
insert into cr_vodic_kategoria values(0,'nezjištěno ','(např. u cizinců)');
--commit;
select * from cr_vodic_kategoria;

create table cr_vodic_stav(
    id_stav number primary key,
    stav varchar2(40) not null,
    detail varchar2(50)
);
/

insert into cr_vodic_stav values(1,'dobrý','žádné nepříznivé okolnosti nebyly zjištěny');
insert into cr_vodic_stav values(21,'unaven, usnul, ','');
insert into cr_vodic_stav values(22,'náhlá fyzická indispozice','');
insert into cr_vodic_stav values(3,'pod vlivem','léků, narkotik');
insert into cr_vodic_stav values(4,'pod vlivem','alkoholu, obsah alkoholu v krvi do 0,99 ‰');
insert into cr_vodic_stav values(5,'pod vlivem','alkoholu, obsah alkoholu v krvi 1 ‰ a více');
insert into cr_vodic_stav values(6,'nemoc, úraz apod. ','');
insert into cr_vodic_stav values(7,'invalida','');
alter table cr_vodic_stav modify stav varchar2(45);
insert into cr_vodic_stav values(8,'řidič při jízdě zemřel (infarkt apod.)','');
insert into cr_vodic_stav values(9,'pokus o sebevraždu, sebevražda','');
insert into cr_vodic_stav values(0,'jiný nepříznivý stav','');
--commit;
select * from cr_vodic_stav;

create table cr_ovplyvnenie(
    id_typ number primary key,
    typ varchar2(70) not null
);
/
alter table cr_ovplyvnenie modify typ varchar2(75);
insert into cr_ovplyvnenie values(1,'řidič nebyl ovlivněn');
insert into cr_ovplyvnenie values(2,'oslněn sluncem');
insert into cr_ovplyvnenie values(3,'oslněn světlomety jiného vozidla');
insert into cr_ovplyvnenie values(4,'ovlivněn jednáním jiného účastníka silničního provozu');
insert into cr_ovplyvnenie values(5,'ovlivněn při vyhýbání lesní zvěří, domácímu zvířectvu apod. ');
insert into cr_ovplyvnenie values(0,'jiné ovlivnění');
--commit;
select * from cr_ovplyvnenie;

create table cr_vozidla(
    id_nehoda number not null,
    id_vozidlo number not null,
    id_druh_vozidla number not null,
    id_znacka number not null,
    id_pohon number not null,
    druh_pneu char(1), --'L'-letne, 'Z'-zimne, 'C'-celorocne, null
    rok_vyroby number, -- uvadza sa iba posledne dvojcislie
    id_vyuzitie number,
    smyk char(1), -- 'A'-ano, 'N'-nie, null
    id_voz_po_nehode number,
    voz_skoda_kc number not null, -- sposobena skoda na vozidle
    id_kateg_vodic number,
    id_vodic_stav number,
    id_ovplyvnenie number,
    constraint "CR_VOZIDLA_PK" primary key(id_nehoda, id_vozidlo),
    foreign key (id_nehoda) references cr_nehody(id_nehoda),
    foreign key (id_druh_vozidla) references cr_druh_vozidla(id_typ),
    foreign key (id_znacka) references cr_znacka_vozidla(id_znacka),
    foreign key (id_pohon) references cr_druh_pohonu(id_druh),
    foreign key (id_vyuzitie) references cr_voz_vyuzitie(id_typ),
    foreign key (id_voz_po_nehode) references cr_voz_po_nehode(id_stav),
    foreign key (id_kateg_vodic) references cr_vodic_kategoria(id_kategoria),
    foreign key (id_vodic_stav) references cr_vodic_stav(id_stav),
    foreign key (id_ovplyvnenie) references cr_ovplyvnenie(id_typ)
);
/
--commit;
select count(*) from cr_vozidla;
--druh_pneu char(1), --'L'-letne, 'Z'-zimne, 'C'-celorocne, null
--smyk char(1), -- 'A'-ano, 'N'-nie, null
--insert into cr_vozidla(id_nehoda,id_vozidlo,id_druh_vozidla,id_znacka,id_pohon,druh_pneu,rok_vyroby,id_vyuzitie,smyk,id_voz_po_nehode,voz_skoda_kc,id_kateg_vodic,id_vodic_stav,id_ovplyvnenie) values(

select count(*) from cr_vozidla;