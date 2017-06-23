<%@page pageEncoding="UTF-8"%>
<html>
<title>持出状況参照</title>
<link rel="stylesheet" type="text/css" href="${f:url('/css/Kan.css')}" />
<body>
<div id="headerArea" style="background-color: #4E9ABE;">
<h1 style="position: absolute; left: 10px; top: -15px;" >持出状況参照：モバイルWi-Fi</h1>
<form>
	<input type="submit" name="menu" value="メニューへ"
		style="position: absolute; right: 10px; top: 12.5px;" />
	<input type="submit" name="logout" value="ログアウト"
		style="position: absolute; right: 165px; top: 12.5px;" />
</form>
</div>
<div id="contentsArea">
<br />
<s:form>
	<input type="submit" name="wirelessSlaveListUp" value="シンクラ端末" />
	<input type="submit" name="pcListUp" value="PC端末" disabled />
	<input type="submit" name="wirelessLanListUp" value="モバイルWi-Fi" />
</s:form>
<table border="1">
	<tr>
		<th class="ultraSmall">社内</th>
		<th class="small">ITラベル</th>
		<th class="small">申請者<br />社員番号</th>
		<th class="small">申請者氏名</th>
		<th>持出先</th>
		<th class="small">持出開始日</th>
		<th class="small">持出終了日</th>
	</tr>
		<c:forEach var="a" items="${syaDaityoLookDto1}">
		<tr>
			<td>
			<c:if test="${a.syanai == '無'}">
			<font color="red">${f:h(a.syanai) }</font></c:if>
			<c:if test="${a.syanai == '有'}">
			<font color="blue">${f:h(a.syanai) }</font></c:if>
			</td>
			<td >${f:h(a.itLabel) }</td>
			<td >${f:h(a.bringPersonNumber)}</td>
			<td >${f:h(a.bringPersonName)}</td>
			<td class="long">${f:h(a.dest)}</td>
			<td >${f:h(a.startDate)}</td>
			<td >${f:h(a.maxEndDate)}</td>
			</tr>
			</c:forEach>
	<c:if test="${(syaDaityoLookDto2)!=null}">
	
	<tr><th colspan=8>持出履歴のないもの</th></tr>
	<tr>
		<th class="ultraSmall">社内</th>
		<th class="small">ITラベル</th>
		<th class="small">申請者<br />社員番号</th>
		<th class="small">申請者氏名</th>
		<th>持出先</th>
		<th class="small">持出開始日</th>
		<th class="small">持出終了日</th>
	</tr>
	<c:forEach var="a" items="${syaDaityoLookDto2}">
		<tr>
			<td>
			<font color="blue">有</font>
			</td>
			<td >${f:h(a.itLabel) }</td>
			<td >${f:h(a.bringPersonNumber)}</td>
			<td >${f:h(a.bringPersonName)}</td>
			<td class="long">${f:h(a.dest)}</td>
			<td >${f:h(a.startDate)}</td>
			<td >${f:h(a.maxEndDate)}</td>
			</tr>
			</c:forEach>
			
	</c:if>
</table>

</div>
</body>
</html>