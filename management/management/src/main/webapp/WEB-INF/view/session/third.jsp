<%@page pageEncoding="UTF-8"%>
<tiles:insert template="/WEB-INF/view/common/layout.jsp" flush="true">
<tiles:put name="title"  value="Tiles"/>
<tiles:put name="content" type="string">
<link rel="stylesheet" type="text/css" href="${f:url('/css/sa.css')}" />

<h1>Tutorial: Session third</h1>

<s:form>
<table>
<tr><td>First</td><td>${f:h(first)}</td></tr>
<tr><td>Second</td><td>${f:h(second)}</td></tr>
</table><br />
<input type="submit" name="backSecond" value="戻る"/>
<input type="submit" name="clear" value="クリアして最初の画面へ"/>
<input type="submit" name="/add/" value="addへ"/>
</s:form>
</tiles:put>
</tiles:insert>
