alter table GAITYU_MONTHLY_COST add constraint GAITYU_MONTHLY_COST_FK1 foreign key (theme_no) references THEME_MASTER (theme_no);
alter table GAITYU_MONTHLY_COST add constraint GAITYU_MONTHLY_COST_FK2 foreign key (emp_no) references EMP_MASTER (emp_no);
