<%@page pageEncoding="UTF-8"%>
<html>
<title>新規作成完了</title>
<link rel="stylesheet" type="text/css" href="${f:url('/css/sa.css')}" />
<body>
<h1>資産管理：新規作成完了</h1>
<html:errors />
<s:form>
	<p>ITラベル：${f:h(itLabel)}を新規作成いたしました！</p>
	
	<input type="submit" name="returnSearch" value="検索画面へ" />
</s:form>
</body>
</html>