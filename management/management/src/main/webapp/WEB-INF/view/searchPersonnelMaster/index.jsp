<%@page pageEncoding="UTF-8"%>
<html>
<title>ユーザ検索</title>
<link rel="stylesheet" type="text/css" href="${f:url('/css/sa.css')}" />
<body>
<h1>資産管理：ユーザ検索</h1>
<html:errors />
<table>
	<s:form>
		<tr>
			<th>社員No</th>
			<td><html:text property="personnelNumber" maxlength="8" /></td>
		</tr>
		<tr>
			<th>社員名</th>
			<td><html:text property="personnelName" /></td>
		</tr>
		<tr>
			<th>ユーザID</th>
			<td><html:text property="userId" /></td>
		</tr>
		<tr>
			<th>パスワード</th>
			<td><html:text property="userPass" maxlength="10" /></td>
		</tr>
		<tr>
			<th>権限</th>
			<td><html:text property="authorizations" maxlength="2" /></td>
		</tr>
		<tr>
			<td class="bottun" align="left">
				<input type="submit" name="cleateNew" value="新規作成へ" />
			</td>
			<th></th>
			<td class="bottun" align="right">
				<input type="submit" name="submit" value="検索開始" />
			</td>
		</tr>
	</s:form>
</table>
</body>
</html>