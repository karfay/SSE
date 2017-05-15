create table EMP_AUTH_RELATION (
    EMP_NO varchar(10) not null,
    AUTH_ID int not null,
    SYS_ID varchar(10) not null,
    constraint EMP_AUTH_RELATION_PK primary key(EMP_NO, AUTH_ID, SYS_ID)
);
