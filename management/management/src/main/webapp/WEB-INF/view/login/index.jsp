<%@page pageEncoding="UTF-8"%>
<html>
<title>ログイン</title>
<link rel="stylesheet" type="text/css" href="${f:url('/css/Input.css')}" />
<body>

<div id="headerArea">
<h1 style="position: absolute; left: 10px; top: -15px;" >資産管理：ログイン</h1>
</div>
<div id="contentsArea">
<ul><html:errors /></ul>
<br />
<p><font color="red" size="7" >※　PC端末管理用テスト環境です　※</font></p>
<table>
	<s:form>
		<tr>
			<th>ユーザID</th>
			<td><html:text property="userId" maxlength="10" errorStyleClass="err" style="ime-mode: disabled; width:200px;"/></td>
		</tr>
		<tr>
			<th>パスワード</th>
			<td><html:password property="userPass" maxlength="10" errorStyleClass="err" style="ime-mode: disabled; width:200px;"/></td>
		</tr>
		<tr>
			<td class="button">
				<input type="submit" name="login" value="ログイン" style="width: 100%;" />
			</td>
			<td class="button">
				
			</td>
		</tr>
	</s:form>
</table>

</div>
</body>
</html>