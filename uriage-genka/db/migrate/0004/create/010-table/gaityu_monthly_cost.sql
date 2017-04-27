create table GAITYU_MONTHLY_COST (
    GMC_ID int not null auto_increment,
    THEME_NO varchar(10) not null,
    EMP_NO varchar(10) not null,
    NENDO int not null,
    MONTH int not null,
    K_COST decimal(14,0),
    M_COST decimal(14,0),
    J_COST decimal(14,0),
    constraint GAITYU_MONTHLY_COST_PK primary key(GMC_ID)
);
