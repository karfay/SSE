/*
auther:亀田正刀
持出台帳からITラベルごとに持出終了日が最新のデータを取り出し、
モバイルWi-Fiのマスタテーブルに内部結合するsql
*/
select
	tpo.wireless_lan it_label
    ,wlm.admin
    ,tpo.app_user bring_person_number
    ,pm.personnel_name bring_person_name
    ,tpo.dest
    ,tpo.start_date
    ,tpo.end_date max_end_date
from wireless_lan_master wlm
inner join
	(select tpo1.* from take_pc_out tpo1
	inner join
		(select max(end_date) max_end_date, wireless_lan
        	from (select * from take_pc_out where condition_code <> -1) tpo group by wireless_lan) tpo2
	on (tpo1.end_date = tpo2.max_end_date and tpo1.wireless_lan = tpo2.wireless_lan)) tpo
on wlm.it_label = tpo.wireless_lan
inner join personnel_master pm
on tpo.app_user = pm.personnel_number
group by wlm.it_label asc
	