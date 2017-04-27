/*
テーマ親番から対象の案件をすべて取得するメソッド
原価管理表に影響があるような案件変更履歴を取得したいので
削除、失注操作も考慮する
*/
select ar.* from anken_rireki ar
inner join anken an
on (an.ANKEN_ID = ar.anken_id and an.LATEST_RIREKI_NO = ar.anken_rireki_no)
inner join uriage_keikaku uk
on ar.anken_rireki_id = uk.anken_rireki_id
inner join (select * from theme_master where THEME_GROUP = /*themeGroup*/'25401-531') tm
on uk.theme_no = tm.THEME_NO
