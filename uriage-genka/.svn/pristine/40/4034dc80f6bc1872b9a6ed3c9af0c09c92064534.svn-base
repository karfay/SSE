select
	group_concat(sub2.THEME_NO) theme_no
	,sub2.THEME_GROUP theme_group
	,sub2.name theme_name
	,sub2.kokyaku_initial kokyaku_initial
	,sub2.jutyugaku jutyugaku
from
	(select
		tm.THEME_NO
	    ,tm.THEME_GROUP
	    ,concat(ar.kokyaku_name, "　",ar.anken_name) name
	    ,ar.kokyaku_initial
		,ar.jutyugaku
	from theme_master tm
	inner join  uriage_keikaku uk
	on tm.THEME_NO = uk.theme_no
	inner join anken_rireki ar
	on ar.anken_rireki_id = uk.anken_rireki_id
	where tm.THEME_GROUP =
		(select sub1.THEME_GROUP from theme_master sub1 where theme_no = /*themeNo*/'25401-5317')
	group by tm.THEME_NO asc
    ) sub2
group by sub2.THEME_GROUP;