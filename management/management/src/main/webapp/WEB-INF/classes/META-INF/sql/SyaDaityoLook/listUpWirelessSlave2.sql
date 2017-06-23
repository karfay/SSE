/*
auther:亀田正刀
無線子機マスタテーブルから持出履歴のない端末のデータを取り出す
つまり社内に絶対にある無線子機のデータを取り出す
SyaDaityoLookDtoに書式を合わせるためnumberをit_labelとして出力
*/
select
	wsm.number it_label
from wireless_slave_master wsm
left outer join (select * from take_pc_out where condition_code <> -1) tpo
on wsm.number = tpo.wireless_slave
where tpo.app_date is null
group by wsm.number asc