<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" type="text/css" href="${f:url('/css/global.css')}"/>
</head>
<body>

<html:errors/>


<table border="1">
<tr style="background-color:pink">

	<th>empName</th>
	<th>loginId</th>
	<th>password</th>
	<th>authorization</th>
	<th>shortEmpName</th>
	<th>empConditionCode</th>
<th></th><th></th><th></th>
</tr>

<c:forEach var="e" varStatus="s" items="${empMasterItems}">
	<tr style="background-color:${s.index %2 == 0 ? 'white' : 'aqua'}">
		<td>
			${f:h(e.empName)}
		</td>
		<td>
			${f:h(e.loginId)}
		</td>
		<td>
			${f:h(e.password)}
		</td>
		<td>
			${f:h(e.authorization)}
		</td>
		<td>
			${f:h(e.shortEmpName)}
		</td>
		<td>
			${f:h(e.empConditionCode)}
		</td>
		<td><s:link href="show/${e.empNo}"> show </s:link></td>
		<td><s:link href="edit/${e.empNo}"> edit </s:link></td>
		<td><s:link onclick="return confirm('delete OK?');" href="delete/${e.empNo}">delete</s:link></td>
	</tr>
</c:forEach>

</table>

<s:link href="create"> create new Object </s:link>
</body>
</html>