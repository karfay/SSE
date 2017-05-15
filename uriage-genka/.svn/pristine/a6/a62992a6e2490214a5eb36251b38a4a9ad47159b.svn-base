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

	<th>KTankaApr</th>
	<th>KTankaMay</th>
	<th>KTankaJun</th>
	<th>KTankaJul</th>
	<th>KTankaAug</th>
	<th>KTankaSep</th>
	<th>KTankaOct</th>
	<th>KTankaNov</th>
	<th>KTankaDec</th>
	<th>KTankaJan</th>
	<th>KTankaFeb</th>
	<th>KTankaMar</th>
<th></th><th></th><th></th>
</tr>

<c:forEach var="e" varStatus="s" items="${keikakuTankaMasterItems}">
	<tr style="background-color:${s.index %2 == 0 ? 'white' : 'aqua'}">
		<td>
			${f:h(e.KTankaApr)}
		</td>
		<td>
			${f:h(e.KTankaMay)}
		</td>
		<td>
			${f:h(e.KTankaJun)}
		</td>
		<td>
			${f:h(e.KTankaJul)}
		</td>
		<td>
			${f:h(e.KTankaAug)}
		</td>
		<td>
			${f:h(e.KTankaSep)}
		</td>
		<td>
			${f:h(e.KTankaOct)}
		</td>
		<td>
			${f:h(e.KTankaNov)}
		</td>
		<td>
			${f:h(e.KTankaDec)}
		</td>
		<td>
			${f:h(e.KTankaJan)}
		</td>
		<td>
			${f:h(e.KTankaFeb)}
		</td>
		<td>
			${f:h(e.KTankaMar)}
		</td>
		<td><s:link href="show/${e.nendo}"> show </s:link></td>
		<td><s:link href="edit/${e.nendo}"> edit </s:link></td>
		<td><s:link onclick="return confirm('delete OK?');" href="delete/${e.nendo}">delete</s:link></td>
	</tr>
</c:forEach>

</table>

<s:link href="create"> create new Object </s:link>
</body>
</html>