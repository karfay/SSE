select *
from take_pc_out tpo
join personnel_master pm
  on tpo.app_user = pm.user_id
left join (
select tdo.table_id documents, tdo.doc_id from take_documents_out tdo where tdo.condition_code <> -1 group by table_id) tdo
on tpo.table_id = tdo.documents
where condition_code = 0 or condition_code = 2
order by app_date desc,app_user asc