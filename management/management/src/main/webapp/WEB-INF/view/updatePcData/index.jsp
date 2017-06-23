<%@page pageEncoding="UTF-8"%>
<html>
<title>更新</title>
<script type="text/javascript">
<!--
function disp(){
	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('更新してもよろしいでしょうか？')){
		window.alert('更新されました！');
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
<!--
function deleteAll1(){
	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('削除してもよろしいでしょうか？')){
		window.alert('削除されました！');
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
<!--
function deleteSoftware(){
	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('削除してもよろしいでしょうか？')){
		window.alert('削除されました！');
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
<!--
function addSoftware(){
	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('追加してもよろしいでしょうか？test')){
		window.alert('追加しました！');
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
<h1>資産管理：更新</h1>
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
				<input type="hidden" name="itLabel" value="${f:h(itLabel)}" />
				<input type="submit" name="deleteAll" value="削除" onClick="return deleteAll1()"/>
			</td>
		</tr>
		<tr>
			<th>ITラベル</th>
			<td font="15px">${f:h(itLabel)}</td>
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
			<td class="bottun"></td>
			<td class="bottun"></td>
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
				<input type="hidden" name="itLabel" value="${f:h(itLabel)}" />
				<input type="hidden" name="softwareId" value="${f:h(a.softwareId)}" />
				<input type="submit" name="update" value="更新" onClick="return disp()" />
			</td>
		</tr>
	</s:form>
		
		<br>
		<br>
		<table>
			<tr>
				<th>ソフトウェア</th>
			</tr>
		</table>
		<c:forEach var="a" items="${personSoftware}" varStatus="status">
			<table>	
				<tr>
					<td class="t">${f:h(a.softwareName)}</td>
					<td class="t">${f:h(a.softwareVer)}</td>
					<s:form>
						<input type="hidden" name="itLabel" value="${f:h(itLabel)}" />
						<input type="hidden" name="softwareId" value="${f:h(a.softwareId)}" />
						<td class="bottun" align="left">
							<input type="submit" name="delete" value="削除" onClick="return deleteSoftware()"/>
						</td>
					</s:form>
				</tr>
			</table>
		</c:forEach>
			<CAPTION ALIGN=bottom>
				<s:form>
					<html:select property="selectSoftwareId">
						<c:forEach var="a" items="${selectSoftwareName}" varStatus="status">
							<html:option value="${f:h(a.softwareId)}">${f:h(a.softwareName)} ${f:h(a.softwareVer)}</html:option>
						</c:forEach>
					</html:select>
					<input type="hidden" name="itLabel" value="${f:h(itLabel)}" />
					<input type="hidden" name="softwareId" value="${f:h(a.softwareId)}" />
					<input type="submit" name="add" value="追加" onClick="return addSoftware()"/>
				</s:form>
			</CAPTION>

		
</table>
	<s:form>
		<input type="submit" name="returnSearch" value="検索画面へ" />
	</s:form>
</body>
</html>