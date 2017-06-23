<%@page pageEncoding="UTF-8"%>
<tiles:insert template="/WEB-INF/view/common/layout.jsp" flush="true">
<tiles:put name="title"  value="Add_Tiles"/>
<tiles:put name="content" type="string">

${f:h(name)}
<link rel="stylesheet" type="text/css" href="${f:url('/css/sa.css')}" />

<h1>Tutorial: Add</h1>

<html:errors/>
<s:form name="add_form">
<html:text property="arg1"/> +
<html:text property="arg2"/>
= ${f:h(result)}<br />
<input type="submit" name="submit" value="サブミット"/>
</s:form>
</tiles:put>
</tiles:insert>
