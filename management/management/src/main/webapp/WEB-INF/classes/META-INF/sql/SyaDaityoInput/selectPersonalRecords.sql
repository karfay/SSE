select *
from take_pc_out tpo
join personnel_master pm
  on tpo.app_user = pm.user_id
where app_user = /*userId*/'sse999999' AND condition_code <> -1