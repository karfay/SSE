<%@page pageEncoding="UTF-8"%>
<html>
<title>社内持込管理システム</title>
<link rel="stylesheet" type="text/css" href="${f:url('/css/Mot.css')}" />
<body>

<script type="text/javascript">
<!--
function checkApprove(){
	
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
	
}
// -->
</script>

<div id="headerArea">
<c:if test="${authorizations==1}">
	<h1 style="position: absolute; left: 10px; top: -15px;">社内持込台帳：検索と承認</h1>
</c:if>
<c:if test="${authorizations!=1}">
	<h1 style="position: absolute; left: 10px; top: -15px;">社内持込台帳：検索</h1>
</c:if>
<form>
	<input type="submit" name="menu" value="メニューへ"
		style="position: absolute; right: 10px; top: 12.5px;" />
	<input type="submit" name="logout" value="ログアウト"
		style="position: absolute; right: 165px; top: 12.5px;" />
	<input type="submit" name="motDaityoInput" value="登録画面へ" 
		style="position: absolute; right: 320px; top: 12.5px;" />
	<input type="submit" name="motSearchUpdate" value="検索画面へ"
		style="position: absolute; right: 475px; top: 12.5px;" />
</form>
</div>
<div id="contentsArea">
<br />
<s:form>
	<font size="4" color="blue"><b>１ボタン検索</b></font>
	<br />
	<input type="submit" name="searchAll" value="全件表示" />
	<input type="submit" name="searchUnapprovedRecords" value="未承認一覧" />
	<input type="submit" name="searchExpired" value="期限切れデータを探す"
		class="long" />
	<br />
	<br />
	<font size="4" color="blue"><b>条件検索</b></font>
	<br />
	対象データを選択<br />
<label for="ckDelete">
	<input type="checkbox" name="includeDeleted" value="1"
		<c:if test="${includeDeleted==1}">checked</c:if> class="checkbox" id="ckDelete" /><b>削除</b>
</label>
<label for="ckBringUnapproved">
<input type="checkbox" name="includeBringUnapproved" value="1"
		<c:if test="${includeBringUnapproved==1}">checked</c:if>
		class="checkbox"  id="ckBringUnapproved" /><b>持込承認待ち</b>
</label>
<label for="ckBringApproved">
<input type="checkbox" name="includeBringApproved" value="1"
		<c:if test="${includeBringApproved==1}">checked</c:if>
		class="checkbox" id="ckBringApproved" /><b>持込承認済み</b>
</label>
<label for="ckBringUpdate">
<input type="checkbox" name="includeBringUpdate" value="1"
		<c:if test="${includeBringUpdate==1}">checked</c:if> class="checkbox" id="ckBringUpdate" /><b>持込修正</b>
</label>
<label for="ckBringRemand">
<input type="checkbox" name="includeBringRemand" value="1"
		<c:if test="${includeBringRemand == 1}">checked</c:if>
		class="checkbox" id="ckBringRemand" /><b>持込差し戻し</b>
</label>
<br />
<label for="ckProcessUnapproved">
	<input type="checkbox" name="includeProcessUnapproved" value="1"
		<c:if test="${includeProcessUnapproved==1}">checked</c:if>
		class="checkbox" id="ckProcessUnapproved" /><b>終了対応承認待ち</b>
</label>
<label for="ckProcessApproved">
<input type="checkbox" name="includeProcessApproved" value="1"
		<c:if test="${includeProcessApproved==1}">checked</c:if>
		class="checkbox" id="ckProcessApproved"/ ><b>終了対応承認済み</b>
</label>
<label for="ckProcessUpdate">
<input type="checkbox" name="includeProcessUpdate" value="1"
		<c:if test="${includeProcessUpdate==1}">checked</c:if>
		class="checkbox" id="ckProcessUpdate" /><b>終了対応修正</b>
</label>
<label for="ckProcessRemand">
<input type="checkbox" name="includeProcessRemand" value="1"
		<c:if test="${includeProcessRemand == 1}">checked</c:if>
		class="checkbox" id="ckProcessRemand" /><b>終了対応差し戻し</b>
</label>
<br />

<font size="4" face="ＭＳ ゴシック">
	データ件数${f:h(totalTable)}件&nbsp;全${f:h(totalPage)}ページ中<br />
	<select class="page" name="pageNumber">
		<c:forEach begin="1" end="${f:h(totalPage)}" step="1"
			varStatus="status">

			<!-- ↓セレクトボックスの初期値を調整する処理↓ -->
			<c:if test="${pageNumber == status.count}">
				<option value="${status.count}" selected>${status.count}</option>
			</c:if>

			<c:if test="${pageNumber != status.count}">
				<option value="${status.count}">${status.count}</option>
			</c:if>
			<!-- ↑セレクトボックスの初期値を調整する処理↑ -->

		</c:forEach>
	</select> ページ目を表示 </font>


<br />
	<input type="submit" name="search" value="この条件で検索"
		style="position: relative; left: 465px;" />
</s:form>
<br />
<font size="4" color="red"><b>${f:h(motMsg)}</b></font>

<!-- ↓履歴を表示するときの処理↓ -->

<table border="1">
	<tr>
		<th class="cond">状態</th>
		<th class="small">持込日</th>
		<th class="small">持込者</th>
		<th class="small"  style="font-size: 10px;">保管終了予定日</th>
		<th>預かり元</th>
		<th>プロジェクト名</th>
		<th class="ultraSmall">機密</th>
		<th class="small">確認日</th>
		<th class="small">確認者</th>
		<td class="none"></td>
	</tr>
	<c:forEach var="a" items="${historyDto}">
		<tr>
			<td >${f:h(a.conditionName)}</td>
			<td >${f:h(a.bringDate)}</td>
			<td >${f:h(a.bringPersonName)}</td>
			<td >${f:h(a.scheduledDate)}</td>
			<td class="long">${f:h(a.clientName)}</td>
			<td class="long">${f:h(a.project)}</td>
			<td ><c:if test="${a.confidential==1}">
				<font color="red">！</font>
			</c:if> <c:if test="${a.confidential==0}"></c:if></td>

			<c:if test="${a.conditionCode==11 || a.conditionCode==13}">
				<td >${f:h(a.bringApprovalDate)}</td>
				<td >${f:h(a.bringApproverName)}</td>
			</c:if>
			<c:if test="${a.conditionCode==21 || a.conditionCode==23}">
				<td >${f:h(a.processApprovalDate)}</td>
				<td >${f:h(a.processApproverName)}</td>
			</c:if>
			<c:if
				test="${a.conditionCode!=11 && a.conditionCode!=21 && a.conditionCode!=13 && a.conditionCode!=23}">
				<td ></td>
				<td ></td>
			</c:if>
			<s:form>
				<td class="space"><input type="submit" name="details"
					value="詳細表示" /></td>
				<input type="hidden" name="tableId" value="${f:h(a.tableId)}" />
			</s:form>
		</tr>
	</c:forEach>
</table>

<!-- ↑履歴を表示するときの処理↑ -->

<%--
<!-- ページング処理 -->
<font size="4" face="ＭＳ ゴシック">
データ件数${f:h(pageCount)}件&nbsp;全${f:h(totalPage)}ページ<br />
<c:if test="${(pageNumber-1)>=1}">
	<a><s:link href="${f:h(pagingUrl)}${(pageNumber-1)}">前</s:link></a>
</c:if> &nbsp;&gt;&gt;&nbsp; <c:forEach begin="1" end="${f:h(totalPage)}"
	step="1" varStatus="status">
	<c:if test="${status.index==pageNumber}">
	${f:h(pageNumber)}
	</c:if>
	<c:if test="${status.index!=pageNumber}">
		<a><s:link href="${f:h(pagingUrl)}${status.index}">
			<c:out value="${status.index}" />
		</s:link></a>
	</c:if>
</c:forEach> &nbsp;&gt;&gt;&nbsp; <c:if test="${(pageNumber+1)<=totalPage}">
	<a><s:link href="${f:h(pagingUrl)}${(pageNumber+1)}">次</s:link></a>
</c:if> </font>
<!-- ページング処理 -->
--%>
</div>
</body>
</html>