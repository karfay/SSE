<h1>Tutorial: Tiles	</h1>
<h2>${f:h(name)}</h2>
<h2>${f:h(msg)}</h2>
<body onLoad="javascript:init();">
    <form name="myForm">
        <input type="text" name="inputbox1" value = "${f:h(err)}"><input type="button" name="on_off"
              value="button" onClick="javascript:disp_ctrl();">
    </form>
    <script>
		show_err();
	</script>
</body>
header