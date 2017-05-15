create table KAIHATSUTAISEI (
    GK_ID int not null,
    EMP_NO varchar(10) not null,
    GAITYU_FLAG int not null,
    constraint KAIHATSUTAISEI_PK primary key(GK_ID, EMP_NO)
);
