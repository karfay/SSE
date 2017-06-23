<%@page pageEncoding="UTF-8"%>
<html>
<title>メニュー</title>
<link rel="stylesheet" type="text/css" href="${f:url('/css/Kan.css')}" />
<body>

<div id="headerArea">
<h1 style="position: absolute; left: 10px; top: -15px;" >資産管理システム：端末管理</h1>
<s:form>
	<input type="submit" name="logout" value="ログアウト"
		style="position: absolute; right: 10px; top: 12.5px;" />
	<input type="submit" name="index" value="持出持込台帳"
		style="position: absolute; right: 165px; top: 12.5px;" />
</s:form>
</div>
<div id="contentsArea">
<ul>
<br />
<li><h3><a href = "../kanPc/">端末（PC）管理（※現在は使用できません）</a></h3></li>
<br />
<li><h3><a href ="../kanWirelessLan/">端末（モバイルWi-Fi）管理</a></h3></li>
<br />
<li><h3><a href ="../kanWirelessSlave/">端末（無線子機）管理</a></h3></li>
<br />
<li><h3>文書保管室資産管理（※現在は使用できません）</h3></li>
<br />
<li><h3><a href="../kanPersonnel/">システムユーザー管理</h3></li>
</ul>
</div>
</body>
</html>