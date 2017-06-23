<%@page pageEncoding="UTF-8"%>
<html>
<title>社外持出管理台帳</title>
<link rel="stylesheet" type="text/css" href="${f:url('/css/Input.css')}" />
<body>

<script type="text/javascript">
<!--
function checkInsert(){
	
	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('台帳の申請を行います。')){
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
	if(window.confirm('資料の追加を行います。')){
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


function checkWirelessLan(obj){
	appUser = obj.form.appUser.value;
	wirelessLan = obj.form.wirelessLan.value;

	window.alert(appUser + ":" + wirelessLan);

}

// -->

</script>


<div id="headerArea">
<h1 style="position: absolute; left: 10px; top: -15px;" >PC持出台帳：申請</h1>
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
	<input type="submit" name="showPersonalRecords" value="あなたの登録履歴を表示" style="width: 200px;">
</s:form>
<br />
<font size="4" color="red"><b>${f:h(sya010msg)}</b></font>

<!-- ↓入力フォーム↓ -->

<s:form>
	<table border="1">
		<tr>
			<th>申請日</th>
			<th>申請者</th>
			<th>持出開始日</th>
			<th>持出終了日</th>
		</tr>
		<tr>
			<td><html:text styleClass="hankaku"  maxlength="8" property="appDate" value="${f:h(time)}" /></td>
			<td><html:text styleClass="hankaku"  maxlength="9" property="appUser" value="${f:h(userId)}" /></td>
			<td><html:text styleClass="hankaku"  maxlength="8" style="width: 100%;" property="startDate" value="${f:h(time)}" /></td>
			<td><html:text styleClass="hankaku"  maxlength="8" style="width: 100%;" property="endDate" value="${f:h(time)}" /></td>
		</tr>
		<tr>
			<th>持出先</th>
			<td class="none"></td>
			<td class="none"></td>
			<td class="none"></td>
		</tr>
		<tr>
			<td colspan="4"><html:text property="dest" value="${f:h(dest)}" styleClass="zenkaku" /></td>
		</tr>
		<tr>
			<th>プロジェクト名</th>
			<td class="none"></td>
			<td class="none"></td>
			<td class="none"></td>
		</tr>
		<tr>
			<td colspan="5"><html:text styleClass="zenkaku" property="project" value="${f:h(project)}" /></td>
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
			<td class="noneBox"><select name="wirelessSlave" style="width: 100%;">
				<c:if test="${(wirelessSlave)!=null}" var="flg">
				<option value=""></option>
				</c:if>
				<option value="${f:h(wirelessSlave)}" selected>${f:h(wirelessSlave)}</option>
				<c:forEach var="a" items="${wirelessSlaveNumbers}">
					<c:if test="${wirelessSlave != a}">
					<option value="${a}">${a}</option>
					</c:if>
				</c:forEach>
			</select></td>
		</tr>
		<tr>
			<th>PC（ITラベル）</th>
			<td><html:text styleClass="hankaku"  maxlength="8" property="itLabel" value="${f:h(itLabel)}" /></td>
		</tr>
		<tr>
			<th>モバイルWi-Fi（ITラベル）</th>
			<td class="noneBox"><select name="wirelessLan" style="width: 100%;" onChange="checkWirelessLan(this)">
				<c:if test="${(wirelessLan)!=null}" var="flg">
				<option value=""></option>
				</c:if>
				<option value="${f:h(wirelessLan)}" selected>${f:h(wirelessLan)}</option>
				<c:forEach var="a" items="${wirelessLanLabels}">
					<c:if test="${wirelessLan != a}">
					<option value="${a}">${a}</option>
					</c:if>
				</c:forEach>
			</select></td>
		</tr>
		<tr>
			<th>その他の持出物</th>
			<td><html:text style="width: 100%;" property="otherMedia"
				value="${f:h(otherMedia)}" /></td>
		</tr>
	</table>
	<font size="4"><b>紙媒体資料</b></font>
	<br />
	<font size="4" color="red"><b>${f:h(sya011msg)}</b></font>
	<table border="1">
		<tr>
			<th>資料名称</th>
			<th>部数</th>
			<th>資料区分</th>
		</tr>
		<tr>
			<td><html:text styleClass="zenkaku" property="docName" /></td>
			<td><html:text styleClass="hankaku" property="copies" /></td>
			<td class="noneBox"><select name="categoryId" style="width: 100%;" >
				<option value="" selected>選択して下さい</option>
				<c:forEach var="a" items="${documentCategoy}">
					<option value="${a.categoryId}">${a.categoryName}</option>
				</c:forEach>
			</select></td>
		</tr>
	</table>

	<!-- ↓tableIdを送信することで同一のtableIdで情報を関連付ける↓ -->
	<!-- inputやtextを入力なしで投げた場合、受け取ったプロパティにはNULLではなく空白が入る -->
	<!-- プロパティをすべてStringで宣言しているのが原因かも -->
	<!-- 主にLogicやDaoでの判定で空白文字を使っているのはそのため -->
	<input type="hidden" name="tableId" value="${f:h(tableId)}">
	<input type="submit" name="addDocuments" value="資料を追加" onClick="return checkAddDocuments()" />
	
<c:if test="${not empty documents}">	
	<table border="1">
		<!-- ↓引用時のdocumentsリスト表示用フォーム↓ -->
			<tr>
				<th>資料名称</th>
				<th>部数</th>
				<th>資料区分</th>
			</tr>
		<c:forEach var="s" items="${documents}">
			<tr>
				<td width="450px">${f:h(s.docName)}</td>
				<td>${s.copies}</td>
				<td>${documentCategoy[s.categoryId].categoryName}</td>
			</tr>
		</c:forEach>

		<!-- ↑引用時のdocumentsリスト表示用フォーム↑ -->

	</table>
</c:if>

	<table border="1">
		<tr>
			<td class="space"></td>
			<td class="space"></td>
			<td class="space"></td>
			<td class="space"></td>
			<td class="button">
			<input class="button" type="submit" name="submit" value="台帳に登録" onClick="return checkInsert()" />
			</td>
		</tr>
	</table>
</s:form>

<!-- ↑入力フォーム↑ -->
</div>
</body>
</html>