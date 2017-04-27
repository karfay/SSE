package ug.action;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.seasar.extension.jdbc.JdbcManager;
import org.seasar.struts.annotation.ActionForm;
import org.seasar.struts.annotation.Execute;

import ug.SqlFiles;
import ug.constant.GkConstant;
import ug.dto.GkDto;
import ug.dto.UserDataDto;
import ug.entity.AnkenRireki;
import ug.entity.GenkaKanri;
import ug.entity.GenkaKanriNames;
import ug.entity.MonthlyGenka;
import ug.entity.UriageKeikaku;
import ug.form.GkDetailForm;
import ug.service.GenkaKanriService;
import ug.service.MonthlyGenkaService;
import ug.service.UriageKeikakuService;
import ug.util.StringUtil;

public class GkDetailAction {

	@Resource
	protected UserDataDto userDataDto;

	@ActionForm
	@Resource
	protected GkDetailForm gkDetailForm;

	@Resource
	protected JdbcManager jdbcManager;
	@Resource
	protected MonthlyGenkaService monthlyGenkaService;
	@Resource
	protected UriageKeikakuService uriageKeikakuService;
	@Resource
	protected GenkaKanriService genkaKanriService;

	public List<MonthlyGenka> monthlyGenka;
	public List<MonthlyGenka> shikakariGenka;
	public MonthlyGenka pjGenka;

	public GkDto gk;

	@Execute(validator=false)
	public String index(){
		//TODO 開発用にとりあえず設定
		gkDetailForm.gkId = "2";

		//gkId==nullの場合はアクセスエラー
		if(gkDetailForm.gkId==null){
			gkDetailForm.errMessage = GkConstant.accessErr;
			return "gkDetail.jsp";
		}

		//表示用のgkDtoを取得する
		gk = jdbcManager
			.selectBySqlFile(GkDto.class, SqlFiles.GK_GET_GK_FOR_UPDATE, gkDetailForm.gkId)
			.getSingleResult();

		//月別原価情報を取得
		monthlyGenka = monthlyGenkaService.findByGkId(Integer.parseInt(gkDetailForm.gkId));
		//月別原価情報がない→新規作成
		if(monthlyGenka.isEmpty()){
			//TODO 着手月から納期までテーブルを作成。
			//金額は初期化して0に
			newCreateGenka();
			calcInsertGenkaSum(gk.themeGroup);
		}
		else{
			//themeGroupから関連する案件情報をすべて取得
			List<AnkenRireki> ankenRireki = jdbcManager
					.selectBySqlFile(AnkenRireki.class, SqlFiles.GK_GET_ANKEN_RIREKI_FROM_THEME_GROUP, gk.themeGroup)
					.getResultList();
			Timestamp genkaUpdateTime = genkaKanriService.findById(Integer.parseInt(gkDetailForm.gkId)).lastUpdateTime;
			//原価管理表の更新（再計算）日時が、関連する案件テーブルのいずれの更新日時よりも新しい場合は、
			//更新処理recalculateGenka()と合計の再計算処理calcInsertGenkaSum()を行わない。
			for(AnkenRireki ar : ankenRireki){
				//案件履歴テーブルの更新日時が、原価管理表の更新日時よりも新しい
				if(ar.insertDate.compareTo(genkaUpdateTime) > 0){
					recalculateGenka();
					calcInsertGenkaSum(gk.themeGroup);
					//再計算が完了したら、genkaKanriのlastUpdateTimeを更新しておく
					GenkaKanri update = genkaKanriService.findById(Integer.parseInt(gkDetailForm.gkId));
					update.lastUpdateTime = new Timestamp(System.currentTimeMillis());
					jdbcManager.update(update).includes(GenkaKanriNames.lastUpdateTime()).execute();
					break;
				}
			}
		}
		//TODO 生成まで終わったので一旦起動して正しくテーブル生成が行われるか確認する。
		//生成を確認したら、生成部分をコメントアウトしてform整形のテストを行う。
		monthlyGenka = monthlyGenkaService.getMonthlyGenlka(gk.themeGroup);

		initializeForm(monthlyGenka);

		return "gkDetail.jsp";
	}

	/**
	 * テーマ親番を受け取って、仕掛り系とPJ合計を再計算する。
	 * 売上計画が変化すると仕掛り計の期間や受注額が変動するため、削除、再計算、更新する。
	 * @param themeGroup
	 */
	private void calcInsertGenkaSum(String themeGroup) {
		// TODO 自動生成されたメソッド・スタブ
		//まず削除
		int[] deleteDegugLog = monthlyGenkaService.deleteGenkaSum(gk.themeGroup);
		//次に仕掛り計を再計算
		 shikakariGenka = jdbcManager
				 .selectBySqlFile(MonthlyGenka.class, SqlFiles.GK_GET_SHIKAKARI_GENKA_SUM, gk.themeGroup)
				 .getResultList();
		//仕掛り計を一括挿入
		int[] insertdebugLog = jdbcManager.insertBatch(shikakariGenka).execute();

		//プロジェクト合計を再計算
		 pjGenka = jdbcManager
				 .selectBySqlFile(MonthlyGenka.class, SqlFiles.GK_GET_PJ_GENKA_SUM, gk.themeGroup)
				 .getSingleResult();
		//プロジェクト合計を挿入
		 int count = jdbcManager.insert(pjGenka).execute();
	}

	/**
	 * 表示用にフォームを初期化する。
	 */
	private void initializeForm(List<MonthlyGenka> mgList) {
		//テーマ親番から売上計画を取得
		List<UriageKeikaku> ukList = jdbcManager
				.selectBySqlFile(UriageKeikaku.class, SqlFiles.GK_GET_UK_THEME_NO_SUM_FROM_THEME_GROUP, gk.themeGroup)
				.getResultList();
		//売上計画を整形
		List<FixedUk> fixedUkList = createFixedUkList(ukList);
		// TODO 開発体制を取得

		for(MonthlyGenka mg : mgList){
			List<Map<String, Object>> mapItems = new ArrayList<Map<String, Object>>();

			// 月別原価テーブルの値をマップに格納
			Map<String, Object> m = new HashMap<String, Object>();
			m.put("monthlyGenkaId", mg.monthlyGenkaId);
			m.put("themeNo", mg.themeNo);
			m.put("themeGroup", mg.themeGroup);
			m.put("nendo", mg.nendo);
			m.put("month", mg.month);
			m.put("gkConditionCode", mg.gkConditionCode);
			m.put("KRoumuhi", mg.KRoumuhi);
			m.put("KKousu", mg.KKousu);
			//TODO 計画単価はマスタから取得
			m.put("KTanka", mg.KTanka);
			m.put("KGaityu", mg.KGaityu);
			m.put("KRyohi", mg.KRyohi);
			m.put("KSonota", mg.KSonota);
			m.put("KKeihi", mg.KKeihi);
			m.put("KSum", mg.KSum);
			m.put("MRoumuhi", mg.MRoumuhi);
			m.put("MKousu", mg.MKousu);
			m.put("MTanka", mg.MTanka);
			m.put("MGaityu", mg.MGaityu);
			m.put("MRyohi", mg.MRyohi);
			m.put("MSonota", mg.MSonota);
			m.put("MKeihi", mg.MKeihi);
			m.put("MSum", mg.MSum);
			m.put("JRoumuhi", mg.JRoumuhi);
			m.put("JKousu", mg.JKousu);
			m.put("JTanka", mg.JTanka);
			m.put("JGaityu", mg.JGaityu);
			m.put("JRyohi", mg.JRyohi);
			m.put("JSonota", mg.JSonota);
			m.put("JKeihi", mg.JKeihi);
			m.put("JSum", mg.JSum);
			m.put("KMGap", mg.KMGap);
			m.put("KJGap", mg.KJGap);
			m.put("arari", mg.arari);
			m.put("arariPar", mg.arariPar);

			//プロジェクト合計ならfixedUkの売上額合計を格納
			if(mg.gkConditionCode==403){
				BigDecimal uriage = BigDecimal.ZERO;
				for(FixedUk fixedUk:fixedUkList){
					uriage.add(fixedUk.uriage);
				}
				m.put("uriage", uriage);
			}

			//仕掛り計ならfixedUkから年度、月が一致する要素を検索して売上を格納
			if(mg.gkConditionCode==402){
				for(FixedUk fixedUk:fixedUkList){
					if(mg.nendo==fixedUk.nendo && mg.month==fixedUk.month){
						m.put("uriage", fixedUk.uriage);
						break;
					}
				}
			}

			// mapItemsの先頭mapItems[0]に月別原価情報を格納
			mapItems.add(m);

			for (int i = 0; i < 1; i++) {
				// TODO 開発体制を格納
			}

			gkDetailForm.mapItemsItems.add(mapItems);
		}
	}



	//TODO 既存の月別原価詳細テーブルが最新売上月を上回る場合の処理はrecalcurateGenka()で行う。
	/**
	 * monthlyGenka（月別テーブルの原価リスト）の各月のデータにテーマNOを格納するメソッド。
	 * mgListとfixedUkListの整合性がとれている必要がある。
	 */
	private List<MonthlyGenka> setThemeNoToMonthlyGenka(List<MonthlyGenka> mgList, List<FixedUk> fixedUkList){

		int ukIndex = 0;
		int mgIndex=0;
		while(mgIndex < mgList.size()){
			//テーマNOを格納
			mgList.get(mgIndex).themeNo = fixedUkList.get(ukIndex).themeNo;
			//mgListとfixedUkListの年度を比較し、年度の古いリストのindexを進める。
			if(mgList.get(mgIndex).nendo < fixedUkList.get(ukIndex).nendo){mgIndex++; continue;}
			else if(mgList.get(mgIndex).nendo > fixedUkList.get(ukIndex).nendo){ukIndex++; continue;}
			else{//年度が等しい時
				//mgListとfixedUkListの月を比較し、月の古いリストのindexを進める。
				if(mgList.get(mgIndex).month < fixedUkList.get(ukIndex).month){mgIndex++; continue;}
				else if(mgList.get(mgIndex).month > fixedUkList.get(ukIndex).month){ukIndex++; continue;}
				else{//年度、月いずれも等しい時
					//両方のリストのindexを進める。
					mgIndex++; ukIndex++; continue;
				}
			}
		}
		return mgList;
	}

	/**
	 * 原価情報を新規作成する。
	 */
	private void newCreateGenka() {
		Calendar startDate = StringUtil.converCalendarFromNendoString(gk.tyakusyuMonth);
		Calendar endDate = StringUtil.converCalendarFromNendoString(gk.nouki);
		//テーマ親番から売上計画を取得
		List<UriageKeikaku> ukList = jdbcManager
				.selectBySqlFile(UriageKeikaku.class, SqlFiles.GK_GET_UK_THEME_NO_SUM_FROM_THEME_GROUP, gk.themeGroup)
				.getResultList();
		//売上計画を整形
		List<FixedUk> fixedUkList = createFixedUkList(ukList);
		//fixedUkListの最後の要素が最新の売上月
		// yyyy/MM の形に整形
		String dateStr  = String.valueOf(fixedUkList.get(fixedUkList.size()-1).nendo) + "/";
		if(fixedUkList.get(fixedUkList.size()-1).month < 9)dateStr += "0";
		dateStr += String.valueOf(fixedUkList.get(fixedUkList.size()-1).month);
		Calendar latestUriageMonth = StringUtil.converCalendarFromString(dateStr);
		//最新売上月が納期よりも新しい場合、納期を無視して最新売上月まで月別原価情報を作成する。
		if(latestUriageMonth.compareTo(endDate)>0){
			endDate = latestUriageMonth;
		}

		List<MonthlyGenka> insertMgList = new ArrayList<MonthlyGenka>();

		//startDate～endDateまでの月別原価テーブルを作成
		while(startDate.compareTo(endDate)<=0){
			MonthlyGenka newMg = new MonthlyGenka();
			newMg.themeGroup = gk.themeGroup;
			newMg.nendo = StringUtil.getNendoFromCalendar(startDate);
			newMg.month = startDate.get(Calendar.MONTH) + 1;
			newMg.gkConditionCode = 401;//コード名称：月別
			newMg.themeNo = "";
			insertMgList.add(newMg);

			startDate.add(Calendar.MONTH, 1);
		}
		//TODO themeNoを売上計画から設定
		insertMgList = setThemeNoToMonthlyGenka(insertMgList, fixedUkList);

		//初期項目のみでinert
		int[] insertBatchLog = jdbcManager.insertBatch(insertMgList).execute();

	}

	/**
	 * 原価情報を再計算する。
	 */
	private void recalculateGenka() {
		// TODO 自動生成されたメソッド・スタブ
		//既に原価情報の入力があるなら、一旦テーマNO情報を空に
		for(MonthlyGenka mg : monthlyGenka){
			mg.themeNo = "";//テーマNOをすべて空白に
		}
	//関連する売上計画の年度ごとの合計を昇順で取得
	List<UriageKeikaku> ukList = jdbcManager.
			selectBySqlFile(UriageKeikaku.class, SqlFiles.GK_GET_UK_NENDO_SUM_FROM_GK_ID, gkDetailForm.gkId)
			.getResultList();

	}

	/**
	 * themeGroupから関連する売上計画を取得して、List<fixedUkDto>を生成し、返すメソッド
	 */
	private List<FixedUk> createFixedUkList(List<UriageKeikaku> ukList){
		List<FixedUk> fixedUkList = new ArrayList<FixedUk>();
		for(UriageKeikaku uk : ukList){
			FixedUk fixedUk = new FixedUk();
			//その月の売上額があれば格納する
			if(uk.ukApr.compareTo(BigDecimal.ZERO)>0){
				fixedUk.nendo = uk.nendo;
				fixedUk.themeNo = uk.themeNo;
				fixedUk.month = 4;
				fixedUk.uriage = uk.ukApr;
				fixedUkList.add(fixedUk);
			}
			if(uk.ukMay.compareTo(BigDecimal.ZERO)>0){
				fixedUk.nendo = uk.nendo;
				fixedUk.themeNo = uk.themeNo;
				fixedUk.month = 5;
				fixedUk.uriage = uk.ukMay;
				fixedUkList.add(fixedUk);
			}
			if(uk.ukJun.compareTo(BigDecimal.ZERO)>0){
				fixedUk.nendo = uk.nendo;
				fixedUk.themeNo = uk.themeNo;
				fixedUk.month = 6;
				fixedUk.uriage = uk.ukJun;
				fixedUkList.add(fixedUk);
			}
			if(uk.ukJul.compareTo(BigDecimal.ZERO)>0){
				fixedUk.nendo = uk.nendo;
				fixedUk.themeNo = uk.themeNo;
				fixedUk.month = 7;
				fixedUk.uriage = uk.ukJul;
				fixedUkList.add(fixedUk);
			}
			if(uk.ukAug.compareTo(BigDecimal.ZERO)>0){
				fixedUk.nendo = uk.nendo;
				fixedUk.themeNo = uk.themeNo;
				fixedUk.month = 8;
				fixedUk.uriage = uk.ukAug;
				fixedUkList.add(fixedUk);
			}
			if(uk.ukSep.compareTo(BigDecimal.ZERO)>0){
				fixedUk.nendo = uk.nendo;
				fixedUk.themeNo = uk.themeNo;
				fixedUk.month = 9;
				fixedUk.uriage = uk.ukSep;
				fixedUkList.add(fixedUk);
			}
			if(uk.ukOct.compareTo(BigDecimal.ZERO)>0){
				fixedUk.nendo = uk.nendo;
				fixedUk.themeNo = uk.themeNo;
				fixedUk.month = 10;
				fixedUk.uriage = uk.ukOct;
				fixedUkList.add(fixedUk);
			}
			if(uk.ukNov.compareTo(BigDecimal.ZERO)>0){
				fixedUk.nendo = uk.nendo;
				fixedUk.themeNo = uk.themeNo;
				fixedUk.month = 11;
				fixedUk.uriage = uk.ukNov;
				fixedUkList.add(fixedUk);
			}
			if(uk.ukDec.compareTo(BigDecimal.ZERO)>0){
				fixedUk.nendo = uk.nendo;
				fixedUk.themeNo = uk.themeNo;
				fixedUk.month = 12;
				fixedUk.uriage = uk.ukDec;
				fixedUkList.add(fixedUk);
			}
			if(uk.ukJan.compareTo(BigDecimal.ZERO)>0){
				fixedUk.nendo = uk.nendo;
				fixedUk.themeNo = uk.themeNo;
				fixedUk.month = 1;
				fixedUk.uriage = uk.ukJan;
				fixedUkList.add(fixedUk);
			}
			if(uk.ukFeb.compareTo(BigDecimal.ZERO)>0){
				fixedUk.nendo = uk.nendo;
				fixedUk.themeNo = uk.themeNo;
				fixedUk.month = 2;
				fixedUk.uriage = uk.ukFeb;
				fixedUkList.add(fixedUk);
			}
			if(uk.ukMar.compareTo(BigDecimal.ZERO)>0){
				fixedUk.nendo = uk.nendo;
				fixedUk.themeNo = uk.themeNo;
				fixedUk.month = 3;
				fixedUk.uriage = uk.ukMar;
				fixedUkList.add(fixedUk);
			}

		}
		return fixedUkList;
	}
}

/**
 * 売上計画から月別原価情報を取得する際に、
 * 処理を簡易化するために売上計画を一度変換する容れ物。
 * 月別原価情報の処理に適応（fix）させた売上計画情報。
 * @author sse802563
 *
 */
class FixedUk{
	int nendo;
	int month;
	BigDecimal uriage;
	String themeNo;
}
