/*
auther:亀田正刀
持出台帳から管理番号ごとに持出終了日が最新のデータを取り出し、
無線子機のマスタテーブルに内部結合するsql
SyaDaityoLookDtoに書式を合わせるためnumberをit_labelとして出力
*/
select
	tpo.wireless_slave it_label
    ,tpo.app_user bring_person_number
    ,pm.personnel_name bring_person_name
    ,tpo.dest
    ,tpo.start_date
    ,tpo.end_date max_end_date
from wireless_slave_master wsm
inner join
	(select tpo1.* from take_pc_out tpo1
	inner join
		(select max(end_date) max_end_date, wireless_slave
        	from (select * from take_pc_out where condition_code <> -1) tpo group by wireless_slave) tpo2
	on (tpo1.end_date = tpo2.max_end_date and tpo1.wireless_slave = tpo2.wireless_slave)) tpo
on wsm.number = tpo.wireless_slave
inner join personnel_master pm
on tpo.app_user = pm.personnel_number
where tpo.condition_code <> -1
group by wsm.number asc
	