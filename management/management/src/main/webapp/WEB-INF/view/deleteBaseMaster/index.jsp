<%@page pageEncoding="UTF-8"%>
<html>
<head>
<title>削除</title>
<script type="text/javascript">
<!--
function disp(){
	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('削除してもよろしいでしょうか？')){

		return true;

	}
	// 「OK」時の処理終了
	// 「キャンセル」時の処理開始
	else{

		window.alert('キャンセルされました'); // 警告ダイアログを表示
		return false;

	}
	// 「キャンセル」時の処理終了
	
}
// -->
</script>
<link rel="stylesheet" type="text/css" href="${f:url('/css/sa.css')}" />
</head>
<body>
<h1>資産管理：削除</h1>
<html:errors />
<table>

	<tr>
		<th>ITラベル</th>
		<td>${f:h(itLabel)}</td>
		<th>管理者</th>
		<td>${f:h(admini)}</td>
		<th>使用者</th>
		<td>${f:h(user)}</td>
	</tr>
	<tr>
		<th>貸出日</th>
		<td>${f:h(lendingDate)}</td>
		<th>回収日</th>
		<td>${f:h(collectionDay)}</td>
		<th>廃棄日</th>
		<td>${f:h(disposalDate)}</td>
	</tr>
	<tr>
		<th>型番</th>
		<td>${f:h(mdoelNumber)}</td>
		<th>製造番号</th>
		<td>${f:h(serialNumber)}</td>
		<th>出荷年月</th>
		<td>${f:h(delivery)}</td>
	</tr>
	<tr>
		<th>OS</th>
		<td>${f:h(os)}</td>
		<th>無線LAN</th>
		<td>${f:h(wirelessLan)}</td>
		<th>HDD容量</th>
		<td>${f:h(hddSpace)}</td>
	</tr>
	<tr>
		<th>IPアドレス</th>
		<td>${f:h(ipAddress)}</td>
		<th>暗号化ソフト</th>
		<td>${f:h(encryptionSoft)}</td>
		<th>備考</th>
		<td>${f:h(notes)}</td>
	</tr>
	
	<CAPTION ALIGN=bottom>
		<s:form>
			<input type="hidden" name="itLabel" value="${f:h(itLabel)}" />
			<input type="submit" name="submit" value="削除" onClick="return disp()"/>
		</s:form>
	</CAPTION>

</table>
</body>
</html>