<%@page pageEncoding="UTF-8"%>
<html>
<title>検索</title>
<script type="text/javascript">
function tableColor(table,start,color1,color2){
	var rows=table.rows;
	for(var idx=start;idx<rows.length;++idex){
		rows[idx].style.backgroundColor=idx%2==0?color1:color2;
	}	
}
// -->
</script>
<link rel="stylesheet" type="text/css" href="${f:url('/css/sa.css')}" />
<body>
<h1>資産管理：検索</h1>
<html:errors />
<table>
	<s:form>
		<tr>
			<td class="bottun"></td>
			<td class="bottun"></td>
			<td class="bottun"></td>
			<td class="bottun"></td>
			<td class="bottun"></td>
			<td class="bottun"></td>
			<td class="bottun"></td>
			<td class="bottun" align="right">
				<input type="submit" name="menu" value="メニューへ" />
				<input type="submit" name="logout" value="ログアウト" />
			</td>
		</tr>
		<tr>
			<th>ITラベル</th>
			<td><html:text property="itLabel" maxlength="8" /></td>
			<th>管理者</th>
			<td><html:text property="admini" /></td>
			<th>使用者</th>
			<td><html:text property="user" /></td>
			<th>貸出日</th>
			<td><html:text property="lendingDate" maxlength="8" /></td>
		</tr>
		<tr>

			<th>回収日</th>
			<td><html:text property="collectionDay" maxlength="8" /></td>
			<th>廃棄日</th>
			<td><html:text property="disposalDate" maxlength="8" /></td>
			<th>型番</th>
			<td><html:text property="mdoelNumber" /></td>
			<th>OS</th>
			<td>
				<html:select property="os">
					<html:option value=""></html:option>
					<html:option value="Windows XP">Windows XP</html:option>
					<html:option value="Windows7(32bit)">Windows7(32bit)</html:option>
					<html:option value="Windows7(64bit)">Windows7(64bit)</html:option>
				</html:select>
			</td>
		</tr>
		<tr>
			<th>無線LAN</th>
			<td><html:text property="wirelessLan" /></td>
			<th>HDD容量</th>
			<td>
				<html:text property="hddSpace" />
			</td>
			<th>単位</th>
			<td>
				<html:radio property="dataVolume" value="G" />G
				<html:radio property="dataVolume" value="T" />T
			</td>
			<th>IPアドレス</th>
			<td>
				<html:radio property="ipAddress" value="DHCP"/>DHCP
				<html:radio property="ipAddress" value="else"/>固定
			</td>
		</tr>
		<tr>
			<td class="bottun" align="left">
				<input type="submit" name="cleateNew" value="新規作成へ" />
			</td>
			<td class="bottun"></td>
			<td class="bottun"></td>
			<td class="bottun"></td>
			<td class="bottun"></td>
			<td class="bottun"></td>
			<td class="bottun"></td>
			<td class="bottun" align="right">
				<input type="submit" name="submit" value="検索開始" />
			</td>
		</tr>
</s:form>
</table>

<br>
<br>
<div style="width:965px; border-style:solid; border-width:1px;">
	<div style="width:100%;">
		<table class="t">

			<thead>
				<tr>
					<th class="t">ITラベル</th>
					<th class="t">管理者</th>
					<th class="t">使用者</th>
					<th class="t">貸出日</th>
					<th class="t">回収日</th>
					<th class="t">廃棄日</th>
					<th class="t">型番</th>
					<th class="t">製造番号</th>
					<th class="t">出荷年月</th>
					<th class="small_t"></th>
				</tr>
				<tr>
					<th class="t">OS</th>
					<th class="t">無線LAN</th>
					<th class="t">HDD容量</th>
					<th class="t">単位</th>
					<th class="t">IPアドレス</th>
					<th class="t">暗号化ソフト</th>
					<th class="t">備考</th>
					<th class="t"></th>
					<th class="t"></th>
					<th class="t"></th>
				</tr>
			</thead>
		</table>
	</div>
	<div style="height:250px; width:100%; overflow:auto; background:#BBBBBB">
		<table class="t">

		<tbody>
			<c:forEach var="a" items="${result}" varStatus="status">
				<tr>
					<td class="t"><a href="../TAN020/?itLabel=${f:h(a.itLabel)}">${f:h(a.itLabel)}</a></td>
					<td class="t">${f:h(a.admini)}</td>
					<td class="t">${f:h(a.user)}</td>
					<td class="t">${f:h(a.lendingDate)}</td>
					<td class="t">${f:h(a.collectonday)}</td>
					<td class="t">${f:h(a.disposalDate)}</td>
					<td class="t">${f:h(a.mdoelNumber)}</td>
					<td class="t">${f:h(a.serialNumber)}</td>
					<td class="t">${f:h(a.delivery)}</td>
				</tr>
				<tr>
					<td class="t">${f:h(a.os)}</td>
					<td class="t">${f:h(a.wirelessLan)}</td>
					<td class="t">${f:h(a.hddSpace)}</td>
					<td class="t">${f:h(a.dataVolume)}</td>
					<td class="t">${f:h(a.ipAddress)}</td>
					<td class="t">${f:h(a.encryptionSoft)}</td>
					<td class="t">${f:h(a.notes)}</td>
					<td class="t"></td>
					<td class="t"></td>
				</tr>
			</c:forEach>
		</tbody>
		</table>
	</div>
</div>
</body>
</html><html>

</html>