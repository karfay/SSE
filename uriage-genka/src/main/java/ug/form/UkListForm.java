package ug.form;

import org.seasar.struts.annotation.Required;


public class UkListForm extends CommonForm{

	public String pageName = "売上計画管理表";

	//入力フォーム
	@Required
	public String nendo;
	@Required
	public String eigyo;
	@Required
	public String ankenName;
	public String jutyuName;
	public String themeGroup;
	public String themeNo;
	public String kaihatsuGroupHead;
	@Required
	public String kokyakuName;
	@Required
	public String kokyakuInitial;
	@Required
	public String hattyuTypeCode;
	@Required
	public String hattyuMikomiDate;
	public String hattyuDate;
	public String kensyuDate;
	@Required
	public String kakudoCode;
	@Required
	public String jutyugaku;
	public String ukYokuyoku;

	//jspからhiddenで受け取るフォーム
	public String ankenId;
	public String ankenRirekiNo;
	public String ankenRirekiId;
	public String ukConditionCode;

	//当年度の売上計画
	public String tounendoApr;
	public String tounendoMay;
	public String tounendoJun;
	public String tounendoJul;
	public String tounendoAug;
	public String tounendoSep;
	public String tounendoKamiki;
	public String tounendoOct;
	public String tounendoNov;
	public String tounendoDec;
	public String tounendoJan;
	public String tounendoFeb;
	public String tounendoMar;
	public String tounendoShimoki;
	public String tounendoTotal;
	//次年度の売上計画
	public String jinendoApr;
	public String jinendoMay;
	public String jinendoJun;
	public String jinendoJul;
	public String jinendoAug;
	public String jinendoSep;
	public String jinendoKamiki;
	public String jinendoOct;
	public String jinendoNov;
	public String jinendoDec;
	public String jinendoJan;
	public String jinendoFeb;
	public String jinendoMar;
	public String jinendoShimoki;
	public String jinendoTotal;
	//入力情報の維持のためにhiddenで送信する
	public String zennendoTotal;
	public String uriageTotal;

	//検索条件
	public String searchNendo;
	public String searchKokyakuName;
	public String searchAnkenName;
	public String searchJutyuName;
	public String[] searchKakudoList;
	public String[] searchHattyuTypeList;
	public String[] searchEigyoList;
	public String[] searchConditionCodeList;
	public String searchSort;

	//枠の着色用
	public String newInsert;
	public String newUpdate;
	public String newDelete;

	/**
	 * 初期化メソッド
	 * 初期表示index()のときに呼ばれる
	 */
	public void initialize(){
		//現在の年度を検索条件に
		searchNendo = ug.util.StringUtil.getCurrentNendo();
		//新規テーマのみを表示
		searchConditionCodeList = new String[] {"1"};
		//ソート順を標準ソートに
		searchSort = "normal";

		//金額に関するフォームをすべて"0"に
		jutyugaku = "0";
		ukYokuyoku = "0";
		tounendoApr = "0";
		tounendoMay = "0";
		tounendoJun = "0";
	}
}