create table EMP_MASTER (
    EMP_NO varchar(10) not null,
    EMP_NAME varchar(20) not null,
    LOGIN_ID varchar(10),
    PASSWORD varchar(10),
    AUTHORIZATION varchar(10),
    SHORT_EMP_NAME varchar(10) not null,
    EMP_CONDITION_CODE int not null,
    constraint EMP_MASTER_PK primary key(EMP_NO)
);
