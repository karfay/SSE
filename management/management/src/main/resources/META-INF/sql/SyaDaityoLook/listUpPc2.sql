/*
auther:亀田正刀
PCマスタテーブルから持出履歴のない端末のデータを取り出す
つまり社内に絶対にあるPCのデータを取り出す
*/
select
	bm.it_label
    ,user
from base_master bm
left outer join take_pc_out tpo
on bm.it_label = tpo.it_label
where tpo.app_date is null
order by bm.it_label asc