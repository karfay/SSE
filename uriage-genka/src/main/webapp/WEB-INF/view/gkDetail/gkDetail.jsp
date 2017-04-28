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
	str = obj.value;
	if(str==''){
		obj.value='0';
		return;
	}
	number = Number(str);
	if(isInteger(number)==true && number >= 0){
		obj.value=number.toLocaleString();
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
	if(str.match(/^([1-9]\d*|0)(\.\d)$/g))return;
	number = Number(str);
	if(isInteger(number)==true && number >= 0){
		obj.value = number.toLocaleString(undefined, {minimumFractionDigits: 1});
		return;
	}
	window.alert('工数は小数第一位までの数値のみ有効です。入力し直して下さい。\n【受け付ける数値例】1,10.0,65.5');
	obj.value='0.0';
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

		<table border="1">
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
		<html:submit property="updateGenkaKanri" value="基本情報を修正" styleClass="normal" />
		<html:submit property="/ukList/" value="売上計画内訳" styleClass="normal" />
		<html:submit property="showBikou" value="備考・状況報告" styleClass="normal" />
		<html:submit property="update" value="原価情報を更新" styleClass="update" />
		<div class="space"></div>
	</div>

	<div class="unfixed" id="unfixed">
		<table border="1">
		<c:forEach var="mapItems" varStatus="s" items="${mapItemsItems}">
		    <c:forEach var="m" varStatus="s2" items="${mapItems}">
		    <%--
		    **************************************************************
		    月別原価情報の場合
		     --%>
	<c:if test="${m.gkConditionCode==401 }">
		    <tr>
		    	<th colspan="4">${f:h(m.themeNo)}
		        </th>
		    </tr>
		    <tr>
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
		    <tr>
		    	<th class="sub">労務費</th>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.KRoumuhi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KRoumuhi" value="${m.KRoumuhi }" />
		    	</td>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.MRoumuhi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MRoumuhi" value="${m.MRoumuhi }" />
		    	</td>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.JRoumuhi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JRoumuhi" value="${m.JRoumuhi }" />
		    	</td>
				<td class="space"></td>
				<td class="no-input"><fmt:formatNumber value="${f:h(m.KMGap)}" />
				<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KMGap" value="${m.KMGap }" />
				</td>
				<td class="no-input"><fmt:formatNumber value="${f:h(m.KJGap)}" />
				<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KJGap" value="${m.KJGap }" />
				</td>
				<td class="space"></td>
		    	<th class="sub">計画</th>
		    	<td class="no-input">要計算</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="input">
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
					<td class="input">
					<fmt:formatNumber var="KKousu" value="${f:h(kt.KKousu)}" />
					<html:text property="mapItemsItems[${s.index}][${s3.index}].KKousu"
					value="${KKousu}" onblur="checkMoney(this)" />
					</td>
				</c:if>
				</c:forEach>
		    </tr>
		    <tr>
		    	<th class="sub">工数</th>
		    	<td class="no-input"><fmt:formatNumber pattern="###,##0.0" value="${f:h(m.KKousu)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KKousu" value="${m.KKousu }" />
		    	</td>
		    	<td class="no-input"><fmt:formatNumber pattern="###,##0.0" value="${f:h(m.MKousu)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MKousu" value="${m.MKousu }" />
		    	</td>
		    	<td class="input">
		    	<fmt:formatNumber var="JKousu" pattern="###,##0.0" value="${f:h(m.JKousu)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].JKousu"
				value="${JKousu}" onblur="checkKousu(this)" />
				</td>
				<td class="space"></td>
				<td class="space"></td>
				<td class="space"></td>
				<td class="space"></td>
		    	<th class="sub">見込</th>
		    	<td class="no-input">要計算</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="input">
					<fmt:formatNumber var="MKousu" pattern="###,##0.0" value="${f:h(kt.MKousu)}" />
					<html:text property="mapItemsItems[${s.index}][${s3.index}].MKousu"
					value="${MKousu}" onblur="checkKousu(this)" />
					</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<%--外注費は本来Costだけど、java側の処理上マップのキーをKousuにしている --%>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==1 }">
					<td class="input">
					<fmt:formatNumber var="MKousu" value="${f:h(kt.MKousu)}" />
					<html:text property="mapItemsItems[${s.index}][${s3.index}].MKousu"
					value="${MKousu}" onblur="checkMoney(this)" />
					</td>
				</c:if>
				</c:forEach>
		    </tr>
		    <tr>
		    	<th class="sub">単価</th>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.KTanka)}" /></td>
		    	<td class="input">
		    	<fmt:formatNumber var="MTanka" pattern="###,##0" value="${f:h(m.MTanka)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].MTanka"
				value="${MTanka}" onblur="checkMoney(this)" />
				</td>
				<td class="input">
		    	<fmt:formatNumber var="JTanka" pattern="###,##0" value="${f:h(m.JTanka)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].JTanka"
				value="${JTanka}" onblur="checkMoney(this)" />
				</td>
				<td class="space"></td>
				<td class="space"></td>
				<td class="space"></td>
				<td class="space"></td>
		    	<th class="sub">実績</th>
		    	<td class="no-input">要計算</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="input">
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
					<td class="input">
					<fmt:formatNumber var="JKousu" value="${f:h(kt.JKousu)}" />
					<html:text property="mapItemsItems[${s.index}][${s3.index}].JKousu"
					value="${JKousu}" onblur="checkMoney(this)" />
					</td>
				</c:if>
				</c:forEach>
		    </tr>

		    <tr>
		    	<th class="sub">外注加工費</th>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.KGaityu)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KGaityu" value="${m.KGaityu }" />
		    	</td>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.MGaityu)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MGaityu" value="${m.MGaityu }" />
		    	</td>
		    	<td class="input">
		    	<fmt:formatNumber var="JGaityu" pattern="###,##0" value="${f:h(m.JGaityu)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].JGaityu"
				value="${JGaityu}" onblur="checkMoney(this)" />
				</td>
				<td class="space"></td>
				<td class="space"></td>
				<td class="space"></td>
				<td class="space"></td>
		    	<th class="sub">計/見 差異</th>
		    	<td class="no-input">要計算</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="no-input">
					<fmt:formatNumber pattern="###,##0.0" value="${kt.KKousu - kt.MKousu }" />
					</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
				<c:if test="${kt.gaityuFlag==1 }">
					<td class="no-input">
					<fmt:formatNumber value="${kt.KKousu - kt.MKousu }" />
					</td>
				</c:if>
				</c:forEach>
		    </tr>

		    <tr>
		    	<th class="sub">旅費交通費</th>
		    	<td class="input">
		    	<fmt:formatNumber var="KRyohi" pattern="###,##0" value="${f:h(m.KRyohi)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].KRyohi"
				value="${KRyohi}" onblur="checkMoney(this)" />
				</td>
		    	<td class="input">
		    	<fmt:formatNumber var="MRyohi" pattern="###,##0" value="${f:h(m.MRyohi)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].MRyohi"
				value="${MRyohi}" onblur="checkMoney(this)" />
				</td>
		    	<td class="input">
		    	<fmt:formatNumber var="JRyohi" pattern="###,##0" value="${f:h(m.JRyohi)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].JRyohi"
				value="${JRyohi}" onblur="checkMoney(this)" />
				</td>
				<td class="space"></td>
				<td class="space"></td>
				<td class="space"></td>
				<td class="space"></td>
		    	<th class="sub">計/実 差異</th>
		    	<td class="no-input">要計算</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="no-input">
					<fmt:formatNumber pattern="###,##0.0" value="${kt.KKousu - kt.JKousu }" />
					</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
				<c:if test="${kt.gaityuFlag==1 }">
					<td class="no-input">
					<fmt:formatNumber value="${kt.KKousu - kt.JKousu }" />
					</td>
				</c:if>
				</c:forEach>
		    </tr>

		    <tr>
		    	<th class="sub">その他経費</th>
		    	<td class="input">
		    	<fmt:formatNumber var="KSonota" pattern="###,##0" value="${f:h(m.KSonota)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].KSonota"
				value="${KSonota}" onblur="checkMoney(this)" />
				</td>
		    	<td class="input">
		    	<fmt:formatNumber var="MSonota" pattern="###,##0" value="${f:h(m.MSonota)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].MSonota"
				value="${MSonota}" onblur="checkMoney(this)" />
				</td>
		    	<td class="input">
		    	<fmt:formatNumber var="JSonota" pattern="###,##0" value="${f:h(m.JSonota)}" />
				<html:text property="mapItemsItems[${s.index}][${s2.index}].JSonota"
				value="${JSonota}" onblur="checkMoney(this)" />
				</td>
		    </tr>

		    <tr>
		    	<th class="sub">経費合計</th>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.KKeihi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KKeihi" value="${m.KKeihi }" />
		    	</td>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.MKeihi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MKeihi" value="${m.MKeihi }" />
		    	</td>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.JKeihi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JKeihi" value="${m.JKeihi }" />
		    	</td>
		    </tr>

		    <tr>
		    	<th class="sub">合計</th>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.KSum)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KSum" value="${m.KSum }" />
		    	</td>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.MSum)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MSum" value="${m.MSum }" />
		    	</td>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.JSum)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JSum" value="${m.JSum }" />
		    	</td>
		    </tr>
	</c:if>

		    <%--
		    **************************************************************
		    プロジェクト合計の場合
		     --%>
	<c:if test="${m.gkConditionCode==403 }">
		    <tr>
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
		    <tr>
		    	<th class="sub">労務費</th>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.KRoumuhi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KRoumuhi" value="${m.KRoumuhi }" />
		    	</td>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.MRoumuhi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MRoumuhi" value="${m.MRoumuhi }" />
		    	</td>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.JRoumuhi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JRoumuhi" value="${m.JRoumuhi }" />
		    	</td>
				<td class="space"></td>
				<td class="no-input"><fmt:formatNumber value="${f:h(m.KMGap)}" />
				<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KMGap" value="${m.KMGap }" />
				</td>
				<td class="no-input"><fmt:formatNumber value="${f:h(m.KJGap)}" />
				<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KJGap" value="${m.KJGap }" />
				</td>
				<td class="space"></td>
		    	<th class="sub">計画</th>
		    	<td class="no-input">要計算</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="no-input">要計算</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==1 }">
					<td class="no-input">要計算</td>
				</c:if>
				</c:forEach>
		    </tr>
		    <tr>
		    	<th class="sub">工数</th>
		    	<td class="no-input"><fmt:formatNumber pattern="###,##0.0" value="${f:h(m.KKousu)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KKousu" value="${m.KKousu }" />
		    	</td>
		    	<td class="no-input"><fmt:formatNumber pattern="###,##0.0" value="${f:h(m.MKousu)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MKousu" value="${m.MKousu }" />
		    	</td>
		    	<td class="no-input"><fmt:formatNumber pattern="###,##0.0" value="${f:h(m.JKousu)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JKousu" value="${m.JKousu }" />
		    	</td>
				<td class="space"></td>
				<th class="sub" rowspan="2">売上金額</th>
				<th class="sub" rowspan="2">平均単価</th>
				<td class="space"></td>
		    	<th class="sub">見込</th>
		    	<td class="no-input">要計算</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="no-input">要計算</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==1 }">
					<td class="no-input">要計算</td>
				</c:if>
				</c:forEach>
		    </tr>
		    <tr>
		    	<th class="sub">外注加工費</th>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.KGaityu)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KGaityu" value="${m.KGaityu }" />
		    	</td>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.MGaityu)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MGaityu" value="${m.MGaityu }" />
		    	</td>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.JGaityu)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JGaityu" value="${m.JGaityu }" />
		    	</td>
				<td class="space"></td>
				<td class="space"></td>
		    	<th class="sub">実績</th>
		    	<td class="no-input">要計算</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="no-input">要計算</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==1 }">
					<td class="no-input">要計算</td>
				</c:if>
				</c:forEach>
		    </tr>

		    <tr>
		    	<th class="sub">旅費交通費</th>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.KRyohi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KRyohi" value="${m.KRyohi }" />
		    	</td>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.MRyohi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MRyohi" value="${m.MRyohi }" />
		    	</td>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.JRyohi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JRyohi" value="${m.JRyohi }" />
		    	</td>
				<td class="space"></td>
				<td class="no-input"><fmt:formatNumber value="${f:h(m.uriage)}" /></td>
				<td class="no-input"><fmt:formatNumber pattern="###,##0.0" value="${f:h(m.JTanka)}" />
				<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JTanka" value="${m.JTanka }" />
				</td>
				<td class="space"></td>
		    	<th class="sub">計/見 差異</th>
		    	<td class="no-input">要計算</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="no-input">要計算</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==1 }">
					<td class="no-input">要計算</td>
				</c:if>
				</c:forEach>
		    </tr>

		    <tr>
		    	<th class="sub">その他経費</th>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.KSonota)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KSonota" value="${m.KSonota }" />
		    	</td>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.MSonota)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MSonota" value="${m.MSonota }" />
		    	</td>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.JSonota)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JSonota" value="${m.JSonota }" />
		    	</td>
				<td class="space"></td>
				<th class="sub" rowspan="2">粗利金額</th>
				<th class="sub" rowspan="2">粗利率</th>
				<td class="space"></td>
		    	<th class="sub">計/実 差異</th>
		    	<td class="no-input">要計算</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="no-input">要計算</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==1 }">
					<td class="no-input">要計算</td>
				</c:if>
				</c:forEach>
		    </tr>

		    <tr>
		    	<th class="sub">経費合計</th>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.KKeihi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KKeihi" value="${m.KKeihi }" />
		    	</td>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.MKeihi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MKeihi" value="${m.MKeihi }" />
		    	</td>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.JKeihi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JKeihi" value="${m.JKeihi }" />
		    	</td>
		    </tr>

		    <tr>
		    	<th class="sub">合計</th>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.KSum)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KSum" value="${m.KSum }" />
		    	</td>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.MSum)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MSum" value="${m.MSum }" />
		    	</td>
		    	<td class="no-input"><fmt:formatNumber value="${f:h(m.JSum)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JSum" value="${m.JSum }" />
		    	</td>
		    	<td class="space"></td>
				<td class="no-input"><fmt:formatNumber value="${f:h(m.uriage - m.JSum)}" /></td>
				<td class="no-input"><fmt:formatNumber pattern="###,##0.0"
				value="${f:h(m.JSum==0 ? 0 : m.JSum / (m.uriage - m.JSum))}" /></td>
				<td class="space"></td>
		    </tr>
	</c:if>


		    <%--
		    **************************************************************
		    仕掛り計の場合
		     --%>
	<c:if test="${m.gkConditionCode==402 }">
		    <tr>
		    	<th class="shikakari" colspan="4">${f:h(m.themeNo)}
		        </th>
		    </tr>
		    <tr>
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
		    <tr>
		    	<th class="shikakari-sub">労務費</th>
		    	<td class="shikakari-no-input"><fmt:formatNumber value="${f:h(m.KRoumuhi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KRoumuhi" value="${m.KRoumuhi }" />
		    	</td>
		    	<td class="shikakari-no-input"><fmt:formatNumber value="${f:h(m.MRoumuhi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MRoumuhi" value="${m.MRoumuhi }" />
		    	</td>
		    	<td class="shikakari-no-input"><fmt:formatNumber value="${f:h(m.JRoumuhi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JRoumuhi" value="${m.JRoumuhi }" />
		    	</td>
				<td class="space"></td>
				<td class="shikakari-no-input"><fmt:formatNumber value="${f:h(m.KMGap)}" />
				<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KMGap" value="${m.KMGap }" />
				</td>
				<td class="shikakari-no-input"><fmt:formatNumber value="${f:h(m.KJGap)}" />
				<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KJGap" value="${m.KJGap }" />
				</td>
				<td class="space"></td>
		    	<th class="shikakari-sub">計画</th>
		    	<td class="shikakari-no-input">要計算</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="shikakari-no-input">要計算</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==1 }">
					<td class="shikakari-no-input">要計算</td>
				</c:if>
				</c:forEach>
		    </tr>
		    <tr>
		    	<th class="shikakari-sub">工数</th>
		    	<td class="shikakari-no-input"><fmt:formatNumber pattern="###,##0.0" value="${f:h(m.KKousu)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KKousu" value="${m.KKousu }" />
		    	</td>
		    	<td class="shikakari-no-input"><fmt:formatNumber pattern="###,##0.0" value="${f:h(m.MKousu)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MKousu" value="${m.MKousu }" />
		    	</td>
		    	<td class="shikakari-no-input"><fmt:formatNumber pattern="###,##0.0" value="${f:h(m.JKousu)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JKousu" value="${m.JKousu }" />
		    	</td>
				<td class="space"></td>
				<th class="shikakari-sub" rowspan="2">売上金額</th>
				<th class="shikakari-sub" rowspan="2">平均単価</th>
				<td class="space"></td>
		    	<th class="shikakari-sub">見込</th>
		    	<td class="shikakari-no-input">要計算</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="shikakari-no-input">要計算</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==1 }">
					<td class="shikakari-no-input">要計算</td>
				</c:if>
				</c:forEach>
		    </tr>
		    <tr>
		    	<th class="shikakari-sub">外注加工費</th>
		    	<td class="shikakari-no-input"><fmt:formatNumber value="${f:h(m.KGaityu)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KGaityu" value="${m.KGaityu }" />
		    	</td>
		    	<td class="shikakari-no-input"><fmt:formatNumber value="${f:h(m.MGaityu)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MGaityu" value="${m.MGaityu }" />
		    	</td>
		    	<td class="shikakari-no-input"><fmt:formatNumber value="${f:h(m.JGaityu)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JGaityu" value="${m.JGaityu }" />
		    	</td>
				<td class="space"></td>
				<td class="space"></td>
		    	<th class="shikakari-sub">実績</th>
		    	<td class="shikakari-no-input">要計算</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="shikakari-no-input">要計算</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==1 }">
					<td class="shikakari-no-input">要計算</td>
				</c:if>
				</c:forEach>
		    </tr>

		    <tr>
		    	<th class="shikakari-sub">旅費交通費</th>
		    	<td class="shikakari-no-input"><fmt:formatNumber value="${f:h(m.KRyohi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KRyohi" value="${m.KRyohi }" />
		    	</td>
		    	<td class="shikakari-no-input"><fmt:formatNumber value="${f:h(m.MRyohi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MRyohi" value="${m.MRyohi }" />
		    	</td>
		    	<td class="shikakari-no-input"><fmt:formatNumber value="${f:h(m.JRyohi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JRyohi" value="${m.JRyohi }" />
		    	</td>
				<td class="space"></td>
				<td class="shikakari-no-input"><fmt:formatNumber value="${f:h(m.uriage)}" /></td>
				<td class="shikakari-no-input"><fmt:formatNumber pattern="###,##0.0" value="${f:h(m.JTanka)}" />
				<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JTanka" value="${m.JTanka }" />
				</td>
				<td class="space"></td>
		    	<th class="shikakari-sub">計/見 差異</th>
		    	<td class="shikakari-no-input">要計算</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="shikakari-no-input">要計算</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==1 }">
					<td class="shikakari-no-input">要計算</td>
				</c:if>
				</c:forEach>
		    </tr>

		    <tr>
		    	<th class="shikakari-sub">その他経費</th>
		    	<td class="shikakari-no-input"><fmt:formatNumber value="${f:h(m.KSonota)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KSonota" value="${m.KSonota }" />
		    	</td>
		    	<td class="shikakari-no-input"><fmt:formatNumber value="${f:h(m.MSonota)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MSonota" value="${m.MSonota }" />
		    	</td>
		    	<td class="shikakari-no-input"><fmt:formatNumber value="${f:h(m.JSonota)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JSonota" value="${m.JSonota }" />
		    	</td>
				<td class="space"></td>
				<th class="shikakari-sub" rowspan="2">粗利金額</th>
				<th class="shikakari-sub" rowspan="2">粗利率</th>
				<td class="space"></td>
		    	<th class="shikakari-sub">計/実 差異</th>
		    	<td class="shikakari-no-input">要計算</td>
		    	<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==0 }">
					<td class="shikakari-no-input">要計算</td>
				</c:if>
				</c:forEach>
				<td class="space"></td>
				<c:forEach var="kt" varStatus="s3" items="${mapItems }" begin="1">
		    	<c:if test="${kt.gaityuFlag==1 }">
					<td class="shikakari-no-input">要計算</td>
				</c:if>
				</c:forEach>
		    </tr>

		    <tr>
		    	<th class="shikakari-sub">経費合計</th>
		    	<td class="shikakari-no-input"><fmt:formatNumber value="${f:h(m.KKeihi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KKeihi" value="${m.KKeihi }" />
		    	</td>
		    	<td class="shikakari-no-input"><fmt:formatNumber value="${f:h(m.MKeihi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MKeihi" value="${m.MKeihi }" />
		    	</td>
		    	<td class="shikakari-no-input"><fmt:formatNumber value="${f:h(m.JKeihi)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JKeihi" value="${m.JKeihi }" />
		    	</td>
		    </tr>

		    <tr>
		    	<th class="shikakari-sub">合計</th>
		    	<td class="shikakari-no-input"><fmt:formatNumber value="${f:h(m.KSum)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].KSum" value="${m.KSum }" />
		    	</td>
		    	<td class="shikakari-no-input"><fmt:formatNumber value="${f:h(m.MSum)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].MSum" value="${m.MSum }" />
		    	</td>
		    	<td class="shikakari-no-input"><fmt:formatNumber value="${f:h(m.JSum)}" />
		    	<html:hidden property="mapItemsItems[${s.index}][${s2.index}].JSum" value="${m.JSum }" />
		    	</td>
		    	<td class="space"></td>
				<td class="shikakari-no-input"><fmt:formatNumber value="${f:h(m.uriage - m.JSum)}" /></td>
				<td class="shikakari-no-input"><fmt:formatNumber pattern="###,##0.0"
				value="${f:h(m.JSum==0 ? 0 : m.JSum / (m.uriage - m.JSum))}" /></td>
				<td class="space"></td>
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