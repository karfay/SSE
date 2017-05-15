alter table ANKEN_RIREKI add constraint ANKEN_RIREKI_FK1 foreign key (eigyo) references EMP_MASTER (emp_no);
alter table ANKEN_RIREKI add constraint ANKEN_RIREKI_FK2 foreign key (INSERT_EMP_NO) references EMP_MASTER (EMP_NO);
alter table ANKEN_RIREKI add constraint ANKEN_RIREKI_FK3 foreign key (kaihatsu_group_head) references EMP_MASTER (emp_no);
alter table ANKEN_RIREKI add constraint ANKEN_RIREKI_FK4 foreign key (anken_id) references ANKEN (anken_id);
