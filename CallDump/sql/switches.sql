
drop synonym roles;
drop synonym users;
drop synonym user_notifications;
drop synonym user_password_history;
drop synonym user_roles;
drop table call_dump_reports;
drop table call_dump_queue;
drop table switches;
drop database link dsbms;

create database link dsbms connect to dsbms identified by red4netprod using 'USCC';

create synonym roles for roles@dsbms;
create synonym users for users@dsbms;
create synonym user_notifications for user_notifications@dsbms;
create synonym user_password_history for user_password_history@dsbms;
create synonym user_roles for user_roles@dsbms;

create table switches (
   market varchar2(5),
   name varchar2(50),
   identifier varchar2(10),
   effective_date date,
   expiration_date date,
   type char(1),
   manufacturer varchar2(30)
);
create table call_dump_queue (
   id number(10) not null,
   priority number(10) not null,
   status varchar2(2) not null,
   userid varchar2(20) not null,
   submit_date date not null,
   start_date date not null,
   end_date date not null,
   switches_m01 varchar2(100),
   switches_m02 varchar2(100),
   switches_m03 varchar2(100),
   switches_m04 varchar2(100),
   switches_m05 varchar2(100),
   switches_m06 varchar2(100),
   search_string_1 varchar2(15),
   search_string_2 varchar2(15),
   search_string_3 varchar2(15),
   search_string_4 varchar2(15),
   search_string_5 varchar2(15),
   search_string_6 varchar2(15),
   search_string_type_1 varchar2(100),
   search_string_type_2 varchar2(100),
   search_string_type_3 varchar2(100),
   search_string_type_4 varchar2(100),
   search_string_type_5 varchar2(100),
   search_string_type_6 varchar2(100),
   pid number(6),
   constraint idpk primary key (id)
);

create table call_dump_reports (
   id number(10) not null,
   hostname varchar2(30),
   file_name varchar2(200),
   constraint idfk foreign key (id) references call_dump_queue (id) on delete cascade
);


insert into switches values ('M01','all voice','M01ALLV',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M01','all data','M01ALLD',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M01','Asheville','ASHE',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M01','Clinton','CLIN',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M01','Clarkesville','CLRK',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M01','Greenville','GREE',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M01','Knoxsville','KNOX',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M01','Lynchburg','LLYN',sysdate-1000,null,'V','LUCENT');
insert into switches values ('M01','Mabscott','LMAB',sysdate-1000,null,'V','LUCENT');
insert into switches values ('M01','Roanoke','LROE',sysdate-1000,null,'V','LUCENT');
insert into switches values ('M01','Morgantown','MORG',sysdate-1000,null,'V','LUCENT');
insert into switches values ('M01','Brew','BREW',sysdate-1000,null,'D','NORTEL');
insert into switches values ('M01','EasyEdge','AAA',sysdate-1000,null,'D','NORTEL');
insert into switches values ('M01','Mobile Messaging','MMS',sysdate-1000,null,'D','NORTEL');
insert into switches values ('M01','SMS','SMS',sysdate-1000,null,'D','NORTEL');

insert into switches values ('M02','all voice','M02ALLV',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M02','all data','M02ALLD',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M02','Appleton','APPL',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M02','Brookfield','BROO',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M02','Madison','MADI',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M02','New Berlin','NEWB',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M02','Rockford','ROC2',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M02','Brew','BREW',sysdate-1000,null,'D','NORTEL');
insert into switches values ('M02','EasyEdge','AAA',sysdate-1000,null,'D','NORTEL');
insert into switches values ('M02','Mobile Messaging','MMS',sysdate-1000,null,'D','NORTEL');
insert into switches values ('M02','SMS','SMS',sysdate-1000,null,'D','NORTEL');

insert into switches values ('M03','all voice','M03ALLV',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M03','all data','M03ALLD',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M03','Cedar Rapids','CDR2',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M03','Columbia','COLU',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M03','Cong','CONG',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M03','Granite Hills','GRAN',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M03','Grand Island','GRIS',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M03','Mansfield','MANS',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M03','Mixmaster','MIXM',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M03','Omaha','OMAH',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M03','Peoria','PEO2',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M03','St Louis','STLO',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M03','Brew','BREW',sysdate-1000,null,'D','NORTEL');
insert into switches values ('M03','EasyEdge','AAA',sysdate-1000,null,'D','NORTEL');
insert into switches values ('M03','Mobile Messaging','MMS',sysdate-1000,null,'D','NORTEL');
insert into switches values ('M03','SMS','SMS',sysdate-1000,null,'D','NORTEL');

insert into switches values ('M04','all voice','M04ALLV',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M04','all data','M04ALLD',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M04','Atoka','ATO2',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M04','Joplin','JOPL',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M04','Oklahoma City','OKLA',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M04','Owaso','OWAS',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M04','Salina','SALI',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M04','Tulsa','TULS',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M04','Witchita Falls','WIC2',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M04','Brew','BREW',sysdate-1000,null,'D','NORTEL');
insert into switches values ('M04','EasyEdge','AAA',sysdate-1000,null,'D','NORTEL');
insert into switches values ('M04','Mobile Messaging','MMS',sysdate-1000,null,'D','NORTEL');
insert into switches values ('M04','SMS','SMS',sysdate-1000,null,'D','NORTEL');

insert into switches values ('M05','all voice','M05ALLV',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M05','all data','M05ALLD',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M05','Bend','BEND',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M05','Eureka','EURE',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M05','Longview','LONG',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M05','Medford','MEDF',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M05','Yakima','YAKI',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M05','Brew','BREW',sysdate-1000,null,'D','NORTEL');
insert into switches values ('M05','EasyEdge','AAA',sysdate-1000,null,'D','NORTEL');
insert into switches values ('M05','Mobile Messaging','MMS',sysdate-1000,null,'D','NORTEL');
insert into switches values ('M05','SMS','SMS',sysdate-1000,null,'D','NORTEL');

insert into switches values ('M06','all voice','M06ALLV',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M06','all data','M06ALLD',sysdate-1000,null,'V','NORTEL');
insert into switches values ('M06','Lombard 2','LOM2',sysdate-1000,null,'V','LUCENT');
insert into switches values ('M06','Lombard 3','LOM3',sysdate-1000,null,'V','LUCENT');
insert into switches values ('M06','Schaumburg','SCHA',sysdate-1000,null,'V','LUCENT');
insert into switches values ('M06','Schaumburg 2','SCH2',sysdate-1000,null,'V','LUCENT');
insert into switches values ('M06','Brew','BREW',sysdate-1000,null,'D','NORTEL');
insert into switches values ('M06','EasyEdge','AAA',sysdate-1000,null,'D','NORTEL');
insert into switches values ('M06','Mobile Messaging','MMS',sysdate-1000,null,'D','NORTEL');
insert into switches values ('M06','SMS','SMS',sysdate-1000,null,'D','NORTEL');

drop sequence calldump;
create sequence calldump start with 1000 increment by 1;

