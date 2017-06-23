/*
--作成日：2016/08/24
--作成者：亀田　正刀
--モバイルWi-Fiのマスタテーブルを全件検索する
--管理者（admin）と使用者（admin）の氏名を社員マスタ（personnel_master）と結合して抜き出す
--管理者氏名（admin_name）,使用者氏名（user_name）
*/
select
wlm.phone_number
,wlm.model
,wlm.plan
,wlm.pin_code
,wlm.serial_number
,wlm.it_label
,wlm.admin
,wlm.post
,wlm.iccid
,wlm.pin_release_code
,wlm.user
,pm1.personnel_name admin_name
,pm2.personnel_name user_name
from wireless_lan_master wlm
left join personnel_master pm1
on wlm.admin = pm1.personnel_number
left join personnel_master pm2
on wlm.user = pm2.personnel_number