<html>
<head>
<title><tiles:getAsString name="title" /></title>
<script type="text/javascript">
<!--
function init()
{
    document.myForm.inputbox1.style.visibility = "visible" ;
}
function disp_ctrl()
{
	if( document.myForm.inputbox1.style.visibility == "visible" ){
		document.myForm.inputbox1.style.visibility = "hidden" ;
        document.myForm.on_off.value = "button" ;
     }
    else{
   document.myForm.inputbox1.style.visibility = "visible" ;
   document.myForm.on_off.value = "clear" ;
    }
}
function show_err()
{
	document.myForm.inputbox1.value("${f:h(err)}");
}
//-->
</script>

<link rel="stylesheet" type="text/css" href="${f:url('/css/sa.css')}" />
</head>
<body>

<table class="layout" width="100%">
  <tr><td class="header" colspan="2"><tiles:insert page="header.jsp" /></td></tr>
  <tr>
    <td class="menu" width="20%"><tiles:insert page="menu.jsp" /></td>
    <td class="content" ><tiles:insert attribute="content" /></td>
  </tr>
  <tr><td class="footer" colspan="2"><tiles:insert page="footer.jsp" /></td></tr>
</table>
</body>
</html>