<%@page pageEncoding="UTF-8"%>
<html>
<title>無線子機の管理ページ</title>
<link rel="stylesheet" type="text/css" href="${f:url('/css/Kan.css')}" />
<body onLoad="err()" >

<script type="text/javascript">
<!--
function checkInsert(){
	
	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('新規登録をします。')){
		return true;

	}
	// 「OK」時の処理終了
	// 「キャンセル」時の処理開始
	else{

		window.alert('キャンセルされました'); // 警告ダイアログを表示
		return false;

	}
	// 「キャンセル」時の処理終了
	
}

function checkDelete(){
	
	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('テーブルを削除します。')){
		return true;

	}
	// 「OK」時の処理終了
	// 「キャンセル」時の処理開始
	else{

		window.alert('キャンセルされました'); // 警告ダイアログを表示
		return false;

	}
	// 「キャンセル」時の処理終了
}

function err(){
	window.alert("入力エラーがあります。");
}

// -->
</script>

<div id="headerArea">
<h1 style="position: absolute; left: 10px; top: -15px;" >無線子機の管理</h1>
<form>
	<input type="submit" name="menu" value="メニューへ"
		style="position: absolute; right: 10px; top: 12.5px;" />
	<input type="submit" name="logout" value="ログアウト"
		style="position: absolute; right: 165px; top: 12.5px;" />
</form>
</div>
<div id="contentsArea">
<br />
<ul><html:errors /></ul>

<h1>無線子機の管理</h1>
<br />
<br />
<c:if test="${(authorizations == 1)}">
<s:form>
		<table border="1">
			<tr>
				<th>管理番号</th>
				<td><html:text style="ime-mode: disabled; width: 100%;" property="number" value="${f:h(number)}" maxlength="10" errorStyleClass="err" /></td>
				<td>
				<input class="button" type="submit" name="insert" value="新規登録" onClick="return checkInsert()" /></td>
			</tr>
		</table>
	</s:form>
</c:if>

<font color="blue" ><b>${(msg)}</b></font>
	<table border="1">
		<tr>
			<th >管理番号</th>
			<td class="none"></td>
		</tr>
		<c:forEach var="a" items="${wirelessSlaveMaster}" varStatus="st">
		<c:if test="${st.index%2==0}">
		<tr>
		</c:if>
		<c:if test="${st.index%2==1}">
		<tr bgcolor="aliceblue">
		</c:if>
			<td >${(a.number)}</td>
			
			<c:if test="${(authorizations == 1)}">
				<s:form>
				<td class="space">
				<input class="smallButton" type="submit" name="delete" value="削除" onClick="return checkDelete()" />
				</td>
			<%-- 更新と削除に必要なテーブルの主キーをこのフォームで渡せるように記述 --%>
				<input type="hidden" name="number" value="${(a.number)}" />		
				</s:form>
			</c:if>
			
			<c:if test="${(authorizations != 1)}">
				<td class="none"></td>
			</c:if>
			
		</tr>
		</c:forEach>
	</table>

</div>

</body>
</html>