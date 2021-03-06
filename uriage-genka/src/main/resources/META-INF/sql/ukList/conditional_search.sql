select
	ar.anken_id
    ,ar.anken_rireki_no
    ,ar.anken_rireki_id
    ,ar.nendo
    ,ar.kokyaku_name
    ,ar.kokyaku_initial
    ,ar.anken_name
    ,ar.jutyu_name
    ,ifnull(tounendo.theme_no, jinendo.THEME_NO) theme_no
    ,tm.theme_group
    ,ar.kaihatsu_group_head
    ,head.short_emp_name kaihatsu_group_head_name
    ,ar.eigyo
    ,eigyo.short_emp_name eigyo_name
    ,ar.hattyu_type_code
    ,hattyu.code_name hattyu_type_name
    ,ar.kakudo_code
    ,kakudo.code_name kakudo_name
    ,ar.hattyu_mikomi_date
    ,ar.hattyu_date
    ,ar.kensyu_date
    ,ar.notes
    ,ar.jutyugaku
    ,ar.uk_yokuyoku
    ,ar.uk_condition_code
    ,ar.insert_date
    ,ar.insert_emp_no
    ,tounendo.uk_apr tounendo_apr
    ,tounendo.uk_may tounendo_may
	,tounendo.uk_jun tounendo_jun
	,tounendo.uk_jul tounendo_jul
	,tounendo.uk_aug tounendo_aug
	,tounendo.uk_sep tounendo_sep
	,tounendo.uk_oct tounendo_oct
	,tounendo.uk_nov tounendo_nov
	,tounendo.uk_dec tounendo_dec
	,tounendo.uk_jan tounendo_jan
	,tounendo.uk_feb tounendo_feb
	,tounendo.uk_mar tounendo_mar
	,jinendo.uk_apr jinendo_apr
	,jinendo.uk_may jinendo_may
	,jinendo.uk_jun jinendo_jun
	,jinendo.uk_jul jinendo_jul
	,jinendo.uk_aug jinendo_aug
	,jinendo.uk_sep jinendo_sep
	,jinendo.uk_oct jinendo_oct
	,jinendo.uk_nov jinendo_nov
	,jinendo.uk_dec jinendo_dec
	,jinendo.uk_jan jinendo_jan
	,jinendo.uk_feb jinendo_feb
	,jinendo.uk_mar jinendo_mar
    ,tounendo.uk_kamiki tounendo_kamiki
    ,tounendo.uk_shimoki tounendo_shimoki
    ,tounendo.uk_total tounendo_total
    ,jinendo.uk_kamiki jinendo_kamiki
    ,jinendo.uk_shimoki jinendo_shimoki
    ,jinendo.uk_total jinendo_total
    ,zennendo.uk_total zennendo_total
from anken_rireki ar
inner join anken a
on (ar.anken_id = a.anken_id and ar.anken_rireki_no = a.latest_rireki_no)
inner join ug_code_master kakudo
on ar.kakudo_code = kakudo.code_id
inner join emp_master eigyo
on ar.eigyo = eigyo.emp_no
/*
本来は発注タイプコードは必須だが、現行の売管では必ず登録されてはいないので
NULLを考慮して外部結合
どうせ包含関係にあるので入力チェックがしっかりしていれば特に修正する必要もない
*/
left join ug_code_master hattyu
on ar.hattyu_type_code = hattyu.code_id
left join emp_master head
on ar.kaihatsu_group_head = head.emp_no
left join (select * from uriage_keikaku uk1 where uk1.nendo = /*tounendo*/2017) tounendo
on ar.anken_rireki_id = tounendo.anken_rireki_id
left join (select * from uriage_keikaku uk2 where uk2.nendo = /*jinendo*/2018) jinendo
on ar.anken_rireki_id = jinendo.anken_rireki_id
left join (select * from uriage_keikaku uk3 where uk3.nendo = /*zennendo*/2016) zennendo
on ar.anken_rireki_id = zennendo.anken_rireki_id
left join theme_master tm
on tm.THEME_NO = tounendo.theme_no or tm.THEME_NO = jinendo.THEME_NO
where ((ar.nendo<=/*zennendo*/2016 and tounendo.nendo=/*tounendo*/2017) or (ar.nendo>=/*tounendo*/2017))
/*IF kokyakuName != null*/
and ar.kokyaku_name like concat('%',/*kokyakuName*/'','%')
/*END*/
/*IF ankenName != null*/
and ar.anken_name like concat('%',/*ankenName*/'','%')
/*END*/
/*IF jutyuName != null*/
and (ar.jutyu_name like concat('%',/*jutyuName*/'','%') or (ar.jutyu_name is null))
/*END*/
/*IF kakudoList != null*/
and ar.kakudo_code in /*kakudoList*/(101, 102, 103, 104, 105, 106)
/*END*/
/*IF hattyuTypeList != null*/
and ar.hattyu_type_code in /*hattyuTypeList*/(210, 215, 220, 230, 240, 250, 260, 270)
/*END*/
/*IF eigyoList != null*/
and ar.eigyo in /*eigyoList*/('sse801311', 'sse802347')
/*END*/
/*IF conditionCodeList != null*/
and ar.uk_condition_code in /*conditionCodeList*/(1)
/*END*/
/*IF themeGroup != null*/
and tm.theme_group = /*themeGroup*/'25401-531'
/*END*/
/*IF sort == "normal"*/
order by ar.uk_condition_code, ar.kakudo_code, ar.nendo, ar.hattyu_type_code, ar.kokyaku_initial
/*END*/
/*IF sort == "themeNo"*/
order by ar.uk_condition_code, tounendo.theme_no, tm.theme_group, ar.kakudo_code
/*END*/

