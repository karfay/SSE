/*
auther:亀田正刀
PCマスタテーブルから持出履歴のない端末のデータを取り出す
つまり社内に絶対にあるPCのデータを取り出す
*/
select
	wlm.it_label
    ,wlm.admin
from wireless_lan_master wlm
left outer join (select * from take_pc_out where condition_code <> -1) tpo
on wlm.it_label = tpo.wireless_lan
where tpo.app_date is null
group by wlm.it_label asc