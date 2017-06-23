<%@page pageEncoding="UTF-8"%>
<html>
<title>削除完了</title>
<link rel="stylesheet" type="text/css" href="${f:url('/css/sa.css')}" />
<body>
<h1>資産管理：削除完了</h1>
<html:errors />
<s:form>
	<p>ITラベル：${f:h(itLabel)}が削除されました</p>

	<input type="submit" name="returnSearch" value="検索画面へ" />
</s:form>
</body>
</html>