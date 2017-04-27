alter table MONTHLY_GENKA add constraint MONTHLY_GENKA_FK1 foreign key (theme_group) references GENKA_KANRI (theme_group);
