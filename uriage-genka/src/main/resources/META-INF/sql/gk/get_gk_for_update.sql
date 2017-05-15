/*
複数の案件を同じ原価管理表で扱う場合、
受注額の合計額を計算するような処理を追加する必要がある。
*/
select
	sub1.GK_ID
	,sub1.THEME_GROUP
	,group_concat(sub1.THEME_NO) theme_no
    ,sub1.THEME_NAME
	,sub1.KOKYAKU_INITIAL
	,sub1.PJ_ADMIN
	,sub1.pj_admin_name
	,sub1.PJ_LEADER
	,sub1.pj_leader_name
	,sub1.jutyugaku
	,sub1.TYAKUSYU_MONTH
	,sub1.NOUKI
from
	(
    select
		gk.GK_ID
	    ,gk.THEME_GROUP
	    ,tm.THEME_NO
	    ,gk.THEME_NAME
	    ,gk.KOKYAKU_INITIAL
	    ,gk.PJ_ADMIN
	    ,pj_admin.EMP_NAME pj_admin_name
	    ,gk.PJ_LEADER
	    ,pj_leader.EMP_NAME pj_leader_name
	    ,ar.jutyugaku
	    ,gk.TYAKUSYU_MONTH
	    ,gk.NOUKI
	from
		(select * from genka_kanri gk where gk.GK_ID = /*gkId*/'1') gk
	inner join emp_master pj_admin
	on gk.PJ_ADMIN = pj_admin.EMP_NO
	inner join emp_master pj_leader
	on gk.PJ_LEADER = pj_leader.EMP_NO
	inner join theme_master tm
	on gk.THEME_GROUP = tm.THEME_GROUP
	inner join uriage_keikaku uk
	on tm.THEME_NO = uk.theme_no
	inner join anken_rireki ar
	on uk.anken_rireki_id = ar.anken_rireki_id
	group by theme_no
	) sub1
group by THEME_GROUP