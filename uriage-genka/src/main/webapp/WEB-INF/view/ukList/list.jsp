<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" type="text/css" href="${f:url('/css/ukList.css')}"></link>

<script type="text/javascript" src="${f:url('/javascript/checkDatePattern.js')}"></script>
<script type="text/javascript" src="${f:url('/javascript/jquery-3.1.1.min.js')}"></script>

<script type="text/javascript">
function executeClear(){

	$(".anken-input-table, .uk-input-table").find("input, select").each(function(){
		$(this).val("");

		//変更した入力フォームの色を修正
		//色の判定はクロスブラウザに対応させると非常に面倒くさそうなので
		//必須項目とdisabled以外を白に戻す
		if( ($(this).attr('class')!='required') && ($(this).prop('disabled')!=true) ){
			$(this).css('background-color' ,'white');
		}
		if($(this).attr('class')=='required'){
			$(this).css('background-color' ,'pink');
		}
	});

	calcUriageTotal();

	$('.anken-input-table [name="jutyugaku"]').val('0');

	if(orgRow!=null){
		if(orgRow % 2 == 0)document.getElementById(orgRow).className='row1';
		else document.getElementById(orgRow).className='row2';
	}

	$('.update').prop('disabled', true);
	//window.alert('入力フォームをクリアしました。');
	return false;
}

function checkInsert(){
	var input = document.forms["input"];
	if(input.nendo.value==''){
		window.alert('年度は必須です。');
		return false;
	}
	if(input.eigyo.value==''){
		window.alert('担当は必須です。');
		return false;
	}
	if(input.ankenName.value==''){
		window.alert('案件名は必須です。');
		return false;
	}
	if(input.kokyakuName.value==''){
		window.alert('顧客名は必須です。');
		return false;
	}
	if(input.kokyakuInitial.value==''){
		window.alert('イニシャルは必須です。');
		return false;
	}
	if(input.hattyuTypeCode.value==''){
		window.alert('発注タイプは必須です。');
		return false;
	}
	if(input.hattyuMikomiDate.value==''){
		window.alert('受注見込時期は必須です。');
		return false;
	}
	if(input.kakudoCode.value==''){
		window.alert('状況は必須です。');
		return false;
	}
	if(input.jutyugaku.value==''){
		window.alert('受注額は必須です。');
		return false;
	}
	uriageTotalNum = Number($('[name=uriageTotal]').val().replace(/,/g,''));
	zennendoTotalNum = Number($('[name=zennendoTotal]').val().replace(/,/g,''));
	jutyugakuNum = Number($('[name=jutyugaku]').val().replace(/,/g,''));
	if(jutyugakuNum != uriageTotalNum + zennendoTotalNum ){
		window.alert('売上計画と受注額の金額が一致していません');
		return false;
	}
		return confirm('入力した内容で新規作成します');
}

function checkUpdate(){
	if(checkQuote() == false)return false;
	uriageTotalNum = Number($('[name=uriageTotal]').val().replace(/,/g,''));
	zennendoTotalNum = Number($('[name=zennendoTotal]').val().replace(/,/g,''));
	jutyugakuNum = Number($('[name=jutyugaku]').val().replace(/,/g,''));
	if(jutyugakuNum != uriageTotalNum + zennendoTotalNum ){
		window.alert('売上計画と受注額の金額が一致していません');
		return false;
	}
	else return window.confirm('更新して良いですか？');
}

function checkDelete(){
	if(checkQuote() == false)return false;
	else return window.confirm('削除して良いですか？');
}

function checkQuote(){
	if(document.forms["input"].ankenId.value == ''){
		window.alert('対象が選択されていません');
		return false;
	} else return true;
}

function executeQuote(id){
	var input = document.forms["input"];
	//input.nendo.value = $.trim($("#"+index).children("#nendo").text());

	input.ankenId.value = $('#' +id+ ' [name="ankenId"]').val();
	input.ankenRirekiNo.value = $('#' +id+ ' [name="ankenRirekiNo"]').val();
	input.ankenRirekiId.value = $('#' +id+ ' [name="ankenRirekiId"]').val();
	input.nendo.value = $('#' +id+ ' [name="nendo"]').val();
	input.kokyakuName.value = $('#' +id+ ' [name="kokyakuName"]').val();
	input.kokyakuInitial.value = $('#' +id+ ' [name="kokyakuInitial"]').val();
	input.ankenName.value = $('#' +id+ ' [name="ankenName"]').val();
	input.jutyuName.value = $('#' +id+ ' [name="jutyuName"]').val();
	input.themeNo.value = $('#' +id+ ' [name="themeNo"]').val();
	input.themeGroup.value = $('#' +id+ ' [name="themeGroup"]').val();
	input.kaihatsuGroupHead.value = $('#' +id+ ' [name="kaihatsuGroupHead"]').val();
	//input.kaihatsuGroupHeadName.value = $('#' +id+ ' [name="kaihatsuGroupHeadName"]').val();
	input.eigyo.value = $('#' +id+ ' [name="eigyo"]').val();
	//input.eigyoName.value = $('#' +id+ ' [name="eigyoName"]').val();
	input.hattyuTypeCode.value = $('#' +id+ ' [name="hattyuTypeCode"]').val();
	//input.hattyuTypeName.value = $('#' +id+ ' [name="hattyuTypeName"]').val();
	input.kakudoCode.value = $('#' +id+ ' [name="kakudoCode"]').val();
	//input.kakudoName.value = $('#' +id+ ' [name="kakudoName"]').val();
	input.hattyuMikomiDate.value = $('#' +id+ ' [name="hattyuMikomiDate"]').val();
	input.hattyuDate.value = $('#' +id+ ' [name="hattyuDate"]').val();
	input.kensyuDate.value = $('#' +id+ ' [name="kensyuDate"]').val();
	//input.notes.value = $('#' +id+ ' [name="notes"]').val();
	//金額のみ3桁区切り数値に変換
	input.jutyugaku.value = Number($('#' +id+ ' [name="jutyugaku"]').val()).toLocaleString();
	input.ukYokuyoku.value = Number($('#' +id+ ' [name="ukYokuyoku"]').val()).toLocaleString();
	input.ukConditionCode.value = $('#' +id+ ' [name="ukConditionCode"]').val();
	//input.insertDate.value = obj.form.insertDate.value;
	//input.insertEmpNo.value = obj.form.insertEmpNo.value;

	input.tounendoApr.value = Number($('#' +id+ ' [name="tounendoApr"]').val()).toLocaleString();
	input.tounendoMay.value = Number($('#' +id+ ' [name="tounendoMay"]').val()).toLocaleString();
	input.tounendoJun.value = Number($('#' +id+ ' [name="tounendoJun"]').val()).toLocaleString();
	input.tounendoJul.value = Number($('#' +id+ ' [name="tounendoJul"]').val()).toLocaleString();
	input.tounendoAug.value = Number($('#' +id+ ' [name="tounendoAug"]').val()).toLocaleString();
	input.tounendoSep.value = Number($('#' +id+ ' [name="tounendoSep"]').val()).toLocaleString();
	input.tounendoOct.value = Number($('#' +id+ ' [name="tounendoOct"]').val()).toLocaleString();
	input.tounendoNov.value = Number($('#' +id+ ' [name="tounendoNov"]').val()).toLocaleString();
	input.tounendoDec.value = Number($('#' +id+ ' [name="tounendoDec"]').val()).toLocaleString();
	input.tounendoJan.value = Number($('#' +id+ ' [name="tounendoJan"]').val()).toLocaleString();
	input.tounendoFeb.value = Number($('#' +id+ ' [name="tounendoFeb"]').val()).toLocaleString();
	input.tounendoMar.value = Number($('#' +id+ ' [name="tounendoMar"]').val()).toLocaleString();
	input.jinendoApr.value = Number($('#' +id+ ' [name="jinendoApr"]').val()).toLocaleString();
	input.jinendoMay.value = Number($('#' +id+ ' [name="jinendoMay"]').val()).toLocaleString();
	input.jinendoJun.value = Number($('#' +id+ ' [name="jinendoJun"]').val()).toLocaleString();
	input.jinendoJul.value = Number($('#' +id+ ' [name="jinendoJul"]').val()).toLocaleString();
	input.jinendoAug.value = Number($('#' +id+ ' [name="jinendoAug"]').val()).toLocaleString();
	input.jinendoSep.value = Number($('#' +id+ ' [name="jinendoSep"]').val()).toLocaleString();
	input.jinendoOct.value = Number($('#' +id+ ' [name="jinendoOct"]').val()).toLocaleString();
	input.jinendoNov.value = Number($('#' +id+ ' [name="jinendoNov"]').val()).toLocaleString();
	input.jinendoDec.value = Number($('#' +id+ ' [name="jinendoDec"]').val()).toLocaleString();
	input.jinendoJan.value = Number($('#' +id+ ' [name="jinendoJan"]').val()).toLocaleString();
	input.jinendoFeb.value = Number($('#' +id+ ' [name="jinendoFeb"]').val()).toLocaleString();
	input.jinendoMar.value = Number($('#' +id+ ' [name="jinendoMar"]').val()).toLocaleString();
	//input.tounendoKamiki.value = Number($('#' +id+ '[name=tounendoKamiki]').val()).toLocaleString();
	//上記の方法では書き換えられない。disabledとhiddenの両方を変えたいので同じ名前のフォームをjqueryで取得する。
	$('.input-form [name=tounendoKamiki]').val( Number($('#' +id+ ' [name="tounendoKamiki"]').val()).toLocaleString() );
	$('.input-form [name=tounendoShimoki]').val( Number($('#' +id+ ' [name="tounendoShimoki"]').val()).toLocaleString() );
	$('.input-form [name=tounendoTotal]').val( Number($('#' +id+ ' [name="tounendoTotal"]').val()).toLocaleString() );
	$('.input-form [name=jinendoKamiki]').val( Number($('#' +id+ ' [name="jinendoKamiki"]').val()).toLocaleString() );
	$('.input-form [name=jinendoShimoki]').val( Number($('#' +id+ ' [name="jinendoShimoki"]').val()).toLocaleString() );
	$('.input-form [name=jinendoTotal]').val( Number($('#' +id+ ' [name="jinendoTotal"]').val()).toLocaleString() );
	$('.input-form [name=zennendoTotal]').val( Number($('#' +id+ ' [name="zennendoTotal"]').val()).toLocaleString() );

	//売上計の計算
	value = 0;
	value += parseInt($('[name=tounendoTotal]').val().replace(/,/g,''));
	value += parseInt($('[name=jinendoTotal]').val().replace(/,/g,''));
	if($('[name=ukYokuyoku]').val()=='')$('[name=ukYokuyoku]').val('0');
	value += parseInt($('[name=ukYokuyoku]').val().replace(/,/g,''));
	if($('.input-form [name=zennendoTotal]').val()=='')$('.input-form [name=zennendoTotal]').val('0');
	$('.input-form [name=uriageTotal]').val(value.toLocaleString());
	//	console.log("quote successful");
	//window.alert('入力フォームに値を転記しました。');
	return false;
}

//もとのスタイルをorgRowに保存して、selectedに変える。
//色替え処理は色々スタイルをいじった後、最後に行いたい処理なので、
//背景色のみを変える処理でも良いかもしれない。
//引数のrowはリスト<th>タグのidにインデックスを設定することで利用可能。
//row1はリストの偶数行、row2は奇数行、selectedは選択中の行のクラス。
var orgRow;
function changeColor(row){
	if(orgRow!=null){
		if(orgRow % 2 == 0)document.getElementById(orgRow).className='row1';
		else document.getElementById(orgRow).className='row2';
	}
	orgRow = row;
	document.getElementById(row).className='selected';
}

//テーマNOの検証を行う。フォーカスが外れた時（onblur）に使用する。
//テーマNOにふさわしい文字列でない場合、入力を空白に戻す。
//また、正しい値が入力されたときテーマ親番の自動採番を行う。
function checkThemeNo(){
	str = document.forms["input"].themeNo.value;
	if(str == ''){

		//売上計画管理表のみの特別な判定
		//テーマNOなしにテーマ親番を入力できない
		if(document.forms["input"].themeGroup.value!=''){
			window.alert('テーマNOが未入力の時、テーマ親番は入力できません。');
			document.forms["input"].themeGroup.value = '';
			document.forms["input"].themeGroup.focus();
			return;
		}
		return;
	}

	if(str.match(/^[0-9]{9}$/)){
		str = str.substring(0,5)+'-'+str.substring(5,9);
		document.forms["input"].themeNo.value = str;
	}
	if(str.match(/^[0-9]{5}-[0-9]{4}$/)){
	//テーマ親番の自動採番
		if(document.forms["input"].themeGroup.value==''){
			document.forms["input"].themeGroup.value = str.substring(0,9)
		}
	}else{
		window.alert('テーマNOに相応しくありません。入力し直して下さい。');
		document.forms["input"].themeNo.value = '';
		document.forms["input"].themeNo.focus();
	}
}

function checkThemeGroup(){
	str = document.forms["input"].themeGroup.value;
	if(str == '')return;

	//売上計画管理表のみの特別な判定
	//テーマNOなしにテーマ親番を入力できない
	if(document.forms["input"].themeNo.value==""){
		window.alert('テーマNOが未入力の時、テーマ親番は入力できません。');
		document.forms["input"].themeGroup.value = '';
		document.forms["input"].themeGroup.focus();
		return;
	}

	if(str.match(/^[0-9]{8}$/)){
		str = str.substring(0,5)+'-'+str.substring(5,8);
		document.forms["input"].themeGroup.value = str;
	}
	if(str.match(/[0-9]{5}-[0-9]{3}/))return;

	window.alert('テーマ親番に相応しくありません。入力し直して下さい。');
	document.forms["input"].themeGroup.value = '';
	document.forms["input"].themeGroup.focus();
}


//ENTERキーを無効化
document.onkeydown = KeyEvent;
function KeyEvent(e){
    var pressKey=event.keyCode;
    if(pressKey == 13) {
	return false;
    }
}

//金額チェック
//空白なら"0"に差し替え
//入力文字列のカンマを削除して、0以上の整数なら3桁カンマ区切りに再フォーマット
//そうでない場合はエラーメッセージを出して入力を"0"に差し替え
function checkMoney(obj){
	str = obj.value;
	if(str==''){
		obj.value="0"
		return;
	}
	number = Number(str.replace(/,/g,""));
	if(isInteger(number)==true && number >= 0){
		obj.value=number.toLocaleString();
		return;
	}
	window.alert('金額は自然数でなければいけません。入力し直して下さい。');
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

 $(function(){
	 $('.uk-input-table').find('input').change(function(){
		//入力チェック
		//空白なら'0'に変換
		str = $(this).val();
		if(str==''){
			$(this).val('0');

		}
		//入力があれば数値チェック
		number = Number(str.replace(/,/g,""));
		if(isInteger(number)==true && number >= 0){
			//数値が正しければ3桁区切りに変換
			$(this).val(number.toLocaleString());

			calcUriageTotal();
			return;
		}

		//数字チェックを満たさない場合はエラー
		window.alert('金額は自然数でなければいけません。入力し直して下さい。');
		obj.value='0';
	 });
 });

 function calcUriageTotal(){
		//当年度上期の再計算
		value = 0;
		$('.tounendo-kamiki').each(function(){
			if($(this).val()=='')$(this).val('0');
			value += parseInt($(this).val().replace(/,/g,''));
		});
		$('[name=tounendoKamiki]').val(value.toLocaleString());

		//当年度下期の再計算
		value = 0;
		$('.tounendo-shimoki').each(function(){
			if($(this).val()=='')$(this).val('0');
			value += parseInt($(this).val().replace(/,/g,''));
		});
		$('[name=tounendoShimoki]').val(value.toLocaleString());

		//当年度計の計算
		value = 0;
		value += parseInt($('[name=tounendoKamiki]').val().replace(/,/g,''));
		value += parseInt($('[name=tounendoShimoki]').val().replace(/,/g,''));
		$('[name=tounendoTotal]').val(value.toLocaleString());


		//次年度上期の再計算
		value = 0;
		$('.jinendo-kamiki').each(function(){
			if($(this).val()=='')$(this).val('0');
			value += parseInt($(this).val().replace(/,/g,''));
		});
		$('[name=jinendoKamiki]').val(value.toLocaleString());

		//次年度下期の再計算
		value = 0;
		$('.jinendo-shimoki').each(function(){
			if($(this).val()=='')$(this).val('0');
			value += parseInt($(this).val().replace(/,/g,''));
		});
		$('[name=jinendoShimoki]').val(value.toLocaleString());

		//次年度計の計算
		value = 0;
		value += parseInt($('[name=jinendoKamiki]').val().replace(/,/g,''));
		value += parseInt($('[name=jinendoShimoki]').val().replace(/,/g,''));
		$('[name=jinendoTotal]').val(value.toLocaleString());

		//売上計の計算
		value = 0;
		value += parseInt($('[name=tounendoTotal]').val().replace(/,/g,''));
		value += parseInt($('[name=jinendoTotal]').val().replace(/,/g,''));
		if($('[name=ukYokuyoku]').val()=='')$('[name=ukYokuyoku]').val('0');
		value += parseInt($('[name=ukYokuyoku]').val().replace(/,/g,''));
		if($('#zennendoTotal .input-form [name=zennendoTotal]').val()==''){
			$('#zennendoTotal .input-form [name=zennendoTotal]').val('0');
		}
		$('#uriageTotal, .input-form [name=uriageTotal]').val(value.toLocaleString());

		return;
 }

$(function(){
	$(".anken-input-table, .uk-input-table").find("input, select").change(function(){
		$(this).css('background-color', 'yellow');
		$('.input-form .update').prop('disabled', false);
	});
});

//パーセンテージ入力チェック
function checkParcentage(obj){
	str = obj.value;
	if(str=='')return;
	if(str.match(/^[0-9]{2}.[0-9]$/))return;
	number = Number(str);
	if(isInteger(number)==true && (number>=0 && number<=100)){
		obj.value = number.toFixed(1);
		return;
	}
	window.alert('百分率でなければいけません。入力し直して下さい。\n【受け付ける数値例】30,100,65.5');
	obj.value='';

	function isInteger(x) {
	    return Math.round(x) === x;
	}
}

//フォームの折りたたみ
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

//可変するフォームの高さに合わせて、リストの表示位置を再計算する
function initializeUnfixedHeight(){
	if(${empty themeInsert}){
		console.log('no authorization');
	}

	$('div.fixed').css('top', $('div.header').height());
	$('div.list-header').css('top', $('div.header').height()+$('div.fixed').height());
	$('div.list-body').css('top', $('div.header').height()+ $('div.fixed').height()+ $('div.list-header').height());

	$('div.subtotal')
		.css('position', 'absolute')
		.css('top', $('div.list-body').height() + $('div.list-body').offset().top + 10);
}

//縦スクロールはさせたくないけど、横スクロールはさせたいdivはここに追加
window.addEventListener('scroll', _hangleScroll, false);
function _hangleScroll(){
	$('div.fixed').css('left',  - window.scrollX);

	$('div.list-header').css('left',  - window.scrollX + 8);
	//console.log($('div#list-header').css('left'));
}

//list-bodyの<td class="keyClass">を順次チェックして、newInsertまたはnewUpdateに該当するものがあったら列の色を変える。
//keyClassクラスはその列で一意のクラスでなければならない。text()で複数の要素をまとめて取り出してしまうため。
//対象が複数であっても問題なく色が変わる。ただし対象は列ごと。
//以前はtext()で取得してtrim()していたが、text()だとhiddenから値が取得できない。
//属性名に対する値が取得可能なattr('value')を利用すべき
function changeExecuteRowColor(keyClass){
	$('.list-body tr').each(function(){
		//keyClass = 'anken-rireki-id';
		//console.log('check');
		console.log($('.anken-rireki-id').attr('value'));
		if($(this).children('.'+keyClass).attr('value') == '${newInsert}'){
			$(this).css('border','solid 2px red');//2px以上にすると、別のテーブルのbordarに影響が出る。謎。
		}
		else if($(this).children('.'+keyClass).attr('value') == '${newUpdate}'){
			$(this).css('border','solid 2px aqua');
		}
		else if($(this).children('.'+keyClass).attr('value') == '${newDelete}'){
			$(this).css('border','solid 2px aqua');
		}

		//削除テーマならグレーアウト
		if($(this).children('#condition-code').attr('value') == '4'){
			$(this).css('background-color','gray');
		}
		//失注テーマなら濃いグレーに白文字
		if($(this).children('#condition-code').attr('value') == '3'){
			$(this).css('background-color','#333333');
			$(this).css('color','white');
		}
	});
}

//初期表示で画面サイズを90%に
//jquery上で問題が多いので封印。
/*
$(window).load(function(){
	$('body').css('zoom','90%');
});
*/

//チェックボックスを子要素に含むtdをクリックするとチェックボックスのチェックを行う
//tdのクラス名を"checkbox-options"に設定することで利用可能
$(function(){
	//マウスのイン・アウトによる背景色の変更
	$('.checkbox-options').mouseover(function(){
		$(this).css("background-color","skyblue");
	});

	$('.checkbox-options').mouseout(function(){
		$(this).css("background-color","");
	});

	$('.checkbox-options').click(function(){
		//checkboxをチェックすると親要素にバインドされているイベントが発火しなくなる
		//２重チェックによる誤作動を防止
		$(':checkbox').click(function(event){
		    event.stopPropagation()
		});
		//console.log($(this).children(':checkbox').val());
		if(!$(this).children(':checkbox').prop('checked')){
			$(this).children(':checkbox').prop('checked',true);
		}
		else if($(this).children(':checkbox').prop('checked')){
			$(this).children(':checkbox').prop('checked',false);
		}
	});

	//ラジオボタン版
	//クラス名を指定せずに動く
	$(':radio').parent('td').on("mouseover", function(){
		$(this).css("background-color","skyblue");
	});

	$(':radio').parent('td').on("mouseout", function(){
		$(this).css("background-color","");
	});

	$(':radio').parent('td').on('click', function(){
		$(this).children(':radio').prop('checked',true);
	});
});

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

<div class="fixed" id="fixed" style="left: 0px;">

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

	<s:form styleId="input">
<c:if test="${userDataDto.ukUpdate==1}">
	<div class="input-form">
		<font>入力フォーム</font>
		<input type="button" onclick="hideDiv('hide-input-form', this)" value="非表示" class="normal" />
		<div id="hide-input-form">
			<table class="anken-input-table">

				<%-- ankenId,ankenRirekiId,ankenRirekiNo,ukConditionCodeを選択ボタンから受けるhidden --%>
				<html:hidden property="ankenId" value="${ankenId }" />
				<html:hidden property="ankenRirekiId" value="${ankenRirekiId }" />
				<html:hidden property="ankenRirekiNo" value="${ankenRirekiNo }" />
				<html:hidden property="ukConditionCode" value="${ukConditionCode }" />

				<tr>
					<th>年度</th>
					<th>担当</th>
					<th colspan="4">案　件　名</th>
					<th colspan="4">受　注　品　名</th>
					<th>テーマNO</th>
					<th>テーマ親番</th>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td><html:text property="nendo" styleClass="required" errorStyleClass="error" onblur="checkNendo(this)" /></td>
					<td><html:select property="eigyo" styleClass="required" errorStyleClass="error" value="${eigyo}" >
						<c:forEach var="el" items="${eigyoList}">
							<html:option value="${el.empNo}">${el.shortEmpName}</html:option>
						</c:forEach>
					</html:select></td>
					<td colspan="4"><html:text property="ankenName" styleClass="required" errorStyleClass="error" style="width: 424px;" /></td>
					<td colspan="4"><html:text property="jutyuName" style="width: 424px;" /></td>
					<td><html:text property="themeNo" onblur="checkThemeNo()" /></td>
					<td><html:text property="themeGroup" onblur="checkThemeGroup()" /></td>
				</tr>
				<tr>
					<th>開発G</th>
					<th>顧客名</th>
					<th>イニシャル</th>
					<th>発注タイプ</th>
					<th>受注見込時期</th>
					<th>発注日</th>
					<th>検収日</th>
					<th>状況</th>
					<th>受注額</th>
					<!-- <th class="disabled">売上計</th> -->

					<th class="disabled">${searchNendo - 1}年度計</th>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td><html:select property="kaihatsuGroupHead" value="${kaihatsuGroupHead}" >
							<html:option value=""></html:option>
						<c:forEach var="el" items="${kaihatsuGroupList}">
							<html:option value="${el.empNo}">${el.shortEmpName}</html:option>
						</c:forEach>
					</html:select></td>
					<td><html:text property="kokyakuName" styleClass="required" errorStyleClass="error" /></td>
					<td><html:text property="kokyakuInitial" styleClass="required" errorStyleClass="error" /></td>
					<td><html:select property="hattyuTypeCode" styleClass="required" errorStyleClass="error" value="${hattyuTypeCode}" >
						<c:forEach var="el" items="${hattyuTypeList}">
							<html:option value="${el.codeId}">${el.codeName}</html:option>
						</c:forEach>
					</html:select></td>
					<td><html:text property="hattyuMikomiDate" styleClass="required" errorStyleClass="error" /></td>
					<td><html:text property="hattyuDate" /></td>
					<td><html:text property="kensyuDate" /></td>
					<td><html:select property="kakudoCode" styleClass="required" errorStyleClass="error" value="${kakudoCode}" >
						<c:forEach var="el" items="${kakudoList}">
							<html:option value="${el.codeId}">${el.codeName}</html:option>
						</c:forEach>
					</html:select></td>
					<td><html:text property="jutyugaku" styleClass="required" errorStyleClass="error" onblur="checkMoney(this)" /></td>
					<!-- <td><html:text disabled="true" property="uriageTotal" />
						<html:hidden property="uriageTotal" /></td> -->

					<td><html:text disabled="true" property="zennendoTotal" />
						<html:hidden property="zennendoTotal" /></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</table>
			<table class="uk-input-table">
				<tr>
					<th></th>
					<th>４月</th>
					<th>５月</th>
					<th>６月</th>
					<th>７月</th>
					<th>８月</th>
					<th>９月</th>
					<th class="disabled">上期</th>
					<th>１０月</th>
					<th>１１月</th>
					<th>１２月</th>
					<th>１月</th>
					<th>２月</th>
					<th>３月</th>
					<th class="disabled">下期</th>
					<th class="disabled">年度計</th>
					<th rowspan="2">翌々年度以降<br />売上計画</th>
				</tr>
				<tr>
					<th style="width: 75px;">${searchNendo}年度</th>
					<td><html:text property="tounendoApr" styleClass="tounendo-kamiki" /></td>
					<td><html:text property="tounendoMay" styleClass="tounendo-kamiki" /></td>
					<td><html:text property="tounendoJun" styleClass="tounendo-kamiki" /></td>
					<td><html:text property="tounendoJul" styleClass="tounendo-kamiki" /></td>
					<td><html:text property="tounendoAug" styleClass="tounendo-kamiki" /></td>
					<td><html:text property="tounendoSep" styleClass="tounendo-kamiki" /></td>
					<td><html:text property="tounendoKamiki" disabled="true" />
						<html:hidden property="tounendoKamiki" /></td>
					<td><html:text property="tounendoOct" styleClass="tounendo-shimoki" /></td>
					<td><html:text property="tounendoNov" styleClass="tounendo-shimoki" /></td>
					<td><html:text property="tounendoDec" styleClass="tounendo-shimoki" /></td>
					<td><html:text property="tounendoJan" styleClass="tounendo-shimoki" /></td>
					<td><html:text property="tounendoFeb" styleClass="tounendo-shimoki" /></td>
					<td><html:text property="tounendoMar" styleClass="tounendo-shimoki" /></td>
					<td><html:text property="tounendoShimoki" disabled="true" />
						<html:hidden property="tounendoShimoki" /></td>
					<td><html:text property="tounendoTotal" disabled="true" />
						<html:hidden property="tounendoTotal" /></td>

				</tr>
				<tr>
					<th style="width: 75px;">${searchNendo+1}年度</th>
					<td><html:text property="jinendoApr" styleClass="jinendo-kamiki" /></td>
					<td><html:text property="jinendoMay" styleClass="jinendo-kamiki" /></td>
					<td><html:text property="jinendoJun" styleClass="jinendo-kamiki" /></td>
					<td><html:text property="jinendoJul" styleClass="jinendo-kamiki" /></td>
					<td><html:text property="jinendoAug" styleClass="jinendo-kamiki" /></td>
					<td><html:text property="jinendoSep" styleClass="jinendo-kamiki" /></td>
					<td><html:text property="jinendoKamiki" disabled="true" />
						<html:hidden property="jinendoKamiki" /></td>
					<td><html:text property="jinendoOct" styleClass="jinendo-shimoki" /></td>
					<td><html:text property="jinendoNov" styleClass="jinendo-shimoki" /></td>
					<td><html:text property="jinendoDec" styleClass="jinendo-shimoki" /></td>
					<td><html:text property="jinendoJan" styleClass="jinendo-shimoki" /></td>
					<td><html:text property="jinendoFeb" styleClass="jinendo-shimoki" /></td>
					<td><html:text property="jinendoMar" styleClass="jinendo-shimoki" /></td>
					<td><html:text property="jinendoShimoki" disabled="true" />
						<html:hidden property="jinendoShimoki" /></td>
					<td><html:text property="jinendoTotal" disabled="true" />
						<html:hidden property="jinendoTotal" /></td>
					<td><html:text property="ukYokuyoku" />
						<html:hidden property="ukYokuyoku" /></td>
				</tr>
			</table>
			<input type="submit" onclick="return checkInsert()" name="newCreate" value="新規作成" class="insert" />
			<input type="submit" onclick="return checkUpdate()" name="update" value="更新" class="update" disabled="true"/>
			<input type="submit" onclick="return checkDelete()" name="delete" value="削除" class="delete" />
			<input type="submit" onclick="return checkDelete()" name="sittyu" value="失注削除" class="delete" />
			<input type="button" onclick="return executeClear()" value="クリア" class="normal" />
		</div>
	</div>
</c:if>
	<div class="search-form" >
		<font>検索フォーム</font>
		<input type="button" onclick="hideDiv('hide-search-form', this)" value="非表示" class="normal" />
		<div id="hide-search-form">
			<table>
				<tr>
					<th>年度</th>
					<td><html:select property="searchNendo" value="${searchNendo }">
						<c:forEach var="nl" items="${nendoList }">
							<html:option value="${nl }">${nl }</html:option>
						</c:forEach>
					</html:select></td>
					<td></td>
					<th>顧客名</th>
					<td colspan="2"><html:text property="searchKokyakuName" value="${f:h(searchKokyakuName)}" style="width:200px" ></html:text></td>
					<td></td>
					<th>ソート</th>
			<%--
					<td><input type="radio" name="searchSort" value="nomal">通常</td>
					<td><input type="radio" name="searchSort" value="themeNo">テーマNO</td>
			--%>
					<td><html:radio property="searchSort" value="normal" />通常</td>
					<td><html:radio property="searchSort" value="themeNo" />テーマNO</td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<th>案件名</th>
					<td colspan="3"><html:text property="searchAnkenName" value="${f:h(searchAnkenName) }" style="width: 300px;" ></html:text></td>
					<td></td>
					<td></td>
					<td></td>
					<th>受注品名</th>
					<td colspan="3"><html:text property="searchJutyuName" value="${f:h(searchJutyuName) }" style="width: 300px;" ></html:text></td>
					<td></td>
					<td></td>
				</tr>
				<tr >
					<th>確度</th>
					<c:forEach var="kl" items="${kakudoList }">
						<td class="checkbox-options" >
						<html:checkbox  property="searchKakudoList" value="${kl.codeId }" />${kl.codeName }</td>
					</c:forEach>
					<th>担当</th>
					<c:forEach var="el" items="${eigyoList }">
						<td class="checkbox-options"><html:multibox property="searchEigyoList" value="${el.empNo }" />${el.shortEmpName }</td>
					</c:forEach>
				</tr>

				<tr>
					<th>発注タイプ</th>
					<c:forEach var="htl" items="${hattyuTypeList }">
						<td class="checkbox-options"><html:multibox property="searchHattyuTypeList" value="${htl.codeId }" />${htl.codeName }</td>
					</c:forEach>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<th>特殊</th>
					<c:forEach var="ccl" items="${conditionCodeList }" end="${userDataDto.ukUpdate==1 ? '3' : '1'}" >
						<td class="checkbox-options"><html:multibox property="searchConditionCodeList" value="${ccl.codeId }" />${ccl.codeName }</td>
					</c:forEach>
					<td></td>
					<td></td>
				</tr>
			</table>
			<html:submit property="search" value="検索" styleClass="update"></html:submit>
		</div>
	</div>

	</s:form>
</div>

<div class="list-header" style="width: 7500px;">
<table id="list-header" class="list" border="1">
	<tr>
		<th rowspan="2"></th>
		<th rowspan="2">年度</th>
		<th rowspan="2">顧客名</th>
		<th rowspan="2">案　件　名</th>
		<th rowspan="2">受注品名</th>
		<th rowspan="2">開発G</th>
		<th rowspan="2">担当</th>
		<th rowspan="2">発注タイプ</th>
		<th rowspan="2">発注見込時期</th>
		<th rowspan="2">発注日</th>
		<th rowspan="2">検収日</th>
		<th rowspan="2">状況</th>
		<th rowspan="2">テーマ親番</th>
		<th rowspan="2">テーマNO</th>
		<th rowspan="2">受注額(円)</th>
		<!-- <th rowspan="2" class="disabled">売上計</th> -->

		<th colspan="15" id="uriage-keikaku">${searchNendo}年度</th>
		<th colspan="15">${searchNendo+1}年度</th>
		<th rowspan="2" id="uk-yokuyoku">翌々年度移行<br />売上計画</th>
		<th rowspan="2" id="notes">備考</th>
	</tr>
	<tr id="test">
		<th>４月</th>
		<th>５月</th>
		<th>６月</th>
		<th>７月</th>
		<th>８月</th>
		<th>９月</th>
		<th>上期計</th>
		<th>１０月</th>
		<th>１１月</th>
		<th>１２月</th>
		<th>１月</th>
		<th>２月</th>
		<th>３月</th>
		<th>下期計</th>
		<th>当年度計</th>
		<th>４月</th>
		<th>５月</th>
		<th>６月</th>
		<th>７月</th>
		<th>８月</th>
		<th>９月</th>
		<th>上期計</th>
		<th>１０月</th>
		<th>１１月</th>
		<th>１２月</th>
		<th>１月</th>
		<th>２月</th>
		<th>３月</th>
		<th>下期計</th>
		<th>次年度計</th>
	</tr>
</table>
</div>
<div class="list-body" style="width: 7500px;">
<table id="list-body" class="list">
	<c:forEach items="${ukList}" var="e" varStatus="s">

	<tr class="${s.index %2 == 0 ? 'row1' : 'row2'}" id="${s.index}">

		<%-- jqueryでidによる受け渡しも考えたけど、\マークの削除処理とかselectのid受け渡しとかでかえって面倒になった --%>
		<s:form>
		<html:hidden property="ankenId" value="${e.ankenId}" />
		<html:hidden property="ankenRirekiNo" value="${e.ankenRirekiNo}" />
		<html:hidden property="ankenRirekiId" value="${e.ankenRirekiId}" styleClass="anken-rireki-id" />
		<html:hidden property="nendo" value="${e.nendo}" />
		<html:hidden property="kokyakuName" value="${e.kokyakuName}" />
		<html:hidden property="kokyakuInitial" value="${e.kokyakuInitial}" />
		<html:hidden property="ankenName" value="${e.ankenName}" />
		<html:hidden property="jutyuName" value="${e.jutyuName}" />
		<html:hidden property="themeNo" value="${e.themeNo}" />
		<html:hidden property="themeGroup" value="${e.themeGroup}" />
		<html:hidden property="kaihatsuGroupHead" value="${e.kaihatsuGroupHead}" />
		<html:hidden property="kaihatsuGroupHeadName" value="${e.kaihatsuGroupHeadName}" />
		<html:hidden property="eigyo" value="${e.eigyo}" />
		<html:hidden property="eigyoName" value="${e.eigyoName}" />
		<html:hidden property="hattyuTypeCode" value="${e.hattyuTypeCode}" />
		<html:hidden property="hattyuTypeName" value="${e.hattyuTypeName}" />
		<html:hidden property="kakudoCode" value="${e.kakudoCode}" />
		<html:hidden property="kakudoName" value="${e.kakudoName}" />
		<html:hidden property="hattyuMikomiDate" value="${e.hattyuMikomiDate}" />
		<html:hidden property="hattyuDate" value="${e.hattyuDate}" />
		<html:hidden property="kensyuDate" value="${e.kensyuDate}" />
		<html:hidden property="notes" value="${e.notes}" />
		<html:hidden property="jutyugaku" value="${e.jutyugaku}" />
		<html:hidden property="ukYokuyoku" value="${e.ukYokuyoku}" />
		<html:hidden property="ukConditionCode" value="${e.ukConditionCode}" styleId="condition-code" />
		<html:hidden property="insertDate" value="${e.insertDate}" />
		<html:hidden property="insertEmpNo" value="${e.insertEmpNo}" />
		<html:hidden property="tounendoApr" value="${e.tounendoApr}" />
		<html:hidden property="tounendoMay" value="${e.tounendoMay}" />
		<html:hidden property="tounendoJun" value="${e.tounendoJun}" />
		<html:hidden property="tounendoJul" value="${e.tounendoJul}" />
		<html:hidden property="tounendoAug" value="${e.tounendoAug}" />
		<html:hidden property="tounendoSep" value="${e.tounendoSep}" />
		<html:hidden property="tounendoOct" value="${e.tounendoOct}" />
		<html:hidden property="tounendoNov" value="${e.tounendoNov}" />
		<html:hidden property="tounendoDec" value="${e.tounendoDec}" />
		<html:hidden property="tounendoJan" value="${e.tounendoJan}" />
		<html:hidden property="tounendoFeb" value="${e.tounendoFeb}" />
		<html:hidden property="tounendoMar" value="${e.tounendoMar}" />
		<html:hidden property="jinendoApr" value="${e.jinendoApr}" />
		<html:hidden property="jinendoMay" value="${e.jinendoMay}" />
		<html:hidden property="jinendoJun" value="${e.jinendoJun}" />
		<html:hidden property="jinendoJul" value="${e.jinendoJul}" />
		<html:hidden property="jinendoAug" value="${e.jinendoAug}" />
		<html:hidden property="jinendoSep" value="${e.jinendoSep}" />
		<html:hidden property="jinendoOct" value="${e.jinendoOct}" />
		<html:hidden property="jinendoNov" value="${e.jinendoNov}" />
		<html:hidden property="jinendoDec" value="${e.jinendoDec}" />
		<html:hidden property="jinendoJan" value="${e.jinendoJan}" />
		<html:hidden property="jinendoFeb" value="${e.jinendoFeb}" />
		<html:hidden property="jinendoMar" value="${e.jinendoMar}" />
		<html:hidden property="tounendoKamiki" value="${e.tounendoKamiki}" />
		<html:hidden property="tounendoShimoki" value="${e.tounendoShimoki}" />
		<html:hidden property="tounendoTotal" value="${e.tounendoTotal}" />
		<html:hidden property="jinendoKamiki" value="${e.jinendoKamiki}" />
		<html:hidden property="jinendoShimoki" value="${e.jinendoShimoki}" />
		<html:hidden property="jinendoTotal" value="${e.jinendoTotal}" />
		<html:hidden property="zennendoTotal" value="${e.zennendoTotal}" />

		<%--
				<c:if test="${!empty ukUpdate}">
					<td id="${s.index}X1" class="limited-auth"><input type="button" value="選択" onclick="changeColor(${s.index});executeQuote(this);" class="select" /></td>
				</c:if>

		 <td id="${s.index}X1" class="limited-auth"><input type="button" value="選択" onclick="changeColor(${s.index});executeQuote(this);" class="select" /></td>
		 --%>
		 <td id="select-button" class="limited-auth" style="padding:  0;"><input type="button" value="選択" onclick="changeColor(${s.index});executeQuote(${s.index});" class="select" /></td>
				<td id="nendo" class="nendo" style="text-align: center;">
					${f:h(e.nendo) }
				</td>
				<td id="kokyaku-name" class="kokyaku-name" style="text-align: left; padding-left: 5px;">
					${f:h(e.kokyakuInitial)}  ${f:h(e.kokyakuName)}
				</td>
				<td id="anken-name" class="anken-name" style="text-align: left; padding-left: 5px;">
					${f:h(e.ankenName)}
				</td>
				<td id="jutyu-name" class="jutyu-name" style="text-align: left; padding-left: 5px;">
					${f:h(e.jutyuName)}
				</td>
				<td id="kaihatsu-group-head-name" class="short-emp-name" style="text-align: center;">
					${f:h(e.kaihatsuGroupHeadName)}
				</td>
				<td id="eigyo-name" class="short-emp-name" style="text-align: center;">
					${f:h(e.eigyoName)}
				</td>
				<td id="hattyu-type-name" class="hattyu-type" style="text-align: center;">
					${f:h(e.hattyuTypeName)}
				</td>
				<td id="hattyu-mikomi-date" class="date" style="text-align: right; padding-right: 5px;">
					${f:h(e.hattyuMikomiDate)}
				</td>
				<td id="hattyu-date" class="date" style="text-align: right; padding-right: 5px;">
					${f:h(e.hattyuDate)}
				</td>
				<td id="kensyu-date" class="date" style="text-align: right; padding-right: 5px;">
					${f:h(e.kensyuDate)}
				</td>
				<td id="kakudo-name" class="jokyo" style="text-align: center;">
					${f:h(e.kakudoName)}
				</td>
				<td id="theme-group" class="theme-group" style="text-align: center;">
					${f:h(e.themeGroup)}
				</td>
				<td id="theme-no" class="theme-no" style="text-align: center;">
					${f:h(e.themeNo)}
				</td>
				<td id="jutyugaku" class="money" style="text-align: right; padding-right: 5px;">
					¥ <fmt:formatNumber value="${f:h(e.jutyugaku - e.zennendoTotal)}" />
				</td>
				<!-- 売上計は一先ず実装しない
				<td id="uriage-total" class="money" style="text-align: right; padding-right: 5px;">
				</td>
 -->
				<c:if test="${!empty e.tounendoApr}">
					<td id="tounendo-apr" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.tounendoApr)}" />
					</td>
					<td id="tounendo-may" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.tounendoMay)}" />
					</td>
					<td id="tounendo-jun" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.tounendoJun)}" />
					</td>
					<td id="tounendo-jul" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.tounendoJul)}" />
					</td>
					<td id="tounendo-aug" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.tounendoAug)}" />
					</td>
					<td id="tounendo-sep" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.tounendoSep)}" />
					</td>
					<td id="tounendo-kamiki" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.tounendoKamiki)}" />
					</td>
					<td id="tounendo-oct" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.tounendoOct)}" />
					</td>
					<td id="tounendo-nov" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.tounendoNov)}" />
					</td>
					<td id="tounendo-dec" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.tounendoDec)}" />
					</td>
					<td id="tounendo-jan" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.tounendoJan)}" />
					</td>
					<td id="tounendo-feb" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.tounendoFeb)}" />
					</td>
					<td id="tounendo-mar" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.tounendoMar)}" />
					</td>
					<td id="tounendo-shimoki" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.tounendoShimoki)}" />
					</td>
					<td id="tounendo-total" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.tounendoTotal)}" />
					</td>

				</c:if>
				<c:if test="${empty e.tounendoApr}">
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>

				</c:if>

				<c:if test="${!empty e.jinendoApr}">
					<td id="jinendo-apr" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.jinendoApr)}" />
					</td>
					<td id="jinendo-may" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.jinendoMay)}" />
					</td>
					<td id="jinendo-jun" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.jinendoJun)}" />
					</td>
					<td id="jinendo-jul" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.jinendoJul)}" />
					</td>
					<td id="jinendo-aug" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.jinendoAug)}" />
					</td>
					<td id="jinendo-sep" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.jinendoSep)}" />
					</td>
					<td id="jinendo-kamiki" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.jinendoKamiki)}" />
					</td>
					<td id="jinendo-oct" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.jinendoOct)}" />
					</td>
					<td id="jinendo-nov" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.jinendoNov)}" />
					</td>
					<td id="jinendo-dec" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.jinendoDec)}" />
					</td>
					<td id="jinendo-jan" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.jinendoJan)}" />
					</td>
					<td id="jinendo-feb" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.jinendoFeb)}" />
					</td>
					<td id="jinendo-mar" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.jinendoMar)}" />
					</td>
					<td id="jinendo-shimoki" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.jinendoShimoki)}" />
					</td>
					<td id="jinendo-total" class="money" style="text-align: right; padding-right: 5px;">
						¥ <fmt:formatNumber value="${f:h(e.jinendoTotal)}" />
					</td>
				</c:if>
				<c:if test="${empty e.jinendoApr}">
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>

				</c:if>

				<td id="uk-yokuyoku" class="money" style="text-align: right; padding-right: 5px;">
					¥ <fmt:formatNumber value="${f:h(e.ukYokuyoku)}" />
				</td>
				<td id="notes" class="notes" style="text-align: left; padding-left: 5px;">
					${f:h(e.notes)}
				</td>


		</s:form>
	</tr>
	</c:forEach>

	<!-- 小計テーブル -->
	<tr class="blunk" style="height: 100px;"><td colspan="46"></td></tr>
	<c:forEach items="${subtotalKeys}" var="keys" varStatus="s">
		<c:if test="${empty keys}">
			<tr class="blunk"><td colspan="12"></td><td colspan="34" /></tr>
		</c:if>
		<c:if test="${not empty keys}">
			<tr style="border: none;">
				<td colspan="12" class="blunk"></td>
				<th colspan="2" style="border:solid thin black;">${keys}計</th>
				<td id="jutyugaku" class="money">
					\ <fmt:formatNumber>${subtotal[keys].jutyugaku - subtotal[keys].zennendoTotal}</fmt:formatNumber>
				</td>
				<td id="tounendo-Apr" class="money">
					\ <fmt:formatNumber>${subtotal[keys].tounendoApr}</fmt:formatNumber>
				</td>
				<td id="tounendo-may" class="money">
					\ <fmt:formatNumber>${subtotal[keys].tounendoMay}</fmt:formatNumber>
				</td>
				<td id="tounendo-jun" class="money">
					\ <fmt:formatNumber>${subtotal[keys].tounendoJun}</fmt:formatNumber>
				</td>
				<td id="tounendo-jul" class="money">
					\ <fmt:formatNumber>${subtotal[keys].tounendoJul}</fmt:formatNumber>
				</td>
				<td id="tounendo-aug" class="money">
					\ <fmt:formatNumber>${subtotal[keys].tounendoAug}</fmt:formatNumber>
				</td>
				<td id="tounendo-sep" class="money">
					\ <fmt:formatNumber>${subtotal[keys].tounendoSep}</fmt:formatNumber>
				</td>
				<td id="tounendo-kamiki" class="money">
					\ <fmt:formatNumber>${subtotal[keys].tounendoKamiki}</fmt:formatNumber>
				</td>
				<td id="tounendo-oct" class="money">
					\ <fmt:formatNumber>${subtotal[keys].tounendoOct}</fmt:formatNumber>
				</td>
				<td id="tounendo-nov" class="money">
					\ <fmt:formatNumber>${subtotal[keys].tounendoNov}</fmt:formatNumber>
				</td>
				<td id="tounendo-dec" class="money">
					\ <fmt:formatNumber>${subtotal[keys].tounendoDec}</fmt:formatNumber>
				</td>
				<td id="tounendo-jan" class="money">
					\ <fmt:formatNumber>${subtotal[keys].tounendoJan}</fmt:formatNumber>
				</td>
				<td id="tounendo-feb" class="money">
					\ <fmt:formatNumber>${subtotal[keys].tounendoFeb}</fmt:formatNumber>
				</td>
				<td id="tounendo-mar" class="money">
					\ <fmt:formatNumber>${subtotal[keys].tounendoMar}</fmt:formatNumber>
				</td>
				<td id="tounendo-shimoki" class="money">
					\ <fmt:formatNumber>${subtotal[keys].tounendoShimoki}</fmt:formatNumber>
				</td>
				<td id="tounendo-total" class="money">
					\ <fmt:formatNumber>${subtotal[keys].tounendoTotal}</fmt:formatNumber>
				</td>

				<td id="jinendo-apr" class="money">
					\ <fmt:formatNumber>${subtotal[keys].jinendoApr}</fmt:formatNumber>
				</td>
				<td id="jinendo-may" class="money">
					\ <fmt:formatNumber>${subtotal[keys].jinendoMay}</fmt:formatNumber>
				</td>
				<td id="jinendo-jun" class="money">
					\ <fmt:formatNumber>${subtotal[keys].jinendoJun}</fmt:formatNumber>
				</td>
				<td id="jinendo-jul" class="money">
					\ <fmt:formatNumber>${subtotal[keys].jinendoJul}</fmt:formatNumber>
				</td>
				<td id="jinendo-aug" class="money">
					\ <fmt:formatNumber>${subtotal[keys].jinendoAug}</fmt:formatNumber>
				</td>
				<td id="jinendo-sep" class="money">
					\ <fmt:formatNumber>${subtotal[keys].jinendoSep}</fmt:formatNumber>
				</td>
				<td id="jinendo-kamiki" class="money">
					\ <fmt:formatNumber>${subtotal[keys].jinendoKamiki}</fmt:formatNumber>
				</td>
				<td id="jinendo-oct" class="money">
					\ <fmt:formatNumber>${subtotal[keys].jinendoOct}</fmt:formatNumber>
				</td>
				<td id="jinendo-nov" class="money">
					\ <fmt:formatNumber>${subtotal[keys].jinendoNov}</fmt:formatNumber>
				</td>
				<td id="jinendo-dec" class="money">
					\ <fmt:formatNumber>${subtotal[keys].jinendoDec}</fmt:formatNumber>
				</td>
				<td id="jinendo-jan" class="money">
					\ <fmt:formatNumber>${subtotal[keys].jinendoJan}</fmt:formatNumber>
				</td>
				<td id="jinendo-feb" class="money">
					\ <fmt:formatNumber>${subtotal[keys].jinendoFeb}</fmt:formatNumber>
				</td>
				<td id="jinendo-mar" class="money">
					\ <fmt:formatNumber>${subtotal[keys].jinendoMar}</fmt:formatNumber>
				</td>
				<td id="jinendo-shimoki" class="money">
					\ <fmt:formatNumber>${subtotal[keys].jinendoShimoki}</fmt:formatNumber>
				</td>
				<td id="jinendo-total" class="money">
					\ <fmt:formatNumber>${subtotal[keys].jinendoTotal}</fmt:formatNumber>
				</td>
				<td id="uk-yokuyoku" class="money">
					\ <fmt:formatNumber>${subtotal[keys].ukYokuyoku}</fmt:formatNumber>
				</td>
			</tr>
		</c:if>
	</c:forEach>
</table>
</div>


<script type="text/javascript">
//即時関数を利用してtableのヘッダを固定
//tableのclassを設定すれば動くように改良
//呼び出しタイミングだけ出来てないので仕方なくここで宣言
$(window).on('load resize',function() {
	//ヘッダが２行あるので細かく対応
	//1行目の案件ヘッダの長さを調整して、2行目の売上計画ヘッダの長さを調整
	//最後に繰り返し条件から漏れる備考と翌々年度売上計画ヘッダを調整
	//ちゃんとセルにid付けて対応させてないからカラム変更しただけでバグる可能性がある。注意。

	$('#loading').css('display', 'none');

	maxCols = $('.list')[0].rows[0].cells.length;//listクラスのテーブルの行数を取得
	maxCols2 = $('#list-header')[0].rows[1].cells.length;
	cols2 = 0;//listクラスのテーブルの行数を取得

	for(i=0; i<maxCols; i++){
		//ヘッダ１行目のth#uriage-keikakuまで
		rel = $('.list-header tr:eq(0)').find("th:eq("+i+")");
		if(rel.attr('id') == 'uriage-keikaku'){
			cols2 = i;
			continue;
		}
		rel.css('width', $('.list-body').find("td:eq("+i+")").innerWidth()-1);//innerWidthでpaddingを含む。なぜか+1多くなるので調整。

		//console.log($('.list-body').find("td:eq(1)").text());
		//console.log($('.list-header').find("th:eq(1)").text());
	}
	for(i=0; i<maxCols2; i++){
		$('.list-header tr:eq(1)').find("th:eq("+i+")").css('width', $('.list-body').find("td:eq("+ (i+cols2) +")").innerWidth()-1);//innerWidthでpaddingを含む。なぜか+1多くなるので調整。
		//console.log($('.list-body ').find("td:eq("+(i+cols1)+")").text());
		//console.log($('.list-header  tr:eq(1)').find("th:eq("+ (i) +")").text());
	}

	$('.list-header tr:eq(0)').find("#uk-yokuyoku").css('width', $('.list-body').find('#uk-yokuyoku').innerWidth()-1);//翌翌年度以降売上計画
	$('.list-header tr:eq(0)').find("#notes").css('width', $('.list-body').find('#notes').innerWidth()-1);//備考
	//console.log($('.list-header tr:eq(0)').find("th:eq("+19+")").text());
	//console.log($('.list-body').find('#uk-yokuyoku').innerWidth());

	console.log('table fixed');

	changeExecuteRowColor('anken-rireki-id');

	initializeUnfixedHeight();

	$('#main-contents').css('visibility', 'visible');

}());
</script>

</div>
</body>
</html>