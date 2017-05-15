alter table GENKA_KANRI add constraint GENKA_KANRI_FK1 foreign key (creater) references EMP_MASTER (emp_no);
alter table GENKA_KANRI add constraint GENKA_KANRI_FK2 foreign key (pj_admin) references EMP_MASTER (emp_no);
alter table GENKA_KANRI add constraint GENKA_KANRI_FK3 foreign key (pj_leader) references EMP_MASTER (emp_no);
