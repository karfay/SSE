<%@page pageEncoding="UTF-8"%>
<html>
<title>モバイルWi-Fiの管理ページ　-更新-</title>
<link rel="stylesheet" type="text/css" href="${f:url('/css/Kan.css')}" />
<body>

<script type="text/javascript">
<!--
function checkInsert(){
	
	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('更新をします。')){
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
<h1 style="position: absolute; left: 10px; top: -12.5px;" >モバイルWi-Fiの管理　-更新-</h1>
<s:form>
	<input type="submit" name="menu" value="メニューへ"
		style="position: absolute; right: 10px; top: 12.5px;" />
	<input type="submit" name="logout" value="ログアウト"
		style="position: absolute; right: 165px; top: 12.5px;" />
</s:form>
</div>
<div id="contentsArea">
<br />
<font color="blue"><b>更新前のテーブル</b></font>
	<table border="1">
		<tr>
			<th >電話番号</th>
			<th >機種</th>
			<th >プラン</th>
			<th >機種PIN</th>
			<th >製造番号</th>
			<th >ITラベル</th>
			<td class="none"></td>
		</tr>
		<tr>
			<td><input type="text" style="width:100%;" disabled="disabled" name="old.phoneNumber" value="${(old.phoneNumber)}" /></td>		
			<td><input type="text" style="width:100%;" disabled="disabled" name="old.model" value="${(old.model)}" /></td>
			<td><input type="text" style="width:100%;" disabled="disabled" name="old.plan" value="${(old.plan)}" /></td>
			<td><input type="text" style="width:100%;" disabled="disabled" name="old.pinCode" value="${(old.pinCode)}" /></td>
			<td><input type="text" style="width:100%;" disabled="disabled" name="old.serialNumber" value="${(old.serialNumber)}" /></td>		
			<td><input type="text" style="width:100%;" disabled="disabled" name="old.itLabel" value="${(old.itLabel)}" /></td>
			<td class="none" style="border-bottom: 1px solid black"></td>
		</tr>
		<tr>
			<th >管理者名</th>
			<th >使用者名</th>
			<th colspan="2" align="center" style="width:300px;">部署名</th>
			<th colspan="2" align="center" style="width:300px;">ICCID</th>
			<th >PIN解除コード</th>
		</tr>
		<tr>
			<td><input type="text" style="width:100%;" disabled="disabled" name="old.admin" value="${(old.admin)}" /></td>
			<td><input type="text" style="width:100%;" disabled="disabled" name="old.user" value="${(old.user)}" /></td>
			<td colspan="2"><input type="text" style="width:100%;" disabled="disabled" name="old.post" value="${(old.post)}" /></td>
			<td colspan="2"><input type="text" style="width:100%;" disabled="disabled" name="old.iccid" value="${(old.iccid)}" /></td>
			<td><input type="text" disabled="disabled" style="width:100%;" name="old.pinReleaseCode" value="${(old.pinReleaseCode)}" /></td>
		</tr>
		</table>

<br />
<s:form>
<font color="red"><b>更新後のテーブル</b></font>
	<table border="1">
		<tr>
			<th class="update">電話番号</th>
			<th class="update">機種</th>
			<th class="update">プラン</th>
			<th class="update">機種PIN</th>
			<th class="update">製造番号</th>
			<th class="update">ITラベル</th>
			<td class="none"></td>
		</tr>
		<tr>
			<td><html:text styleClass="hankaku"  property="phoneNumber" value="${f:h(phoneNumber)}" maxlength="13" /></td>
			<td><html:text styleClass="hankaku" property="model" value="${f:h(model)}" maxlength="10" /></td>
			<td><html:text style="width:100%;"  property="plan" value="${f:h(plan)}" maxlength="10" /></td>
			<td><html:text styleClass="hankaku"  property="pinCode" value="${f:h(pinCode)}" maxlength="10" /></td>
			<td><html:text styleClass="hankaku"  property="serialNumber" value="${f:h(serialNumber)}" maxlength="20" /></td>
			<td><html:text styleClass="hankaku"  property="itLabel" value="${f:h(itLabel)}" maxlength="8" /></td>
			<td class="none" style="border-bottom: 1px solid black"></td>
		</tr>
		<tr>
			<th class="update">管理者名</th>
			<th class="update">使用者名</th>
			<th class="update" colspan="2" align="center" >部署名</th>
			<th class="update" colspan="2" align="center" >ICCID</th>
			<th class="update">PIN解除コード</th>
		</tr>
		<tr>
			<td><html:text styleClass="hankaku"  property="admin" value="${f:h(admin)}" maxlength="9"/></td>
			<td><html:text styleClass="hankaku"  property="user" value="${f:h(user)}" maxlength="9"/></td>
			<td colspan="2"><html:text property="post" value="${f:h(post)}" maxlength="20" styleClass="zenkaku" /></td>
			<td colspan="2"><html:text property="iccid" value="${f:h(iccid)}" maxlength="19" styleClass="hankaku" /></td>
			<td><html:text styleClass="hankaku"  property="pinReleaseCode" value="${f:h(pinReleaseCode)}" maxlength="8" /></td>
		</tr>

	</table>
		<input class="button" type="submit" name="update" value="この情報で更新" onClick="return checkInsert()" />
		
		<%-- oldの要素へ値を引き継ぐ --%>
			<input type="hidden" name="old.phoneNumber" value="${(old.phoneNumber)}" />		
			<input type="hidden" name="old.model" value="${(old.model)}" />
			<input type="hidden" name="old.plan" value="${(old.plan)}" />
			<input type="hidden" name="old.pinCode" value="${(old.pinCode)}" />
			<input type="hidden" name="old.serialNumber" value="${(old.serialNumber)}" />		
			<input type="hidden" name="old.itLabel" value="${(old.itLabel)}" />		
			<input type="hidden" name="old.admin" value="${(old.admin)}" />
			<input type="hidden" name="old.user" value="${(old.user)}" />
			<input type="hidden" name="old.post" value="${(old.post)}" />
			<input type="hidden" name="old.iccid" value="${(old.iccid)}" />
			<input type="hidden" name="old.pinReleaseCode" value="${(old.pinReleaseCode)}" />
			
		</s:form>
</div>
</body>
</html>