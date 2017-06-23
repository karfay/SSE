<%@page pageEncoding="UTF-8"%>
<html>
<title>社外持出管理台帳</title>
<link rel="stylesheet" type="text/css" href="${f:url('/css/Input.css')}" />
<body onLoad="message()">

<script type="text/javascript">
<!--
function checkDeleteDaityo(){
	
	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('台帳を削除します。関連する紙媒体資料の情報も削除されます。')){
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


function checkDeleteDocument(){
	
	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('この紙媒体資料を削除します。')){
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


function CheckUpdate(){
	
	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('修正を行います。修正されたデータは再承認が必要です。')){
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


function checkAddDocuments(){
	
	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('資料の追加を行います。修正されたデータは再承認が必要です。')){
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
	window.alert("${sya010msg}");
}


// -->

</script>

<div id="headerArea">
<h1 style="position: absolute; left: 10px; top: -15px;" >PC持出台帳：修正</h1>
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
<br />
<ul><html:errors /></ul>
<font size="4" color="red"><b>${f:h(sya010msg)}</b></font>

<!-- ↓入力フォーム↓ -->
<s:form>
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
			<td><html:text style="ime-mode: disabled; width: 100%;" errorStyleClass="err" maxlength="8" property="appDate" value="${f:h(appDate)}" /></td>
			<td><html:text style="ime-mode: disabled; width: 100%;" errorStyleClass="err" maxlength="9" property="appUser" value="${f:h(userId)}" /></td>
			<td><html:text style="ime-mode: disabled; width: 100%;" errorStyleClass="err" maxlength="8" property="startDate" value="${f:h(startDate)}" /></td>
			<td><html:text style="ime-mode: disabled; width: 100%;" errorStyleClass="err" maxlength="8" property="endDate" value="${f:h(endDate)}" /></td>
		</tr>
		<tr>
			<th>持出先</th>
			<td class="none"></td>
			<td class="none"></td>
			<td class="none"></td>
		</tr>
		<tr>
			<td colspan="4"><html:text property="dest" value="${f:h(dest)}" style="ime-mode: active; width: 100%;" errorStyleClass="err" /></td>
		</tr>
		<tr>
			<th>プロジェクト名</th>
			<td class="none"></td>
			<td class="none"></td>
			<td class="none"></td>
		</tr>
		<tr>
			<td colspan="4"><html:text property="project" value="${f:h(project)}" style="ime-mode: active; width: 100%;" errorStyleClass="err" /></td>
		</tr>
	</table>

	<h3>-持ち出し物-</h3>
	<font size="4">機器</font>
	<table border="1">
		<tr>
			<th>シンクラ端末（ITラベル）</th>
			<td class="noneBox"><html:select property="wirelessSlave" style="width: 100%;">
				<c:if test="${(wirelessSlave)!=null}" var="flg">
				<option value=""></option>
				</c:if>
				<option value="${f:h(wirelessSlave)}" selected>${f:h(wirelessSlave)}</option>
				<c:forEach var="a" items="${wirelessSlaveNumbers}">
					<c:if test="${wirelessSlave != a}">
					<option value="${a}">${a}</option>
					</c:if>
				</c:forEach>
			</html:select></td>
		</tr>
		<tr>
			<th class="details">PC（ITラベル）</th>
			<td><html:text style="ime-mode: disabled; width: 100%;" errorStyleClass="err" maxlength="8"  property="itLabel" value="${f:h(itLabel)}" /></td>
		</tr>
		<tr>
			<th style="width: 150;">モバイルWi-Fi（ITラベル）</th>
			<td class="noneBox"><html:select property="wirelessLan" style="width: 100%;">
				<c:if test="${(wirelessLan)!=null}" var="flg">
				<option value=""></option>
				</c:if>
				<option value="${f:h(wirelessLan)}" selected>${f:h(wirelessLan)}</option>
				<c:forEach var="a" items="${wirelessLanLabels}">
					<c:if test="${wirelessLan != a}">
					<option value="${a}">${a}</option>
					</c:if>
				</c:forEach>
			</html:select></td>
		</tr>
				<tr>
			<th>その他の持出物</th>
			<td><html:text property="otherMedia" value="${f:h(otherMedia)}" style="width: 100%" /></td>
		</tr>
	</table>
	<table border="1">
		<tr>
			<td class="none" style="width: 150; border-bottom: 1px solid #EEEEEE;"></td>
			<td class="none" style="width: 150; border-bottom: 1px solid #EEEEEE;"></td>
			<td class="none" style="width: 150; border-bottom: 1px solid #EEEEEE;"></td>
			<td class="none" style="border-bottom: 1px solid #EEEEEE;"><input type="submit" name="updateDaityo"
				value="台帳を修正" onClick="return CheckUpdate()" /></td>
			<td class="none" style="border-bottom: 1px solid #EEEEEE;"><input type="submit" name="deleteDaityo"
				value="データを削除" class="button" onClick="return checkDeleteDaityo()" /></td>
		</tr>
	</table>
	<input type="hidden" name="tableId" value="${f:h(tableId)}">
	<input type="hidden" name="conditionCode" value="${f:h(conditionCode)}">
</s:form>

<s:form>
	<font size="4">紙媒体資料</font>
	<br />
	<font size="4" color="red"><b>${f:h(sya011msg)}</b></font>
	<table border="1">
		<tr>
			<th>資料名称</th>
			<th>部数</th>
			<th>資料区分</th>
		</tr>
		<tr>
			<td><html:text property="docName" value="" style="ime-mode: active; width: 100%;" errorStyleClass="err" /></td>
			<td><html:text property="copies" value="" style="ime-mode: disabled; width: 100%;" errorStyleClass="err" /></td>
			<td class="noneBox"><html:select property="categoryId" style="width: 100%;" errorStyleClass="err" >
				<option value="" selected>選択して下さい</option>
				<c:forEach var="a" items="${documentCategoy}">
					<option value="${a.categoryId}">${a.categoryName}</option>
				</c:forEach>
			</html:select></td>
		</tr>
	</table>

	<!-- ↓tableIdを送信することで同一のtableIdで情報を関連付ける↓ -->
	<!-- inputやtextを入力なしで投げた場合、受け取ったプロパティにはNULLではなく空白が入る -->
	<!-- プロパティをすべてStringで宣言しているのが原因かも -->
	<!-- 主にLogicやDaoでの判定で空白文字を使っているのはそのため -->
	<input type="hidden" name="tableId" value="${f:h(tableId)}">
	<input type="hidden" name="conditionCode" value="${f:h(conditionCode)}">
	<input type="submit" name="addDocumentsToUpdate" value="資料を追加" onClick="return checkAddDocuments()" />

</s:form>


<c:if test="${not empty documents}">
<table border="1">
	<!-- ↓引用時のdocumentsリスト表示用フォーム↓ -->
	<tr>
		<th width="450px">資料名称</th>
		<th>部数</th>
		<th>資料区分</th>
		<td class="space" style="border-top: 1px solid #EEEEEE;"></td>
		<td class="space" style="border-top: 1px solid #EEEEEE;"></td>
	</tr>
	<c:forEach var="s" items="${documents}">
		<s:form>
			<tr>
				<td><html:text property="docName" value="${s.docName}" style="ime-mode: active; width: 100%;" errorStyleClass="err" /></td>
				<td><html:text property="copies" value="${s.copies}" style="ime-mode: disabled; width: 100%;" errorStyleClass="err" /></td>
				<td class="noneBox"><html:select property="categoryId" style="width: 100%;">
					<c:forEach var="a" items="${documentCategoy}">

						<!-- ↓セレクトボックスの初期値を調整する処理↓ -->
						<c:if test="${s.categoryId == a.categoryId}">
							<option value="${a.categoryId}" selected>${a.categoryName}</option>
						</c:if>

						<c:if test="${s.categoryId != a.categoryId}">
							<option value="${a.categoryId}">${a.categoryName}</option>
						</c:if>
						<!-- ↑セレクトボックスの初期値を調整する処理↑ -->


					</c:forEach>
				</html:select></td>
				<input type="hidden" name="tableId" value="${f:h(tableId)}">
				<input type="hidden" name="docId" value="${s.docId}">
				<input type="hidden" name="conditionCode"
					value="${f:h(conditionCode)}">
				<td class="button"><input type="submit" name="updateDocument"
					value="修正" onClick="return CheckUpdate()" /></td>
				<td class="button"><input type="submit" name="deleteDocument"
					value="削除" class="button" onClick="return checkDeleteDocument()" /></td>
			</tr>
		</s:form>
	</c:forEach>

	<!-- ↑引用時のdocumentsリスト表示用フォーム↑ -->
</table>
</c:if>

<!-- ↑入力フォーム↑ -->
</div>
</body>
</html>