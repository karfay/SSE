/*
作成日：2016/09/05
作成者：亀田正刀
PersonnelMasterから値を全件取得する
カラム名がSAStrutsの規約に即していないためエイリアスで対応
*/
select
pm.personnelNumber personnel_number
,pm.personnelName personnel_name
,pm.userId user_id
,pm.userPass user_pass
,pm.authorizations
from personnel_master pm
