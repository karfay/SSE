<%@page pageEncoding="UTF-8"%>
<html>
<title>社外持出管理台帳</title>
<link rel="stylesheet" type="text/css" href="${f:url('/css/Sya.css')}" />
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
	if(window.confirm('この登録情報を引用して新規登録を行います。')){
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
<h1 style="position: absolute; left: 10px; top: -15px;" >社外持出台帳：登録履歴</h1>
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
<s:form>
	<font size="4" color="red"><b>${f:h(sya010msg)}</b></font>
	<br />
	<font size="4" face="ＭＳ ゴシック">
	データ件数${f:h(pageCount)}件&nbsp;全${f:h(totalPage)}ページ中<br />
	<select name="pageNumber" class="page">
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
	</select> ページ目を </font>

	<input type="submit" name="showPersonalRecords" value="表示する"
		style="position: relative; left: 0px;" />
</s:form>

<!-- ↓履歴を表示するときの処理↓ -->

<table>
	<tr>
		<th class="cond" style="width: 50px;">状態</th>
		<th class="small">申請日</th>
		<th class="small">申請者</th>
		<th class="small" style="font-size: 10px;">持出開始日</th>
		<th class="small" style="font-size: 10px;">持出終了日</th>
		<th>持出先</th>
		<th colspan="5" style="width: 250px;">持出物</th>
		<th class="small">承認日</th>
		<th class="small">承認者</th>
		<td class="none" style="width: 25px;"></td>
		<td class="none" style="width: 25px;"></td>
		<td class="none" style="width: 50px;"></td>
	</tr>
	<c:forEach var="a" items="${historyDto}">
		<s:form>
			<tr>
				<!--conditionMasterの内容は以下の通り
				         要素:   0      1       2      3	
				conditionCode:  -1      1       2      3
				conditionName:"削除","未承認","承認","修正"
				つまり(conditionCode+1)してやれば要素と同じ値が取れる
			 -->
				<td>${conditionMaster[(a.conditionCode+1)].conditionName}</td>
				<td>${f:h(a.appDate)}</td>
				<td>${f:h(a.personnelName)}</td>
				<td>${f:h(a.startDate)}</td>
				<td>${f:h(a.endDate)}</td>
				<td class="long">${f:h(a.dest)}</td>
				
				<c:if test="${not empty a.wirelessSlave}">
					<td class="thincl">ｼﾝｸﾗ</td>
				</c:if>
				<c:if test="${empty a.wirelessSlave}">
					<td>ｼﾝｸﾗ</td>
				</c:if>
				<c:if test="${not empty a.itLabel}">
					<td class="pc">PC</td>
				</c:if>
				<c:if test="${empty a.itLabel}">
					<td>PC</td>
				</c:if>
				<c:if test="${not empty a.wirelessLan}">
					<td class="wifi">Wi-Fi</td>
				</c:if>
				<c:if test="${empty a.wirelessLan}">
					<td>Wi-Fi</td>
				</c:if>
				<c:if test="${not empty a.otherMedia}">
					<td class="other">その他</td>
				</c:if>
				<c:if test="${empty a.otherMedia}">
					<td>その他</td>
				</c:if>
				<c:if test="${not empty a.docId}">
					<td class="doc">資料</td>
				</c:if>
				<c:if test="${empty a.docId}">
					<td>資料</td>
				</c:if>
				<td>${f:h(a.approvalDate)}</td>
				<td>${f:h(a.approver)}</td>


				<!-- ↓選択したテーブルの情報を遷移先に送るための記述↓ -->
				<input type="hidden" name="tableId" value="${f:h(a.tableId)}" />
				<!-- ↑選択したテーブルの情報を遷移先に送るための記述↑ -->

				<td><input type="submit" name="update" value="修正" 
					onClick="return checkUpdatePermission(${a.conditionCode})" class="button" /></td>
				<td><input type="submit" name="quote" value="引用" onClick="return checkQuote()" class="button" /></td>
				<td><input type="submit" name="details" value="持出詳細" class="button" /></td>
			</tr>
		</s:form>
	</c:forEach>
</table>


<!-- ↑履歴を表示するときの処理↑ -->
</div>
</body>
</html>