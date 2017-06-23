/*
作成日：2016/09/15
作成者：亀田正刀
pc_masterの表示用sql
ifnull()を利用して、カラムadmin,userの社員番号がユーザマスタ（personnel_master）のpersonnel_numberと
一致した際には対応した社員氏名（personnel_master.personnel_name）を取得し、一致しない場合はカラム内の
値をそのまま取得する
*/
select
pcm.it_label
,ifnull(pm.personnel_name, pcm.admin) admin
,pcm.admin admin_number
,ifnull(pm2.personnel_name ,pcm.user) user
,pcm.user user_number
,pcm.assets_mode
,pcm.start_date
,pcm.end_date
,pcm.scheduled_date
,pcm.maker
,pcm.model_number
,pcm.serial_number
,pcm.os
,pcm.wireless_lan
,pcm.encryption
,pcm.notes
from pc_master pcm
left join personnel_master pm
on pcm.admin = pm.personnel_number
left join personnel_master pm2
on pcm.user = pm2.personnel_number