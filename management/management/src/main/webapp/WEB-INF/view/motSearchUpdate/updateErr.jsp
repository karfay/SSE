<%@page pageEncoding="UTF-8"%>
<html>
<title>社内持込管理システム</title>
<link rel="stylesheet" type="text/css" href="${f:url('/css/Input.css')}" />
<body>

<script type="text/javascript">
<!--
function checkUpdate(){
	
	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm(登録内容の修正を行います。')){
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


<div id="headerArea">
	<h1 style="position: absolute; left: 10px; top: -15px;">社内持込台帳：持込情報修正</h1>
<form>
	<input type="submit" name="menu" value="メニューへ"
		style="position: absolute; right: 165px; top: 12.5px;" />
	<input type="submit" name="logout" value="ログアウト"
		style="position: absolute; right: 10px; top: 12.5px;" />
	<input type="submit" name="motDaityoInput" value="登録画面へ" 
		style="position: absolute; right: 320px; top: 12.5px;" />
	<input type="submit" name="motSearchUpdate" value="検索画面へ"
		style="position: absolute; right: 475px; top: 12.5px;" />
</form>
</div>
<div id="contentsArea">
<br />
<ul><html:errors /></ul>
<font size="4" color="red"><b>${f:h(motMsg)}</b></font>
<!-- ↓入力フォーム↓ -->
	<s:form>
		<table border="1">
			<tr>
				<th class="cond">持込承認待ち</th>
				<td class="space" style="border-top: 1px solid #EEEEEE" colspan="3"></td>
			</tr>
			<tr>
				<th>持込開始日</th>
				<th>持込者</th>
				<th>保管終了予定日</th>
				<th>予定処理</th>
			</tr>
			<tr>
				<td><html:text style="ime-mode: disabled; width: 100%;" maxlength="8" property="bringDate" value="${f:h(bringDate)}" errorStyleClass="err" /></td>
				<td><html:text style="ime-mode: disabled; width: 100%;" maxlength="9" property="bringPerson" value="${f:h(bringPerson)}" errorStyleClass="err" /></td>
				<td><html:text style="ime-mode: disabled; width: 100%;" maxlength="8" property="scheduledDate" value="${f:h(scheduledDate)}" errorStyleClass="err" /></td>
				<td><html:select property="scheduledCode" style="width: 100%;" errorStyleClass="err" >
					<c:forEach var="p" items="${processMaster}" begin="1">
						<c:if test="${p.processCode == h.processCode}">
						<option value="${p.processCode}" selected >${p.processName}</option>
						</c:if>
						<c:if test="${p.processCode != h.processCode}">
						<option value="${p.processCode}">${p.processName}</option>
						</c:if>
					</c:forEach>
				</html:select></td>
			</tr>
			<tr>
				<th>預かり元</th>
				<td class="none"></td>
				<td class="none"></td>
				<td class="none"></td>
			</tr>
			<tr>
				<td colspan="4"><html:text property="clientName" value="${f:h(clientName)}" style="ime-mode: active; width: 100%;" errorStyleClass="err" /></td>
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
		<br />
		<br />
		<font size="5">-持ち込み物-</font>
		<br />
		<table border="1">
			<tr>
				<th>持込物名称</th>
				<td colspan="3" class="space" style="border-top: 1px solid #EEEEEE"></td>
			</tr>
			<tr>
				<td colspan="4">
				<html:text property="materialName" value="${f:h(materialName)}" style="ime-mode: active; width: 100%;" errorStyleClass="err" /></td>
			</tr>
			<tr>
			</tr>
			<tr>
				<th>部数</th>
				<th>持込物区分</th>
				<th colspan="2">機密</th>
			</tr>
			<tr>
				<td><html:text style="ime-mode: disabled; width: 100%;" property="copies" value="${f:h(copies)}" errorStyleClass="err" /></td>
				<td><html:select property="categoryCode" style="width: 100%;" errorStyleClass="err" >
					<c:forEach var="m" items="${materialCategoryMaster}">
						<c:if test="${m.categoryCode == categoryCode}">
						<option value="${m.categoryCode}" selected>${m.categoryName}</option>
						</c:if>
						<c:if test="${m.categoryCode != categoryCode}">
						<option value="${m.categoryCode}">${m.categoryName}</option>
						</c:if>
					</c:forEach>
				</html:select></td>
				<td colspan="2"><input type="radio" name="confidential"
					value="1" class="radio" checked />重要扱い事項 <input type="radio"
					name="confidential" value="0" class="radio" disabled />重要扱い事項でない</td>
			</tr>
			<tr>
				<th>格納場所</th>
				<td class="space"></td>
				<td class="space"></td>
				<td class="space"></td>
			</tr>
			<tr>
				<td class="noneBox" colspan="4"><!--※※※ ↓自動インデントするとテキストエリア内に文字が初期値として格納されてしまう場合がある↓ ※※※-->
				<html:textarea property="depository" rows="4" style="width: 100%; ime-mode: active;" errorStyleClass="err" >${f:h(depository)}</html:textarea></td>
			</tr>
			<tr>
				<th>持込時備考</th>
				<td class="space"></td>
				<td class="space"></td>
				<td class="space"></td>
			</tr>
			<tr>
				<td class="noneBox" colspan="4"><!--※※※ ↓自動インデントするとテキストエリア内に文字が初期値として格納されてしまう場合がある↓ ※※※-->
				<textarea name="bringNotes" rows="4" style="width: 100%; ime-mode: active;" />${f:h(bringNotes)}</textarea></td>
			</tr>
			<tr>
				<td class="none" style="border: none;" colspan="3"></td>
				<td class="none" style="border: none;" ><input class="button" type="submit"
					name="bringUpdateExecute" value="持込情報を修正"
					onClick="return checkUpdate()" /> <input type="hidden"
					name="tableId" value="${f:h(tableId)}" /> <input type="hidden"
					name="conditionCode" value="${f:h(conditionCode)}" /></td>
			</tr>
		</table>
	</s:form>

<!-- ↑入力フォーム↑ -->
</div>
</body>
</html>