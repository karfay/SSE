/*
params : themeGroup
パラメータののテーマ親番を持つ原価月別詳細テーブルをすべて取得する。
金額の合計を計算する。
単価は0とnullを含まずに平均を計算する。
状態コードは403(PJ計)固定。
テーマNOは挿入対象外なので抽出しない。
月は0
*/
select
    mg.THEME_GROUP
    ,mg.NENDO
    ,0 month
    ,403 GK_CONDITION_CODE
	,sum(mg.K_ROUMUHI) K_ROUMUHI
    ,sum(mg.K_KOUSU) K_KOUSU
    ,avg(case when mg.K_TANKA = 0 then null else mg.K_TANKA end) K_TANKA
    ,sum(mg.K_GAITYU) K_GAITYU
    ,sum(mg.K_RYOHI) K_RYOHI
    ,sum(mg.K_SONOTA) K_SONOTA
    ,sum(mg.K_KEIHI) K_KEIHI
    ,sum(mg.K_SUM) K_SUM
    ,sum(mg.K_M_GAP) K_M_GAP
    ,sum(mg.K_J_GAP) K_J_GAP
	,sum(mg.M_ROUMUHI) M_ROUMUHI
    ,sum(mg.M_KOUSU) M_KOUSU
    ,avg(case when mg.M_TANKA = 0 then null else mg.M_TANKA end) M_TANKA
    ,sum(mg.M_GAITYU) M_GAITYU
    ,sum(mg.M_RYOHI) M_RYOHI
    ,sum(mg.M_SONOTA) M_SONOTA
    ,sum(mg.M_KEIHI) M_KEIHI
    ,sum(mg.M_SUM) M_SUM
    ,sum(mg.J_ROUMUHI) J_ROUMUHI
    ,sum(mg.J_KOUSU) J_KOUSU
    ,avg(case when mg.J_TANKA = 0 then null else mg.J_TANKA end) J_TANKA
    ,sum(mg.J_GAITYU) J_GAITYU
    ,sum(mg.J_RYOHI) J_RYOHI
    ,sum(mg.J_SONOTA) J_SONOTA
    ,sum(mg.J_KEIHI) J_KEIHI
    ,sum(mg.J_SUM) J_SUM
from monthly_genka mg
where mg.THEME_GROUP = /*themeGroup*/'25401-531'
	and mg.GK_CONDITION_CODE = 401
    and mg.THEME_NO is not null
