/*
 * テーマ親版から関連する売上計画の年度計を取得する
 * 年度ごとの合計なので、List<UriageKeikaku>
 * */
select
	uk.nendo
    ,SUM(uk.uk_apr) uk_apr
    ,SUM(uk.uk_may) uk_may
    ,SUM(uk.uk_jun)	uk_jun
    ,SUM(uk.uk_jul) uk_jul
    ,SUM(uk.uk_aug) uk_aug
    ,SUM(uk.uk_sep) uk_sep
    ,SUM(uk.uk_oct) uk_oct
    ,SUM(uk.uk_nov) uk_nov
    ,SUM(uk.uk_dec) uk_dec
    ,SUM(uk.uk_jan) uk_jan
    ,SUM(uk.uk_feb) uk_feb
    ,SUM(uk.uk_mar) uk_mar
from
	(select * from theme_master where THEME_GROUP = /*themeGroup*/'25401-531') tm
inner join uriage_keikaku uk
on tm.THEME_NO = uk.theme_no
inner join anken_rireki ar
on uk.anken_rireki_id = ar.anken_rireki_id
inner join anken an
on (ar.anken_id = an.ANKEN_ID and ar.anken_rireki_no = an.LATEST_RIREKI_NO)
group by uk.nendo desc
