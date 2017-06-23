<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" type="text/css" href="${f:url('/css/global.css')}"></link>
<style type="text/css">
div.input-form{
	background-color:#f8e58c;
	width:100%;
	left:0;
	padding:5px 30px;
	text-align: center;
}
#login-table {
	position: absolute;
	text-align: center;
}
#login-table td{
	padding: 10px;
	vertical-align: middle;
}
input[type="submit"].login {
	width: 150px;
	font-size: 18px;
	font-weight: bold;
	text-decoration: none;
	text-align: 8px 0 10px;
	color: dark;
	border-radius: 2px;
	box-shadow:2px 2px gray;
	background-image: -webkit-gradient(
	linear,left top,left bottom,
	from(yellow),
	to(darkorange));
}
input[type="text"] {
  background-color: white;
  color: black;
  padding: 0 ;
  font-size: medium;
  font-weight: bold;
}
input[type="password"] {
  background-color: white;
  color: black;
  padding: 0;
  font-size: medium;
  font-weight: bold;
}

</style>

<script type="text/javascript" src="${f:url('/javascript/jquery-3.1.1.min.js')}"></script>

<script type="text/javascript">
function checkLogin(obj){
	if($('#loginId').val()==''){
		window.alert('ログインIDは必須です');
		return false;
	}
	if($('#password').val()==''){
		window.alert('パスワードは必須です');
		return false;
	}
	return true;
}

$(window).on('load', function(){
	$('.input-form').css('height',$(window).height() - $('.input-form').offset().top);

	$('#login-table').css('top', $(window).height() / 2 - $('#login-table').height());
	$('#login-table').css( 'left', ( $(window).width() - $('#login-table').width()) / 2 );
});
</script>

<title>${pageName}</title>
</head>
<body>
<div class="header">
${sysName} / ${pageName}
</div>

<div class="fixed" style="top: 24px;">

	<c:if test="${!empty errMessage}">
		<div class="error">
		${errMessage}
		</div>
	</c:if>

	<html:errors/>

	<c:if test="${!empty sysMessage}">
		<div class="message">
		${sysMessage}
		</div>
	</c:if>
	<div class="input-form">
		<s:form>
			<table id="login-table">
				<tr>
					<td><b></>ログインID：</b></td>
					<td><html:text property="loginId" styleClass="required" styleId="loginId" maxlength="10" /></td>
				</tr>
				<tr>
					<td><b>パスワード：</b></td>
					<td><html:password property="password" styleClass="required" styleId="password" maxlength="10" /></td>
				</tr>
				<tr><td colspan="2">
					<input type="submit" name="login" value="ログイン" class="login" onclick="return checkLogin(this)" />
				</td></tr>
			</table>
		</s:form>
	</div>
</div>
</body>
</html>