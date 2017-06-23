select count(*)
from take_pc_out tpo
join personnel_master pm
  on tpo.app_user = pm.user_id
order by app_date desc,app_user asc