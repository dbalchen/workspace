set echo on

drop database link CALLDUMPPROD;
drop database link DSBMSPROD;
create database link CALLDUMPPROD connect to calldump identified by calldump using 'USCC';
create database link DSBMSPROD connect to dsbms identified by red4netprod using 'USCC';

-- calldump
drop table CALL_DUMP_REPORTS;
drop table CALL_DUMP_QUEUE;
drop table SWITCHES;

create table CALL_DUMP_QUEUE as (select * from CALL_DUMP_QUEUE@CALLDUMPPROD);
create table CALL_DUMP_REPORTS as (select * from CALL_DUMP_REPORTS@CALLDUMPPROD);
create table SWITCHES as (select * from SWITCHES@CALLDUMPPROD);

-- build management system
drop table APPROVED_REQUESTS;
drop table APPLICATION_ROLES;
drop table APPLICATIONS;
drop table BASELINE;
drop table BUILDS;
drop table BUILD_CONTENTS;
drop table DEVELOPER_APPROVER;
drop table GROUPS;
drop table GROUP_ASSIGNMENTS;
drop table MERGE_EQUIVALENT;
drop table REBASE_CANDIDATES;
drop table REBASE_DETAILS;
drop table REBASE_REQUESTS;
drop table RELEASES;
drop table RELEASE_DETAILS;
drop table RELEASE_PARAMS;
drop table REQUESTS;
drop table REQUEST_FILES;
drop table ROLES;
drop table SYSTEM_CHANGES;
drop table USERS;
drop table USER_NOTIFICATIONS;
drop table USER_PASSWORD_HISTORY;
drop table USER_ROLES;

create table APPROVED_REQUESTS as (select * from APPROVED_REQUESTS@DSBMSPROD);
create table APPLICATIONS as (select * from APPLICATIONS@DSBMSPROD);
create table APPLICATION_ROLES as (select * from APPLICATION_ROLES@DSBMSPROD);
create table BASELINE as (select * from BASELINE@DSBMSPROD);
create table BUILDS as (select * from BUILDS@DSBMSPROD);
create table BUILD_CONTENTS as (select * from BUILD_CONTENTS@DSBMSPROD);
create table DEVELOPER_APPROVER as (select * from DEVELOPER_APPROVER@DSBMSPROD);
create table GROUPS as (select * from GROUPS@DSBMSPROD);
create table GROUP_ASSIGNMENTS as (select * from GROUP_ASSIGNMENTS@DSBMSPROD);
create table MERGE_EQUIVALENT as (select * from MERGE_EQUIVALENT@DSBMSPROD);
create table REBASE_CANDIDATES as (select * from REBASE_CANDIDATES@DSBMSPROD);
create table REBASE_DETAILS as (select * from REBASE_DETAILS@DSBMSPROD);
create table REBASE_REQUESTS as (select * from REBASE_REQUESTS@DSBMSPROD);
create table RELEASES as (select * from RELEASES@DSBMSPROD);
create table RELEASE_DETAILS as (select * from RELEASE_DETAILS@DSBMSPROD);
create table RELEASE_PARAMS as (select * from RELEASE_PARAMS@DSBMSPROD);
create table REQUESTS as (select * from REQUESTS@DSBMSPROD);
create table REQUEST_FILES as (select * from REQUEST_FILES@DSBMSPROD);
create table ROLES as (select * from ROLES@DSBMSPROD);
create table SYSTEM_CHANGES as (select * from SYSTEM_CHANGES@DSBMSPROD);
create table USERS as (select * from USERS@DSBMSPROD);
create table USER_NOTIFICATIONS as (select * from USER_NOTIFICATIONS@DSBMSPROD);
create table USER_PASSWORD_HISTORY as (select * from USER_PASSWORD_HISTORY@DSBMSPROD);
create table USER_ROLES as (select * from user_roles@DSBMSPROD);

exit;


