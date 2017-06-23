<%@page pageEncoding="UTF-8"%>
<html>
<title>社外持出管理台帳</title>
<link rel="stylesheet" type="text/css" href="${f:url('/css/Input.css')}" />
<body>

<h1>PC持出台帳：申請</h1>
<html:errors />
<s:form>
	<input type="submit" name="index" value="申請画面トップへ" />
	<input type="submit" name="syaSearchApprove" value="検索画面へ" />
	<input type="submit" name="menu" value="メニューへ"
		style="position: relative; left: 150px;" />
	<input type="submit" name="logout" value="ログアウト"
		style="position: relative; left: 150px;" />
	<br />
	<br />
	<input type="submit" name="showPersonalRecords" value="あなたの更新履歴を表示" />
</s:form>
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
			<td><html:text property="appDate" value="${f:h(time)}" /></td>
			<td><html:text property="appUser" value="${f:h(userId)}" /></td>
			<td><html:text property="startDate" value="${f:h(time)}" /></td>
			<td><html:text property="endDate" value="${f:h(time)}" /></td>
		</tr>
		<tr>
			<th>持出先</th>
			<th>プロジェクト名</th>
			<td class="none"></td>
			<td class="none"></td>
		</tr>
		<tr>
			<td><html:text property="dest" value="${f:h(dest)}" /></td>
			<td><html:text property="project" value="${f:h(project)}" /></td>
			<td class="none"></td>
			<td class="none"></td>
		</tr>
	</table>

	<br />
	<font size="5">-持ち出し物-</font>
	<br />
	<font size="4"><b>機器</b></font>
	<table border="1">
		<tr>
			<th>PC（ITラベル）</th>
			<td><html:text property="itLabel" value="${f:h(itLabel)}" /></td>
			<td class="none"></td>
		</tr>
		<tr>
			<th>モバイルWi-Fi（ITラベル）</th>
			<td><html:text property="wirelessLan"
				value="${f:h(wirelessLan)}" /></td>
			<td class="none"></td>
		</tr>
		<tr>
			<th>シンクラ端末（ITラベル）</th>
			<td><html:text property="flashMemory"
				value="${f:h(flashMemory)}" /></td>
			<td class="none"></td>
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
			<td><html:text property="docName" /></td>
			<td><html:text property="copies" /></td>
			<td class="none"><select name="categoryId">
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
	<input type="submit" name="addDocuments" value="資料を追加" />
	<table border="1">
		<!-- ↓引用時のdocumentsリスト表示用フォーム↓ -->

		<c:forEach var="s" items="${documents}">
			<tr>
				<th>資料名称</th>
				<th>部数</th>
				<th>資料区分</th>
			</tr>
			<tr>
				<td>${s.docName}</td>
				<td>${s.copies}</td>
				<td>${documentCategoy[s.categoryId].categoryName}</td>
			</tr>
		</c:forEach>

		<!-- ↑引用時のdocumentsリスト表示用フォーム↑ -->

	</table>
	<input class="button" type="submit" name="submit" value="台帳に登録"
		style="position: relative; left: 500px;" />
</s:form>

<!-- ↑入力フォーム↑ -->
</body>
</html>