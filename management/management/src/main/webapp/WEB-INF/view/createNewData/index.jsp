<%@page pageEncoding="UTF-8"%>
<html>
<title>新規作成</title>
<script type="text/javascript">
<!--
function disp(){
	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('新規作成いたしますがよろしいでしょうか？')){

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
<body>
<h1>資産管理：新規作成</h1>
<html:errors/>
<table>
	<s:form>
		<tr>
			<th>ITラベル</th>
			<td><html:text property="itLabel" /></td>
			<th>管理者</th>
			<td><html:text property="admini" /></td>
			<th>使用者</th>
			<td><html:text property="user" /></td>
			<th>貸出日</th>
			<td><html:text property="lendingDate" /></td>
		</tr>
		<tr>
			<th>回収日</th>
			<td><html:text property="collectionDay" /></td>
			<th>廃棄日</th>
			<td><html:text property="disposalDate" /></td>
			<th>型番</th>
			<td><html:text property="mdoelNumber" /></td>
			<th>製造番号</th>
			<td><html:text property="serialNumber" /></td>
		</tr>
		<tr>
			<th>出荷年月</th>
			<td><html:text property="delivery" /></td>
			<th>OS</th>
			<td>
				<html:select property="os">
					<html:option value=""></html:option>
					<html:option value="Windows XP">Windows XP</html:option>
					<html:option value="Windows7(32bit)">Windows7(32bit)</html:option>
					<html:option value="Windows7(64bit)">Windows7(64bit)</html:option>
				</html:select>
			</td>
			<th>無線LAN</th>
			<td><html:text property="wirelessLan" /></td>
			<th>HDD容量</th>
			<td><html:text property="hddSpace" /></td>
		</tr>
		<tr>
			<th>単位</th>
			<td>	
					<html:radio property="dataVolume" value="G" />G
					<html:radio property="dataVolume" value="T" />T
			</td>
			<th>IPアドレス</th>
			<td><html:text property="ipAddress" /></td>
			<th>暗号化ソフト</th>
			<td><html:text property="encryptionSoft" /></td>
			<th>備考</th>
			<td><html:text property="notes" /></td>
		</tr>
		<tr>
			<td class="bottun"></td>
			<td class="bottun"></td>
			<td class="bottun"></td>
			<td class="bottun"></td>
			<td class="bottun"></td>
			<td class="bottun"></td>
			<td class="bottun"></td>
			<td class="bottun" align="right">
				<input type="submit" name="create" value="新規作成"  onClick="return disp()"/>
			</td>
		</tr>
	</s:form>
</table>
	<s:form>
		<input type="submit" name="returnSearch" value="検索画面へ" />
	</s:form>
</body>
</html>