<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" type="text/css" href="${f:url('/css/global.css')}"/>
</head>
<body>

<html:errors/>

<table class="tablebg">
	<tr>
		<td> ankenRirekiId </td>
		<td>
			${f:h(ankenRirekiId)}
		</td>	
	</tr>
	<tr>
		<td> nendo </td>
		<td>
			${f:h(nendo)}
		</td>	
	</tr>
	<tr>
		<td> ukApr </td>
		<td>
			${f:h(ukApr)}
		</td>	
	</tr>
	<tr>
		<td> ukMay </td>
		<td>
			${f:h(ukMay)}
		</td>	
	</tr>
	<tr>
		<td> ukJun </td>
		<td>
			${f:h(ukJun)}
		</td>	
	</tr>
	<tr>
		<td> ukJul </td>
		<td>
			${f:h(ukJul)}
		</td>	
	</tr>
	<tr>
		<td> ukAug </td>
		<td>
			${f:h(ukAug)}
		</td>	
	</tr>
	<tr>
		<td> ukSep </td>
		<td>
			${f:h(ukSep)}
		</td>	
	</tr>
	<tr>
		<td> ukOct </td>
		<td>
			${f:h(ukOct)}
		</td>	
	</tr>
	<tr>
		<td> ukNov </td>
		<td>
			${f:h(ukNov)}
		</td>	
	</tr>
	<tr>
		<td> ukDec </td>
		<td>
			${f:h(ukDec)}
		</td>	
	</tr>
	<tr>
		<td> ukJan </td>
		<td>
			${f:h(ukJan)}
		</td>	
	</tr>
	<tr>
		<td> ukFeb </td>
		<td>
			${f:h(ukFeb)}
		</td>	
	</tr>
	<tr>
		<td> ukMar </td>
		<td>
			${f:h(ukMar)}
		</td>	
	</tr>

</table>











<table border="1">
<tr>
  <td>codeId</td>
  <td>codeType</td>
  <td>codeName</td>
  <td>codeFlag</td>
</tr>
<c:forEach var="ugCodeMasterItems" items="${ugCodeMasterItems}">
<tr>
  <td>${f:h(ugCodeMasterItems.codeId)}</td>
  <td>${f:h(ugCodeMasterItems.codeType)}</td>
  <td>${f:h(ugCodeMasterItems.codeName)}</td>
  <td>${f:h(ugCodeMasterItems.codeFlag)}</td>
</tr>
</c:forEach>
</table>

















<s:link href="edit/${ankenRirekiId}/${nendo}"> edit </s:link>


<br/><br/>
<s:link href="/uriageKeikaku/">list page</s:link>
</body>
</html>
