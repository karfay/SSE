select *
from take_pc_out tpo
join personnel_master pm
  on tpo.app_user = pm.user_id
left join (
select tdo.table_id documents, tdo.doc_id from take_documents_out tdo where tdo.condition_code <> -1 group by table_id) tdo
on tpo.table_id = tdo.documents
where table_id = CONVERT(/*$1*/'99999920140926101411',CHAR)