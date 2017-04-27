create table EMP_MONTHLY_KOUSU (
    EMK_ID int not null auto_increment,
    THEME_NO varchar(10) not null,
    EMP_NO varchar(10) not null,
    NENDO int not null,
    MONTH int not null,
    K_KOUSU decimal(5,1),
    M_KOUSU decimal(5,1),
    J_KOUSU decimal(5,1),
    constraint EMP_MONTHLY_KOUSU_PK primary key(EMK_ID)
);
