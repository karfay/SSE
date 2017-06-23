/*
auther:亀田正刀
持出台帳からITラベルごとに持出終了日が最新のデータを取り出し、
モバイルWi-Fiのマスタテーブルに内部結合するsql

共通
モバイルWi-Fiマスタに以下のテーブルを外部結合する
	・モバイルWi-Fiごとで、持出終了日がもっとも新しい持出台帳テーブル（削除テーブルを除く）

注意事項
持出終了日が同じデータがあるとだぶついて表示される
この場合、申請日が最新のものを優先したい（そもそもデータ入力を不正にしたいものなので、こちらで対応するのは２度手間になりそう）

１．貸し出せるデータのみを抽出する処理
	・その日に申請されたものをリストに含まない
where tpo.app_date <> curennt_date

	・持ち出されている端末をリストに含まない（=持出開始日～終了日の間に現在日時が含まれていない）
and (tpo.start_date < current_date and current_date < tpo.end_date)


運用に即して
	・同じ端末を個人が使うことが多く、持出終了日に本社に戻ってきて再度申請する人が多い
	　上記の条件では持出終了日当日は抽出されないので当日の再申請の際に困りそうに見える
	→今のシステムでは引用すれば抽出されないものも申請できるので最後に持出した人は引用すれば良い

*/
select
	tpo.wireless_lan it_label
    ,wlm.admin
    ,tpo.app_user bring_person_number
    ,tpo.dest
    ,tpo.app_date
    ,tpo.start_date
    ,tpo.end_date max_end_date
from wireless_lan_master wlm
left join
	(select tpo1.* from take_pc_out tpo1
	inner join
		(select max(end_date) max_end_date, wireless_lan
        	from (select * from take_pc_out where condition_code <> -1) tpo group by wireless_lan) tpo2
	on (tpo1.end_date = tpo2.max_end_date and tpo1.wireless_lan = tpo2.wireless_lan)) tpo
on wlm.it_label = tpo.wireless_lan
where current_date <> tpo.app_date
and (tpo.start_date < current_date and current_date < tpo.end_date)
group by wlm.it_label asc