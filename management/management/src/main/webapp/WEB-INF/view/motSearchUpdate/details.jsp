<%@page pageEncoding="UTF-8"%>
<html>
<title>社内持込管理システム</title>
<link rel="stylesheet" type="text/css" href="${f:url('/css/Mot.css')}" />
<body>

<script type="text/javascript">
<!--
function checkUpdatePermission(conditionCode){
	
	if(conditionCode == 1){
		// 警告ダイアログを表示
		window.alert('承認済みのデータは修正できません\n承認者にデータの差し戻しを依頼してください'); 
		return false;

	}
	
}
// -->

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

<!--
function checkRemand(){
	
	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('差し戻ししてもよろしいでしょうか？')){
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

<!--
function checkProcess(){
	
	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('終了時対応を確定してもよろしいでしょうか？')){
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

<!--
function checkUpdate(){
	
	// 「OK」時の処理開始 ＋ 確認ダイアログの表示
	if(window.confirm('終了時対応を修正してもよろしいでしょうか？')){
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
	<h1 style="position: absolute; left: 10px; top: -15px;">社内持込台帳：詳細表示</h1>
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
<html:errors />
<font size="4" color="red"><b>${f:h(motMsg)}</b></font>

<!-- ↓出力フォーム↓ -->
<br />
<font size="5">-持込情報-</font>
<br />
<c:forEach var="h" items="${historyDto}">
	<table border="1">
		<tr>
			<th class="cond">${f:h(h.conditionName)}</th>
			<%-- 状態が持込承認待ち、持込修正、持込差し戻しの時のみ、修正ボタンが出現し修正可能 --%>
			<c:if test="${h.conditionCode==10 || h.conditionCode==13 || h.conditionCode==12}">
				<s:form>
					<td class="noneBottomBorder">
					<input type="submit" name="bringUpdate" value="持込情報を修正" class="button" />
					<input type="hidden" name="tableId" value="${f:h(h.tableId)}" /></td>
				</s:form>
			</c:if>
			<c:if test="${h.conditionCode!=10 && h.conditionCode!=13 && h.conditionCode!=12}">
				<td class="none" style="border-bottom: 1px solid black"></td>
			</c:if>
			<td class="noneBottomBorder"></td>
			<td class="noneBottomBorder"></td>
		</tr>
		<tr>
			<th>持込者</th>
			<th>持込開始日</th>
			<th>保管終了予定日</th>
			<th>終了時予定対応</th>
		</tr>
		<tr>
			<td>${f:h(h.bringPersonName)}</td>
			<td>${f:h(h.bringDate)}</td>
			<td>${f:h(h.scheduledDate)}</td>
			<td>${f:h(h.scheduledName)}</td>
		</tr>
		<%-- 終了対応が何かしら入力されていたら終了対応を表示 --%>
		<c:if test="${h.processCode!=0}">
			<tr>
				<th class="process">終了時対応者</th>
				<th class="process">持込終了日</th>
				<th class="process">終了時対応</th>
				<td class="none"></td>
			</tr>
			<tr>
				<td>${f:h(h.processPersonName)}</td>
				<td>${f:h(h.processDate)}</td>
				<td>${f:h(h.processName)}</td>
				<td class="none"></td>
			</tr>
		</c:if>
		<tr>
			<th>預かり元</th>
			<td class="noneBottomBorder"></td>
			<td class="noneBottomBorder"></td>
			<td class="noneBottomBorder"></td>
		</tr>
		<tr>
			<td class="long" colspan="4">${f:h(h.clientName)}</td>
		</tr>
		<tr>
			<th>プロジェクト名</th>
			<td class="noneBottomBorder"></td>
			<td class="noneBottomBorder"></td>
			<td class="noneBottomBorder"></td>
		</tr>
		<tr>
			<td class="long" colspan="4">${f:h(h.project)}</td>
		</tr>
	</table>
	<br />
	<table border="1">
		<tr>
			<th>持込物名称</th>
			<td class="noneBottomBorder"></td>
			<td class="noneBottomBorder"></td>
		</tr>
		<tr>
			<td class="long" colspan="3">${f:h(h.materialName)}</td>
		</tr>
		<tr>
			<th>部数</th>
			<th>持込物区分</th>
			<th>機密</th>
		</tr>
		<tr>
			<td>${f:h(h.copies)}</td>
			<td>${f:h(h.categoryName)}</td>
			<c:if test="${h.confidential==1}">
				<td class="red">重要扱い</td>
			</c:if>
			<c:if test="${h.confidential==0}">
				<td>重要扱いでない</td>
			</c:if>
		</tr>
		<tr>
			<th>格納場所</th>
			<td class="noneBottomBorder"></td>
			<td class="noneBottomBorder"></td>
		</tr>
		<tr>
			<td class="notes"  colspan="3"><pre>${f:h(h.depository)}</pre></td>
		</tr>
		<tr>
			<th>持込時備考</th>
			<td class="noneBottomBorder"></td>
			<td class="noneBottomBorder"></td>
		</tr>
		<tr>
			<td colspan="3" class="notes"><pre>${f:h(h.bringNotes)}</pre></td>
		</tr>
	</table>
	<br />
	<!-- ↓持ち込み承認出力フォーム↓ -->
	<%-- 状態が持込承認待ちでない --%>
	<c:if test="${h.conditionCode != 10}">
		<font size="5">-持込承認情報-</font>
		<table border="1">
			<tr>
				<th class="cond">${f:h(h.conditionName)}</th>
				<td class="noneBottomBorder"></td>
				<td class="none"></td>
			</tr>
			<tr>
				<th class="approve">確認者</th>
				<th class="approve">対応日</th>
				<td class="none" style="width: 173px;"></td>
			</tr>
			<%-- 持込承認情報があれば、その情報を出力
			状態が持込承認待ちでない && 承認者の情報がある
			 --%>
			<c:if test="${h.bringApprover!=null}">
				<tr>
					<td>${h.bringApproverName}</td>
					<td>${h.bringApprovalDate}</td>
					<td class="none"></td>
				</tr>
				<tr>
					<th class="approve">持込確認時備考</th>
					<td class="noneBottomBorder"></td>
					<td class="noneBottomBorder"></td>
				</tr>
				<tr>
					<td colspan="3" class="notes"><pre>${(h.bringApproveNotes)}</pre></td>
				</tr>
			</c:if>
			<%-- 持込承認の前に終了対応が行われた場合、その旨を明記して情報を出力
			状態が持込承認待ちでない && 承認者の情報がある
			--%>
			<c:if test="${h.bringApprover==null}">
				<tr>
					<td>なし</td>
					<td>なし</td>
					<td class="none"></td>
				</tr>
				<tr>
					<th class="approve">持込確認時備考</th>
					<td class="noneBottomBorder"></td>
					<td class="noneBottomBorder"></td>
				</tr>
				<tr>
					<td colspan="3" class="notes"><pre>持込承認を行う前に終了対応が登録されました。</pre></td>
				</tr>
			</c:if>
		</table>

		<!-- ↓終了時対応出力フォーム↓ -->
		<%-- 状態が持ち込み承認待ちでない && 終了対応が未処理でない --%>
		<c:if test="${h.processCode!=0}">
			<br />
			<font size="5">-持込終了対応情報-</font>
			<table border="1">
				<tr>
					<th class="process">終了時対応者</th>
					<th class="process">持込終了日</th>
					<th class="process">終了時対応</th>
				</tr>
				<tr>
					<td>${f:h(h.processPersonName)}</td>
					<td>${f:h(h.processDate)}</td>
					<td>${f:h(h.processName)}</td>
				</tr>
				<tr>
					<th class="process">終了対応時備考</th>
					<td class="noneBottomBorder"></td>
					<td class="noneBottomBorder"></td>
				</tr>
				<tr>
					<td colspan="3" class="notes"><pre>${f:h(h.processNotes)}</pre></td>
				</tr>
			</table>

			<!-- ↓終了時対応承認情報出力フォーム↓ -->
			<%-- 状態が持込承認待ちでない && 終了対応が未処理でない && 終了対応承認待ちでない --%>
			<c:if test="${h.conditionCode != 20}">
				<br />
				<font size="5">-持込終了対応承認情報-</font>
				<table border="1">
					<tr>
						<th class="process">終了対応確認者</th>
						<th class="process">終了対応確認日</th>
						<td class="none" style="width: 173px;"></td>
					</tr>
					<tr>
						<td class="details">${f:h(h.processApproverName)}</td>
						<td class="details">${f:h(h.processDate)}</td>
						<td class="none"></td>
					</tr>
					<tr>
						<th class="process">終了対応時備考</th>
						<td class="noneBottomBorder"></td>
						<td class="noneBottomBorder">
					</tr>
					<tr>
						<td colspan="3" class="notes"><pre>${f:h(h.processApproveNotes) }</pre></td>
					</tr>
				</table>
			</c:if>
		</c:if>

	</c:if>


	<!-- ↓入力フォーム↓ -->

	<!-- ↓削除済みのデータは入力フォームによる修正ができない↓ -->
	<c:if test="${h.conditionCode != -1}">

		<br />
		<!-- ↓対応内容入力フォーム↓ -->
		<c:if test="${h.processCode == 0}">
			<s:form>
				<font size="5" color="red">-持込終了対応（返却・廃棄）入力-</font>
				<table border="1">
					<tr>
						<th class="process">終了対応者</th>
						<th class="process">終了対応日</th>
						<th class="process">実施対応</th>
					</tr>
					<tr>
						<td><html:text styleClass="hankaku" maxlength="9"  property="processPerson" value="${f:h(userId)}" /></td>
						<td><html:text styleClass="hankaku" maxlength="8" property="processDate" value="${f:h(time)}" /></td>
						<td>
						<select name="processCode" style="width: 100%; ime-mode: active;">
							<option value="" selected>選択して下さい</option>
							<c:forEach var="p" items="${processMaster}" begin="1">
								<option value="${p.processCode}">${p.processName}</option>
							</c:forEach>
						</select></td>
					</tr>
					<tr>
						<th class="process">終了対応時備考</th>
						<td class="noneBottomBorder"></td>
						<td class="noneBottomBorder"></td>
					</tr>
					<tr>
					<td class="notes" colspan="3"><textarea name="processNotes" style="ime-mode: active" />${f:h(h.processNotes)}</textarea></td>>
					</tr>
				</table>
				<input type="submit" name="process" value="終了対応入力" onClick="return checkProcess()" />
				<input type="hidden" name="conditionCode" value="${f:h(h.conditionCode)}" />
				<input type="hidden" name="tableId" value="${f:h(h.tableId)}" />
			</s:form>
		</c:if>

		<!-- ↓対応内容修正フォーム↓ -->
		<!-- 終了時対応の入力が行われていて、対応の承認（最終承認）が行われていないとき -->
		<c:if test="${h.conditionCode != 21 && h.processCode != 0}">
			<s:form>
				<font size="5" color="red">-持込終了対応（返却・廃棄）内容修正-</font>
				<table border="1">
					<tr>
						<th class="process">終了対応者</th>
						<th class="process">終了対応日</th>
						<th class="process">実施対応</th>
					</tr>
					<tr>
						<td><html:text styleClass="hankaku" maxlength="9" property="processPerson" value="${f:h(userId)}" /></td>
						<td><html:text styleClass="hankaku" maxlength="8" property="processDate" value="${f:h(time)}" /></td>
						<td class="noneBox"><select name="processCode"
							style="width: 100%;" >
							<option value="" selected>選択して下さい</option>
							<c:forEach var="p" items="${processMaster}" begin="1">
								<option value="${p.processCode}">${p.processName}</option>
							</c:forEach>
						</select></td>
					</tr>
					<tr>
						<th class="process">終了対応時備考</th>
						<td class="noneBottomBorder"></td>
						<td class="noneBottomBorder"></td>
					</tr>
					<tr>
						<td class="notes" colspan="3"><textarea name="processNotes" style="ime-mode: active;" />${f:h(h.processNotes)}</textarea></td>
					</tr>
				</table>
				<input type="submit" name="process" value="終了対応修正"
					onClick="return checkUpdate()" />
				<input type="hidden" name="conditionCode"
					value="${f:h(h.conditionCode)}" />
				<input type="hidden" name="tableId" value="${f:h(h.tableId)}" />
			</s:form>
		</c:if>

		<!-- ↓持込承認内容入力フォーム↓ -->
		<c:if
			test="${(authorizations == 1) && (h.conditionCode==10 || h.conditionCode==12)}">
			<s:form>
				<font size="5" color="blue">-持込承認・差戻入力-</font>
				<table border="1">
					<tr>
						<th>持込確認者</th>
						<th>持込確認日</th>
						<td class="none" style="width: 185px">
					</tr>
					<tr>
						<td><select name="bringApprover" style="width: 100%;">
							<c:forEach var="t" items="${approvers}">

								<!-- ↓セレクトボックスの初期値を調整する処理↓ -->
								<c:if test="${(userId == t.personnelNumber) && (h.bringPersonName != t.personnelName)}">
									<option value="${t.personnelNumber}" selected>${t.PersonnelName}</option>
								</c:if>

								<c:if test="${userId != t.personnelNumber}">
									<option value="${t.personnelNumber}">${t.PersonnelName}</option>
								</c:if>
								<!-- ↑セレクトボックスの初期値を調整する処理↑ -->

							</c:forEach>
						</select></td>
						<td><html:text styleClass="hankaku" maxlength="8" property="bringApprovalDate"
							value="${f:h(time)}" /></td>
						<td class="none"></td>
					</tr>
					<tr>
						<th>持込確認時備考</th>
						<td class="noneBottomBorder"></td>
						<td class="noneBottomBorder"></td>
					</tr>
					<tr>
						<td class="notes" colspan="3">
						<textarea name="bringApproveNotes" style="ime-mode: active;" />${f:h(h.bringApproveNotes)}</textarea>
						</td>
					</tr>
				</table>
				<input type="submit" name="bringApprove" value="承認"
					onClick="return checkApprove()" />
				<input type="submit" name="bringRemand" value="差し戻し"
					onClick="return checkRemand()" />
				<input type="hidden" name="conditionCode"
					value="${f:h(h.conditionCode)}" />
				<input type="hidden" name="tableId" value="${f:h(h.tableId)}" />
			</s:form>
		</c:if>


		<!-- ↓終了対応承認内容入力フォーム↓ -->
		<c:if test="${(authorizations == 1) && h.conditionCode==20}">
			<s:form>
				<font size="5" color="blue">-終了対応承認・差戻入力-</font>
				<table border="1">
					<tr>
						<th class="process">終了対応確認者</th>
						<th class="process">終了対応確認日</th>
						<td class="none" style="width: 185px;"></td>
					</tr>
					<tr>
						<td><select name="processApprover">
							<c:forEach var="t" items="${approvers}">

								<!-- ↓セレクトボックスの初期値を調整する処理↓ -->
								<c:if test="${(userId == t.personnelNumber) && (h.bringPersonName != t.personnelName)}">
									<option value="${t.personnelNumber}" selected>${t.PersonnelName}</option>
								</c:if>

								<c:if test="${userId != t.personnelNumber}">
									<option value="${t.personnelNumber}">${t.PersonnelName}</option>
								</c:if>
								<!-- ↑セレクトボックスの初期値を調整する処理↑ -->
							</c:forEach>
						</select></td>
						<td><html:text property="processApprovalDate" value="${f:h(time)}" styleClass="hankaku" maxlength="8" /></td>
						<td class="none"></td>
					<tr>
						<th class="process">終了対応確認時備考</th>
						<td class="noneBottomBorder"></td>
						<td class="noneBottomBorder"></td>
					</tr>
					<tr>
						<td class="notes" colspan="3"><textarea name="processApproveNotes" style="imemode: active;" />${f:h(h.processApproveNotes)}</textarea>
						</td>
					</tr>
				</table>
				<input type="submit" name="processApprove" value="承認"
					onClick="return checkApprove()" />
				<input type="submit" name="processRemand" value="差し戻し"
					onClick="return checkRemand()" />
				<input type="hidden" name="conditionCode"
					value="${f:h(h.conditionCode)}" />
				<input type="hidden" name="tableId" value="${f:h(h.tableId)}" />
			</s:form>
		</c:if>

	</c:if>

</c:forEach>
</div>
</body>
</html>