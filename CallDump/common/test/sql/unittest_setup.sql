

insert into roles values ('managers','Development Managers capable of approving requests for builds');
insert into roles values ('developers','Software Developers capable of submitting requests for build');
insert into roles values ('admin','System Adminisrators');
insert into roles values ('calldumpadmin','CallDump System Admin');
insert into roles values ('dsbmsadmin','DataServices Build Management System Admin');
insert into roles values ('superuser','Super User for all applications');
insert into roles values ('submitter','Call Dump Submitter');
insert into roles values ('view','Read Only');
insert into roles values ('sqa','approver of builds');

insert into applications values ('calldump');
insert into applications values ('dsbms');

insert into users values ('md1csta1', 'Craig', 'Stalsberg','cares123',SYSDATE, 'craig.stalsberg@uscellular.com',1,0);
insert into users values ('md1dbal1','David','Balchen','cares123',SYSDATE,'david.balchen@uscellular.com',1,0);
insert into users values ('md1mobr1','Marsue','Obremski','cares123',SYSDATE,'marsue.obremski@uscellular.com',1,0);
insert into users values ('md1rtom1','Randy','Tomas','cares123',SYSDATE,'randy.tomas@uscellular.com',1,0);
insert into users values ('root','Super','User','cares123',SYSDATE,'craig.stalsberg@uscellular.com',1,0);

insert into user_roles values ('md1csta1','developers');
insert into user_roles values ('md1dbal1','developers');
insert into user_roles values ('md1rtom1','developers');
insert into user_roles values ('md1mobr1','managers');
insert into user_roles values ('md1csta1','submitter');

insert into application_roles values('calldump','calldumpadmin');
insert into application_roles values('calldump','superuser');
insert into application_roles values('calldump','submitter');
insert into application_roles values('calldump','view');
insert into application_roles values('dsbms','dsbmsadmin');
insert into application_roles values('dsbms','superuser');
insert into application_roles values('dsbms','managers');
insert into application_roles values('dsbms','developers');
insert into application_roles values('dsbms','sqa');
insert into application_roles values('dsbms','view');


insert into request_files values ('PR030910105400BR','/source/sys/fm_act_pol/fm_act_pol_spec_event_cache.c');
insert into request_files values ('PR030910105400BR','/source/sys/fm_inv_pol/fm_inv_pol_prep_invoice.c');
insert into request_files values ('PR030910105400BR','/source/sys/fm_inv_pol/uscc_inv_consts.h');
insert into request_files values ('PR030910105400BR','/source/sys/fm_inv_pol/uscc_inv_pol_prep.h');
insert into request_files values ('PR030910105400BR','/source/sys/fm_inv_pol/uscc_inv_prep_list.c');
insert into request_files values ('PR030910105400BR','/source/sys/fm_inv_pol/uscc_inv_prep_utils.c');
insert into request_files values ('PR030910105400BR','/source/sys/fm_inv_pol/uscc_op_data_invoice_extract.c');


insert into releases values ('290', 0, to_date('20-DEC-2004','DD-MON-YYYY'),'DS_V2.9.0.0BR','ds_v2.9.0.0build',48736,'280',75,0,'','');
insert into releases values ('280', 0, to_date('20-DEC-2004','DD-MON-YYYY'),'DS_V2.8.0.0BR','ds_v2.8.0.0build',48736,'271',10,0,'','');
insert into releases values ('271', 1, to_date('10-JUL-2004','DD-MON-YYYY'),'DS_V2.7.1.0BR','ds_v2.7.1.0build',48736,'270',0,0,'','');
insert into releases values ('270', 1, to_date('10-JUL-2004','DD-MON-YYYY'),'DS_V2.7.0.0BR','ds_v2.7.0.0build',48736,'261',0,0,'','');
insert into releases values ('261', 1, to_date('10-JUL-2004','DD-MON-YYYY'),'DS_V2.6.1.0BR','ds_v2.6.1.0build',48736,'260',0,0,'','');
insert into releases values ('260', 1, to_date('10-JUL-2004','DD-MON-YYYY'),'DS_V2.6.0.0BR','ds_v2.6.0.0build',48736,'xxx',0,0,'','');

insert into requests (request_date, request, requestor, description) values (to_date('12/10/04','MM/DD/YY'), 'PR041209132800BR','md1csta1','This PR contains the pricing set up for unlimited easyedge services.');
insert into requests (request_date, request, requestor, description) values (to_date('12/09/04','MM/DD/YY'), 'PR040831170147BR','md1csta1','Fix to resume billing when a data soc is added.');
insert into requests (request_date, request, requestor, description) values (to_date('12/20/04','MM/DD/YY'), 'PR041220093500BR','md1csta1','This PR contains new production pricing for Associate, Agents and Demo lines.  The new mappings will offer 20 MB  or Unlimited easyedge usage for a recurring charge.');
insert into requests (request_date, request, requestor, description) values (to_date('12/22/04','MM/DD/YY'), 'PR041216150002BR','md1csta1','he deploy_int.sh script was updated to reflect the new user IDs');
insert into requests (request_date, request, requestor, description) values (to_date('12/22/04','MM/DD/YY'), 'PR041222103307BR'
,'md1csta1','Infranet Adjustment Performance Fix for BLINPROD (Billing Invoicing).  This uses an existing index on uscc_charge_detail to increase performance when adjustments to unbilled usage is made.  Remedy 961640, 962178.');

insert into requests (request_date, request, related_request, requestor, description) values (to_date('01/14/2005','MM/DD/YYYY'),'PR050113105848BR','PR050113105848BR
','md1csta1','Changed the code to no longer append an "S" to the beginning of the Infranet-bound AAA_ERROR filename that resides on the CARES side and also contains an
 entry on the ac_processing_accounting table.');

insert into build_contents values ('280',85, 'PR050113105848BR');
insert into build_contents values ('290',1, 'PR040831170147BR');
insert into build_contents values ('290',2, 'PR041209132800BR');
insert into build_contents values ('290',3, 'PR041220093500BR');
insert into build_contents values ('290',4, 'PR041216150002BR');
insert into build_contents values ('290',4, 'PR041222103307BR');
insert into builds values (280,85,0,to_date('12/01/2004','MM/DD/YYYY'));
insert into builds values (290,4,0,to_date('12/22/2004','MM/DD/YYYY'));
insert into builds values (290,3,0,to_date('12/20/2004','MM/DD/YYYY'));
insert into builds values (290,2,0,to_date('12/10/2004','MM/DD/YYYY'));
insert into builds values (290,1,0,to_date('12/09/2004','MM/DD/YYYY'));
