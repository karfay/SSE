<%@page pageEncoding="UTF-8"%>
<html>
<head>
<title>Tutorial: Nested Foreach Update</title>
<link rel="stylesheet" type="text/css" href="${f:url('/css/sa.css')}" />
</head>
<body>
<h1>Tutorial: Nested Foreach Update</h1>

<html:errors/>
<s:form>
<table border="1">
<c:forEach var="mapItems" varStatus="s" items="${mapItemsItems}">
    <tr>
        <td>
            <input type="text"
                name="mapItemsItems[${s.index}][0].pm"
                value="${f:h(mapItems[0].pm)}" />
        </td>
    <c:forEach var="m" varStatus="s2" items="${mapItems}" begin="1">

        <td>
            <input type="text"
                name="mapItemsItems[${s.index}][${s2.index}].itLabel"
                value="${f:h(m.itLabel)}"/>
        </td>
        <td>
            <input type="text"
                name="mapItemsItems[${s.index}][${s2.index}].${str}"
                value="${f:h(m.number)}"/>
        </td>
    </c:forEach>
    </tr>
</c:forEach>
</table><br />
<input type="submit" name="submit" value="サブミット"/>
<input type="button" value="子画面" onClick="window.open('index','index','width=800, height=600')" />
</s:form>
</body>
</html>