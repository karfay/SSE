<%@page pageEncoding="UTF-8"%>
<html>
<title>PC端末の管理ページ</title>
<link rel="stylesheet" type="text/css" href="${f:url('/css/KanPc.css')}" />

<script type="text/javascript">
<!--
function checkInsert(){
	
	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('PCを新規登録します。')){
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

function checkDelete(){
	
	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('このPC情報を削除します。')){
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

function executeQuote(Obj){
	var insert = document.forms["insert"];
	
	insert.itLabel.value = Obj.form.itLabel.value;
	insert.admin.value = Obj.form.admin.value;
	insert.user.value = Obj.form.user.value;
	insert.assetsMode.value = Obj.form.assetsMode.value;
	insert.startDate.value = Obj.form.startDate.value;
	insert.endDate.value = Obj.form.endDate.value;
	insert.scheduledDate.value = Obj.form.scheduledDate.value;
	insert.maker.value = Obj.form.maker.value;
	insert.modelNumber.value = Obj.form.modelNumber.value;
	insert.serialNumber.value = Obj.form.serialNumber.value;
	insert.os.value = Obj.form.os.value;
	insert.wirelessLan.value = Obj.form.wirelessLan.value;
	insert.encryption.value = Obj.form.encryption.value;
	insert.notes.value = Obj.form.notes.value;	
	
	window.alert("新規登録のフォームに値を引用しました");

	return false;
}


function message(){
	window.alert("${message}");
}

function postAdmin(obj){
	var insert = document.forms["insert"];
	insert.admin.value = obj.post.value;
	return false;
}

function postUser(obj){
	var insert = document.forms["insert"];
	insert.user.value = obj.post.value;
	return false;
}

function checkImport(){
	
	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('csvファイルに出力します。')){
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

function executeClear(){
	var insert = document.forms["insert"];

	insert.itLabel.value = '';
	insert.admin.value = '';
	insert.user.value = '';
	insert.assetsMode.value = '';
	insert.startDate.value = '';
	insert.endDate.value = '';
	insert.scheduledDate.value = '';
	insert.maker.value = '';
	insert.modelNumber.value = '';
	insert.serialNumber.value = '';
	insert.os.value = '';
	insert.wirelessLan.value = '';
	insert.encryption.value = '';
	insert.notes.value = '';

	window.alert('入力欄をクリアしました');

	return false;
}
// -->
</script>
<head>
</head>
<body onLoad="message()" class="input">
<div id="headerArea">

<h1 style="position: absolute; left: 10px; top: -12.5px;" >PC端末の管理</h1>
<s:form>
	<input type="submit" name="menu" value="メニューへ"
		style="position: absolute; right: 10px; top: 12.5px;" />
	<input type="submit" name="logout" value="ログアウト"
		style="position: absolute; right: 165px; top: 12.5px;" />
</s:form>

</div>

<div id="selectArea">
<form>
<table>
<tr><th colspan="3" class="post">
社員番号転記用フォーム
</th></tr>
<tr><td>
	<select name="post" class="post">
		<option value="">選択して下さい</option>
		<c:forEach var="pm" items="${(personnelMaster)}">
			<option value="${f:h(pm.personnelNumber)}">${(pm.personnelName)}</option>
		</c:forEach>
	</select>
	</td>
	<td><input type="submit" value="管理者へ転記" onclick="return postAdmin(this.form)" /></td>
	<td><input type="submit" value="利用者へ転記" onclick="return postUser(this.form)" /></td>
	</tr>
</table>
</form>
<s:form styleId="insert">
	<table border="1">
		<tr>
			<th style="background-color:yellow;">ITラベル(必須)</th>
			<th>管理者</th>
			<th>利用者</th>
			<th>資産形態</th>
			<th>利用開始日</th>
			<th>利用終了日</th>
			<th>終了予定日</th>
		</tr>
		<tr>
			<td><html:text styleClass="hankaku" maxlength="8" errorStyleClass="err"
							property="itLabel" value="${f:h(itLabel)}" /></td>
			<td><html:text property="admin" value="${f:h(admin)}" /></td>
			<td><html:text property="user" value="${f:h(user)}" /></td>
			<td><select name="assetsMode">
					<option value="" selected>選択して下さい</option>
					<option value="本部貸出">本部貸出</option>
					<option value="リース">リース</option>
					<option value="その他">その他</option>
			</select></td>
			<td><html:text styleClass="hankaku" maxlength="8" errorStyleClass="err"
							property="startDate" value="${f:h(startDate)}" /></td>
			<td><html:text styleClass="hankaku" maxlength="8" errorStyleClass="err"
							property="endDate" value="${f:h(endDate)}" /></td>
			<td><html:text styleClass="hankaku" maxlength="8" errorStyleClass="err"
							property="scheduledDate" value="${f:h(scheduledDate)}" /></td>
		</tr>
		<tr>
			<th>メーカー</th>
			<th>型番</th>
			<th>製造番号</th>
			<th>OS</th>
			<th>無線LAN</th>
			<th colspan="2">暗号化ソフト</th>
		</tr>
		<tr>
			<td><select name="maker">
					<option value="" selected>選択して下さい</option>
					<option value="NEC">NEC</option>
					<option value="TOSHIBA">TOSHIBA</option>
					<option value="その他">その他</option>
			</select></td>
			<td><html:text styleClass="hankaku" property="modelNumber" value="${f:h(modelNumber)}" /></td>
			<td><html:text styleClass="hankaku" property="serialNumber" value="${f:h(serialNumber)}" /></td>
			<td><html:text styleClass="hankaku" property="os" value="${f:h(os)}" /></td>
			<td><select name="wirelessLan">
					<option value="" selected>選択して下さい</option>
					<option value="有">有</option>
					<option value="無">無</option>
			</select></td>
			<td colspan="2"><html:text styleClass="hankaku" property="encryption" value="${f:h(encryption)}" /></td>
		</tr>
		<tr>
		<th>備考</th>
		<td colspan="6"><html:text styleClass="zenkaku" property="notes" value="${f:h(notes)}" /></td>
		</tr>
	</table>
	<input class="soloButton" type="submit" name="insert" value="新規登録" onClick="return checkInsert()" />
	<input class="clearButton" type="submit" name="clear" value="入力情報のクリア" onClick="return executeClear()" />
</s:form>
<p class="messages">${message}</p>
</div>
<div id="contentsArea">
<br />
<ul><html:errors /></ul>
<br />
<table class="kanPcTable" style="margin-top: 10px">
<s:form>
	<tr>
		<td class="outputCsv" colspan="3">
		<input class="outputCsv" type="submit" name="importCsv" value="CSVに出力" onClick="return checkImport()" />
		</td>
		<th class="small">ITラベル</th>
		<th class="small">管理者</th>
		<th class="small">利用者</th>
		<th class="small">資産形態</th>
		<th class="small">利用開始日</th>
		<th class="small">利用終了日</th>
		<th class="small">終了予定日</th>
		<th class="small">メーカー</th>
		<th>型番</th>
		<th class="small">製造番号</th>
		<th class="small">OS</th>
		<th class="ultraSmall">無線LAN</th>
		<th>暗号化ソフト</th>
		<th>備考</th>
	</tr>
</s:form>
	<c:forEach var="a" items="${pcMasterDto}" varStatus="st">
		<c:if test="${st.index%2==0}">
		<tr>
		</c:if>
		<c:if test="${st.index%2==1}">
		<tr bgcolor="aliceblue">
		</c:if>
			<s:form>
			<html:hidden property="itLabel" value="${f:h(a.itLabel)}" />
			<html:hidden property="admin" value="${f:h(a.admin)}" />
			<html:hidden property="user" value="${f:h(a.user)}" />
			<html:hidden property="assetsMode" value="${f:h(a.assetsMode)}" />
			<html:hidden property="startDate" value="${f:h(a.startDate)}" />
			<html:hidden property="endDate" value="${f:h(a.endDate)}" />
			<html:hidden property="scheduledDate" value="${f:h(a.scheduledDate)}" />
			<html:hidden property="maker" value="${f:h(a.maker)}" />
			<html:hidden property="modelNumber" value="${f:h(a.modelNumber)}" />
			<html:hidden property="serialNumber" value="${f:h(a.serialNumber)}" />
			<html:hidden property="os" value="${f:h(a.os)}" />
			<html:hidden property="wirelessLan" value="${f:h(a.wirelessLan)}" />
			<html:hidden property="encryption" value="${f:h(a.encryption)}" />
			<html:hidden property="notes" value="${f:h(a.notes)}" />
			<td class="update"><input class="update" type="submit" name="jumpUpdate" value="修正" /></td>
			<td class="update"><input class="quote" type="submit" name="quote" value="引用" onClick="return executeQuote(this)" /></td>
			<td class="update"><input class="delete" type="submit" name="delete" value="削除" onClick="return checkDelete()" /></td>
			<td class="t">${f:h(a.itLabel)}</td>
			<td class="t">${f:h(a.admin)}</td>
			<td class="t">${f:h(a.user)}</td>
			<td class="t">${f:h(a.assetsMode)}</td>
			<td class="t">${f:h(a.startDate)}</td>
			<td class="t">${f:h(a.endDate)}</td>
			<td class="t">${f:h(a.scheduledDate)}</td>
			<td class="t">${f:h(a.maker)}</td>
			<td class="t">${f:h(a.modelNumber)}</td>
			<td class="t">${f:h(a.serialNumber)}</td>
			<td class="t">${f:h(a.os)}</td>
			<td class="t">${f:h(a.wirelessLan)}</td>
			<td class="t">${f:h(a.encryption)}</td>
			<td class="notes">
			<div id="notes"><a title="${f:h(a.notes)}">${f:h(a.notes)}</a></div>
			</td>
			</s:form>
		</tr>
	</c:forEach>
</table>
</div>
</body>
</html>