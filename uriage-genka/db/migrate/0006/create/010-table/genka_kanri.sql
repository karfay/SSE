create table GENKA_KANRI (
    GK_ID int not null auto_increment,
    THEME_GROUP varchar(10) not null,
    THEME_NAME varchar(100) not null,
    KOKYAKU_INITIAL varchar(1) not null,
    PJ_ADMIN varchar(10) not null,
    PJ_LEADER varchar(10) not null,
    CREATER varchar(10) not null,
    TYAKUSYU_MONTH varchar(10) not null,
    NOUKI varchar(10) not null,
    LAST_UPDATER varchar(10) not null,
    LAST_UPDATE_TIME timestamp not null,
    constraint GENKA_KANRI_PK primary key(GK_ID)
);
