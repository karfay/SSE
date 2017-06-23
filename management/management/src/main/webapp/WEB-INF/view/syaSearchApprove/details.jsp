<%@page pageEncoding="UTF-8"%>
<html>
<title>社外持出管理台帳</title>

<script type="text/javascript">
<!--

function checkApprove(obj){

	approver = obj.form.approver.value;
	
	if(${conditionCode}==1){
		window.alert('既に承認されています');
		return false;
	}
	// 承認者とログインユーザが違うと承認入力を受け付けない
	if('${userId}' != approver){
		window.alert('選択した承認者とログインユーザが違います。\n選択したユーザIDでログインし直してください。' + approver);
		return false;
	}
	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('承認してもよろしいでしょうか？')){
		return true;

	}
	// 「OK」時の処理終了
	// 「キャンセル」時の処理開始
	else{

		window.alert('キャンセルされました'); // 警告ダイアログを表示
		return false;

	}
	// 「キャンセル」時の処理終了
	return false;
}


function checkRemand(obj){

	approver = obj.form.approver.value;
	notes = obj.form.notes.value;

	// 承認者とログインユーザが違うと承認入力を受け付けない
	if('${userId}' != approver){
		window.alert('選択した承認者とログインユーザが違います。\n選択したユーザIDでログインし直してください。' + approver);
		return false;
	}
	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('差し戻ししてもよろしいでしょうか？')){

		if(notes == ""){
			window.alert('差し戻しするには備考に差し戻し事由を明記して下さい。');
			return false;
		}

		return true;

	}
	// 「OK」時の処理終了
	// 「キャンセル」時の処理開始
	else{

		window.alert('キャンセルされました'); // 警告ダイアログを表示
		return false;

	}
	// 「キャンセル」時の処理終了
	return false;
}
// -->
</script>

<link rel="stylesheet" type="text/css" href="${f:url('/css/Input.css')}" />
<body>

<div id="headerArea">
<h1 style="position: absolute; left: 10px; top: -15px;" >社外持出台帳：詳細表示</h1>
<form>
	<input type="submit" name="menu" value="メニューへ"
		style="position: absolute; right: 10px; top: 12.5px;" />
	<input type="submit" name="logout" value="ログアウト"
		style="position: absolute; right: 165px; top: 12.5px;" />
	<input type="submit" name="syaDaityoInput" value="登録画面へ" 
		style="position: absolute; right: 320px; top: 12.5px;" />
	<input type="submit" name="syaSearchApprove" value="検索画面へ"
		style="position: absolute; right: 475px; top: 12.5px;" />
</form>
</div>
<div id="contentsArea">
<html:errors />
<br />
<font size="4" color="red"><b>${f:h(sya020msg)}</b></font>

<table border="1">
	<tr>
		<th class="cond">${f:h(conditionMaster[conditionCode+1].conditionName)}</th>
		<td class="none"></td>
		<td class="none"></td>
		<td class="none"></td>
	</tr>
	<tr>
		<th>申請日</th>
		<th>申請者</th>
		<th>持出開始日</th>
		<th>持出終了日</th>
	</tr>
	<tr>
		<td class="details">${f:h(appDate)}</td>
		<td class="details">${f:h(personnelName)}</td>
		<td class="details">${f:h(startDate)}</td>
		<td class="details">${f:h(endDate)}</td>
	</tr>
	<tr>
		<th>持出先</th>
		<td class="space"></td>
		<td class="space"></td>
		<td class="space"></td>
	</tr>
	<tr>
		<td colspan="4" class="long" style="width:100%;">${f:h(dest)}</td>
	</tr>
	<tr>
		<th>プロジェクト名</th>
		<td class="none"></td>
		<td class="none"></td>
		<td class="none"></td>
	</tr>
	<tr>
		<td colspan="4" class="long" style="width: 100%">${f:h(project)}</td>
	</tr>
</table>
<br />
<br />
<font size="5">-持ち出し物-</font>
<br />
<font size="4"><b>機器</b></font>
<table border="1">
<tr>
		<th>シンクラ端末（ITラベル）</th>
		<td class="details">${f:h(wirelessSlave)}</td>
	</tr>
	<tr>
		<th class="details">PC（ITラベル）</th>
		<td class="details">${f:h(itLabel)}</td>
	</tr>
	<tr>
		<th>モバイルWi-Fi（ITラベル）</th>
		<td class="details">${f:h(wirelessLan)}</td>
	</tr>
	<tr>
		<th>その他の持出物</th>
		<td class="details">${f:h(otherMedia)}</td>
	</tr>
</table>
<font size="4"><b>紙媒体資料</b></font>
<br />
<font size="4" color="red"><b>${f:h(sya021msg)}</b></font>
<table border="1">
	<c:forEach var="s" items="${documents}">
		<tr>
			<th>資料名称</th>
			<th>部数</th>
			<th>資料区分</th>
		</tr>
		<tr>
			<td class="long" style="width: 450;">${f:h(s.docName)}</td>
			<td>${f:h(s.copies)}</td>
			<td>${f:h(documentCategoy[s.categoryId].categoryName)}</td>
		</tr>
	</c:forEach>
</table>
<br />
<br />

<!-- 差し戻しの場合、差し戻し事由を表示 -->
<c:if test="${conditionCode==3 && authorizations!=1}">
	<table border="1">
		<tr>
			<th class="cond">備考</th>
			<td class="space">
		</tr>
		<tr>
			<td colspan="2" class="long" style="width: 300; height: 90; vertical-align: top;"><pre>${(notes)}</pre></td>
		</tr>
	</table>
</c:if>


<c:if test="${authorizations==1}">
	<s:form>
		<table border="1" style="position: relative; left: 300px;">
			<tr>
				<th style="background-color: yellow;">承認日</th>
				<th style="background-color: yellow;">承認者</th>
				<td class="space" style="border-top: 1px solid #EEEEEE;"></td>
			</tr>
			<tr>
				<td class="t"><input type="text" name="approvalDate" value="${f:h(time)}" class="hankaku" maxlength="8" ></td>
				<td class="noneBox"><select name="approver">
					<c:forEach var="a" items="${approvers}">

						<!-- ↓セレクトボックスの初期値を調整する処理↓ -->
						<c:if test="${(userId == a.personnelNumber) && (appUser != a.personnelNumber)}">
							<option value="${a.personnelNumber}" selected>${a.PersonnelName}</option>
						</c:if>

						<c:if test="${userId != a.personnelNumber}">
							<option value="${a.personnelNumber}">${a.PersonnelName}</option>
						</c:if>
						<!-- ↑セレクトボックスの初期値を調整する処理↑ -->

					</c:forEach>
				</select></td>
				<td class="space">
				<input type="submit" name="approve" value="承認" onClick="return checkApprove(this)" style="color: red;" /></td>
			</tr>
		</table>

		<br />

		<table border="1" style="position: relative; left: 300px;">
			<tr>
				<th style="background-color: yellow;">備考</th>
				<td class="space" style="border-top: 1px solid #EEEEEE;"></td>
			</tr>
			<tr>
				<td class="noneBox"><!--※※※ ↓自動インデントするとテキストエリア内に文字が初期値として格納されてしまう場合がある↓ ※※※-->
				<html:textarea property="notes" cols="50" rows="4" errorStyleClass="err" >${f:h(notes)}</html:textarea></td>
				<td class="space" style="vertical-align: bottom;">
				<input type="submit" name="remand" value="差し戻し" onClick="return checkRemand(this)" style="color: red;" /></td>
			</tr>
		</table>
		<br />
		<br />
		<input type="hidden" name="tableId" value="${f:h(tableId)}" />
	</s:form>
</c:if>
</div>
</body>
</html>