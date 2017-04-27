/*
テーマ親番から売上計画を取得する。
年度、テーマNOでグループ化し、売上額の合計を計算する。
出力順はいずれも昇順。
*/
select
	uk.nendo
    ,uk.theme_no
    ,SUM(uk.uk_apr) uk_apr
    ,SUM(uk.uk_may) uk_may
    ,SUM(uk.uk_jun) uk_jun
    ,SUM(uk.uk_jul) uk_jul
    ,SUM(uk.uk_aug) uk_aug
    ,SUM(uk.uk_sep) uk_sep
    ,SUM(uk.uk_oct) uk_oct
    ,SUM(uk.uk_nov) uk_nov
    ,SUM(uk.uk_dec) uk_dec
    ,SUM(uk.uk_jan) uk_jan
    ,SUM(uk.uk_feb) uk_feb
    ,SUM(uk.uk_mar) uk_mar
from uriage_keikaku uk
inner join (select * from theme_master where THEME_GROUP = /*themeGroup*/'25401-531') tm
on uk.theme_no = tm.THEME_NO
inner join (
	select ar.anken_rireki_id
    from anken_rireki ar
    inner join anken an
    on (an.ANKEN_ID = ar.anken_id and an.LATEST_RIREKI_NO = ar.anken_rireki_no)
    where ar.uk_condition_code in (1, 2)
    ) ar
on uk.anken_rireki_id = ar.anken_rireki_id
group by uk.nendo asc , uk.theme_no asc