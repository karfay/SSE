function checkDatePattern(obj){
	console.log(obj.value);
	str = obj.value;
	if(str=='')return;
	else if(str.match(/^[0-9]{4}$/)){
		console.log('年度');
		return;
	}else if((str.match(/^[0-9]{6}$/)) || (str.match(/^[0-9]{4}\/[0-9]{1,2}$/))){
		console.log('月');
		if(str.match(/^[0-9]{6}$/)){
			str = str.substring(0,4) + '/' + str.substring(4,6);
		}
		date = new Date(str);
		if(isNaN(date)==false){
			obj.value = date.getFullYear() + '/' + ('0'+(date.getMonth()+1)).slice(-2);
			console.log('fixed');
			return;
		}
	}else if((str.match(/^[0-9]{8}$/)) || (str.match(/^[0-9]{4}\/[0-9]{1,2}\/[0-9]{1,2}$/))){
		console.log('日付');
		if(str.match(/^[0-9]{8}$/)){
			str = str.substring(0,4) +'/'+ str.substring(4,6) +'/'+ str.substring(6,8);
		}
		date = new Date(str);
		if(isNaN(date)==false){
			obj.value = date.getFullYear() + '/' + ('0'+(date.getMonth()+1)).slice(-2) + '/' + ('0'+date.getDate()).slice(-2);
			console.log('fixed');
			return;
		}
	}
	alert('日付ではありません。入力し直して下さい。\n【受け付ける日付例】2017,201704,20170401');
	obj.value = '';
}

function checkNendo(obj){
	console.log(obj.value);
	str = obj.value;
	if(str=='')return;
	else if(str.match(/^[0-9]{4}$/)){
		console.log('年度');
		return;
	}
	alert('年度ではありません。入力し直して下さい。\n【受け付ける年度例】2017');
	obj.value = '';
}