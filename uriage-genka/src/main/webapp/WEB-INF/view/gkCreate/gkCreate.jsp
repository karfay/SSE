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

div.kaihatsu-taisei{
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
tr.space{height: 10px}
</style>

<script type="text/javascript" src="${f:url('/javascript/checkDatePattern.js')}"></script>
<script type="text/javascript" src="${f:url('/javascript/jquery-3.1.1.min.js')}"></script>
<script type="text/javascript">
function checkInsert(){
	var input = document.forms["input"];
	if(input.themeName.value==''){
		window.alert('テーマ名は必須です。');
		return false;
	}
	var input = document.forms["input"];
	if(input.kokyakuInitial.value==''){
		window.alert('イニシャルは必須です。');
		return false;
	}
	var input = document.forms["input"];
	if(input.tyakusyuMonth.value==''){
		window.alert('着手月は必須です。');
		return false;
	}
	var input = document.forms["input"];
	if(input.nouki.value==''){
		window.alert('納期は必須です。');
		return false;
	}

	return confirm('入力した内容で新規作成します');
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
	//$('div.list-body').css('top', $('div.list-header').offset().top + $('div.list-header').height());
}

//var listHeader = $('div#list-header');
window.addEventListener('scroll', _hangleScroll, false);
function _hangleScroll(){
	$('div#list-header').css('left',  - window.scrollX + 8);
	//console.log($('div#list-header').css('left'));
}
function checkNouki(obj){
	//納期が空白なら判定しない
	if(obj.form.nouki.value==""){
		return;
	}

	compN = obj.form.nouki.value.replace("/","");
	if(("${latestUriageMonth}").replace("/","") < compN){
		window.alert("納期が売上計画外の期間に設定されています。修正して下さい。");
		obj.form.nouki.value="";
		return;
	}

	if(obj.form.tyakusyuMonth.value==""){
		return;
	}
	compTm = obj.form.tyakusyuMonth.value.replace("/","");
	//納期が着手月よりも前に設定されていたらエラー
	//納期を空白に戻す
	if(compN <= compTm){
		window.alert("納期が着手月よりも前に設定されています。修正して下さい。");
		obj.form.nouki.value="";
		return;
	}
}

function quoteKaihatsuPeriod(){
	$('input[name="tyakusyuMonth"]').val("${earliestUriageMonth}");
	$('input[name="nouki"]').val("${latestUriageMonth}");
}

function changeDeleteMember(empNo){
	//console.log($('input[name="deleteMember"]').val());
	$('input[name="deleteMember"]').val(empNo);
	//console.log($('input[name="deleteMember"]').val());
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

	<div class="fixed" id="fixed" style="position: absolute; z-index: 5000;">
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
			<div class="input-form">
				<%--
				hiddenで受け渡す値。gkIdはフォーム間で値を引き継ぐのが目的。
				deleteMemberは外すボタンを押下した際にchangeDeleteMember()によってvalueが変更される。
				--%>
				<html:hidden property="gkId" value="${gkId }"></html:hidden>
				<html:hidden property="deleteMember" value="default"></html:hidden>
				<table>
					<tr>
						<th>テーマ親番</th>
						<td>
							<html:text property="themeGroup" value="${gk.themeGroup }" disabled="true"></html:text>
							<html:hidden property="themeGroup" value="${gk.themeGroup }"></html:hidden>
						</td>
					</tr>
					<tr>
						<th>テーマNO</th>
						<td>
							<html:text property="themeNo" value="${gk.themeNo }" disabled="true"></html:text>
							<html:hidden property="themeNo" value="${gk.themeNo }"></html:hidden>
						</td>
					</tr>
					<tr>
						<th>テーマ名</th>
						<td>
							<html:text property="themeName" value="${gk.themeName }" styleClass="required"></html:text>
						</td>
					</tr>
					<tr>
						<th>イニシャル</th>
						<td>
							<html:text property="kokyakuInitial" value="${gk.kokyakuInitial }" styleClass="required"></html:text>
						</td>
					</tr>
					<tr>
						<th>受注額</th>
						<td>
							<html:text property="jutyugaku" value="${gk.jutyugaku }" disabled="true"></html:text>
							<html:hidden property="jutyugaku" value="${gk.jutyugaku }"></html:hidden>
						</td>
					</tr>
				</table>
				<br />
				<div class="title">
					開発期間　<input type="button" value="売上計画から自動取得" onclick="quoteKaihatsuPeriod()" class="normal" style="width:250px;"
					title="テーマNOに紐付く売上計画から、着手月と納期を自動で設定します。"></input>
				</div>
				<table>
					<tr>
						<th>着手月</th>
						<td>
							<html:text property="tyakusyuMonth" value="${gk.tyakusyuMonth }" onblur="checkDatePattern(this);checkNouki(this);" styleClass="required"></html:text>
						</td>
						<td>～</td>
						<th>納期</th>
						<td>
							<html:text property="nouki" value="${gk.nouki }" onblur="checkDatePattern(this);checkNouki(this);" styleClass="required"></html:text>
						</td>
					</tr>
				</table>
				<br />
				<table>
					<tr>
						<th>プロジェクト管理者</th>
						<td>
							<html:select property="pjAdmin" value="${pjAdmin }">
								<c:forEach items="${pjAdminList }" var="e">
									<html:option value="${e.empNo }">${e.empName }</html:option>
								</c:forEach>
							</html:select>
						</td>
					</tr>
					<tr>
						<th>プロジェクトリーダ</th>
						<td>
							<html:select property="pjLeader" value="${pjLeader }">
								<c:forEach items="${pjLeaderList }" var="e">
									<html:option value="${e.empNo }">${e.empName }</html:option>
								</c:forEach>
							</html:select>

						</td>
					</tr>
				</table>

				<div style="padding-top: 30px;">
					<html:submit property="newCreate" value="原価管理表を新規作成"
					onclick="return checkInsert()" styleClass="insert"
					style="width:300px; visibility: ${empty gkId ? 'visible':'hidden' }" ></html:submit>
					<html:submit property="update" value="原価管理表を修正"
					onclick="return checkUpdate()" styleClass="update"
					style="width:250px; visibility: ${!empty gkId ? 'visible':'hidden' }" ></html:submit>
				</div>
				</div>
				<div class="kaihatsu-taisei">
					<div class="title">
						開発体制
					</div>
					<table>
						<c:if test="${!empty gkId }">
							<tr class="space"></tr>
							<c:if test="${!empty pjMemberList }">
								<c:forEach items="${pjMemberList }" var="e" varStatus="s">
									<c:if test="${s.index==0 }">
										<tr>
											<th>プロジェクトメンバ</th>
											<th>${e.empName }</th>
											<td><html:submit property="deletePjMember" value="外す" styleClass="normal" onclick="changeDeleteMember('${e.empNo }')"></html:submit></td>
										</tr>
									</c:if>
									<c:if test="${s.index!=0 }">
										<tr>
											<td></td>
											<th>${e.empName }</th>
											<td><html:submit property="deletePjMember" value="外す" styleClass="normal" onclick="changeDeleteMember('${e.empNo }')"></html:submit></td>
										</tr>
									</c:if>
								</c:forEach>
							</c:if>
							<tr>
								<c:if test="${!empty pjMemberList }"><td></td></c:if>
								<c:if test="${empty pjMemberList }"><th>プロジェクトメンバ</th></c:if>
								<td>
									<html:select property="pjMember" value="">
										<html:option value="" ></html:option>
										<c:forEach items="${pjMemberCandidate }" var="e">
											<html:option value="${e.empNo }">${e.empName }</html:option>
										</c:forEach>
									</html:select>
								</td>
								<td><html:submit property="addPjMember" styleClass="update" value="追加" ></html:submit></td>
							</tr>
							<tr class="space"></tr>

							<c:if test="${!empty gaityuMemberList }">
								<c:forEach items="${gaityuMemberList }" var="e" varStatus="s">
									<c:if test="${s.index==0 }">
										<tr>
											<th>外注（パートナー）</th>
											<th>${e.empName }</th>
											<td><html:submit property="deleteGaityuMember" value="外す" styleClass="normal" onclick="changeDeleteMember('${e.empNo }')"></html:submit></td>
										</tr>
									</c:if>
									<c:if test="${s.index!=0 }">
										<tr>
											<td></td>
											<th>${e.empName }</th>
											<td><html:submit property="deleteGaityuMember" value="外す" styleClass="normal" onclick="changeDeleteMember('${e.empNo }')"></html:submit></td>
										</tr>
									</c:if>
								</c:forEach>
							</c:if>
							<tr>
								<c:if test="${!empty gaityuMemberList }"><td></td></c:if>
								<c:if test="${empty gaityuMemberList }"><th>外注（パートナー）</th></c:if>
								<td>
									<html:select property="gaityuMember" value="">
										<html:option value=""></html:option>
										<c:forEach items="${gaityuMemberCandidate }" var="e">
											<html:option value="${e.empNo }">${e.empName }</html:option>
										</c:forEach>
									</html:select>
								</td>
								<td><html:submit property="addGaityuMember" styleClass="update" value="追加" ></html:submit></td>
							</tr>

						</c:if>
					</table>
				</div>
			</s:form>


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