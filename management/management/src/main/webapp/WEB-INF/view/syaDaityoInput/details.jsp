<%@page pageEncoding="UTF-8"%>
<html>
<title>社外持出管理台帳</title>
<link rel="stylesheet" type="text/css" href="${f:url('/css/Input.css')}" />
<body>

<script type="text/javascript">
<!--
function checkUpdatePermission(conditionCode){
	
	if(conditionCode == 1){
		// 警告ダイアログを表示
		window.alert('承認済みのデータは修正できません\n承認者にデータの差し戻しを依頼してください'); 
		return false;

	}
	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('この登録情報の修正を行います。')){
		return true;

		}
	// 「OK」時の処理終了
	// 「キャンセル」時の処理開始
	else{

		window.alert('キャンセルされました'); // 警告ダイアログを表示
		return false;
	}

}

function checkQuote(){

	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('この登録情報を引用して新規を行います。')){
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
<h1 style="position: absolute; left: 10px; top: -15px;" >PC持出台帳：詳細表示</h1>
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
<font size="4" color="red"><b>${f:h(sya010msg)}</b></font>
<!-- ↓入力フォーム↓ -->
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
		<td class="none"></td>
		<td class="none"></td>
		<td class="none"></td>
	</tr>
	<tr>
		<td class="long" colspan="4" style="width: 100%; ">${f:h(dest)}</td>
	</tr>
	<tr>
		<th>プロジェクト名</th>
		<td class="none"></td>
		<td class="none"></td>
		<td class="none"></td>
	</tr>
	<tr>
		<td class="long" colspan="4" style="width: 100%;">${f:h(project)}</td>
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
<font size="4" color="red"><b>${f:h(sya011msg)}</b></font>
<table border="1">
	<c:forEach var="s" items="${documents}">
		<tr>
			<th>資料名称</th>
			<th>部数</th>
			<th>資料区分</th>
		</tr>
		<tr>
			<td class="long" width="450px">${f:h(s.docName)}</td>
			<td>${f:h(s.copies)}</td>
			<td>${f:h(documentCategoy[s.categoryId].categoryName)}</td>
		</tr>
	</c:forEach>
	<!-- ↑引用時のdocumentsリスト表示用フォーム↑ -->
</table>
<br />
<br />

<c:if test="${conditionCode==3}">
	<table border="1">
		<tr>
			<th class="cond">備考</th>
		</tr>
		<tr>
			<td style="width: 300; hight: 90;">${f:h(notes)}</td>
		</tr>
	</table>
</c:if>

<s:form>
	<input type="hidden" name="tableId" value="${f:h(tableId)}" />
	<input type="hidden" name="appDate" value="${f:h(appDate)}" />
	<input type="hidden" name="appUser" value="${f:h(appUser)}" />
	<input type="hidden" name="startDate" value="${f:h(startDate)}" />
	<input type="hidden" name="endDate" value="${f:h(endDate)}" />
	<input type="hidden" name="dest" value="${f:h(dest)}" />
	<input type="hidden" name="project" value="${f:h(project)}" />
	<input type="hidden" name="itLabel" value="${f:h(itLabel)}" />
	<input type="hidden" name="wirelessLan" value="${f:h(wirelessLan)}" />
	<input type="hidden" name="flashMemory" value="${f:h(flashMemory)}" />

	<input type="submit" name="quote" value="引用"  onClick="return checkQuote()"/>
	<input type="submit" name="update" value="修正"
		onClick="return checkUpdatePermission(${conditionCode})" />
</s:form>

</div>
</body>
</html>