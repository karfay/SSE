<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" type="text/css" href="${f:url('/css/global.css')}"></link>
<style type="text/css">
a {
	padding: 10px;
	font-weight: bold;
	font-size: 50px;
	text-decoration: none;
}

div.link {
	text-align: center;
}
</style>
<script type="text/javascript" src="${f:url('/javascript/jquery-3.1.1.min.js')}"></script>
<script type="text/javascript">
$(function() {
	  //マウスを乗せたら発動
	  $('div.link').hover(function() {
	    //マウスを乗せたら色が変わる
	    $(this).css('background', 'skyblue');

	  //ここにはマウスを離したときの動作を記述
	  }, function() {
	    //色指定を空欄にすれば元の色に戻る
	    $(this).css('background', '');
	  });
	});
</script>
<title>${pageName}</title>
</head>
<body>
<div class="header" id="header">
	${sysName} / ${pageName}
</div>
<div class="fixed" style="top: 24px">
	<div class="message">
		${sysMessage}
	</div>

	<div class="link">
		<s:link href="/themeMaster/" target="_blank" >テーマ一覧表</s:link>
	</div>
	<div class="link">
		<s:link href="/ukList/" target="_blank" >売上計画管理表</s:link>
	</div>
		<div class="link">
		<s:link href="/keikakuTankaMaster/" target="_blank" >計画単価設定</s:link>
	</div>
	<div class="link">
		<s:link href="logout">ログアウト</s:link>
	</div>
</div>
</body>
</html>