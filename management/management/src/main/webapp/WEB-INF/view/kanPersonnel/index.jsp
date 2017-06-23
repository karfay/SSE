<%@page pageEncoding="UTF-8"%>
<html>
<title>システムユーザーの管理ページ</title>
<link rel="stylesheet" type="text/css" href="${f:url('/css/Kan.css')}" />
<body>

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
// -->
</script>


<div id="headerArea">
<h1 style="position: absolute; left: 10px; top: -12.5px;" >システムユーザーの管理</h1>
<s:form>
	<input type="submit" name="menu" value="メニューへ"
		style="position: absolute; right: 10px; top: 12.5px;" />
	<input type="submit" name="logout" value="ログアウト"
		style="position: absolute; right: 165px; top: 12.5px;" />
</s:form>
</div>
<div id="contentsArea">
<br />
<c:if test="${(condAuthorizations == 1)}">
<s:form>
	<table border="1">
		<tr>
			<th>社員番号</th>
			<th>社員名(姓)</th>
			<th>社員名(名)</th>
			<th>ユーザID</th>
			<th>パスワード</th>
			<th>権限</th>
		</tr>
		<tr>
			<td><html:text styleClass="hankaku"  property="personnelNumber" value="${f:h(personnelNumber)}" maxlength="9" /></td>
			<td><html:text styleClass="zenkaku" property="familyName" value="${f:h(familyName)}" maxlength="10" /></td>
			<td><html:text styleClass="zenkaku" property="firstName" value="${f:h(firstName)}" maxlength="10" /></td>
			<td><html:text styleClass="hankaku"  property="userId" value="${f:h(userId)}" maxlength="9" /></td>
			<td><html:text styleClass="hankaku" property="userPass" value="${f:h(userPass)}" maxlength="10" /></td>
			<td><html:radio property="authorizations" value="0" />一般<html:radio property="authorizations" value="1" />管理者</td>	
		</tr>
	</table>
	<input class="button" type="submit" name="insert" value="新規登録" onClick="return checkInsert()" />
</s:form>
</c:if>

<font color="blue" ><b>${(msg01)}</b></font>
	<table border="1">
		<tr>
			<th>社員番号</th>
			<th>社員名</th>
			<th>ユーザID</th>
			<th>パスワード</th>
			<th>権限</th>
			<td class="none" style="border-bottom: 1px solid black;"></td>
			<td class="none" style="border-bottom: 1px solid black;"></td>
		</tr>
		<c:forEach var="a" items="${personnelMaster}" varStatus="st">
		<c:if test="${st.index%2==0}">
		<tr>
		</c:if>
		<c:if test="${st.index%2==1}">
		<tr bgcolor="aliceblue">
		</c:if>
			<td >${(a.personnelNumber)}</td>
			<td >${(a.personnelName)}</td>
			<td >${(a.userId)}</td>
			<td >●●●●●●</td>
			<c:if test="${(a.authorizations != 1)}">
			<td >一般</td>
			</c:if>
			<c:if test="${(a.authorizations == 1)}">
			<td >管理者</td>
			</c:if>
			<c:if test="${(condAuthorizations == 1)}">
				<s:form>
				<td>
				<input class="smallButton" type="submit" name="jumpUpdate" value="更新" />
				</td>
				<td>
				<input class="smallButton" type="submit" name="delete" value="削除" onClick="return checkDelete()" />
				</td>
			<%-- 更新と削除に必要なテーブルの主キーをこのフォームで渡せるように記述 --%>
				<input type="hidden" name="personnelNumber" value="${(a.personnelNumber)}" />		
				<input type="hidden" name="personnelName" value="${(a.personnelName)}" />
				<input type="hidden" name="userId" value="${(a.userId)}" />
				<input type="hidden" name="userPass" value="${(a.userPass)}" />
				<input type="hidden" name="authorizations" value="${(a.authorizations)}" />		
			</s:form>
			</c:if>
			
			<c:if test="${(condAuthorizations != 1)}">
				<td class="none"></td>
				<td class="none"></td>
			</c:if>

		</tr>
		</c:forEach>
	</table>
</div>
</body>
</html>