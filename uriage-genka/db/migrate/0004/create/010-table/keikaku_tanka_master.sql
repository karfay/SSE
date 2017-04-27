create table KEIKAKU_TANKA_MASTER (
    NENDO int not null,
    K_TANKA_APR decimal(14,0),
    K_TANKA_MAY decimal(14,0),
    K_TANKA_JUN decimal(14,0),
    K_TANKA_JUL decimal(14,0),
    K_TANKA_AUG decimal(14,0),
    K_TANKA_SEP decimal(14,0),
    K_TANKA_OCT decimal(14,0),
    K_TANKA_NOV decimal(14,0),
    K_TANKA_DEC decimal(14,0),
    K_TANKA_JAN decimal(14,0),
    K_TANKA_FEB decimal(14,0),
    K_TANKA_MAR decimal(14,0),
    constraint KEIKAKU_TANKA_MASTER_PK primary key(NENDO)
);
