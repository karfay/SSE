<%@page pageEncoding="UTF-8"%>
<tiles:insert template="/WEB-INF/view/common/layout.jsp" flush="true">
<tiles:put name="title"  value="Session_Tiles"/>
<tiles:put name="content" type="string">
<link rel="stylesheet" type="text/css" href="${f:url('/css/sa.css')}" />

<h1>Tutorial: Session index</h1>
<html:errors/>
<s:form>
First:<html:text property="first"/><br />
<input type="submit" name="goSecond" value="Secondへ"/>
</s:form>
</tiles:put>
</tiles:insert>
