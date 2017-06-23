<%@page pageEncoding="UTF-8"%>
<html>
<title>モバイルWi-Fiの管理ページ</title>
<link rel="stylesheet" type="text/css" href="${f:url('/css/Kan.css')}" />
<body onLoad="err()" >

<script type="text/javascript">
<!--
function checkInsert(){
	
	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('新規登録をします。')){
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
	if(window.confirm('テーブルを削除します。')){
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

function err(){
	window.alert("入力エラーがあります。");
}

// -->
</script>


<div id="headerArea">
<h1 style="position: absolute; left: 10px; top: -12.5px;" >モバイルWi-Fiの管理</h1>
<s:form>
	<input type="submit" name="menu" value="メニューへ"
		style="position: absolute; right: 10px; top: 12.5px;" />
	<input type="submit" name="logout" value="ログアウト"
		style="position: absolute; right: 165px; top: 12.5px;" />
</s:form>
</div>
<div id="contentsArea">
<br />
<ul><html:errors /></ul>
<c:if test="${(authorizations == 1)}">
<s:form>
	<table border="1">
		<tr>
			<th>電話番号</th>
			<th>機種</th>
			<th>プラン</th>
			<th>機種PIN</th>
			<th>製造番号</th>
			<th>ITラベル</th>
			<td class="none"></td>
		</tr>
		<tr>
			<td><html:text style="ime-mode: disabled; width: 100%;" errorStyleClass="err" property="phoneNumber" value="${f:h(phoneNumber)}" maxlength="13" /></td>
			<td><html:text styleClass="hankaku" property="model" value="${f:h(model)}" maxlength="10" /></td>
			<td><html:text style="width:100%;" property="plan" value="${f:h(plan)}" maxlength="10" /></td>
			<td><html:text styleClass="hankaku" property="pinCode" value="${f:h(pinCode)}" maxlength="10" /></td>
			<td><html:text styleClass="hankaku" property="serialNumber" value="${f:h(serialNumber)}" maxlength="20" /></td>
			<td><html:text style="ime-mode: disabled; width: 100%;" errorStyleClass="err" property="itLabel" value="${f:h(itLabel)}" maxlength="8" /></td>
			<td class="none" style="border-bottom: 1px solid black;"></td>
		</tr>
		<tr>
			<th>管理者名</th>
			<th>使用者名</th>
			<th colspan="2" align="center" style="width:300;">部署名</th>
			<th colspan="2" align="center" style="width:300;">ICCID</th>
			<th>PIN解除コード</th>
		</tr>
		<tr>
			<td><html:text styleClass="hankaku" property="admin" value="${f:h(admin)}" maxlength="9"/></td>
			<td><html:text styleClass="hankaku" property="user" value="${f:h(user)}" maxlength="9"/></td>
			<td colspan="2"><html:text property="post" value="${f:h(post)}" maxlength="20" styleClass="zenkaku" /></td>
			<td colspan="2"><html:text property="iccid" value="${f:h(iccid)}" maxlength="19" styleClass="hankaku" /></td>
			<td><html:text styleClass="hankaku" property="pinReleaseCode" value="${f:h(pinReleaseCode)}" maxlength="8" /></td>
		</tr>

	</table>
	<input class="button" type="submit" name="insert" value="新規登録" onClick="return checkInsert()" />
</s:form>
</c:if>

<font color="blue" ><b>${(msg01)}</b></font>
	<table border="1">
		<tr>
			<th >電話番号</th>
			<th class="verrySmall">機種</th>
			<th class="verrySmall">ﾌﾟﾗﾝ</th>
			<th class="small">機種PIN</th>
			<th >製造番号</th>
			<th >ITラベル</th>
			<th >管理者名</th>
			<th >利用者名</th>
			<th  style="width:200;">部署名</th>
			<th >ICCID</th>
			<th >PIN解除コード</th>
			<td class="none" style="border-bottom: 1px solid block; width: 50px;"></td>
			<td class="none" style="border-bottom: 1px solid block; width: 50px;"></td>
		</tr>
		<c:forEach var="a" items="${wirelessLanMasterDto}" varStatus="st">
		<c:if test="${st.index%2==0}">
		<tr>
		</c:if>
		<c:if test="${st.index%2==1}">
		<tr bgcolor="aliceblue">
		</c:if>
			<td >${(a.phoneNumber)}</td>
			<td >${(a.model)}</td>
			<td >${(a.plan)}</td>
			<td >${(a.pinCode)}</td>
			<td >${(a.serialNumber)}</td>
			<td >${(a.itLabel)}</td>
			<td >${(a.adminName)}</td>
			<td >${(a.userName)}</td>
			<td >${(a.post)}</td>
			<td >${(a.iccid)}</td>
			<td >${(a.pinReleaseCode)}</td>
			
			<c:if test="${(authorizations == 1)}">
				<s:form>
				<td>
				<input class="smallButton" type="submit" name="jumpUpdate" value="更新" />
				</td>
				<td>
				<input class="smallButton" type="submit" name="delete" value="削除" onClick="return checkDelete()" />
				</td>
			<%-- 更新と削除に必要なテーブルの主キーをこのフォームで渡せるように記述 --%>
				<input type="hidden" name="phoneNumber" value="${(a.phoneNumber)}" />		
				<input type="hidden" name="model" value="${(a.model)}" />
				<input type="hidden" name="plan" value="${(a.plan)}" />
				<input type="hidden" name="pinCode" value="${(a.pinCode)}" />
				<input type="hidden" name="serialNumber" value="${(a.serialNumber)}" />		
				<input type="hidden" name="itLabel" value="${(a.itLabel)}" />		
				<input type="hidden" name="admin" value="${(a.admin)}" />
				<input type="hidden" name="user" value="${(a.user)}" />
				<input type="hidden" name="post" value="${(a.post)}" />
				<input type="hidden" name="iccid" value="${(a.iccid)}" />
				<input type="hidden" name="pinReleaseCode" value="${(a.pinReleaseCode)}" />
			</s:form>
			</c:if>
			
			<c:if test="${(authorizations != 1)}">
				<td class="none"></td>
				<td class="none"></td>
			</c:if>

		</tr>
		</c:forEach>
	</table>
</div>
</body>
</html>