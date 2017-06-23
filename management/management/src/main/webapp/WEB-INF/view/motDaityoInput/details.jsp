<%@page pageEncoding="UTF-8"%>
<html>
<title>社内持込管理システム</title>
<link rel="stylesheet" type="text/css" href="${f:url('/css/Input.css')}" />
<body>

<script type="text/javascript">
<!--
function checkUpdatePermission(conditionCode){
	
	if(conditionCode == 21){
		// 警告ダイアログを表示
		window.alert('承認済みのデータは修正できません\n承認者にデータの差し戻しを依頼してください'); 
		return false;

	}
	
}
// -->
</script>

<h1>社内持込台帳：詳細表示</h1>
<html:errors />
<s:form>
	<input type="submit" name="index" value="申請画面トップへ" />
	<input type="submit" name="motSearchUpdate" value="検索画面へ" />
	<input type="submit" name="menu" value="メニューへ"
		style="position: relative; left: 150px;" />
	<input type="submit" name="logout" value="ログアウト"
		style="position: relative; left: 150px;" />
</s:form>
<font size="4" color="red"><b>${f:h(motMsg)}</b></font>

<!-- ↓出力フォーム↓ -->

<c:forEach var="h" items="${historyDto}">
	<table border="1">
		<tr>
			<th class="cond">${f:h(h.conditionName)}</th>
						<c:if test="${h.conditionCode==10 || h.conditionCode==13}">
				<s:form>
					<td class="none"><input type="submit" name="bringUpdate"
						value="持込情報を修正" class="button" /> <input type="hidden"
						name="tableId" value="${f:h(h.tableId)}" /></td>
				</s:form>
			</c:if>
			<c:if test="${h.conditionCode!=10 && h.conditionCode!=13}">
				<td class="space"></td>
			</c:if>
			<td class="space"></td>
			<td class="space"></td>
		</tr>
		<tr>
			<th>持込開始日</th>
			<th>持込者</th>
			<th>保管終了予定日</th>
			<th>終了時予定対応</th>
		</tr>
		<tr>
			<td class="details">${f:h(h.bringDate)}</td>
			<td class="details">${f:h(h.bringPersonName)}</td>
			<td class="details">${f:h(h.scheduledDate)}</td>
			<td class="details">${f:h(h.scheduledName)}</td>
		</tr>
		<c:if test="${h.processCode!=0}">
			<tr>
				<td class="space"></td>
				<th class="process">終了時対応者</th>
				<th class="process">持込終了日</th>
				<th class="process">終了時対応</th>
			</tr>
			<tr>
				<td class="space"></td>
				<td class="details">${f:h(h.processPersonName)}</td>
				<td class="details">${f:h(h.processDate)}</td>
				<td class="details">${f:h(h.processName)}</td>
			</tr>
		</c:if>
		<tr>
			<th>預かり元</th>
			<td class="space"></td>
			<td class="space"></td>
			<td class="space"></td>
		</tr>
		<tr>
			<td colspan="4">${f:h(h.clientName)}</td>
		</tr>
		<tr>
			<th>プロジェクト名</th>
			<td class="space"></td>
			<td class="space"></td>
			<td class="space"></td>
		</tr>
		<tr>
			<td colspan="4">${f:h(h.project)}</td>
		</tr>
	</table>
	<br />
	<font size="5">-持込物情報-</font>
	<br />
	<table border="1">
		<tr>
			<th>持込物名称</th>
			<td class="space"></td>
			<td class="space"></td>
			<td class="space"></td>
		</tr>
		<tr>
			<td colspan="4">${f:h(h.materialName)}</td>
		</tr>
		<tr>
			<th>部数</th>
			<th>持込物区分</th>
			<th>機密</th>
			<td class="space"></td>
		</tr>
		<tr>
			<td class="details">${f:h(h.copies)}</td>
			<td class="details">${f:h(h.categoryName)}</td>
			<c:if test="${h.confidential==1}">
				<td class="red">重要扱い</td>
			</c:if>
			<c:if test="${h.confidential==0}">
				<td>重要扱いでない</td>
			</c:if>
			<td class="space"></td>
		</tr>
		<tr>
			<th>格納場所</th>
			<td class="space"><br />
			</td>
			<td class="space"><br />
			</td>
			<td class="space"><br />
			</td>
		</tr>
		<tr>
			<td colspan="3" rowspan="3">${f:h(h.depository)}</td>
			<td class="space"><br />
			</td>
		</tr>
		<tr>
			<td class="space"><br />
			</td>
		</tr>
		<tr>
			<td class="space"><br />
			</td>
		</tr>
		<tr>
			<th>持込時備考</th>
			<td class="space"><br />
			</td>
			<td class="space"><br />
			</td>
			<td class="space"><br />
			</td>
		</tr>
		<tr>
			<td colspan="3" rowspan="3">${f:h(h.bringNotes)}</td>
			<td class="space"><br />
			</td>
		</tr>
		<tr>
			<td class="space"><br />
			</td>
		</tr>
		<tr>
			<td class="space"><br />
			</td>
		</tr>
	</table>
	<br />
	<!-- ↓持ち込み承認出力フォーム↓ -->
	<c:if test="${h.conditionCode != 10}">
		<font size="5">-持込承認情報-</font>
		<table border="1">
			<tr>
				<th class="cond">${f:h(h.conditionName)}</th>
				<td class="space"></td>
				<td class="space"></td>
				<td class="space"></td>
			</tr>
			<tr>
				<th>確認者</th>
				<th>対応日</th>
				<td class="space"></td>
				<td class="space"></td>
			</tr>
			<tr>
				<td>${h.bringApproverName}</td>
				<td>${h.bringApprovalDate}</td>
				<td class="space"></td>
				<td class="space"></td>
			</tr>
			<tr>
				<th>持込時備考</th>
				<td class="space"><br />
				</td>
				<td class="space"><br />
				</td>
				<td class="space"><br />
				</td>
			</tr>
			<tr>
				<td colspan="3" rowspan="3">${(h.bringApproveNotes)}</td>
				<td class="space"><br />
				</td>
			</tr>
			<tr>
				<td class="space"><br />
				</td>
			</tr>
			<tr>
				<td class="space"><br />
				</td>
			</tr>
		</table>

		<!-- ↓終了時対応出力フォーム↓ -->

		<c:if test="${h.processCode!=0}">
			<br />
			<font size="5">-持込終了対応時情報-</font>
			<table border="1">
				<tr>
					<th class="process">持込終了日</th>
					<th class="process">終了時対応者</th>
					<th class="process">終了時対応</th>
					<td class="space"></td>
				</tr>
				<tr>
					<td class="details">${f:h(h.processDate)}</td>
					<td class="details">${f:h(h.processPersonName)}</td>
					<td class="details">${f:h(h.processName)}</td>
					<td class="space"></td>
				</tr>
				<tr>
					<th class="process">終了対応時備考</th>
					<td class="space"><br />
					</td>
					<td class="space"><br />
					</td>
					<td class="space"><br />
					</td>
				</tr>
				<tr>
					<td colspan="3" rowspan="3">
						<script type="text/javascript"><!-- 
						${h.processNotes}.replace("0","<br />");
						document.write(${h.processNotes})
						// --></script>
						${h.processNotes}</td>
					<td class="space"><br />
					</td>
				</tr>
				<tr>
					<td class="space"><br />
					</td>
				</tr>
				<tr>
					<td class="space"><br />
					</td>
				</tr>
			</table>
		</c:if>


	</c:if>

</c:forEach>


</body>
</html>