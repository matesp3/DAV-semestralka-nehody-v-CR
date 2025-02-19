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
insert into cr_druh_nehody(id_druh, popis) values (10,'iný druh nehody');

select * from cr_druh_nehody;
--commit;

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

create table cr_typ_cestnej_komunikacie(
    id_typ number primary key,
    typ_kom varchar2(35) not null
);
/

insert into cr_typ_cestnej_komunikacie(id_typ, typ_kom) values(1,'dvoupruhová');
insert into cr_typ_cestnej_komunikacie(id_typ, typ_kom) values(2,'třípruhová');
insert into cr_typ_cestnej_komunikacie(id_typ, typ_kom) values(3,'čtyřpruhová s dělícím pásem');
insert into cr_typ_cestnej_komunikacie(id_typ, typ_kom) values(4,'čtyřpruhová s dělící čarou');
insert into cr_typ_cestnej_komunikacie(id_typ, typ_kom) values(5,'vícepruhová');
insert into cr_typ_cestnej_komunikacie(id_typ, typ_kom) values(6,'rychlostní komunikace');
insert into cr_typ_cestnej_komunikacie(id_typ, typ_kom) values(0,'žádná z uvedených');

select * from cr_typ_cestnej_komunikacie;
--commit;

create table cr_miesto_nehody(
    id_miesto number primary key,
    kde varchar2(40) not null
);
/

insert into cr_miesto_nehody(id_miesto, kde) values(1,'na jízdním pruhu');
insert into cr_miesto_nehody(id_miesto, kde) values(2,'na odstavném pruhu');
insert into cr_miesto_nehody(id_miesto, kde) values(3,'na krajnici');
insert into cr_miesto_nehody(id_miesto, kde) values(4,'na odbočovacím, připojovacím pruhu');
insert into cr_miesto_nehody(id_miesto, kde) values(5,'na pruhu pro pomalá vozidla');
insert into cr_miesto_nehody(id_miesto, kde) values(6,'na chodníku nebo ostrůvku');
insert into cr_miesto_nehody(id_miesto, kde) values(7,'na kolejích tramvaje');
insert into cr_miesto_nehody(id_miesto, kde) values(8,'mimo komunikaci');
insert into cr_miesto_nehody(id_miesto, kde) values(9,'na stezce pro cyklisty');
insert into cr_miesto_nehody(id_miesto, kde) values(0,'žádné z uvedených');

select * from cr_miesto_nehody;
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

create table cr_nehody( --posledna todo
    id_nehoda number not null,
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
    celk_skoda number not null,   -- Kč
    id_povrch_voz number not null, --fk
    id_stav_voz number not null, --fk
    id_stav_kom number not null, --fk
    id_pocasie number not null, --fk
    id_viditelnost number not null, --fk
    id_rozhlad number not null, --fk
    id_typ_kom number not null, --fk
    id_miesto number not null, --fk miesto nehody
    id_riadenie number not null, --fk riadenie premavky
    id_upr_prednost number not null, --fk miestna uprava prednosti
    id_miesto number not null, --fk
    id_smer_pom number not null, --fk smerove pomery
    poc_vozidiel number not null, -- pocet vozidiel zucastnenych v nehode
    primary key (id_nehoda),
    foreign key (id_kraja) references cr_kraje(id_kraj),
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
    foreign key (id_typ_kom) references cr_typ_cestnej_komunikacie(id_typ),
    foreign key (id_miesto) references cr_miesto_nehody(id_miesto),
    foreign key (id_riadenie) references cr_riadenie_premavky(id_riadenie),
    foreign key (id_upr_prednost) references cr_uprava_prednosti(id_uprava),
    foreign key (id_miesto) references cr_oblast(id_oblast),
    foreign key (id_smer_pom) references cr_smerove_pomery(id_pomery),
);
/
