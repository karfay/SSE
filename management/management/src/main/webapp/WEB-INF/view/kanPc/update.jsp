<%@page pageEncoding="UTF-8"%>
<html>
<title>PC端末の管理ページ</title>
<link rel="stylesheet" type="text/css" href="${f:url('/css/KanPc.css')}" />

<script type="text/javascript">
<!--
function checkInsert(){
	
	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('入力内容で修正します。')){
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

function message(){
	window.alert("修正を行って下さい。")
}

function postAdmin(obj){
	var insert = document.forms["update"];
	insert.admin.value = obj.post.value;
	return false;
}

function postUser(obj){
	var insert = document.forms["update"];
	insert.user.value = obj.post.value;
	return false;
}

// -->
</script>
<div id="headerArea">
<head>
<h1 style="position: absolute; left: 10px; top: -12.5px;" >PC端末の管理</h1>
<s:form>
	<input type="submit" name="menu" value="メニューへ"
		style="position: absolute; right: 10px; top: 12.5px;" />
	<input type="submit" name="logout" value="ログアウト"
		style="position: absolute; right: 165px; top: 12.5px;" />
</s:form>
</head>
</div>
<body onLoad="message()">
<div id="contentsArea">
<br />
<html:errors />

<s:form styleId="old">
	<table border="1">
		<tr>
			<th>ITラベル</th>
			<th>管理者</th>
			<th>利用者</th>
			<th>資産形態</th>
			<th>利用開始日</th>
			<th>利用終了日</th>
			<th>終了予定日</th>
		</tr>
		<tr>
			<td><input type="text" disabled="disabled" name="old.itLabel" value="${(old.itLabel)}" /></td>
			<td><input type="text" disabled="disabled" name="old.admin" value="${(old.admin)}" /></td>
			<td><input type="text" disabled="disabled" name="old.user" value="${(old.user)}" /></td>
			<td><input type="text" disabled="disabled" name="old.assetsMode" value="${(old.assetsMode)}" /></td>
			<td><input type="text" disabled="disabled" name="old.startDate" value="${(old.startDate)}" /></td>
			<td><input type="text" disabled="disabled" name="old.endDate" value="${(old.endDate)}" /></td>
			<td><input type="text" disabled="disabled" name="old.scheduledDate" value="${(old.scheduledDate)}" /></td>
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
		
			<td><input type="text" disabled="disabled" name="old.maker" value="${(old.maker)}" /></td>
			<td><input type="text" disabled="disabled" name="old.modelNumber" value="${(old.modelNumber)}" /></td>
			<td><input type="text" disabled="disabled" name="old.serialNumber" value="${(old.serialNumber)}" /></td>
			<td><input type="text" disabled="disabled" name="old.os" value="${(old.os)}" /></td>
			<td><input type="text" disabled="disabled" name="old.wirelessLan" value="${(old.wirelessLan)}" /></td>
			<td colspan="2"><input type="text" disabled="disabled" name="old.encryption" value="${(old.encryption)}" /></td>
		</tr>
		<tr>
		<th>備考</th>
		<td class="none" colspan="6"></td>
		</tr>
		<tr>
		<td colspan="7"><input type="text" disabled="disabled" name="old.notes" value="${(old.notes)}" /></td>
		</tr>
	</table>
</s:form>

<form>
<table><tr><th colspan="3" class="post">
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

<s:form styleId="update">
	<table border="1">
		<tr>
			<th style="background-color:yellow;">ITラベル(変更不可)</th>
			<th>管理者</th>
			<th>利用者</th>
			<th>資産形態</th>
			<th>利用開始日</th>
			<th>利用終了日</th>
			<th>終了予定日</th>
		</tr>
		<tr>
			<td><html:text readonly="true" property="itLabel" value="${(old.itLabel)}" /></td>
			<td><html:text property="admin" value="${f:h(adminNumber)}" /></td>
			<td><html:text property="user" value="${f:h(userNumber)}" /></td>
			<td><select name="assetsMode">
					<option value="${(assetsMode)}" selected>${(assetsMode)}</option>
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
					<option value="${(maker)}" selected>${(maker)}</option>
					<option value="NEC">NEC</option>
					<option value="TOSHIBA">TOSHIBA</option>
					<option value="その他">その他</option>
			</select></td>
			<td><html:text styleClass="hankaku" property="modelNumber" value="${f:h(modelNumber)}" /></td>
			<td><html:text styleClass="hankaku" property="serialNumber" value="${f:h(serialNumber)}" /></td>
			<td><html:text styleClass="hankaku" property="os" value="${f:h(os)}" /></td>
			<td><select name="wirelessLan">
					<option value="${(wirelessLan)}" selected>${(wirelessLan)}</option>
					<option value="有">有</option>
					<option value="無">無</option>
			</select></td>
			<td colspan="2"><html:text property="encryption" value="${f:h(encryption)}" /></td>
		</tr>
		<tr>
		<th>備考</th>
		<td class="none" colspan="6"></td>
		</tr>
		<tr>
		<td colspan="7"><html:text styleClass="zenkaku" property="notes" value="${f:h(notes)}" /></td>
		</tr>
	</table>
	<input class="soloButton" type="submit" name="update" value="修正" onClick="return checkInsert()" />
</s:form>

</div>
</body>
</html>