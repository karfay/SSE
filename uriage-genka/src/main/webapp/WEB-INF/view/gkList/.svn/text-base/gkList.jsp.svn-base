<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" type="text/css" href="${f:url('/css/new-global.css')}"></link>
<style type="text/css">

div.input-form{
	background-color:#f8e58c;
	width:100%;
	left:0;
	padding:5px 30px;
}
div.input-form table{background-color: transparent; border: none; padding-top: 5px;}
div.input-form font{font-weight:bold;}

div.search-form{
	background-color:#afeeee;
	width:7500px;
	left:0;
	padding:5px 30px;
}
div.search-form table{background-color: transparent; border: none; padding-top: 5px;}
div.search-form{font-weight:bold;}

input[type="text"]{width:100%;}
div.list-header{position: fixed; z-index: 9999; width:2000px;}
div.list-body{position: absolute; width: 2000px;}
div.unfixed table{
	table-layout: fixed;
	border-collapse: collapse;
	border: solid thin black;
}
.theme-no{width: 100px;}
.theme-group{width: 100px;}
.initial{width: 50px}
#insert-button{
	width: 250px;
}
</style>

<script type="text/javascript" src="${f:url('/javascript/checkDatePattern.js')}"></script>
<script type="text/javascript" src="${f:url('/javascript/jquery-3.1.1.min.js')}"></script>
<script type="text/javascript">
function checkInsert(){
	var input = document.forms["input"];
	if(input.themeNo.value==''){
		window.alert('テーマNOは必須です。');
		return false;

	return confirm('入力した内容で新規作成します');
	}
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
		//何もしない
	}else{
		window.alert('テーマNOに相応しくありません。入力し直して下さい。');
		document.forms["input"].themeNo.value = '';
		document.forms["input"].themeNo.focus();
	}
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
	$('div.list-header').css('top', $('div.fixed').offset().top + $('div.fixed').height());
	$('div.list-body').css('top', $('div.list-header').offset().top + $('div.list-header').height());
}

//var listHeader = $('div#list-header');
window.addEventListener('scroll', _hangleScroll, false);
function _hangleScroll(){
	$('div#list-header').css('left',  - window.scrollX + 8);
	//console.log($('div#list-header').css('left'));
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
			<c:if test="${userDataDto.gkInsert==1}">
				<s:form styleId="input">
				<table><tr>
					<th>テーマNO</th>
					<td><html:text property="themeNo" onblur="checkThemeNo()"></html:text></td>
					<td width="10px"></td>
					<td><html:submit property="newCreate" value="原価管理表を新規作成" onclick="return checkInsert()" styleClass="insert" styleId="insert-button"></html:submit></td>
				</tr></table>
				</s:form>
			</c:if>
		</div>

		<div class="search-form">
			<table><tr>
				<td><html:select property="nendo" value="${nendo}">
					<c:forEach var="e" items="${nendoList}">
						<html:option value="${e.nendo}">${e.nendo}</html:option>
					</c:forEach>
				</html:select></td>
				<td>年度　　</td>
				<td><html:submit property="search" value="検索" styleClass="normal" ></html:submit></td>
			</tr></table>
		</div>
	</div>

	<div class="unfixed" id="unfixed">
		<div class="list-header">
			<table border="1" class="list-header" id="list-header">
			<tr>
				<th id="theme-group" class="theme-group">テーマ親番</th>
				<th id="theme-no" class="theme-no">テーマNO</th>
				<th id="kokyaku-initial" class="initial">ｲﾆｼｬﾙ</th>
				<th id="theme-name" class="name">テーマ名</th>
			</tr>
			</table>
		</div>

		<div class="list-body">
			<table border="1" class="list" id="list-body">
			<c:forEach var="e" varStatus="s" items="${gkList}">
				<s:form>
				<tr class="${s.index %2 == 0 ? 'row1' : 'row2'}" id="${s.index}">
					<td id="theme-group" class="theme-group" style="text-align: center;">
						${f:h(e.themeGroup) }
					</td>
					<td id="theme-no" class="theme-no" style="text-align: center;">

					</td>
					<td id="kokyaku-initial" class="initial" style="text-align: center;">
						${f:h(e.kokyakuInitial)}
					</td>
					<td id="theme-name" class="name" style="text-align: left; padding-left: 5px;">
						${f:h(e.themeName)}
					</td>
				</tr>
				</s:form>
			</c:forEach>
			</table>
		</div>
	</div>
</div>
<script type="text/javascript">
//即時関数を利用してtableのヘッダを固定
$(window).on('load resize',function() {

	$('#loading').css('display', 'none');
	$('#main-contents').css('visibility', 'visible');

	initializeUnfixedHeight();

	maxCols = 4;//$('.list-body tr:eq(0)').cells.length();//list-bodyクラスのテーブルの行数を取得

	for(i=0; i<maxCols; i++){
		rel = $('#list-header tr:eq(0)').find("th:eq("+i+")");
		rel.width($('.list-body').find("td:eq("+i+")").width() + 1);//headerとbodyでpaddingを揃えていればwidthで取得できる。

		//console.log($('.list-body').find("td:eq(1)").text());
		//console.log($('.list-header').find("th:eq(1)").text());
	}

	console.log('table fixed');

	$('#main-contents').css('visibility', 'visible');

}());
</script>
</body>
</html>