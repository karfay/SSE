select * from take_pc_out tpo
join personnel_master pm
  on tpo.app_user = pm.user_id
left join (
select tdo.table_id documents, tdo.doc_id from take_documents_out tdo where tdo.condition_code <> -1 group by table_id) tdo
on tpo.table_id = tdo.documents
where
0=0
and (
	0=1
	/*IF includeDeleted == 1*/
    or condition_code = -1
	/*END*/
	/*IF includeUnapproved == 1*/
	or condition_code = 0
	/*END*/
	/*IF includeApproved == 1*/
	or condition_code = 1
	/*END*/
	/*IF includeCorrected == 1*/
	or condition_code = 2
	/*END*/
	/*IF includeRemanded == 1*/
	or condition_code = 3
	/*END*/
)

/*IF searchDateAfter != ""*/
and app_date >= /*searchDateAfter*/'20000401'
/*END*/
/*IF searchDateBefore != ""*/
and app_date <= /*searchDateBefore*/'20000401'
/*END*/
/*IF searchName != ""*/
and personnel_name like concat('%',/*searchName*/,'%')
/*END*/
/*IF searchDest != ""*/
and dest like concat('%',/*searchDest*/,'%')
/*END*/
/*IF searchPastRecords != ""*/
and
(
	start_date <= /*searchPastRecords*/'20001014'
	and  end_date >= /*searchPastRecords*/'20001014'
)
/*END*/

order by app_date desc,app_user asc