<%@page pageEncoding="UTF-8"%>
<html>
<title>メニュー</title>
<link rel="stylesheet" type="text/css" href="${f:url('/css/Input.css')}" />
<body>

<div id="headerArea">
<h1 style="position: absolute; left: 10px; top: -15px;" >資産管理システム：持出持込台帳</h1>
<s:form>
	<input type="submit" name="logout" value="ログアウト"
		style="position: absolute; right: 10px; top: 12.5px;" />
	<input type="submit" name="kanri" value="端末管理" 
		style="position: absolute; right: 165px; top: 12.5px;" />
</s:form>
</div>
<div id="contentsArea">
<ul>
<br />
<li><h3><a href="../syaDaityoInput/">社外持出管理台帳</a></h3></li>
<br>
<li><h3><a href="../motDaityoInput/">社内持込管理台帳</a></h3></li>
<br>
<li><h3><a href="../syaDaityoLook/">持出状況参照</a></h3></li>
</ul>
</div>
</body>
</html>