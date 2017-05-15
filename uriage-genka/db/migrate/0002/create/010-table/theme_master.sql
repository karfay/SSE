create table THEME_MASTER (
    THEME_NO varchar(10) not null,
    THEME_NAME varchar(100) not null,
    THEME_GROUP varchar(10) not null,
    SHORT_THEME_NAME varchar(100),
    NAIYO_KUBUN varchar(10),
    UKETSUKE_DATE varchar(100),
    IRAI_DATE varchar(10),
    NOUKI varchar(10),
    JUTYU_KINGAKU decimal(14,0),
    KEIKAKU_GENKA_PAR double(22,0),
    TORIHIKISAKI_CODE varchar(100),
    TANTOU_BUMON varchar(100),
    URIAGE_MONTH_KUBUN varchar(10),
    NOTES_URIAGE_MONTH_KUBUN varchar(100),
    URIAGE_YEAR_MONTH varchar(10),
    constraint THEME_MASTER_PK primary key(THEME_NO)
);
