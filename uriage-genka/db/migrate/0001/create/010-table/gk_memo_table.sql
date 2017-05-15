create table GK_MEMO_TABLE (
    MEMO_ID int not null auto_increment,
    GK_ID int not null,
    WRITE_DATE timestamp not null,
    BIKOU varchar(1000),
    JOKYO varchar(1000),
    constraint GK_MEMO_TABLE_PK primary key(MEMO_ID)
);
