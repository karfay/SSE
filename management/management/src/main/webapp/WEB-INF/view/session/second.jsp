<%@page pageEncoding="UTF-8"%>
<tiles:insert template="/WEB-INF/view/common/layout.jsp" flush="true">
<tiles:put name="title"  value="Tiles"/>
<tiles:put name="content" type="string">
<link rel="stylesheet" type="text/css" href="${f:url('/css/sa.css')}" />

<h1>Tutorial: Session second</h1>

<html:errors/>
<s:form>
<table>
<tr><td>First</td><td>${f:h(first)}</td></tr>
<tr><td>Second</td><td><html:text property="second"/></td></tr>
</table>
<input type="submit" name="goThird" value="Thirdへ"/>
<input type="submit" name="index" value="戻る"/>
</s:form>
</tiles:put>
</tiles:insert>