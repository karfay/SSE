/*
auther:亀田正刀
持出台帳から、ITラベルごとに持出終了日が最新のデータを取り出す
サブクエリの関係で処理が重い
*/
select
	tpo.it_label
    ,bm.user
    ,tpo.app_user bring_person_number
    ,pm.personnel_name bring_person_name
    ,tpo.dest
    ,tpo.start_date
    ,tpo.end_date max_end_date
from take_pc_out tpo
left outer join base_master bm
on tpo.it_label = bm.it_label
left outer join personnel_master pm
on tpo.app_user = pm.personnel_number
where (tpo.it_label,tpo.end_date) in (
	select
    	it_label
        ,max(end_date)
    from take_pc_out
    group by it_label
    )
order by tpo.end_date desc
	