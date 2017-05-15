alter table THEME_MASTER add constraint THEME_MASTER_FK1 foreign key (theme_group) references GENKA_KANRI (theme_group);
