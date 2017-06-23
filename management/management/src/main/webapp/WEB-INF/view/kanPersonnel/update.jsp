<%@page pageEncoding="UTF-8"%>
<html>
<title>システムユーザーの管理ページ　-更新-</title>
<link rel="stylesheet" type="text/css" href="${f:url('/css/Kan.css')}" />
<body>

<script type="text/javascript">
<!--
function checkInsert(){
	
	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('更新をします。')){
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
<h1 style="position: absolute; left: 10px; top: -12.5px;" >システムユーザーの管理　-更新-</h1>
<s:form>
	<input type="submit" name="menu" value="メニューへ"
		style="position: absolute; right: 10px; top: 12.5px;" />
	<input type="submit" name="logout" value="ログアウト"
		style="position: absolute; right: 165px; top: 12.5px;" />
</s:form>
</div>
<div id="contentsArea">
<br />
<font color="blue"><b>更新前のテーブル</b></font>
	<table border="1">
		<tr>
			<th>社員番号</th>
			<th>社員名</th>
			<th></th>
			<th>ユーザID</th>
			<th>パスワード</th>
			<th>権限</th>
		</tr>
		<tr>
			<td><input type="text" style="width:100%;" disabled="disabled" name="old.personnelNumber" value="${(old.personnelNumber)}" /></td>		
			<td><input type="text" style="width:100%;" disabled="disabled" name="old.personnelName" value="${(old.personnelName)}" /></td>
			<td><input type="text" style="width:100%;" disabled="disabled" /></td>
			<td><input type="text" style="width:100%;" disabled="disabled" name="old.userId" value="${(old.userId)}" /></td>
			<td><input type="text" style="width:100%;" disabled="disabled" name="old.userPass" value="${(old.userPass)}" /></td>		
			<td><input type="text" style="width:100%;" disabled="disabled" name="old.authorizations" value="${(old.authorizations)}" /></td>
		</tr>
		</table>

<br />
<s:form>
<font color="red"><b>更新後のテーブル</b></font>
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
		<input class="button" type="submit" name="update" value="この情報で更新" onClick="return checkInsert()" />
		
		<%-- oldの要素へ値を引き継ぐ --%>
			<input type="hidden" name="old.phoneNumber" value="${(old.personnelNumber)}" />		
			<input type="hidden" name="old.model" value="${(old.personnelName)}" />
			<input type="hidden" name="old.plan" value="${(old.userId)}" />
			<input type="hidden" name="old.pinCode" value="${(old.userPass)}" />
			<input type="hidden" name="old.serialNumber" value="${(old.authorizations)}" />		
		</s:form>
</div>
</body>
</html>