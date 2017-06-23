/*
よく似たSQLがあるけど、やりたいことが違うので一旦無視
参考：get_uk_nendo_sum_from_theme_group.sql
*/
select

	uk.uk_id
    ,uk.anken_rireki_id
    ,uk.theme_no
    ,uk.nendo
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
    ,SUM(uk.uk_kamiki) uk_kamiki
    ,SUM(uk.uk_shimoki) uk_shimoki
    ,SUM(uk.uk_total) uk_total

from uriage_keikaku uk
inner join theme_master tm
on uk.theme_no = tm.THEME_NO
inner join (select * from genka_kanri where GK_ID = /*gkId*/'2') gk
on tm.THEME_GROUP = gk.THEME_GROUP
/* 案件履歴テーブルの結合条件 */
/* どれにしろ案件テーブルと絡めた場合は外出しで書いたほうがメンテしやすいか？ */
inner join (
	select ar.anken_rireki_id from anken_rireki ar
    inner join anken an
	on (ar.anken_id = an.ANKEN_ID and ar.anken_rireki_no = an.LATEST_RIREKI_NO)
    where ar.uk_condition_code in (1, 2)) ar
on uk.anken_rireki_id = ar.anken_rireki_id
group by uk.nendo asc