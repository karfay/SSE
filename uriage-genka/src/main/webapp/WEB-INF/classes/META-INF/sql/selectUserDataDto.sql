/*
 * userDataDtoを検索するsql
 * 作成日：2017/03/10
 * 作成者：亀田
 */
select
	em.*
    ,sum(uam.uk_history_look) uk_history_look
    ,sum(uam.uk_insert) uk_insert
    ,sum(uam.uk_update) uk_update
    ,sum(uam.uk_delete) uk_delete
    ,sum(uam.gk_insert) gk_insert
    ,sum(uam.gk_update) gk_update
    ,sum(uam.theme_insert) theme_insert
    ,sum(uam.theme_update) theme_update
    ,sum(uam.uriage_tanka_update) uriage_tanka_update
from
	(select * from emp_master em1 where (em1.login_id = /*loginId*/'sse802563' and em1.password = /*password*/'admin')) em
left join
	(select * from emp_auth_relation eal1 where eal1.sys_id = 'Ug') eal
on eal.emp_no = em.emp_no
left join ug_authorizaiton_maser uam
on uam.auth_id = eal.auth_id
group by em.emp_no;