package ug.util;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class StringUtil {

	/**
	 * 現在日付から年度情報を取得して４桁の文字列で返す。
	 * @return
	 */
	public static String getCurrentNendo(){
		Calendar calendar = Calendar.getInstance();
		String nendo;
		//calenderクラスの月は0-11で表される
		//1~3月は0~2
		if(calendar.get(Calendar.MONTH)<3){
			nendo = Integer.toString(calendar.get(Calendar.YEAR)-1);
		}
		else{
			nendo = Integer.toString(calendar.get(Calendar.YEAR));
		}
		return nendo;
	}

	/**
	 * 引数のCalendarから年度を返す。
	 * 戻り値はInteger
	 * @return
	 */
	public static Integer getNendoFromCalendar(Calendar calendar){
		int nendo;
		//calenderクラスの月は0-11で表される
		//1~3月は0~2
		if(calendar.get(Calendar.MONTH)<3){
			nendo = calendar.get(Calendar.YEAR)-1;
		}
		else{
			nendo = calendar.get(Calendar.YEAR);
		}
		return nendo;
	}


	/**
	 * yyyy/MM の文字列をCalender型に変換する。
	 * @param dateStr
	 * @return
	 */
	public static Calendar converCalendarFromString(String dateStr){
		Date date = convertDateFromString(dateStr);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		return calendar;
	}

	/**
	 * yyyy/MM の文字列をCalender型に変換する。
	 * 文字列が年度で表記されている場合はこちらを使う。
	 * @param dateStr
	 * @return
	 */
	public static Calendar converCalendarFromNendoString(String dateStr){
		Date date = convertDateFromString(dateStr);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		//月が１，２，３月のいずれかだったら、カレンダーを１年進める
		//ex) 2017年度３月→2018年３月
		if(calendar.get(Calendar.MONTH) < 3){
			calendar.add(Calendar.YEAR, 1);
		}
		return calendar;
	}

	/**
	 * 空白の場合はNULLとして詰め替える。
	 * 検索条件などは空白によりエラーとなるため
	 * @param from
	 * @param to
	 */
	public static void refillExcludesWhiteSpace(String from, String to){
		if(from=="")to = null;
		else to = from;
	}

	/**
	 * ３桁カンマ区切りの数値を格納した文字列をBigDecimal型にして返す。
	 * 文字列が空白、nullの場合は0を返す。
	 * フォームからエンティティへの値の詰め変えを想定している。
	 * @param str
	 * @return
	 */
	public static BigDecimal convertString(String str) {
		if(str==null || str.equals("")){
			 return new BigDecimal(0);
		} else {
		return new BigDecimal(str.replace(",", ""));
		}
	}

	/**
	 * SAStrutsの<html:select>タグで生成されるString配列に、optionを追加するメソッド
	 * 配列がnull、またはoption値を含んでいた場合はそのまま配列を返す。
	 * 配列がnullでなく、かつoption値を含まない場合は配列にoption値を追加して返す。
	 *
	 * ちなみに、配列の値はダブってても動く(sqlのwhere句がin('option','option')のようになる)が、
	 * inの条件は多いほど検索が重くなるので配列数増やして条件を格納する～というのは今回はやらないこととする。
	 * @param selectList
	 * @param option
	 * @return
	 */
	public static String[] addSelectBoxCondition(String[] selectList, String option) {
		if(selectList==null)return null;
		String[] tmp = new String[selectList.length + 1];
		for(int i=0; i<selectList.length; i++){
			if(selectList[i].equals(option)){
				return selectList;
			}
			tmp[i] = selectList[i];
		}
		tmp[selectList.length] = option;
		return tmp;
	}

	/**
	 * yyyy/MM の文字列をDate型に変換して返す。
	 * @param dateStr
	 * @return ParseExceptionのときはNULLを返す。
	 */
	public static Date convertDateFromString(String dateStr){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM");
		try {
			return sdf.parse(dateStr);
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}
	}


}
