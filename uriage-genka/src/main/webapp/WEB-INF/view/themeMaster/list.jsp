<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" type="text/css" href="${f:url('/css/global.css')}"></link>

<style type="text/css">
div.hide-input-form{padding-left:15px;}
div.input-form{
	background-color:#f8e58c;
	width:100%;
	left:0;
	padding:5px 30px;
}
div.input-form table{background-color: transparent; border: none; padding-top: 5px;}
div.input-form th{width: 150px;}
div.input-form td{width: 150px;}
div.input-form font{font-weight:bold;}
input[type="text"]{width:100%;}
div.list-header{position: fixed; z-index: 9999; width:2000px;}
div.list-body{position: absolute; width: 2000px;}
table.theme-list{
	table-layout: fixed;
	border-collapse: collapse;
	border: solid thin black;
}
.theme-no{width: 100px;}
.theme-group{width: 100px;}
.name{width: 300px;}
.other{width: 50px}
.limited-auth{width: 50px}
.date{width: 100px;}
.money{width: 100px;}
.percentage{width: 75px;}
</style>

<script type="text/javascript" src="${f:url('/javascript/checkDatePattern.js')}"></script>
<script type="text/javascript" src="${f:url('/javascript/jquery-3.1.1.min.js')}"></script>

<script type="text/javascript">
function executeClear(){

	var input = document.forms["input"];
	input.themeNo.value = '';
	input.themeGroup.value = '';
	input.naiyoKubun.value = '';
	input.uketsukeDate.value = '';
	input.iraiDate.value = '';
	input.nouki.value = '';
	input.jutyuKingaku.value = '';
	input.keikakuGenkaPar.value = '';
	input.torihikisakiCode.value = '';
	input.tantouBumon.value = '';
	input.uriageMonthKubun.value = '';
	input.notesUriageMonthKubun.value = '';
	input.uriageYearMonth.value = '';
	input.themeName.value = '';
	input.shortThemeName.value = '';

	if(orgRow!=null){
		if(orgRow % 2 == 0)document.getElementById(orgRow).className='row1';
		else document.getElementById(orgRow).className='row2';
	}
	//window.alert('入力フォームをクリアしました。');
	return false;
}

function checkInsert(){
	var input = document.forms["input"];
	if(input.themeNo.value==''){
		window.alert('テーマNOは必須です。');
		return false;
	}
	if(input.themeGroup.value==''){
		window.alert('テーマ親番は必須です。');
		return false;
	}
	if(input.themeName.value==''){
		window.alert('テーマ名は必須です。');
		return false;
	}
	return confirm('入力した内容で新規作成します');
}

function checkUpdate(){
	if(checkQuote() == false)return false;
	else return window.confirm('更新して良いですか？');
}

function checkDelete(){
	if(checkQuote() == false)return false;
	else return window.confirm('削除して良いですか？');
}

function checkQuote(){
	if(document.forms["input"].themeNo.value == ''){
		window.alert('対象が選択されていません');
		return false;
	} else return true;
}

function executeQuote(obj){

	var input = document.forms["input"];
	input.themeNo.value = obj.form.themeNo.value;
	input.themeGroup.value = obj.form.themeGroup.value;
	input.naiyoKubun.value = obj.form.naiyoKubun.value;
	input.uketsukeDate.value = obj.form.uketsukeDate.value;
	input.iraiDate.value = obj.form.iraiDate.value;
	input.nouki.value = obj.form.nouki.value;
//受注額のみ3桁区切り数値に変換
	input.jutyuKingaku.value = Number(obj.form.jutyuKingaku.value).toLocaleString();
	input.keikakuGenkaPar.value = obj.form.keikakuGenkaPar.value;
	input.torihikisakiCode.value = obj.form.torihikisakiCode.value;
	input.tantouBumon.value = obj.form.tantouBumon.value;
	input.uriageMonthKubun.value = obj.form.uriageMonthKubun.value;
	input.notesUriageMonthKubun.value = obj.form.notesUriageMonthKubun.value;
	input.uriageYearMonth.value = obj.form.uriageYearMonth.value;
	input.themeName.value = obj.form.themeName.value;
	input.shortThemeName.value = obj.form.shortThemeName.value;
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
	if(str == '')return;
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
	if(str.match(/^[0-9]{8}$/)){
		str = str.substring(0,5)+'-'+str.substring(5,8);
		document.forms["input"].themeGroup.value = str;
	}
	if(str.match(/[0-9]{5}-[0-9]{3}/))return;

	window.alert('テーマ親番に相応しくありません。入力し直して下さい。');
	document.forms["input"].themeGroup.value = '';
	document.forms["input"].themeGroup.focus();
}

document.onkeydown = KeyEvent;
function KeyEvent(e){
    var pressKey=event.keyCode;
    if(pressKey == 13) {
	return false;
    }
}

function checkMoney(obj){
	str = obj.value;
	if(str=='')return;
	number = Number(str);
	if(isInteger(number)==true && number > 0){
		obj.value=number.toLocaleString();
		return;
	}
	window.alert('金額は自然数でなければいけません。入力し直して下さい。');
	obj.value='';

	function isInteger(x) {
	    return Math.round(x) === x;
	}
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
	if(${empty themeInsert}){
		console.log('no authorization');
	}

	$('div.fixed').css('top', $('div.header').height());
	$('div.list-header').css('top', $('div.header').height()+$('div.fixed').height());
	$('div.list-body').css('top', $('div.header').height()+ $('div.fixed').height()+ $('div.list-header').height());
}

//var listHeader = $('div#list-header');
window.addEventListener('scroll', _hangleScroll, false);
function _hangleScroll(){
	$('div#list-header').css('left',  - window.scrollX + 8);
	//console.log($('div#list-header').css('left'));
}

//list-bodyの<td class="keyClass">を順次チェックして、newInsertまたはnewUpdateに該当するものがあったら列の色を変える。
//keyClassクラスはその列で一意のクラスでなければならない。text()で複数の要素をまとめて取り出してしまうため。
//対象が複数であっても問題なく色が変わる。ただし対象は列ごと。
function changeExecuteRowColor(keyClass){
	$('.list-body tr').each(function(){
		//keyClass = 'theme-no';
		//console.log('check');
		if($.trim($(this).children('td.'+keyClass).text()) == '${newInsert}'){
			$(this).css('border','solid 2px red');//2px以上にすると、別のテーブルのbordarに影響が出る。謎。
		}
		else if($.trim($(this).children('td.'+keyClass).text()) == '${newUpdate}'){
			$(this).css('border','solid 2px aqua');
		}
	});
}

</script>
<title>${pageName}</title>
</head>
<body onload="initializeUnfixedHeight()">

<div class="header" id="header">
${sysName} / ${pageName}
</div>

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

<div class="input-form">

<c:if test="${!empty themeInsert}">
	<s:form styleId="input">
	<font>入力フォーム</font>
	<input type="button" onclick="hideDiv('hideInputForm', this)" value="非表示" class="normal" />

		<div class="hide-input-form" id="hideInputForm">
		<table id="inputForm">
			<tr>
				<th> テーマNO </th>
				<th> テーマ親番 </th>
				<th> 内容区分 </th>
				<th> 受付日 </th>
				<th> 依頼日 </th>
				<th> 納期（検収日） </th>
				<th> 受注金額（円） </th>
			</tr><tr>
				<td>
					<html:text property="themeNo" styleClass="required" errorStyleClass="error" onblur="return checkThemeNo()" />
				</td>
				<td>
					<html:text property="themeGroup" styleClass="required" errorStyleClass="error" onblur="return checkThemeGroup()" />
				</td>
				<td>
					<html:text property="naiyoKubun" />
				</td>

				<td>
					<html:text property="uketsukeDate" onblur="return checkDatePattern(this)" />
				</td>

				<td>
					<html:text property="iraiDate" onblur="return checkDatePattern(this)" />
				</td>

				<td>
					<html:text property="nouki" onblur="return checkDatePattern(this)" />
				</td>

				<td>
					<html:text property="jutyuKingaku" onblur="checkMoney(this)" />
				</td>
				</tr>
				<tr>
				<th> 計画原価率（％） </th>
				<th> 取引先CD </th>
				<th> 担当部門 </th>
				<th> 売上月区分 </th>
				<th> 売上月区分（備考） </th>
				<th> 売上年月 </th>
				</tr><tr>
				<td>
					<html:text property="keikakuGenkaPar" onblur="checkParcentage(this)" />
				</td>
				<td>
					<html:text property="torihikisakiCode" />
				</td>

				<td>
					<html:text property="tantouBumon" />
				</td>

				<td>
					<html:text property="uriageMonthKubun" />
				</td>

				<td>
					<html:text property="notesUriageMonthKubun" />
				</td>

				<td>
					<html:text property="uriageYearMonth" />
				</td>
			</tr>
			<tr>
				<th> テーマ名 </th>
				<td colspan="6">
					<html:text property="themeName"  styleClass="required" errorStyleClass="error" />
				</td>
			</tr>
			<tr>
				<th> テーマ略称 </th>
				<td colspan="6">
					<html:text property="shortThemeName" styleClass="width:100%;" />
				</td>
			</tr>
		</table>
		<input type="submit" onclick="return checkInsert()" name="insert" value="新規作成" class="insert" />
		<input type="submit" onclick="return checkUpdate()" name="update" value="更新" class="update" />
		<input type="submit" onclick="return checkDelete()" name="delete" value="削除" class="delete" />
		<input type="button" onclick="return executeClear()" value="クリア" class="normal" />
		</div>
	</s:form>
</c:if>
</div>
</div>
<div class="unfixed" id="unfixed">
	<div class="list-header" id="list-header">
		<table border="1" class="theme-list" id="theme-list-header" >
		<tr>
			<c:if test="${!empty themeInsert}">
				<th id="X1" class="limited-auth"></th>
			</c:if>
			<th id="X2" class="theme-no">テーマNO</th>
			<th id="X3" class="theme-group">テーマ親番</th>
			<th id="X4" class="name">テーマ名</th>
			<th id="X5" class="name">テーマ略称</th>
			<th id="X6" class="other">内容<br /></>区分</th>
			<th id="X7" class="date">受付日</th>
			<th id="X8" class="date">依頼日</th>
			<th id="X9" class="date">納期</th>
			<th id="X10" class="money">受注金額</th>
			<th id="X11" class="parcentage">計画原価率</th>
			<th id="X12" class="other">取引先<br />CD</th>
			<th id="X13" class="other">担当<br />部門</th>
			<th id="X14" class="other">売上月<br />区分</th>
			<th id="X15" class="other">売上月<br />区分<br />(備考)</th>
			<th id="X16" class="other">売上<br />年月</th>
		</tr>
		</table>
	</div>

	<div class="list-body">
		<table border="1" class="theme-list" id="theme-list-body">
		<c:forEach var="e" varStatus="s" items="${themeMasterItems}">
			<s:form>
			<html:hidden property="themeNo" value="${f:h(e.themeNo)}" />
			<html:hidden property="themeGroup" value="${f:h(e.themeGroup)}" />
			<html:hidden property="themeName" value="${f:h(e.themeName)}" />
			<html:hidden property="shortThemeName" value="${f:h(e.shortThemeName)}" />
			<html:hidden property="naiyoKubun" value="${f:h(e.naiyoKubun)}" />
			<html:hidden property="uketsukeDate" value="${f:h(e.uketsukeDate)}" />
			<html:hidden property="iraiDate" value="${f:h(e.iraiDate)}" />
			<html:hidden property="nouki" value="${f:h(e.nouki)}" />
			<html:hidden property="jutyuKingaku" value="${f:h(e.jutyuKingaku)}" />
			<html:hidden property="keikakuGenkaPar" value="${f:h(e.keikakuGenkaPar)}" />
			<html:hidden property="torihikisakiCode" value="${f:h(e.torihikisakiCode)}" />
			<html:hidden property="tantouBumon" value="${f:h(e.tantouBumon)}" />
			<html:hidden property="uriageMonthKubun" value="${f:h(e.uriageMonthKubun)}" />
			<html:hidden property="notesUriageMonthKubun" value="${f:h(e.notesUriageMonthKubun)}" />
			<html:hidden property="uriageYearMonth" value="${f:h(e.uriageYearMonth)}" />

			<tr class="${s.index %2 == 0 ? 'row1' : 'row2'}" id="${s.index}">
				<c:if test="${!empty themeInsert}">
					<td id="${s.index}X1" class="limited-auth"><input type="button" value="選択" onclick="changeColor(${s.index});executeQuote(this);" class="select" /></td>
				</c:if>
				<td id="${s.index}X2" class="theme-no" style="text-align: center;">
					${f:h(e.themeNo) }
				</td>
				<td id="${s.index}X3" class="theme-group" style="text-align: center;">
					${f:h(e.themeGroup)}
				</td>
				<td id="${s.index}X4" class="name" style="text-align: left; padding-left: 5px;">
					${f:h(e.themeName)}
				</td>
				<td id="${s.index}X5" class="name" style="text-align: left; padding-left: 5px;">
					${f:h(e.shortThemeName)}
				</td>
				<td id="${s.index}X6" class="other">
					${f:h(e.naiyoKubun)}
				</td>
				<td id="${s.index}X7" class="date" style="text-align: right; padding-right: 5px;">
					${f:h(e.uketsukeDate)}
				</td>
				<td id="${s.index}X8" class="date" style="text-align: right; padding-right: 5px;">
					${f:h(e.iraiDate)}
				</td>
				<td id="${s.index}X9" class="date" style="text-align: right; padding-right: 5px;">
					${f:h(e.nouki)}
				</td>
				<td id="${s.index}X10" class="money" style="text-align: right; padding-right: 5px;">
					¥ <fmt:formatNumber value="${f:h(e.jutyuKingaku)}" />
				</td>
				<td id="${s.index}X11" class="percentage" style="text-align: right; padding-right: 5px;">
					${f:h(e.keikakuGenkaPar)} %
				</td>
				<td id="${s.index}X12" class="other">
					${f:h(e.torihikisakiCode)}
				</td>
				<td id="${s.index}X13" class="other">
					${f:h(e.tantouBumon)}
				</td>
				<td id="${s.index}X14" class="other" style="text-align: right; padding-right: 5px;">
					${f:h(e.uriageMonthKubun)}
				</td>
				<td id="${s.index}X15" class="other">
					${f:h(e.notesUriageMonthKubun)}
				</td>
				<td id="${s.index}X16" class="other">
					${f:h(e.uriageYearMonth)}
				</td>
			</tr>
			</s:form>
		</c:forEach>
		</table>
	</div>
</div>
<script type="text/javascript">
//即時関数を利用してtableのヘッダを固定
//colsはテーブルの列数（カラム数）
(function(cols) {
	for(var i=1; i<=cols; i++){
		$('#X'+i).css('width', $('#1X'+i).innerWidth()-1);//innerWidthでpaddingを含む。なぜか+1多くなるので調整。
		console.log($('#1X'+i).outerWidth());
		console.log($('#X'+i).outerWidth());
	}
	console.log('table fixed');

	changeExecuteRowColor('theme-no');
}(16));

</script>
</body>
</html>