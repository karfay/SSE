/*
案件テーブルと案件履歴テーブルは相互参照なのでseasar2での設定を行っていない
この程度ならタイプセーフ実装しなくても問題ないはず
*/
select ar.nendo from anken_rireki ar
inner join anken a
on ar.anken_id = a.anken_id
group by ar.nendo desc