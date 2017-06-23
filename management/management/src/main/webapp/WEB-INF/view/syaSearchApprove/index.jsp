<%@page pageEncoding="UTF-8"%>
<html>
<title>社外持出管理台帳</title>

<script type="text/javascript">
<!--
function checkApprove(obj){

	approver = obj.form.approver.value;

	// 承認者とログインユーザが違うと承認入力を受け付けない
	if('${userId}'!=approver){
		// 承認者とログインユーザが違うと承認入力を受け付けない
		window.alert('選択した承認者とログインユーザが違います。\n選択したユーザIDでログインし直してください。' + approver);
		return false;
	}

	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('承認してもよろしいでしょうか？' + approver)){
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

<link rel="stylesheet" type="text/css" href="${f:url('/css/Sya.css')}" />


<body>
<div id="headerArea">
<h1 style="position: absolute; left: 10px; top: -15px;" >社外持出台帳：検索と承認</h1>
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
	<font size="4" color="blue"><b>１ボタン検索</b></font>
	<br />
	<input type="submit" name="showAll" value="全件表示" />
	<input type="submit" name="showUnapprovedRecords" value="未承認一覧" />
	<input type="submit" name="showPersonalRecords" value="あなたの登録履歴を表示" style="width: 200px;">
</s:form><font size="4" color="blue"><b>条件検索</b></font>
<s:form>
対象データを選択<br />
<label for="ckDelete">
	<input type="checkbox" name="includeDeleted" value="1"
		<c:if test="${includeDeleted==1}">checked</c:if> class="checkbox" id="ckDelete"/><b>削除</b>
</label>
<label for="ckUnapproved">
	<input type="checkbox" name="includeUnapproved" value="1"
		<c:if test="${includeUnapproved==1}">checked</c:if> class="checkbox" id="ckUnapproved" /><b>未承認</b>
</label>
<label for="ckApproved">
	<input type="checkbox" name="includeApproved" value="1"
		<c:if test="${includeApproved==1}">checked</c:if> class="checkbox" id="ckApproved" /><b>承認済み</b>
</label>
<label for="ckCorrected">
	<input type="checkbox" name="includeCorrected" value="1"
		<c:if test="${includeCorrected==1}">checked</c:if> class="checkbox" id="ckCorrected" /><b>修正</b>
</label>
<label for="ckRemanded">
	<input type="checkbox" name="includeRemanded" value="1"
		<c:if test="${includeRemanded==1}">checked</c:if> class="checkbox" id="ckRemanded" /><b>差し戻し</b>
</label>
<br /><br />
	<table>
		<tr style="border-top: 1px solid #EEEEEE;">
			<th>申請日</th>
			<td class="space"><input class="hankaku" maxlength="8" type="text" name="searchDateAfter" value="${f:h(searchDateAfter)}" /></td>
			<td class="noneLeft" style="border-right: 1px solid black">以降</td>
			<td><input  class="hankaku" maxlength="8" type="text" name="searchDateBefore" value="${f:h(searchDateBefore)}" /></td>
			<td class="noneLeft">以前</td>
		</tr>
		<tr>
			<th>申請者</th>
			<td class="space"><input class="zenkaku" type="text" name="searchName" value="${f:h(searchName)}" /></td>
			<td class="noneLeft">を含む</td>
			<td class="none"></td>
			<td class="none"></td>
		</tr>
		<tr>
			<th>持出先</th>
			<td class="space"><input class="zenkaku" type="text" name="searchDest" value="${f:h(searchDest)}" /></td>
			<td class="noneLeft">を含む</td>
			<td class="none"></td>
			<td class="none"></td>
		</tr>
		<tr style="border-bottom: 1px solid #EEEEEE;">
			<th>過去履歴</th>
			<td class="space"><input class="hankaku" maxlength="8"  type="text" name="searchPastRecords" value="${f:h(searchPastRecords)}" /></td>
			<td colspan="3" class="noneLeft">時点の持出状況を表示</td>
		</tr>
	</table>

	<font size="4" face="ＭＳ ゴシック">
	データ件数${f:h(pageCount)}件&nbsp;全${f:h(totalPage)}ページ中<br />
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

	<input type="submit" name="search" value="この条件で検索"
		style="position:relative; left:220px" />
</s:form>
<br />
<font size="4" color="red"><b>${f:h(sya020msg)}</b></font>

<!-- ↓履歴を表示するときの処理↓ -->
<ul><html:errors /></ul>
<table>
	<tr>
		<th class="cond">状態</th>
		<th class="small">申請日</th>
		<th class="small">申請者</th>
		<th class="small" style="font-size: 10px;">持出開始日</th>
		<th class="small" style="font-size: 10px;">持出終了日</th>
		<th style="width: 100px;">持出先</th>
		<th colspan="5" style="width: 250px;">持出物</th>
		<th class="small">承認日</th>
		<th style="width: 100px;">承認者</th>
		<td class="none" style="border-bottom: 1px solid black"></td>
		<td class="none" style="border-bottom: 1px solid black"></td>
	</tr>
	<c:forEach var="a" items="${historyDto}">
		<tr>
			<!--conditionMasterの内容は以下の通り
				         要素:   0      1       2      3	
				conditionCode:  -1      1       2      3
				conditionName:"削除","未承認","承認","修正"
				つまり(conditionCode+1)してやれば要素と同じ値が取れる
			 -->
			<td class="cond">${conditionMaster[(a.conditionCode+1)].conditionName}</td>
			<td>${f:h(a.appDate)}</td>
			<td>${f:h(a.personnelName)}</td>
			<td>${f:h(a.startDate)}</td>
			<td>${f:h(a.endDate)}</td>
			<td class="long"">${f:h(a.dest)}</td>
			<c:if test="${not empty a.wirelessSlave}">
				<td class="thincl">ｼﾝｸﾗ</td>
			</c:if>
			<c:if test="${empty a.wirelessSlave}">
				<td style="width:50">ｼﾝｸﾗ</td>
			</c:if>
			<c:if test="${not empty a.itLabel}">
				<td class="PC">PC</td>
			</c:if>
			<c:if test="${empty a.itLabel}">
				<td style="width:50">PC</td>
			</c:if>
			<c:if test="${not empty a.wirelessLan}">
				<td class="wifi">Wi-Fi</td>
			</c:if>
			<c:if test="${empty a.wirelessLan}">
				<td style="width:50">Wi-Fi</td>
			</c:if>
			<c:if test="${not empty a.otherMedia}">
				<td class="other">その他</td>
			</c:if>
			<c:if test="${empty a.otherMedia}">
				<td style="width:50">その他</td>
			</c:if>
			<c:if test="${not empty a.docId}">
				<td class="doc">資料</td>
			</c:if>
			<c:if test="${empty a.docId}">
				<td style="width:50">資料</td>
			</c:if>
			<s:form>
				<td style="width:75px;"><input type="text" name="approvalDate" value="${f:h(time)}" class="hankaku" maxlength="8" style="height: 100%" ></td>
				<td><select name="approver" style="height:100%;">
					<c:forEach var="t" items="${approvers}">

						<!-- ↓セレクトボックスの初期値を調整する処理↓ -->
						<c:if test="${(userId == t.personnelNumber) && (a.appUser != t.personnelNumber)}">
							<option value="${t.personnelNumber}" selected>${t.PersonnelName}</option>
						</c:if>

						<c:if test="${userId != t.personnelNumber}">
							<option value="${t.personnelNumber}">${t.PersonnelName}</option>
						</c:if>
						<!-- ↑セレクトボックスの初期値を調整する処理↑ -->

					</c:forEach>
				</select></td>
				<td><input type="submit" class="smallButton" name="approve" value="承認"
					onClick="return checkApprove(this)" style="width: 100%; height: 100%;" /></td>
				<td class="space" style="width: 100;"><input type="submit" name="details"
					value="詳細表示" style="width: 100%; height: 100%;" /></td>
				<input type="hidden" name="tableId" value="${f:h(a.tableId)}" />
			</s:form>
		</tr>
	</c:forEach>
</table>

<!-- ↑履歴を表示するときの処理↑ -->


<!-- ページング処理 

	linkによるFormへの値受け渡しを行うと日本語が文字化けするバグが解決できないため使用凍結中

<font size="4" face="ＭＳ ゴシック">
データ件数${f:h(pageCount)}件&nbsp;全${f:h(totalPage)}ページ<br />
<c:if test="${(pageNumber-1)>=1}">
<a><s:link href="${f:h(pagingUrl)}${(pageNumber-1)}">前</s:link></a>
</c:if>
&nbsp;&gt;&gt;&nbsp;
<c:forEach begin="1" end="${f:h(totalPage)}" step="1" varStatus="status">
	<c:if test="${status.index==pageNumber}">
	${f:h(pageNumber)}
	</c:if>
	<c:if test="${status.index!=pageNumber}">
	<a><s:link href="${f:h(pagingUrl)}${status.index}"><c:out value="${status.index}"/></s:link></a>
	</c:if>
</c:forEach>
&nbsp;&gt;&gt;&nbsp;
<c:if test="${(pageNumber+1)<=totalPage}">
<a><s:link href="${f:h(pagingUrl)}${(pageNumber+1)}">次</s:link></a>
</c:if>
</font>
<!-- ページング処理 -->
</div>
</body>
</html>