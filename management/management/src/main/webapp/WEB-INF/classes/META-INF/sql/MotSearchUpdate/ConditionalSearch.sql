select
  md.table_id
  ,md.bring_person
  ,pm1.personnel_name bring_person_name
  ,md.bring_date
  ,md.client_name
  ,md.project
  ,md.material_name
  ,md.category_code
  ,mcm.category_name
  ,md.depository
  ,md.copies
  ,md.confidential
  ,md.bring_notes
  ,md.scheduled_date
  ,md.scheduled_code
  ,pr1.process_name scheduled_name
  ,md.process_date
  ,md.process_code
  ,pr2.process_name
  ,md.process_person
  ,pm2.personnel_name process_person_name
  ,md.process_notes
  ,md.bring_approval_date
  ,md.bring_approver
  ,pm3.personnel_name bring_approver_name
  ,md.bring_approve_notes
  ,md.process_approval_date
  ,md.process_approver
  ,pm4.personnel_name process_approver_name
  ,md.process_approve_notes
  ,md.condition_code
  ,co.condition_name
from motikomi_daityo md
inner join personnel_master pm1
  on md.bring_person = pm1.user_id
left outer join personnel_master pm2
  on md.process_person = pm2.user_id
left outer join personnel_master pm3
  on md.bring_approver = pm3.user_id
left outer join personnel_master pm4
  on md.process_approver = pm4.user_id
inner join material_category_master mcm
  on md.category_code = mcm.category_code
inner join process_master pr1
  on md.scheduled_code = pr1.process_code
inner join process_master pr2
  on md.process_code = pr2.process_code
inner join condition_master co
  on md.condition_code = co.condition_code
where
0=0
and (
	0=1
	/*IF includeDeleted == 1*/
	or md.condition_code = -1
	/*END*/
	/*IF includeBringUnapproved == 1*/
	or md.condition_code = 10
	/*END*/
	/*IF includeBringApproved == 1*/
	or md.condition_code = 11
	/*END*/
	/*IF includeBringUpdate == 1*/
	or md.condition_code = 12
	/*END*/
	/*IF includeBringRemand == 1*/
	or md.condition_code = 13
	/*END*/
	/*IF includeProcessUnapproved == 1*/
	or md.condition_code = 20
	/*END*/
	/*IF includeProcessApproved == 1*/
	or md.condition_code = 21
	/*END*/
	/*IF includeProcessUpdate == 1*/
	or md.condition_code = 22
	/*END*/
	/*IF includeProcessRemand == 1*/
	or md.condition_code = 23
	/*END*/
)
/*IF tableId != null*/
and md.table_id = /*tableId*/'12345678901234567891'
/*END*/
/*IF includeExpired == 1*/
and md.scheduled_date < /*currentTime*/'20041212'
/*END*/
order by bring_date desc,bring_person asc