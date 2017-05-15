<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" type="text/css" href="${f:url('/css/new-global.css')}"></link>
<style type="text/css">
div.fixed{
	padding-left: 8px;
	background-color: white;
}
div.fixed td, div.fixed th{
	min-width: 100px;
	padding: 0px, 10px;
}

div.unfixed td{
	width: 75px;
}
th.shikakari{
	background-color: darkolivegreen;
}
th.shikakari-sub{
	background-color: lightgreen;
	color: black;
	font-weight: normal;
}
td.no-input{
	background-color: skyblue;
	text-align: right;
}
td.shikakari-no-input{
	background-color: lightgreen;
	text-align: right;
}
td.input{
	text-align: center;
	padding: 0px;
}
div.#main-contents{width:3000px}

input[type="text"]{
	width:inherit;
	text-align: right;
	padding: 0px 5px;
}
div.unfixed{position: absolute;}
table{
	table-layout: fixed;
	border-collapse: collapse;
	border: none;
}
.theme-no{width: 100px;}
.theme-group{width: 100px;}
.initial{width: 50px}
#insert-button{
	width: 250px;
}
div.space{
	height: 10px;
}
td.space{
	width: 10px !important;
	border: none;
}

.sakujo{
	background-color: silver !important;
}
.sakujo-sub{
	background-color: dimgray !important;
}

</style>

<script type="text/javascript" src="${f:url('/javascript/checkDatePattern.js')}"></script>
<script type="text/javascript" src="${f:url('/javascript/jquery-3.1.1.min.js')}"></script>
<script type="text/javascript">
$(function(){
	$("input[type=text]").change(function(){
		console.log("on change!");

	});
});

$(document).ready(function(){
	/*
	calcurate()はinputタグのelement属性を引数にしている。
	すべての月の工数を計算するには全ての月別原価テーブルを順に
	calculate()に渡してやれば良い。
	無駄な計算が多いけど特に速度は気にならないのでこのまま。
	*/
	//実績工数のinputがhiddenでない = 月別原価テーブルのタグ
	mgList = $('input[name$="[0].JKousu"]').not(':hidden');
	count = mgList.length;
	for(i=0; i < count; i++){
		//JQueryセレクタ配列にはDOM要素が格納されている
		calculate( mgList[i] );
	}
	calculatePjTotal();
});


function calculate(obj){
	//内容が変化したtrタグのidを取得
	nameStr = obj.name;
	console.log(nameStr);
	trIndex = $('input[name="'+ nameStr +'"]').parent().parent().attr("class");
	console.log('trIndex: ' + trIndex);

	tr = $('tr.'+ trIndex);
	//trタグ内の原価情報を計算
	//社員別工数、外注別経費を計算
	//まずはプロジェクトメンバの列数を取得する。月別原価情報のKKousuは除外。
	s3Count = tr.find('input[name$="KKousu"]').not('input[name$="[0].KKousu"]').length;
	for(i=1; i<=s3Count; i++ ){
		keikaku = tr.find('input[name$="['+ i +'].KKousu"]').val().replace(/,/g,'');
		mikomi = tr.find('input[name$="['+ i +'].MKousu"]').val().replace(/,/g,'');
		jisseki = tr.find('input[name$="['+ i +'].JKousu"]').val().replace(/,/g,'');
		kmgap = tr.children('#KMKousuGap, #KMCostGap');
		kjgap = tr.children('#KJKousuGap, #KJCostGap');
		//KKousuに小数点が存在したら、計算結果にも小数点を付けて表示
		if(keikaku.match(/\./g)){
			kmgap.eq(i-1).text( (keikaku - mikomi).toLocaleString(undefined, {minimumFractionDigits: 1}) );
			kjgap.eq(i-1).text( (keikaku - jisseki).toLocaleString(undefined, {minimumFractionDigits: 1}) );
		}else{
			kmgap.eq(i-1).text( (keikaku - mikomi).toLocaleString() );
			kjgap.eq(i-1).text( (keikaku - jisseki).toLocaleString() );
		}

	}
	//社員別工数、外注別経費の合計を計算
	calcTotalKousu('KKousu', trIndex);
	calcTotalKousu('MKousu', trIndex);
	calcTotalKousu('JKousu', trIndex);
	calcTotalKousu('KMKousuGap', trIndex);
	calcTotalKousu('KJKousuGap', trIndex);

	//thクラスindexの社員別工数の合計を計算し、対応するセルの値を書き換える。
	//calculateメソッドの内部メソッド
	function calcTotalKousu(tagName, index){
		total = 0;
		//例えば tagName = MKousu の場合、
		//mgMKousu、及びKMKousuGap等のクラス名を除外する
		kousu = tr.children("#total"+ tagName).next('td');
		while(kousu.attr('class')!='space'){
			//tdタグの中にinputタグがあればinputの値を、なければtdのテキストを足し合わせていく
			if(kousu.children('input')[0]){
				total += Number(kousu.children('input').val().replace(/,/g,''));
			}
			else{
				total += Number(kousu.text().replace(/,/g,''));
			}
			kousu = kousu.next('td');
		}
		tr.children('#total'+ tagName).text( total.toLocaleString(undefined, {minimumFractionDigits: 1}) );
	}
/*
	tr.find('input[name$='+ tagName +']').not('input[name$="[0].'+ tagName +'"]').each(function(){
		console.log($(this).attr("name"));
		console.log($(this).val());
		tmp = $(this).val().replace(/,/g,'');
		if(tmp.match(/\./g)){
			total += Number(tmp);
		}
	});
	tr.children('#total' + tagName).text( total.toLocaleString(undefined, {minimumFractionDigits: 1}) );
	}
 */


	//月別原価情報を計算
	//フォーム送信用のinput[type=hidden]と、表示用のtdのテキストを変更する。
	//td直下のhidden要素は同一ページで複数回参照すると値の管理が面倒なので、
	//更新ボタンを押した際にtdのテキスト要素から一斉に書き換えるようにする。
	//工数を社員別工数から反映
	kkousu = tr.find('#mgKKousu');
	comp = tr.children('#totalKKousu').text();//document.getElementById('totalKKousu').innerText;
	kkousu.text( comp );

	mkousu = tr.find('#mgMKousu');
	comp = tr.children('#totalMKousu').text();//document.getElementById('totalMKousu').innerText;
	mkousu.text( comp );

	jkousu = tr.find('#mgJKousu').children('input');
	comp = tr.children('#totalJKousu').text();//document.getElementById('totalJKousu').innerText;
	if(jkousu.val() != comp){
		console.log(jkousu.val());
		jkousu.css('background-color', 'orange');
		jkousu.attr('title', '実績工数が右表の合計と一致していません。訂正しない場合はこの値で更新されます。');
	}else{
		jkousu.css('background-color', 'inherit');
		jkousu.attr('title', '');
	}

	//労務費を再計算
	kroumuhi = tr.find('#mgKRoumuhi');
	ktanka = tr.find('#mgKTanka');
	kroumuhi.text( (kkousu.text() *  ktanka.text().replace(/,/g,'')).toLocaleString() );

	mroumuhi = tr.find('#mgMRoumuhi');
	mtanka = tr.find('#mgMTanka').children('input');
	mroumuhi.text( (mkousu.text() *  mtanka.val().replace(/,/g,'')).toLocaleString() );

	jroumuhi = tr.find('#mgJRoumuhi');
	jtanka = tr.find('#mgJTanka').children('input');
	jroumuhi.text( (jkousu.val() *  jtanka.val().replace(/,/g,'')).toLocaleString() );

	//外注費を社員別外注費から反映
	kgaityu = tr.find('#mgKGaityu');
	comp = calcTotalCost('KKousu', trIndex);
	kgaityu.text( comp );

	mgaityu = tr.find('#mgMGaityu');
	comp = calcTotalCost('MKousu', trIndex);
	mgaityu.text( comp );

	jgaityu = tr.find('#mgJGaityu').children('input');
	comp = calcTotalCost('JKousu', trIndex);
	if(jgaityu.val() != comp){
		console.log(jgaityu.val());
		jgaityu.css('background-color', 'orange');
		jgaityu.attr('title', '実績外注費が右表の合計と一致していません。訂正しない場合はこの値で更新されます。');
	}else{
		jgaityu.css('background-color', 'inherit');
		jgaityu.attr('title', '');
	}

	//thクラスindexの外注別費用の合計を計算し、対応するセルの値を書き換える。
	//calculateメソッドの内部メソッド
	function calcTotalCost(tagName, index){
	total = 0;
	$('tr.' + trIndex).find('input[name$='+ tagName +']').not('input[name$="[0].'+ tagName +'"]').each(function(){
		tmp = $(this).val().replace(/,/g,'');
		if(!tmp.match(/\./g)){//ここの判定が逆になるだけ
			total += Number(tmp);
		}
	});
	return total.toLocaleString();
	}

	//経費合計
	kkeihi = tr.children('#mgKKeihi');
	kryohi = tr.children('#mgKRyohi').children('input');
	ksonota = tr.children('#mgKSonota').children('input');
	kkeihi.text(
			(Number(kgaityu.text().replace(/,/g,''))
			+ Number(kryohi.val().replace(/,/g,''))
			+ Number(ksonota.val().replace(/,/g,'')) ).toLocaleString() );

	mkeihi = tr.children('#mgMKeihi');
	mryohi = tr.children('#mgMRyohi').children('input');
	msonota = tr.children('#mgMSonota').children('input');
	mkeihi.text(
			(Number(mgaityu.text().replace(/,/g,''))
			+ Number(mryohi.val().replace(/,/g,''))
			+ Number(msonota.val().replace(/,/g,'')) ).toLocaleString() );

	jkeihi = tr.children('#mgJKeihi');
	jryohi = tr.children('#mgJRyohi').children('input');
	jsonota = tr.children('#mgJSonota').children('input');
	jkeihi.text(
			(Number(jgaityu.val().replace(/,/g,''))
			+ Number(jryohi.val().replace(/,/g,''))
			+ Number(jsonota.val().replace(/,/g,'')) ).toLocaleString() );

	//合計
	ktotal = tr.children('#mgKTotal');
	mtotal = tr.children('#mgMTotal');
	jtotal = tr.children('#mgJTotal');
	ktotal.text(
			(Number(kroumuhi.text().replace(/,/g,''))
			+ Number(kkeihi.text().replace(/,/g,'')) ).toLocaleString());
	mtotal.text(
			(Number(mroumuhi.text().replace(/,/g,''))
			+ Number(mkeihi.text().replace(/,/g,'')) ).toLocaleString());
	jtotal.text(
			(Number(jroumuhi.text().replace(/,/g,''))
			+ Number(jkeihi.text().replace(/,/g,'')) ).toLocaleString());

	kmgap = tr.find('#mgKMGap');
	kmgap.text( (ktotal.text().replace(/,/g,'') - mtotal.text().replace(/,/g,'')).toLocaleString() );
	kjgap = tr.find('#mgKJGap');
	kjgap.text( (ktotal.text().replace(/,/g,'') - jtotal.text().replace(/,/g,'')).toLocaleString() );


	//仕掛り計に計算情報を反映
	//テーマNOを取得
	themeno = $.trim(tr.children('#themeNo').text());
	shikakari = $('tr.' + $('.shikakari:contains('+ themeno +') ').parent('tr').attr('class'));

	//計算結果を格納する変数
	kroumuhi = 0; mroumuhi = 0; jroumuhi = 0; kmgap = 0; kjgap = 0;
	kkousu = 0; mkousu = 0; jkousu = 0;
	kgaityu = 0; mgaityu = 0; jgaityu = 0;
	kryohi = 0; mryohi = 0; jryohi = 0; kuriage= 0; kavgtanka = 0;
	ksonota = 0; msonota = 0; jsonota = 0;
	kkeihi = 0; mkeihi = 0; jkeihi = 0;
	ktotal = 0; mtotal = 0; jtotal = 0; arari = 0; arariper = 0; totalgenka = 0;
	jtanka = 0; jtankacount = 0;
	membersKKousu = []; membersMKousu = []; membersJKousu = [];
	membersKMGap = []; membersKJGap = [];
	for(var i = 0; i < 100; i++){
		current = $('tr.'+ i );
		if( current == null)break;
		//テーマNOが等しく、仕掛りでない
		if( $.trim(current.children('#themeNo').text()) == themeno && i != shikakari.attr('class') ){
			kroumuhi += Number(current.children('#mgKRoumuhi').text().replace(/,/g,''));
			mroumuhi += Number(current.children('#mgMRoumuhi').text().replace(/,/g,''));
			jroumuhi += Number(current.children('#mgJRoumuhi').text().replace(/,/g,''));
			kkousu += Number(current.children('#mgKKousu').text().replace(/,/g,''));
			mkousu += Number(current.children('#mgMKousu').text().replace(/,/g,''));
			jkousu += Number(current.children('#mgJKousu').children('input').val().replace(/,/g,''));
			kgaityu += Number(current.children('#mgKGaityu').text().replace(/,/g,''));
			mgaityu += Number(current.children('#mgMGaityu').text().replace(/,/g,''));
			jgaityu += Number(current.children('#mgJGaityu').children('input').val().replace(/,/g,''));
			kryohi += Number(current.children('#mgKRyohi').children('input').val().replace(/,/g,''));
			mryohi += Number(current.children('#mgMRyohi').children('input').val().replace(/,/g,''));
			jryohi += Number(current.children('#mgJRyohi').children('input').val().replace(/,/g,''));
			ksonota += Number(current.children('#mgKSonota').children('input').val().replace(/,/g,''));
			msonota += Number(current.children('#mgMSonota').children('input').val().replace(/,/g,''));
			jsonota += Number(current.children('#mgJSonota').children('input').val().replace(/,/g,''));
			kkeihi += Number(current.children('#mgKKeihi').text().replace(/,/g,''));
			mkeihi += Number(current.children('#mgMKeihi').text().replace(/,/g,''));
			jkeihi += Number(current.children('#mgJKeihi').text().replace(/,/g,''));
			ktotal += Number(current.children('#mgKTotal').text().replace(/,/g,''));
			mtotal += Number(current.children('#mgMTotal').text().replace(/,/g,''));
			jtotal += Number(current.children('#mgJTotal').text().replace(/,/g,''));
			kmgap += Number(current.children('#mgKMGap').text().replace(/,/g,''));
			kjgap += Number(current.children('#mgKJGap').text().replace(/,/g,''));
			//平均単価は実績単価の平均で、0の場合は平均の計算に含まない
			currentjtanka = Number(current.children('#mgJTanka').children('input').val().replace(/,/g,''));
			if( currentjtanka != 0 ){
				jtanka += currentjtanka;
				jtankacount++;
			}
			//原価計の計算
			//実績、見込、計画の優先度で、合計が0でない値を原価計として足し合わせていく
			currentktotal = Number(current.children('#mgKTotal').text().replace(/,/g,''))
			currentmtotal = Number(current.children('#mgMTotal').text().replace(/,/g,''))
			currentjtotal = Number(current.children('#mgJTotal').text().replace(/,/g,''))

			if(currentjtotal != 0){
				totalgenka += currentjtotal;
				current.children('#mgKTotal').css('background-color' , 'skyblue');
				current.children('#mgMTotal').css('background-color' , 'skyblue');
				current.children('#mgJTotal').css('background-color' , 'yellow');
			}
			else if(currentmtotal != 0){
				totalgenka += currentmtotal;
				current.children('#mgKTotal').css('background-color' , 'skyblue');
				current.children('#mgMTotal').css('background-color' , 'yellow');
				current.children('#mgJTotal').css('background-color' , 'skyblue');
			}
			else{
				totalgenka += currentktotal;
				current.children('#mgKTotal').css('background-color' , 'yellow');
				current.children('#mgMTotal').css('background-color' , 'skyblue');
				current.children('#mgJTotal').css('background-color' , 'skyblue');
			}

			//社員別工数、要員別外注費
			membersKKousu = getMembers(membersKKousu, current.children('#totalKKousu'));
			membersMKousu = getMembers(membersMKousu, current.children('#totalMKousu'));
			membersJKousu = getMembers(membersJKousu, current.children('#totalJKousu'));
			membersKMGap = getMembers(membersKMGap, current.children('#totalKMKousuGap'));
			membersKJGap = getMembers(membersKJGap, current.children('#totalKJKousuGap'));

		}
	}

	shikakari.children('#mgKRoumuhi').text(kroumuhi.toLocaleString());
	shikakari.children('#mgMRoumuhi').text(mroumuhi.toLocaleString());
	shikakari.children('#mgJRoumuhi').text(jroumuhi.toLocaleString());
	shikakari.children('#mgKKousu').text(kkousu.toLocaleString());
	shikakari.children('#mgMKousu').text(mkousu.toLocaleString());
	shikakari.children('#mgJKousu').text(jkousu.toLocaleString());
	shikakari.children('#mgKGaityu').text(kgaityu.toLocaleString());
	shikakari.children('#mgMGaityu').text(mgaityu.toLocaleString());
	shikakari.children('#mgJGaityu').text(jgaityu.toLocaleString());
	shikakari.children('#mgKRyohi').text(kryohi.toLocaleString());
	shikakari.children('#mgMRyohi').text(mryohi.toLocaleString());
	shikakari.children('#mgJRyohi').text(jryohi.toLocaleString());
	shikakari.children('#mgKSonota').text(ksonota.toLocaleString());
	shikakari.children('#mgMSonota').text(msonota.toLocaleString());
	shikakari.children('#mgJSonota').text(jsonota.toLocaleString());
	shikakari.children('#mgKKeihi').text(kkeihi.toLocaleString());
	shikakari.children('#mgMKeihi').text(mkeihi.toLocaleString());
	shikakari.children('#mgJKeihi').text(jkeihi.toLocaleString());
	shikakari.children('#mgKTotal').text(ktotal.toLocaleString());
	shikakari.children('#mgMTotal').text(mtotal.toLocaleString());
	shikakari.children('#mgJTotal').text(jtotal.toLocaleString());
	shikakari.children('#mgKMGap').text(kmgap.toLocaleString());
	shikakari.children('#mgKJGap').text(kjgap.toLocaleString());
	shikakari.children('#mgAvgTanka').text(((jtanka == 0) ? 0 : jtanka / jtankacount).toLocaleString(undefined, {minimumFractionDigits: 1}));
	//粗利・粗利率の計算
	uriage =  Number(shikakari.children('#mgUriage').text().replace(/,/g,''));
	arari = uriage - totalgenka;
	shikakari.children('#mgArari').text( ( arari ).toLocaleString());
	shikakari.children('#mgArariPer').text(((arari == 0) ? 0 : arari / uriage).toLocaleString(undefined, {minimumFractionDigits: 1}));
	//原価計
	shikakari.children('#mgTotalGenka').text(totalgenka.toLocaleString());

	//開発体制メンバー
	setMembers(membersKKousu, shikakari.children('#totalKKousu'))
	setMembers(membersMKousu, shikakari.children('#totalMKousu'))
	setMembers(membersJKousu, shikakari.children('#totalJKousu'))
	setMembers(membersKMGap, shikakari.children('#totalKMKousuGap'))
	setMembers(membersKJGap, shikakari.children('#totalKJKousuGap'))

	//calculatePjTotal();

}

//プロジェクトメンバ表の合計列のtdセレクタを受け取って、その行の値を格納していく
function getMembers(list, selector){
	//要素がなくなるまで繰り返し
	index = 0;
	while(selector[0]){
		//空白用のtdでない

		if(selector.attr('class') != 'space'){
			/*
			if((selector.attr('id')).toString().match(/Kousu/g) || selector.attr('id').match(/Cost/g)){}
			matchを利用したほうが厳密に判定できるが、attr()の引数が文字列でないためmatch()が利用できない。
			文字列変換を挟むのも面倒なのでとりあえず空白用のクラスspaceでないことを条件とする。
			*/
			//リストに要素がなければ追加、初期値は0
			if(!list[index])list.push(0);
			//input属性ならinputの値を、textならtextの中身を足し合わせる。
			if(selector.children('input')[0]){
				list[index] += Number(selector.children('input').val().replace(/,/g,''));
			}else{
				list[index] += Number(selector.text().replace(/,/g,''));
			}
			index++;
		}
		selector = selector.next('td');
	}
	return list;
}

function setMembers(list, selector){
	index = 0;
	while(selector[0]){
		if(selector.attr('class') != 'space'){//getメソッドと同上
			idStr = selector.attr('id');
			if(idStr.match(/Cost/g)) selector.text( list[index].toLocaleString() );
			if(idStr.match(/Kousu/g)) selector.text( list[index].toLocaleString(undefined, {minimumFractionDigits: 1}) );
			index++;
		}
		selector = selector.next('td');
	}
}
//pj合計を再計算する
function calculatePjTotal(){
/*----------------------------------------------------------------------------------------------------------------------------------*/
	//PJ合計
	//pj合計のtrのクラスは0
	pjTotal = $('tr.0');

	//計算結果を格納する変数
	kroumuhi = 0; mroumuhi = 0; jroumuhi = 0; kmgap = 0; kjgap = 0;
	kkousu = 0; mkousu = 0; jkousu = 0;
	kgaityu = 0; mgaityu = 0; jgaityu = 0;
	kryohi = 0; mryohi = 0; jryohi = 0; kuriage= 0; kavgtanka = 0;
	ksonota = 0; msonota = 0; jsonota = 0;
	kkeihi = 0; mkeihi = 0; jkeihi = 0;
	ktotal = 0; mtotal = 0; jtotal = 0; arari = 0; arariper = 0; totalgenka = 0;
	jtanka = 0; jtankacount = 0;
	membersKKousu = []; membersMKousu = []; membersJKousu = [];
	membersKMGap = []; membersKJGap = [];
		//仕掛り計の合計を計算するので、eachの対象は仕掛り計
		shikakariList = $('#themeNo.shikakari');
		for(i=0; i<shikakariList.length; i++){
			currentIndex = shikakariList.eq(i).parent('tr').attr('class');
			current = $('tr.'+ currentIndex);
			kroumuhi += Number(current.children('#mgKRoumuhi').text().replace(/,/g,''));
			mroumuhi += Number(current.children('#mgMRoumuhi').text().replace(/,/g,''));
			jroumuhi += Number(current.children('#mgJRoumuhi').text().replace(/,/g,''));
			kkousu += Number(current.children('#mgKKousu').text().replace(/,/g,''));
			mkousu += Number(current.children('#mgMKousu').text().replace(/,/g,''));
			jkousu += Number(current.children('#mgJKousu').text().replace(/,/g,''));
			kgaityu += Number(current.children('#mgKGaityu').text().replace(/,/g,''));
			mgaityu += Number(current.children('#mgMGaityu').text().replace(/,/g,''));
			jgaityu += Number(current.children('#mgJGaityu').text().replace(/,/g,''));
			kryohi += Number(current.children('#mgKRyohi').text().replace(/,/g,''));
			mryohi += Number(current.children('#mgMRyohi').text().replace(/,/g,''));
			jryohi += Number(current.children('#mgJRyohi').text().replace(/,/g,''));
			ksonota += Number(current.children('#mgKSonota').text().replace(/,/g,''));
			msonota += Number(current.children('#mgMSonota').text().replace(/,/g,''));
			jsonota += Number(current.children('#mgJSonota').text().replace(/,/g,''));
			kkeihi += Number(current.children('#mgKKeihi').text().replace(/,/g,''));
			mkeihi += Number(current.children('#mgMKeihi').text().replace(/,/g,''));
			jkeihi += Number(current.children('#mgJKeihi').text().replace(/,/g,''));
			ktotal += Number(current.children('#mgKTotal').text().replace(/,/g,''));
			mtotal += Number(current.children('#mgMTotal').text().replace(/,/g,''));
			jtotal += Number(current.children('#mgJTotal').text().replace(/,/g,''));
			kmgap += Number(current.children('#mgKMGap').text().replace(/,/g,''));
			kjgap += Number(current.children('#mgKJGap').text().replace(/,/g,''));
			//平均単価は実績単価の平均で、0の場合は平均の計算に含まない
			currentjtanka = Number(current.children('#mgJTanka').text().replace(/,/g,''));
			if( currentjtanka != 0 ){
				jtanka += currentjtanka;
				jtankacount++;
			}
			//原価計の計算
			//仕掛りテーブルでは原価計の計算が終了しているため、そのままで良い。
			totalgenka += Number(current.children('#mgTotalGenka').text().replace(/,/g,''))

			//社員別工数、要員別外注費
			membersKKousu = getMembers(membersKKousu, current.children('#totalKKousu'));
			membersMKousu = getMembers(membersMKousu, current.children('#totalMKousu'));
			membersJKousu = getMembers(membersJKousu, current.children('#totalJKousu'));
			membersKMGap = getMembers(membersKMGap, current.children('#totalKMKousuGap'));
			membersKJGap = getMembers(membersKJGap, current.children('#totalKJKousuGap'));

		}

	pjTotal.children('#mgKRoumuhi').text(kroumuhi.toLocaleString());
	pjTotal.children('#mgMRoumuhi').text(mroumuhi.toLocaleString());
	pjTotal.children('#mgJRoumuhi').text(jroumuhi.toLocaleString());
	pjTotal.children('#mgKKousu').text(kkousu.toLocaleString());
	pjTotal.children('#mgMKousu').text(mkousu.toLocaleString());
	pjTotal.children('#mgJKousu').text(jkousu.toLocaleString());
	pjTotal.children('#mgKGaityu').text(kgaityu.toLocaleString());
	pjTotal.children('#mgMGaityu').text(mgaityu.toLocaleString());
	pjTotal.children('#mgJGaityu').text(jgaityu.toLocaleString());
	pjTotal.children('#mgKRyohi').text(kryohi.toLocaleString());
	pjTotal.children('#mgMRyohi').text(mryohi.toLocaleString());
	pjTotal.children('#mgJRyohi').text(jryohi.toLocaleString());
	pjTotal.children('#mgKSonota').text(ksonota.toLocaleString());
	pjTotal.children('#mgMSonota').text(msonota.toLocaleString());
	pjTotal.children('#mgJSonota').text(jsonota.toLocaleString());
	pjTotal.children('#mgKKeihi').text(kkeihi.toLocaleString());
	pjTotal.children('#mgMKeihi').text(mkeihi.toLocaleString());
	pjTotal.children('#mgJKeihi').text(jkeihi.toLocaleString());
	pjTotal.children('#mgKTotal').text(ktotal.toLocaleString());
	pjTotal.children('#mgMTotal').text(mtotal.toLocaleString());
	pjTotal.children('#mgJTotal').text(jtotal.toLocaleString());
	pjTotal.children('#mgKMGap').text(kmgap.toLocaleString());
	pjTotal.children('#mgKJGap').text(kjgap.toLocaleString());
	pjTotal.children('#mgAvgTanka').text(((jtanka == 0) ? 0 : jtanka / jtankacount).toLocaleString(undefined, {minimumFractionDigits: 1}));
	//粗利・粗利率の計算
	uriage =  Number(pjTotal.children('#mgUriage').text().replace(/,/g,''));
	arari = uriage - totalgenka;
	pjTotal.children('#mgArari').text( ( arari ).toLocaleString());
	pjTotal.children('#mgArariPer').text(((arari == 0) ? 0 : arari / uriage).toLocaleString(undefined, {minimumFractionDigits: 1}));
	//原価計
	pjTotal.children('#mgTotalGenka').text(totalgenka.toLocaleString());

	//開発体制メンバー
	setMembers(membersKKousu, pjTotal.children('#totalKKousu'))
	setMembers(membersMKousu, pjTotal.children('#totalMKousu'))
	setMembers(membersJKousu, pjTotal.children('#totalJKousu'))
	setMembers(membersKMGap, pjTotal.children('#totalKMKousuGap'))
	setMembers(membersKJGap, pjTotal.children('#totalKJKousuGap'))

}

function checkUpdate(){
	ans = confirm('入力した内容で更新します');
	if(ans == true){
		setHiddenInputValue();
		return true;
	}else return false;

}

document.onkeydown = KeyEvent;
function KeyEvent(e){
    var pressKey=event.keyCode;
    if(pressKey == 13) {
	return false;
    }
}
function hideDiv(divId, obj){
	if(obj.value=='非表示'){
		obj.value='表示';
		document.getElementById(divId).style.display='none';
	}else{
		obj.value='非表示';
		document.getElementById(divId).style.display='block';
	}
	initializeUnfixedHeight();
}

function initializeUnfixedHeight(){
	$('div.fixed').css('top', $('div.header').height());
	$('div.unfixed').css('top', $('div.fixed').offset().top + $('div.fixed').height());
	//$('div.list-body').css('top', $('div.list-header').offset().top + $('div.list-header').height());
}

function checkMoney(obj){
	str = obj.value.replace(/,/g,'');
	if(str==''){
		obj.value='0';
		return;
	}
	number = Number(str);
	if(isInteger(number)==true && number >= 0){
		obj.value=number.toLocaleString();
		calculate(obj);
		calculatePjTotal();
		return;
	}
	window.alert('金額は正の整数でなければいけません。入力し直して下さい。');
	obj.value='0';
}
function isInteger(x) {
	return Math.round(x) === x;
	/*
	 > isInteger(1)
	true
	> isInteger(0)
	true
	> isInteger(1.111)
	false
	> isInteger("1")
	false
	> isInteger("")
	false
	> isInteger(null)
	false
	> isInteger(NaN)
	false
	> isInteger(undefined)
	false
	*/
}


function checkKousu(obj){
	str = obj.value;
	if(str==''){
		obj.value='0.0';
		return;
	}
	if(str.match(/^([1-9]\d*|0)(\.\d)$/g)){
		calculate(obj);
		calculatePjTotal();
		return;
	}
	number = Number(str);
	if(isInteger(number)==true && number >= 0){
		obj.value = number.toLocaleString(undefined, {minimumFractionDigits: 1});
		calculate(obj);
		calculatePjTotal();
		return;
	}
	window.alert('工数は小数第一位までの数値のみ有効です。入力し直して下さい。\n【受け付ける数値例】1,10.0,65.5');
	obj.value='0.0';
}

//append-hidden属性を持つtdの内容をフォームに送信するために、hiddenタグをappend（htmlを書き込み）していく。
//このメソッドでまかない切れないinput属性（社員別工数の社員番号、各テーブルのid属性など）はjspの時点でべた書きしている。
//基本的に、tdのtextをそのままvalueに出来てmapItemsItems[][]のインデックスをタグ情報から指定できればここでなんとかなる。
function setHiddenInputValue(){
	tagList = $('.apppend-hidden');
	for(i=0; i<tagList.length; i++){
		tag = tagList.eq(i);
		hidden = '<input type="hidden"'
				+' name="mapItemsItems['+ tag.parent('tr').attr('class') +'][0].'+ tag.attr('id').substr(2)
				+'" value="'+ tag.text() +'" />'
		tag.append(hidden);
	}

 }

</script>
<title>${pageName}</title>
</head>
<body>

<div id="loading">
読み込み中...
</div>
<div id="main-contents">

	<div class="header" id="header">
	${sysName} / ${pageName}
	</div>
<s:form>
	<div class="fixed" id="fixed">
		<c:if test="${!empty errMessage}">
			<div class="error">
			${errMessage}
			</div>
		</c:if>

		<html:errors/>

		<c:if test="${!empty sysMessage}">
			<div class="message">
			${sysMessage}
			</div>
		</c:if>
		<div class="space"></div>

		<table border="1" id="gkTable">
			<tr>
				<th class="sub">テーマ親番</th>
				<th class="sub" colspan="5" style="text-align: left;">テーマNO</th>
			</tr>
			<tr>
				<td class="no-input" style="text-align: center;">${f:h(gk.themeGroup)}</td>
				<td class="no-input" colspan="5" style="text-align: left;">${f:h(gk.themeNo)}</td>
			</tr>
			<tr>
				<th class="sub">テーマ名</th>
				<td class="no-input" colspan="5" style="text-align: left;">${f:h(gk.themeName)}</td>
			</tr>
			<tr>
				<th class="sub">受注額</th>
				<td class="no-input"><fmt:formatNumber value="${f:h(gk.jutyugaku)}" /></td>
				<th class="sub">着手月</th>
				<td class="no-input">${f:h(gk.tyakusyuMonth)}</td>
				<th class="sub">納期</th>
				<td class="no-input">${f:h(gk.nouki)}</td>
			</tr>
		</table>
		<input type="button" onclick="location.href='../gkCreate/?gkId=${gk.gkId }'" value="基本情報を修正" class="normal" />
		<html:submit property="/ukList/" value="売上計画内訳" styleClass="normal" />
		<html:submit property="showBikou" value="備考・状況報告" styleClass="normal" />
		<html:submit property="update" value="原価情報を更新" styleClass="update" onclick="return checkUpdate();" />
		<div class="space"></div>
	</div>

	<div class="unfixed" id="unfixed">
		<table border="1">
		<c:forEach var="mapItems" varStatus="s" items="${mapItemsItems}">
		    <c:forEach var="m" varStatus="s2" items="${mapItems}" begin="0" end="0">

		    <%--
		    idとその他入力の必要ない属性をhiddenで設定
		     --%>
			<html:hidden property="mapItemsItems[${s.index }][0].monthlyGenkaId" value="${m.monthlyGenkaId }" />
			<html:hidden property="mapItemsItems[${s.index }][0].themeNo" value="${m.themeNo }" />
			<html:hidden property="mapItemsItems[${s.index }][0].themeGroup" value="${m.themeGroup }" />
			<html:hidden property="mapItemsItems[${s.index }][0].nendo" value="${m.nendo }" />
			<html:hidden property="mapItemsItems[${s.index }][0].month" value="${m.month }" />
			<html:hidden property="mapItemsItems[${s.index }][0].gkConditionCode" value="${m.gkConditionCode }" />

		    <%--
		    **************************************************************
		    月別原価情報の場合
		     --%>
	<c:if test="${m.gkConditionCode==401 }">

			<%--
			社員別原価と外注別費用の更新用idをhiddenで格納
			idがない場合は空白入力となり、この場合は必須項目を設定してinsert対象となる。
			 --%>
			<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
				<html:hidden property="mapItemsItems[${s.index }][${s3.index }].emkId" value="${kt.emkId }" />
				<html:hidden property="mapItemsItems[${s.index }][${s3.index }].empNo" value="${kt.empNo }" />
				<html:hidden property="mapItemsItems[${s.index }][${s3.index }].gaityuFlag" value="${kt.gaityuFlag }" />
			</c:forEach>

		    <tr class="${s.index}">
		    	<th colspan="4" id='themeNo'>${f:h(m.themeNo)}
		        </th>
		    </tr>
		    <tr class="${s.index}">
		    	<th>${f:h(m.nendo)} / ${f:h(m.month)}</th>
		        <th class="sub">計画</th>
				<th class="sub">見込</th>
				<th class="sub">実績</th>
				<td class="space"></td>
				<th class="sub">計画/見込<br />差異</th>
				<th class="sub">計画/実績<br />差異</th>
				<td class="space"></td>
				<th class="sub">プロジェクト<br />メンバー</th>
				<th class="sub">合計</th>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
				<c:if test="${kt.gaityuFlag==0 }">
					<th class="sub">${kt.shortEmpName }</th>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
				<c:if test="${kt.gaityuFlag==1 }">
					<th class="sub">${kt.shortEmpName }</th>
				</c:if>
				</c:forEach>
		    </tr>
		    <tr class="${s.index}">
		    	<th class="sub">労務費</th>
		    	<td class="no-input apppend-hidden" id="mgKRoumuhi"><%--<fmt:formatNumber value="${f:h(m.KRoumuhi)}" /> --%>
		    	<fmt:formatNumber value="${f:h(m.KRoumuhi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KRoumuhi" value="${m.KRoumuhi }" styleId="hiddenKRoumuhi" />
		    	</td>
		    	<td class="no-input  apppend-hidden" id="mgMRoumuhi"><fmt:formatNumber value="${f:h(m.MRoumuhi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MRoumuhi" value="${m.MRoumuhi }" styleId="hiddenMRoumuhi" />
		    	</td>
		    	<td class="no-input  apppend-hidden" id="mgJRoumuhi"><fmt:formatNumber value="${f:h(m.JRoumuhi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JRoumuhi" value="${m.JRoumuhi }" styleId="hiddenJRoumuhi"/>
		    	</td>
				<td class="space"></td>
				<td class="no-input  apppend-hidden" id="mgKMGap"><fmt:formatNumber value="${f:h(m.KMGap)}" />
				<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KMGap" value="${m.KMGap }" styleId="hiddenKMGap"/>
				</td>
				<td class="no-input  apppend-hidden" id="mgKJGap"><fmt:formatNumber value="${f:h(m.KJGap)}" />
				<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KJGap" value="${m.KJGap }" styleId="hiddenKJGap"/>
				</td>
				<td class="space"></td>
		    	<th class="sub">計画</th>
		    	<td class="no-input" id="totalKKousu">計算中</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="input" id="KKousu[${s3.index }]">
					<fmt:formatNumber var="KKousu" pattern="###,##0.0" value="${f:h(kt.KKousu)}" />
					<html:text property="mapItemsItems[${s.index}][${s3.index}].KKousu"
					value="${KKousu}" onblur="checkKousu(this)" />
					</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<%--外注費は本来Costだけど、java側の処理上マップのキーをKousuにしている --%>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==1 }">
					<td class="input" id="KCost[${s3.index }]">
					<fmt:formatNumber var="KKousu" value="${f:h(kt.KKousu)}" />
					<html:text property="mapItemsItems[${s.index}][${s3.index}].KKousu"
					value="${KKousu}" onblur="checkMoney(this)" />
					</td>
				</c:if>
				</c:forEach>
		    </tr>
		    <tr class="${s.index}">
		    	<th class="sub">工数</th>
		    	<td class="no-input  apppend-hidden" id="mgKKousu"><fmt:formatNumber pattern="###,##0.0" value="${f:h(m.KKousu)}"/>
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KKousu" value="${m.KKousu }" styleId="hiddenKKousu" />
		    	</td>
		    	<td class="no-input  apppend-hidden" id="mgMKousu"><fmt:formatNumber pattern="###,##0.0" value="${f:h(m.MKousu)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MKousu" value="${m.MKousu }" styleId="hiddenKKousu" />
		    	</td>
		    	<td class="input" id="mgJKousu">
		    	<fmt:formatNumber var="JKousu" pattern="###,##0.0" value="${f:h(m.JKousu)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].JKousu"
				value="${JKousu}" onblur="checkKousu(this)" />
				</td>
				<td class="space"></td>
				<td class="space"></td>
				<td class="space"></td>
				<td class="space"></td>
		    	<th class="sub">見込</th>
		    	<td class="no-input" id="totalMKousu">計算中</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="input">
					<fmt:formatNumber var="MKousu" pattern="###,##0.0" value="${f:h(kt.MKousu)}" />
					<html:text property="mapItemsItems[${s.index}][${s3.index}].MKousu"
					value="${MKousu}" onblur="checkKousu(this)" />
					</td>
				</c:if>
				</c:forEach>
				<td class="space" id="MKousu[${s3.index }]"></td>
				<%--外注費は本来Costだけど、java側の処理上マップのキーをKousuにしている --%>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==1 }">
					<td class="input" id="MCost[${s3.index }]">
					<fmt:formatNumber var="MKousu" value="${f:h(kt.MKousu)}" />
					<html:text property="mapItemsItems[${s.index}][${s3.index}].MKousu"
					value="${MKousu}" onblur="checkMoney(this)" />
					</td>
				</c:if>
				</c:forEach>
		    </tr>
		    <tr class="${s.index}">
		    	<th class="sub">単価</th>
		    	<td class="no-input" id="mgKTanka"><fmt:formatNumber value="${f:h(m.KTanka)}" /></td>
		    	<td class="input" id="mgMTanka">
		    	<fmt:formatNumber var="MTanka" pattern="###,##0" value="${f:h(m.MTanka)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].MTanka"
				value="${MTanka}" onblur="checkMoney(this)" />
				</td>
				<td class="input" id="mgJTanka">
		    	<fmt:formatNumber var="JTanka" pattern="###,##0" value="${f:h(m.JTanka)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].JTanka"
				value="${JTanka}" onblur="checkMoney(this)" />
				</td>
				<td class="space"></td>
				<td class="space"></td>
				<td class="space"></td>
				<td class="space"></td>
		    	<th class="sub">実績</th>
		    	<td class="no-input" id="totalJKousu">計算中</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="input" id="JKousu[${s3.index }]">
					<fmt:formatNumber var="JKousu" pattern="###,##0.0" value="${f:h(kt.JKousu)}" />
					<html:text property="mapItemsItems[${s.index}][${s3.index}].JKousu"
					value="${JKousu}" onblur="checkKousu(this)" />
					</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<%--外注費は本来Costだけど、java側の処理上マップのキーをKousuにしている --%>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==1 }">
					<td class="input" id="JCost[${s3.index }]">
					<fmt:formatNumber var="JKousu" value="${f:h(kt.JKousu)}" />
					<html:text property="mapItemsItems[${s.index}][${s3.index}].JKousu"
					value="${JKousu}" onblur="checkMoney(this)" />
					</td>
				</c:if>
				</c:forEach>
		    </tr>

		    <tr class="${s.index}">
		    	<th class="sub">外注加工費</th>
		    	<td class="no-input  apppend-hidden" id="mgKGaityu"><fmt:formatNumber value="${f:h(m.KGaityu)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KGaityu" value="${m.KGaityu }" styleId="hiddenKGaityu"/>
		    	</td>
		    	<td class="no-input  apppend-hidden" id="mgMGaityu"><fmt:formatNumber value="${f:h(m.MGaityu)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MGaityu" value="${m.MGaityu }" styleId="hiddenMGaityu"/>
		    	</td>
		    	<td class="input" id="mgJGaityu">
		    	<fmt:formatNumber var="JGaityu" pattern="###,##0" value="${f:h(m.JGaityu)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].JGaityu"
				value="${JGaityu}" onblur="checkMoney(this)" />
				</td>
				<td class="space"></td>
				<td class="space"></td>
				<td class="space"></td>
				<td class="space"></td>
		    	<th class="sub">計/見 差異</th>
		    	<td class="no-input" id="totalKMKousuGap">計算中</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="no-input" id="KMKousuGap">
					<fmt:formatNumber pattern="###,##0.0" value="${kt.KKousu - kt.MKousu }" />
					</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
				<c:if test="${kt.gaityuFlag==1 }">
					<td class="no-input" id="KMCostGap">
					<fmt:formatNumber value="${kt.KKousu - kt.MKousu }" />
					</td>
				</c:if>
				</c:forEach>
		    </tr>

		    <tr class="${s.index}">
		    	<th class="sub">旅費交通費</th>
		    	<td class="input" id="mgKRyohi">
		    	<fmt:formatNumber var="KRyohi" pattern="###,##0" value="${f:h(m.KRyohi)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].KRyohi"
				value="${KRyohi}" onblur="checkMoney(this)" />
				</td>
		    	<td class="input" id="mgMRyohi">
		    	<fmt:formatNumber var="MRyohi" pattern="###,##0" value="${f:h(m.MRyohi)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].MRyohi"
				value="${MRyohi}" onblur="checkMoney(this)" />
				</td>
		    	<td class="input" id="mgJRyohi">
		    	<fmt:formatNumber var="JRyohi" pattern="###,##0" value="${f:h(m.JRyohi)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].JRyohi"
				value="${JRyohi}" onblur="checkMoney(this)" />
				</td>
				<td class="space"></td>
				<td class="space"></td>
				<td class="space"></td>
				<td class="space"></td>
		    	<th class="sub">計/実 差異</th>
		    	<td class="no-input" id="totalKJKousuGap">計算中</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="no-input" id="KJKousuGap[${s3.index }]">
					<fmt:formatNumber pattern="###,##0.0" value="${kt.KKousu - kt.JKousu }" />
					</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
				<c:if test="${kt.gaityuFlag==1 }">
					<td class="no-input" id="KJCostGap[${s3.index }]">
					<fmt:formatNumber value="${kt.KKousu - kt.JKousu }" />
					</td>
				</c:if>
				</c:forEach>
		    </tr>

		    <tr class="${s.index}">
		    	<th class="sub">その他経費</th>
		    	<td class="input" id="mgKSonota">
		    	<fmt:formatNumber var="KSonota" pattern="###,##0" value="${f:h(m.KSonota)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].KSonota"
				value="${KSonota}" onblur="checkMoney(this)" />
				</td>
		    	<td class="input" id="mgMSonota">
		    	<fmt:formatNumber var="MSonota" pattern="###,##0" value="${f:h(m.MSonota)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].MSonota"
				value="${MSonota}" onblur="checkMoney(this)" />
				</td>
		    	<td class="input" id="mgJSonota">
		    	<fmt:formatNumber var="JSonota" pattern="###,##0" value="${f:h(m.JSonota)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].JSonota"
				value="${JSonota}" onblur="checkMoney(this)" />
				</td>
		    </tr>

		    <tr class="${s.index}">
		    	<th class="sub">経費合計</th>
		    	<td class="no-input  apppend-hidden" id="mgKKeihi"><fmt:formatNumber value="${f:h(m.KKeihi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KKeihi" value="${m.KKeihi }" styleId="hiddenKKeihi" />
		    	</td>
		    	<td class="no-input  apppend-hidden" id="mgMKeihi"><fmt:formatNumber value="${f:h(m.MKeihi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MKeihi" value="${m.MKeihi }" styleId="hiddenMKeihi" />
		    	</td>
		    	<td class="no-input  apppend-hidden" id="mgJKeihi"><fmt:formatNumber value="${f:h(m.JKeihi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JKeihi" value="${m.JKeihi }" styleId="hiddenJKeihi" />
		    	</td>
		    </tr>

		    <tr class="${s.index}">
		    	<th class="sub">合計</th>
		    	<td class="no-input  apppend-hidden" id="mgKTotal"><fmt:formatNumber value="${f:h(m.KSum)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KSum" value="${m.KSum }" styleId="hiddenKTotal" />
		    	</td>
		    	<td class="no-input  apppend-hidden" id="mgMTotal"><fmt:formatNumber value="${f:h(m.MSum)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MSum" value="${m.MSum }" styleId="hiddenMTotal" />
		    	</td>
		    	<td class="no-input  apppend-hidden" id="mgJTotal"><fmt:formatNumber value="${f:h(m.JSum)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JSum" value="${m.JSum }" styleId="hiddenJTotal" />
		    	</td>
		    </tr>
	</c:if>

		    <%--
		    **************************************************************
		    プロジェクト合計の場合
		     --%>
	<c:if test="${m.gkConditionCode==403 }">
		    <tr class="${s.index}">
		    	<th>プロジェクト合計</th>
		        <th class="sub">計画</th>
				<th class="sub">見込</th>
				<th class="sub">実績</th>
				<td class="space"></td>
				<th class="sub">計画/見込<br />差異</th>
				<th class="sub">計画/実績<br />差異</th>
				<td class="space"></td>
				<th class="sub">プロジェクト<br />メンバー</th>
				<th class="sub">合計</th>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
				<c:if test="${kt.gaityuFlag==0 }">
					<th class="sub">${kt.shortEmpName }</th>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
				<c:if test="${kt.gaityuFlag==1 }">
					<th class="sub">${kt.shortEmpName }</th>
				</c:if>
				</c:forEach>
		    </tr>
		    <tr class="${s.index}">
		    	<th class="sub">労務費</th>
		    	<td class="no-input  apppend-hidden" id="mgKRoumuhi"><fmt:formatNumber value="${f:h(m.KRoumuhi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KRoumuhi" value="${m.KRoumuhi }" styleId="hiddenKRoumuhi"/>
		    	</td>
		    	<td class="no-input  apppend-hidden" id="mgMRoumuhi"><fmt:formatNumber value="${f:h(m.MRoumuhi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MRoumuhi" value="${m.MRoumuhi }" styleId="hiddenMRoumuhi"/>
		    	</td>
		    	<td class="no-input  apppend-hidden" id="mgJRoumuhi"><fmt:formatNumber value="${f:h(m.JRoumuhi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JRoumuhi" value="${m.JRoumuhi }" styleId="hiddenJRoumuhi"/>
		    	</td>
				<td class="space"></td>
				<td class="no-input  apppend-hidden" id="mgKMGap"><fmt:formatNumber value="${f:h(m.KMGap)}" />
				<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KMGap" value="${m.KMGap }" styleId="hiddenKMGap"/>
				</td>
				<td class="no-input  apppend-hidden" id="mgKJGap"><fmt:formatNumber value="${f:h(m.KJGap)}" />
				<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KJGap" value="${m.KJGap }" styleId="hiddenKJGap"/>
				</td>
				<td class="space"></td>
		    	<th class="sub">計画</th>
		    	<td class="no-input" id="totalKKousu">計算中</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="no-input" id="KKousu[${s3.index }]">計算中</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==1 }">
					<td class="no-input" id="KCost[${s3.index }]">計算中</td>
				</c:if>
				</c:forEach>
		    </tr>
		    <tr class="${s.index}">
		    	<th class="sub">工数</th>
		    	<td class="no-input  apppend-hidden" id="mgKKousu"><fmt:formatNumber pattern="###,##0.0" value="${f:h(m.KKousu)}"/>
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KKousu" value="${m.KKousu }" styleId="hiddenKKousu"/>
		    	</td>
		    	<td class="no-input  apppend-hidden" id="mgMKousu"><fmt:formatNumber pattern="###,##0.0" value="${f:h(m.MKousu)}"/>
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MKousu" value="${m.MKousu }" styleId="hiddenMKousu" />
		    	</td>
		    	<td class="no-input  apppend-hidden" id="mgJKousu"><fmt:formatNumber pattern="###,##0.0" value="${f:h(m.JKousu)}"/>
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JKousu" value="${m.JKousu }" styleId="hiddenJKousu" />
		    	</td>
				<td class="space"></td>
				<th class="sub">売上金額</th>
				<th class="sub">平均単価</th>
				<td class="space"></td>
		    	<th class="sub">見込</th>
		    	<td class="no-input" id="totalMKousu">計算中</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="no-input" id="MKousu[${s3.index }]">計算中</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==1 }">
					<td class="no-input" id="MCost[${s3.index }]">計算中</td>
				</c:if>
				</c:forEach>
		    </tr>
		    <tr class="${s.index}">
		    	<th class="sub">外注加工費</th>
		    	<td class="no-input  apppend-hidden" id="mgKGaityu"><fmt:formatNumber value="${f:h(m.KGaityu)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KGaityu" value="${m.KGaityu }" styleId="hiddenKGaityu" />
		    	</td>
		    	<td class="no-input  apppend-hidden" id="mgMGaityu"><fmt:formatNumber value="${f:h(m.MGaityu)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MGaityu" value="${m.MGaityu }" styleId="hiddenMGaityu" />
		    	</td>
		    	<td class="no-input  apppend-hidden" id="mgJGaityu"><fmt:formatNumber value="${f:h(m.JGaityu)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JGaityu" value="${m.JGaityu }" styleId="hiddenJGaityu" />
		    	</td>
				<td class="space"></td>
				<td class="no-input" id="mgUriage"><fmt:formatNumber value="${f:h(m.uriage)}" /></td>
				<td class="no-input  apppend-hidden" id="mgAvgTanka"><fmt:formatNumber pattern="###,##0.0" value="${f:h(m.JTanka)}" />
				<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JTanka" value="${m.JTanka }" styleId="hiddenAvgTanka"/>
				</td>
				<td class="space"></td>
		    	<th class="sub">実績</th>
		    	<td class="no-input" id="totalJKousu">計算中</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="no-input" id="JKousu[${s3.index }]">計算中</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==1 }">
					<td class="no-input" id="JCost[${s3.index }]">計算中</td>
				</c:if>
				</c:forEach>
		    </tr>

		    <tr class="${s.index}">
		    	<th class="sub">旅費交通費</th>
		    	<td class="no-input  apppend-hidden" id="mgKRyohi"><fmt:formatNumber value="${f:h(m.KRyohi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KRyohi" value="${m.KRyohi }" styleId="hiddenKRyohi"/>
		    	</td>
		    	<td class="no-input  apppend-hidden" id="mgMRyohi"><fmt:formatNumber value="${f:h(m.MRyohi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MRyohi" value="${m.MRyohi }" styleId="hiddenMRyohi"/>
		    	</td>
		    	<td class="no-input  apppend-hidden" id="mgJRyohi"><fmt:formatNumber value="${f:h(m.JRyohi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JRyohi" value="${m.JRyohi }" styleId="hiddenJRyohi"/>
		    	</td>
				<td class="space"></td>
				<th class="sub">粗利金額</th>
				<th class="sub">粗利率</th>
				<td class="space"></td>
		    	<th class="sub">計/見 差異</th>
		    	<td class="no-input" id="totalKMKousuGap">計算中</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="no-input"  id="KMKousuGap">計算中</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==1 }">
					<td class="no-input" id="KMCostGap">計算中</td>
				</c:if>
				</c:forEach>
		    </tr>

		    <tr class="${s.index}">
		    	<th class="sub">その他経費</th>
		    	<td class="no-input  apppend-hidden" id="mgKSonota"><fmt:formatNumber value="${f:h(m.KSonota)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KSonota" value="${m.KSonota }" styleId="hiddenKSonota"/>
		    	</td>
		    	<td class="no-input  apppend-hidden" id="mgMSonota"><fmt:formatNumber value="${f:h(m.MSonota)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MSonota" value="${m.MSonota }" styleId="hiddenMSonota"/>
		    	</td>
		    	<td class="no-input  apppend-hidden" id="mgJSonota"><fmt:formatNumber value="${f:h(m.JSonota)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JSonota" value="${m.JSonota }" styleId="hiddenJSonota"/>
		    	</td>
				<td class="space"></td>
				<td class="no-input apppend-hidden" id="mgArari"><fmt:formatNumber value="${f:h(m.uriage - m.JSum)}" /></td>
				<td class="no-input apppend-hidden" id="mgArariPer"><fmt:formatNumber pattern="###,##0.0"
				value="${f:h(m.JSum==0 ? 0 : m.JSum / (m.uriage - m.JSum))}" /></td>
				<td class="space"></td>
		    	<th class="sub">計/実 差異</th>
		    	<td class="no-input" id="totalKJKousuGap">計算中</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="no-input" id="KJKousuGap[${s3.index }]">計算中</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==1 }">
					<td class="no-input" id="KJCostGap[${s3.index }]">計算中</td>
				</c:if>
				</c:forEach>
		    </tr>

		    <tr class="${s.index}">
		    	<th class="sub">経費合計</th>
		    	<td class="no-input  apppend-hidden" id="mgKKeihi"><fmt:formatNumber value="${f:h(m.KKeihi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KKeihi" value="${m.KKeihi }" styleId="hiddenKKeihi"/>
		    	</td>
		    	<td class="no-input  apppend-hidden" id="mgMKeihi"><fmt:formatNumber value="${f:h(m.MKeihi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MKeihi" value="${m.MKeihi }" styleId="hiddenMKeihi"/>
		    	</td>
		    	<td class="no-input  apppend-hidden" id="mgJKeihi"><fmt:formatNumber value="${f:h(m.JKeihi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JKeihi" value="${m.JKeihi }" styleId="hiddenJKeihi"/>
		    	</td>
		    	<td class="space"></td>
		    	<th class="sub" style="background-color: yellow;">原価計</th>
		    </tr>

		    <tr class="${s.index}">
		    	<th class="sub">合計</th>
		    	<td class="no-input  apppend-hidden" id="mgKTotal"><fmt:formatNumber value="${f:h(m.KSum)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KSum" value="${m.KSum }" styleId="hiddenKTotal"/>
		    	</td>
		    	<td class="no-input  apppend-hidden" id="mgMTotal"><fmt:formatNumber value="${f:h(m.MSum)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MSum" value="${m.MSum }" styleId="hiddenMTotal"/>
		    	</td>
		    	<td class="no-input  apppend-hidden" id="mgJTotal"><fmt:formatNumber value="${f:h(m.JSum)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JSum" value="${m.JSum }" styleId="hiddenJTotal"/>
		    	</td>
		    	<td class="space"></td>
		    	<td class="no-input" id="mgTotalGenka" style="background-color: yellow;">計算中</td>
		    </tr>
	</c:if>


		    <%--
		    **************************************************************
		    仕掛り計の場合
		     --%>
	<c:if test="${m.gkConditionCode==402 }">
		    <tr class="${s.index}">
		    	<th class="shikakari" colspan="4" id="themeNo">${f:h(m.themeNo)}
		        </th>
		    </tr>
		    <tr class="${s.index}">
		    	<th class="shikakari">${f:h(m.nendo)} / ${f:h(m.month)}</th>
		        <th class="shikakari-sub">計画</th>
				<th class="shikakari-sub">見込</th>
				<th class="shikakari-sub">実績</th>
				<td class="space"></td>
				<th class="shikakari-sub">計画/見込<br />差異</th>
				<th class="shikakari-sub">計画/実績<br />差異</th>
				<td class="space"></td>
				<th class="shikakari-sub">プロジェクト<br />メンバー</th>
				<th class="shikakari-sub">合計</th>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
				<c:if test="${kt.gaityuFlag==0 }">
					<th class="shikakari-sub">${kt.shortEmpName }</th>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
				<c:if test="${kt.gaityuFlag==1 }">
					<th class="shikakari-sub">${kt.shortEmpName }</th>
				</c:if>
				</c:forEach>
		    </tr>
		    <tr class="${s.index}">
		    	<th class="shikakari-sub">労務費</th>
		    	<td class="shikakari-no-input  apppend-hidden" id="mgKRoumuhi"><fmt:formatNumber value="${f:h(m.KRoumuhi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KRoumuhi" value="${m.KRoumuhi }" styleId="hiddenKRoumuhi"/>
		    	</td>
		    	<td class="shikakari-no-input  apppend-hidden" id="mgMRoumuhi"><fmt:formatNumber value="${f:h(m.MRoumuhi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MRoumuhi" value="${m.MRoumuhi }" styleId="hiddenMRoumuhi"/>
		    	</td>
		    	<td class="shikakari-no-input  apppend-hidden" id="mgJRoumuhi"><fmt:formatNumber value="${f:h(m.JRoumuhi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JRoumuhi" value="${m.JRoumuhi }" styleId="hiddenJRoumuhi"/>
		    	</td>
				<td class="space"></td>
				<td class="shikakari-no-input  apppend-hidden" id="mgKMGap"><fmt:formatNumber value="${f:h(m.KMGap)}" />
				<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KMGap" value="${m.KMGap }" styleId="hiddenKMGap"/>
				</td>
				<td class="shikakari-no-input  apppend-hidden" id="mgKJGap"><fmt:formatNumber value="${f:h(m.KJGap)}" />
				<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KJGap" value="${m.KJGap }" styleId="hiddenKJGap"/>
				</td>
				<td class="space"></td>
		    	<th class="shikakari-sub">計画</th>
		    	<td class="shikakari-no-input" id="totalKKousu">計算中</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="shikakari-no-input" id="KKousu[${s3.index }]">計算中</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==1 }">
					<td class="shikakari-no-input" id="KCost[${s3.index }]">計算中</td>
				</c:if>
				</c:forEach>
		    </tr>
		    <tr class="${s.index}">
		    	<th class="shikakari-sub">工数</th>
		    	<td class="shikakari-no-input  apppend-hidden" id="mgKKousu"><fmt:formatNumber pattern="###,##0.0" value="${f:h(m.KKousu)}"/>
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KKousu" value="${m.KKousu }" styleId="hiddenKKousu"/>
		    	</td>
		    	<td class="shikakari-no-input  apppend-hidden" id="mgMKousu"><fmt:formatNumber pattern="###,##0.0" value="${f:h(m.MKousu)}"/>
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MKousu" value="${m.MKousu }" styleId="hiddenMKousu" />
		    	</td>
		    	<td class="shikakari-no-input  apppend-hidden" id="mgJKousu"><fmt:formatNumber pattern="###,##0.0" value="${f:h(m.JKousu)}"/>
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JKousu" value="${m.JKousu }" styleId="hiddenJKousu" />
		    	</td>
				<td class="space"></td>
				<th class="shikakari-sub">売上金額</th>
				<th class="shikakari-sub">平均単価</th>
				<td class="space"></td>
		    	<th class="shikakari-sub">見込</th>
		    	<td class="shikakari-no-input" id="totalMKousu">計算中</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="shikakari-no-input" id="MKousu[${s3.index }]">計算中</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==1 }">
					<td class="shikakari-no-input" id="MCost[${s3.index }]">計算中</td>
				</c:if>
				</c:forEach>
		    </tr>
		    <tr class="${s.index}">
		    	<th class="shikakari-sub">外注加工費</th>
		    	<td class="shikakari-no-input  apppend-hidden" id="mgKGaityu"><fmt:formatNumber value="${f:h(m.KGaityu)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KGaityu" value="${m.KGaityu }" styleId="hiddenKGaityu" />
		    	</td>
		    	<td class="shikakari-no-input  apppend-hidden" id="mgMGaityu"><fmt:formatNumber value="${f:h(m.MGaityu)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MGaityu" value="${m.MGaityu }" styleId="hiddenMGaityu" />
		    	</td>
		    	<td class="shikakari-no-input  apppend-hidden" id="mgJGaityu"><fmt:formatNumber value="${f:h(m.JGaityu)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JGaityu" value="${m.JGaityu }" styleId="hiddenJGaityu" />
		    	</td>
				<td class="space"></td>
				<td class="shikakari-no-input" id="mgUriage"><fmt:formatNumber value="${f:h(m.uriage)}" /></td>
				<td class="shikakari-no-input  apppend-hidden" id="mgAvgTanka"><fmt:formatNumber pattern="###,##0.0" value="${f:h(m.JTanka)}" />
				<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JTanka" value="${m.JTanka }" styleId="hiddenAvgTanka"/>
				</td>
				<td class="space"></td>
		    	<th class="shikakari-sub">実績</th>
		    	<td class="shikakari-no-input" id="totalJKousu">計算中</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="shikakari-no-input" id="JKousu[${s3.index }]">計算中</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==1 }">
					<td class="shikakari-no-input" id="JCost[${s3.index }]">計算中</td>
				</c:if>
				</c:forEach>
		    </tr>

		    <tr class="${s.index}">
		    	<th class="shikakari-sub">旅費交通費</th>
		    	<td class="shikakari-no-input  apppend-hidden" id="mgKRyohi"><fmt:formatNumber value="${f:h(m.KRyohi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KRyohi" value="${m.KRyohi }" styleId="hiddenKRyohi"/>
		    	</td>
		    	<td class="shikakari-no-input  apppend-hidden" id="mgMRyohi"><fmt:formatNumber value="${f:h(m.MRyohi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MRyohi" value="${m.MRyohi }" styleId="hiddenMRyohi"/>
		    	</td>
		    	<td class="shikakari-no-input  apppend-hidden" id="mgJRyohi"><fmt:formatNumber value="${f:h(m.JRyohi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JRyohi" value="${m.JRyohi }" styleId="hiddenJRyohi"/>
		    	</td>
				<td class="space"></td>
				<th class="shikakari-sub">粗利金額</th>
				<th class="shikakari-sub">粗利率</th>
				<td class="space"></td>
		    	<th class="shikakari-sub">計/見 差異</th>
		    	<td class="shikakari-no-input" id="totalKMKousuGap">計算中</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="shikakari-no-input"  id="KMKousuGap">計算中</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==1 }">
					<td class="shikakari-no-input" id="KMCostGap">計算中</td>
				</c:if>
				</c:forEach>
		    </tr>

		    <tr class="${s.index}">
		    	<th class="shikakari-sub">その他経費</th>
		    	<td class="shikakari-no-input  apppend-hidden" id="mgKSonota"><fmt:formatNumber value="${f:h(m.KSonota)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KSonota" value="${m.KSonota }" styleId="hiddenKSonota"/>
		    	</td>
		    	<td class="shikakari-no-input  apppend-hidden" id="mgMSonota"><fmt:formatNumber value="${f:h(m.MSonota)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MSonota" value="${m.MSonota }" styleId="hiddenMSonota"/>
		    	</td>
		    	<td class="shikakari-no-input  apppend-hidden" id="mgJSonota"><fmt:formatNumber value="${f:h(m.JSonota)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JSonota" value="${m.JSonota }" styleId="hiddenJSonota"/>
		    	</td>
				<td class="space"></td>
				<td class="shikakari-no-input apppend-hidden" id="mgArari"><fmt:formatNumber value="${f:h(m.uriage - m.JSum)}" /></td>
				<td class="shikakari-no-input apppend-hidden" id="mgArariPer"><fmt:formatNumber pattern="###,##0.0"
				value="${f:h(m.JSum==0 ? 0 : m.JSum / (m.uriage - m.JSum))}" /></td>
				<td class="space"></td>
		    	<th class="shikakari-sub">計/実 差異</th>
		    	<td class="shikakari-no-input" id="totalKJKousuGap">計算中</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="shikakari-no-input" id="KJKousuGap[${s3.index }]">計算中</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==1 }">
					<td class="shikakari-no-input" id="KJCostGap[${s3.index }]">計算中</td>
				</c:if>
				</c:forEach>
		    </tr>

		    <tr class="${s.index}">
		    	<th class="shikakari-sub">経費合計</th>
		    	<td class="shikakari-no-input  apppend-hidden" id="mgKKeihi"><fmt:formatNumber value="${f:h(m.KKeihi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KKeihi" value="${m.KKeihi }" styleId="hiddenKKeihi"/>
		    	</td>
		    	<td class="shikakari-no-input  apppend-hidden" id="mgMKeihi"><fmt:formatNumber value="${f:h(m.MKeihi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MKeihi" value="${m.MKeihi }" styleId="hiddenMKeihi"/>
		    	</td>
		    	<td class="shikakari-no-input  apppend-hidden" id="mgJKeihi"><fmt:formatNumber value="${f:h(m.JKeihi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JKeihi" value="${m.JKeihi }" styleId="hiddenJKeihi"/>
		    	</td>
		    	<td class="space"></td>
		    	<th class="shikakari-sub" style="background-color: yellow;">原価計</th>
		    </tr>

		    <tr class="${s.index}">
		    	<th class="shikakari-sub">合計</th>
		    	<td class="shikakari-no-input  apppend-hidden" id="mgKTotal"><fmt:formatNumber value="${f:h(m.KSum)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KSum" value="${m.KSum }" styleId="hiddenKTotal"/>
		    	</td>
		    	<td class="shikakari-no-input  apppend-hidden" id="mgMTotal"><fmt:formatNumber value="${f:h(m.MSum)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MSum" value="${m.MSum }" styleId="hiddenMTotal"/>
		    	</td>
		    	<td class="shikakari-no-input  apppend-hidden" id="mgJTotal"><fmt:formatNumber value="${f:h(m.JSum)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JSum" value="${m.JSum }" styleId="hiddenJTotal"/>
		    	</td>
		    	<td class="space"></td>
		    	<td class="shikakari-no-input" id="mgTotalGenka" style="background-color: yellow;">計算中</td>
		    </tr>
	</c:if>

			    <%--
		    **************************************************************
		    削除対象の場合
		    削除対象テーブルは月別原価と同じように入力ができるが、仕掛り計算の対象にならない
		    更新時に工数と合計が0になっていれば、自動的に削除される。
		    クリアボタンを付けても良いかもしれない
		     --%>
	<c:if test="${m.gkConditionCode==404 }">

			<%--
			社員別原価と外注別費用の更新用idをhiddenで格納
			idがない場合は空白入力となり、この場合は必須項目を設定してinsert対象となる。
			 --%>
			<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
				<html:hidden property="mapItemsItems[${s.index }][${s3.index }].emkId" value="${kt.emkId }" />
				<html:hidden property="mapItemsItems[${s.index }][${s3.index }].empNo" value="${kt.empNo }" />
				<html:hidden property="mapItemsItems[${s.index }][${s3.index }].gaityuFlag" value="${kt.gaityuFlag }" />
			</c:forEach>

		    <tr class="sakujo ${s.index}">
		    	<th colspan="4" id='themeNo' class="sakujo-sub">削除対象
		        </th>
		    </tr>
		    <tr class="sakujo ${s.index}">
		    	<th>${f:h(m.nendo)} / ${f:h(m.month)}</th>
		        <th class="sakujo sub">計画</th>
				<th class="sakujo sub">見込</th>
				<th class="sakujo sub">実績</th>
				<td class="space"></td>
				<th class="sakujo sub">計画/見込<br />差異</th>
				<th class="sakujo sub">計画/実績<br />差異</th>
				<td class="space"></td>
				<th class="sakujo sub">プロジェクト<br />メンバー</th>
				<th class="sakujo sub">合計</th>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
				<c:if test="${kt.gaityuFlag==0 }">
					<th class="sakujo sub">${kt.shortEmpName }</th>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
				<c:if test="${kt.gaityuFlag==1 }">
					<th class="sakujo sub">${kt.shortEmpName }</th>
				</c:if>
				</c:forEach>
		    </tr>
		    <tr class="sakujo ${s.index}">
		    	<th class="sakujo sub">労務費</th>
		    	<td class="sakujo no-input apppend-hidden" id="mgKRoumuhi"><%--<fmt:formatNumber value="${f:h(m.KRoumuhi)}" /> --%>
		    	<fmt:formatNumber value="${f:h(m.KRoumuhi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KRoumuhi" value="${m.KRoumuhi }" styleId="hiddenKRoumuhi" />
		    	</td>
		    	<td class="sakujo no-input  apppend-hidden" id="mgMRoumuhi"><fmt:formatNumber value="${f:h(m.MRoumuhi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MRoumuhi" value="${m.MRoumuhi }" styleId="hiddenMRoumuhi" />
		    	</td>
		    	<td class="sakujo no-input  apppend-hidden" id="mgJRoumuhi"><fmt:formatNumber value="${f:h(m.JRoumuhi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JRoumuhi" value="${m.JRoumuhi }" styleId="hiddenJRoumuhi"/>
		    	</td>
				<td class="space"></td>
				<td class="sakujo no-input  apppend-hidden" id="mgKMGap"><fmt:formatNumber value="${f:h(m.KMGap)}" />
				<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KMGap" value="${m.KMGap }" styleId="hiddenKMGap"/>
				</td>
				<td class="sakujo no-input  apppend-hidden" id="mgKJGap"><fmt:formatNumber value="${f:h(m.KJGap)}" />
				<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KJGap" value="${m.KJGap }" styleId="hiddenKJGap"/>
				</td>
				<td class="space"></td>
		    	<th class="sakujo sub">計画</th>
		    	<td class="sakujo no-input" id="totalKKousu">計算中</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="sakujo input" id="KKousu[${s3.index }]">
					<fmt:formatNumber var="KKousu" pattern="###,##0.0" value="${f:h(kt.KKousu)}" />
					<html:text property="mapItemsItems[${s.index}][${s3.index}].KKousu"
					value="${KKousu}" onblur="checkKousu(this)" />
					</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<%--外注費は本来Costだけど、java側の処理上マップのキーをKousuにしている --%>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==1 }">
					<td class="sakujo input" id="KCost[${s3.index }]">
					<fmt:formatNumber var="KKousu" value="${f:h(kt.KKousu)}" />
					<html:text property="mapItemsItems[${s.index}][${s3.index}].KKousu"
					value="${KKousu}" onblur="checkMoney(this)" />
					</td>
				</c:if>
				</c:forEach>
		    </tr>
		    <tr class="sakujo ${s.index}">
		    	<th class="sakujo sub">工数</th>
		    	<td class="sakujo no-input  apppend-hidden" id="mgKKousu"><fmt:formatNumber pattern="###,##0.0" value="${f:h(m.KKousu)}"/>
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KKousu" value="${m.KKousu }" styleId="hiddenKKousu" />
		    	</td>
		    	<td class="sakujo no-input  apppend-hidden" id="mgMKousu"><fmt:formatNumber pattern="###,##0.0" value="${f:h(m.MKousu)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MKousu" value="${m.MKousu }" styleId="hiddenKKousu" />
		    	</td>
		    	<td class="sakujo input" id="mgJKousu">
		    	<fmt:formatNumber var="JKousu" pattern="###,##0.0" value="${f:h(m.JKousu)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].JKousu"
				value="${JKousu}" onblur="checkKousu(this)" />
				</td>
				<td class="space"></td>
				<td class="space"></td>
				<td class="space"></td>
				<td class="space"></td>
		    	<th class="sakujo sub">見込</th>
		    	<td class="sakujo no-input" id="totalMKousu">計算中</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="sakujo input">
					<fmt:formatNumber var="MKousu" pattern="###,##0.0" value="${f:h(kt.MKousu)}" />
					<html:text property="mapItemsItems[${s.index}][${s3.index}].MKousu"
					value="${MKousu}" onblur="checkKousu(this)" />
					</td>
				</c:if>
				</c:forEach>
				<td class="space" id="MKousu[${s3.index }]"></td>
				<%--外注費は本来Costだけど、java側の処理上マップのキーをKousuにしている --%>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==1 }">
					<td class="sakujo input" id="MCost[${s3.index }]">
					<fmt:formatNumber var="MKousu" value="${f:h(kt.MKousu)}" />
					<html:text property="mapItemsItems[${s.index}][${s3.index}].MKousu"
					value="${MKousu}" onblur="checkMoney(this)" />
					</td>
				</c:if>
				</c:forEach>
		    </tr>
		    <tr class="sakujo ${s.index}">
		    	<th class="sakujo sub">単価</th>
		    	<td class="sakujo no-input" id="mgKTanka"><fmt:formatNumber value="${f:h(m.KTanka)}" /></td>
		    	<td class="sakujo input" id="mgMTanka">
		    	<fmt:formatNumber var="MTanka" pattern="###,##0" value="${f:h(m.MTanka)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].MTanka"
				value="${MTanka}" onblur="checkMoney(this)" />
				</td>
				<td class="sakujo input" id="mgJTanka">
		    	<fmt:formatNumber var="JTanka" pattern="###,##0" value="${f:h(m.JTanka)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].JTanka"
				value="${JTanka}" onblur="checkMoney(this)" />
				</td>
				<td class="space"></td>
				<td class="space"></td>
				<td class="space"></td>
				<td class="space"></td>
		    	<th class="sakujo sub">実績</th>
		    	<td class="sakujo no-input" id="totalJKousu">計算中</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="sakujo input" id="JKousu[${s3.index }]">
					<fmt:formatNumber var="JKousu" pattern="###,##0.0" value="${f:h(kt.JKousu)}" />
					<html:text property="mapItemsItems[${s.index}][${s3.index}].JKousu"
					value="${JKousu}" onblur="checkKousu(this)" />
					</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<%--外注費は本来Costだけど、java側の処理上マップのキーをKousuにしている --%>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==1 }">
					<td class="sakujo input" id="JCost[${s3.index }]">
					<fmt:formatNumber var="JKousu" value="${f:h(kt.JKousu)}" />
					<html:text property="mapItemsItems[${s.index}][${s3.index}].JKousu"
					value="${JKousu}" onblur="checkMoney(this)" />
					</td>
				</c:if>
				</c:forEach>
		    </tr>

		    <tr class="sakujo ${s.index}">
		    	<th class="sakujo sub">外注加工費</th>
		    	<td class="sakujo no-input  apppend-hidden" id="mgKGaityu"><fmt:formatNumber value="${f:h(m.KGaityu)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KGaityu" value="${m.KGaityu }" styleId="hiddenKGaityu"/>
		    	</td>
		    	<td class="sakujo no-input  apppend-hidden" id="mgMGaityu"><fmt:formatNumber value="${f:h(m.MGaityu)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MGaityu" value="${m.MGaityu }" styleId="hiddenMGaityu"/>
		    	</td>
		    	<td class="sakujo input" id="mgJGaityu">
		    	<fmt:formatNumber var="JGaityu" pattern="###,##0" value="${f:h(m.JGaityu)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].JGaityu"
				value="${JGaityu}" onblur="checkMoney(this)" />
				</td>
				<td class="space"></td>
				<td class="space"></td>
				<td class="space"></td>
				<td class="space"></td>
		    	<th class="sakujo sub">計/見 差異</th>
		    	<td class="sakujo no-input" id="totalKMKousuGap">計算中</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="sakujo no-input" id="KMKousuGap">
					<fmt:formatNumber pattern="###,##0.0" value="${kt.KKousu - kt.MKousu }" />
					</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
				<c:if test="${kt.gaityuFlag==1 }">
					<td class="sakujo no-input" id="KMCostGap">
					<fmt:formatNumber value="${kt.KKousu - kt.MKousu }" />
					</td>
				</c:if>
				</c:forEach>
		    </tr>

		    <tr class="sakujo ${s.index}">
		    	<th class="sakujo sub">旅費交通費</th>
		    	<td class="sakujo input" id="mgKRyohi">
		    	<fmt:formatNumber var="KRyohi" pattern="###,##0" value="${f:h(m.KRyohi)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].KRyohi"
				value="${KRyohi}" onblur="checkMoney(this)" />
				</td>
		    	<td class="sakujo input" id="mgMRyohi">
		    	<fmt:formatNumber var="MRyohi" pattern="###,##0" value="${f:h(m.MRyohi)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].MRyohi"
				value="${MRyohi}" onblur="checkMoney(this)" />
				</td>
		    	<td class="sakujo input" id="mgJRyohi">
		    	<fmt:formatNumber var="JRyohi" pattern="###,##0" value="${f:h(m.JRyohi)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].JRyohi"
				value="${JRyohi}" onblur="checkMoney(this)" />
				</td>
				<td class="space"></td>
				<td class="space"></td>
				<td class="space"></td>
				<td class="space"></td>
		    	<th class="sakujo sub">計/実 差異</th>
		    	<td class="sakujo no-input" id="totalKJKousuGap">計算中</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="sakujo no-input" id="KJKousuGap[${s3.index }]">
					<fmt:formatNumber pattern="###,##0.0" value="${kt.KKousu - kt.JKousu }" />
					</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
				<c:if test="${kt.gaityuFlag==1 }">
					<td class="sakujo no-input" id="KJCostGap[${s3.index }]">
					<fmt:formatNumber value="${kt.KKousu - kt.JKousu }" />
					</td>
				</c:if>
				</c:forEach>
		    </tr>

		    <tr class="sakujo ${s.index}">
		    	<th class="sakujo sub">その他経費</th>
		    	<td class="sakujo input" id="mgKSonota">
		    	<fmt:formatNumber var="KSonota" pattern="###,##0" value="${f:h(m.KSonota)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].KSonota"
				value="${KSonota}" onblur="checkMoney(this)" />
				</td>
		    	<td class="sakujo input" id="mgMSonota">
		    	<fmt:formatNumber var="MSonota" pattern="###,##0" value="${f:h(m.MSonota)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].MSonota"
				value="${MSonota}" onblur="checkMoney(this)" />
				</td>
		    	<td class="sakujo input" id="mgJSonota">
		    	<fmt:formatNumber var="JSonota" pattern="###,##0" value="${f:h(m.JSonota)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].JSonota"
				value="${JSonota}" onblur="checkMoney(this)" />
				</td>
		    </tr>

		    <tr class="sakujo ${s.index}">
		    	<th class="sakujo sub">経費合計</th>
		    	<td class="sakujo no-input  apppend-hidden" id="mgKKeihi"><fmt:formatNumber value="${f:h(m.KKeihi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KKeihi" value="${m.KKeihi }" styleId="hiddenKKeihi" />
		    	</td>
		    	<td class="sakujo no-input  apppend-hidden" id="mgMKeihi"><fmt:formatNumber value="${f:h(m.MKeihi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MKeihi" value="${m.MKeihi }" styleId="hiddenMKeihi" />
		    	</td>
		    	<td class="sakujo no-input  apppend-hidden" id="mgJKeihi"><fmt:formatNumber value="${f:h(m.JKeihi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JKeihi" value="${m.JKeihi }" styleId="hiddenJKeihi" />
		    	</td>
		    </tr>

		    <tr class="sakujo ${s.index}">
		    	<th class="sakujo sub">合計</th>
		    	<td class="sakujo no-input  apppend-hidden" id="mgKTotal"><fmt:formatNumber value="${f:h(m.KSum)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KSum" value="${m.KSum }" styleId="hiddenKTotal" />
		    	</td>
		    	<td class="sakujo no-input  apppend-hidden" id="mgMTotal"><fmt:formatNumber value="${f:h(m.MSum)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MSum" value="${m.MSum }" styleId="hiddenMTotal" />
		    	</td>
		    	<td class="sakujo no-input  apppend-hidden" id="mgJTotal"><fmt:formatNumber value="${f:h(m.JSum)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JSum" value="${m.JSum }" styleId="hiddenJTotal" />
		    	</td>
		    </tr>
	</c:if>


		    </c:forEach>
		</c:forEach>
		</table>
		<div class="space"></div>
	</div>
</s:form>
</div>
<script type="text/javascript">
//即時関数を利用してtableのヘッダを固定
$(window).on('load resize',function() {

	$('#loading').css('display', 'none');
	$('#main-contents').css('visibility', 'visible');

	initializeUnfixedHeight();

	$('#main-contents').css('visibility', 'visible');

}());
</script>
</body>
</html>