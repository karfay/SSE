package ug.action;

import java.math.BigDecimal;
import java.math.RoundingMode;
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
import ug.entity.EmpMonthlyKousu;
import ug.entity.EmpMonthlyKousuNames;
import ug.entity.GaityuMonthlyCost;
import ug.entity.GaityuMonthlyCostNames;
import ug.entity.Kaihatsutaisei;
import ug.entity.MonthlyGenka;
import ug.entity.MonthlyGenkaNames;
import ug.entity.UriageKeikaku;
import ug.form.GkDetailForm;
import ug.service.EmpMonthlyKousuService;
import ug.service.GaityuMonthlyCostService;
import ug.service.GenkaKanriService;
import ug.service.KaihatsutaiseiService;
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
	@Resource
	protected KaihatsutaiseiService kaihatsutaiseiService;
	@Resource
	protected EmpMonthlyKousuService empMonthlyKousuService;
	@Resource
	protected GaityuMonthlyCostService gaityuMonthlyCostService;

	public List<MonthlyGenka> monthlyGenka;

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
		monthlyGenka = monthlyGenkaService.findByGkIdIncludeDelete(Integer.parseInt(gkDetailForm.gkId));
		//月別原価情報がない→新規作成
		if(monthlyGenka.isEmpty()){
			//着手月から納期までテーブルを作成。
			//金額は初期化して0に
			newCreateGenka();
			calcInsertGenkaSum(gk.themeGroup);
		}
		else{
			recalculateGenka();
			calcInsertGenkaSum(gk.themeGroup);
		}

		// 表示用に情報を再取得して整形
		monthlyGenka = monthlyGenkaService.getMonthlyGenlka(gk.themeGroup);
		initializeForm(monthlyGenka);

		return "gkDetail.jsp";
	}

	/**
	 * 「原価情報を更新」ボタンを押したときのメソッド。
	 * 月別原価情報、社員月別工数、外注月別費用を更新して再表示する。
	 * @return
	 */
	@Execute(validator=false)
	public String update(){
		List<MonthlyGenka> mgUpdateList = new ArrayList<MonthlyGenka>();
		List<EmpMonthlyKousu> emkInsertList = new ArrayList<EmpMonthlyKousu>();
		List<GaityuMonthlyCost> gmcInsertList = new ArrayList<GaityuMonthlyCost>();
		List<EmpMonthlyKousu> emkUpdateList = new ArrayList<EmpMonthlyKousu>();
		List<GaityuMonthlyCost> gmcUpdateList = new ArrayList<GaityuMonthlyCost>();
		List<EmpMonthlyKousu> emkDeleteList = new ArrayList<EmpMonthlyKousu>();
		List<GaityuMonthlyCost> gmcDeleteList = new ArrayList<GaityuMonthlyCost>();
		//TODO 月別原価情報の更新
		int index = -1;
		for(List<Map<String, Object>> mapItems : gkDetailForm.mapItemsItems){
			index++;
			int index2 = -1;
			for(Map<String, Object> m : mapItems){
				index2++;

				if(index2==0){
					MonthlyGenka mgInsert = new MonthlyGenka();
					//オブジェクト型のキャストってこれでいいの？
					mgInsert.monthlyGenkaId = Integer.parseInt((String) m.get("monthlyGenkaId"));
					mgInsert.themeNo = (String) m.get("themeNo");
					mgInsert.themeGroup = (String) m.get("themeGroup");
					mgInsert.nendo = Integer.parseInt((String) m.get("nendo"));
					mgInsert.month = Integer.parseInt((String) m.get("month"));
					mgInsert.gkConditionCode = Integer.parseInt((String) m.get("gkConditionCode"));
					/* jspから受け取る値は基本的にStringなので、
					 * StringでキャストしてからBigDecimalに変換する。
					*/
					mgInsert.KRoumuhi = (StringUtil.convertString((String) m.get("KRoumuhi")));
					mgInsert.KKousu = (StringUtil.convertString((String) m.get("KKousu")));
					//mgInsert.KTanka = (StringUtil.convertString((String) m.get("KTanka")));
					mgInsert.KGaityu = (StringUtil.convertString((String) m.get("KGaityu")));
					mgInsert.KRyohi = (StringUtil.convertString((String) m.get("KRyohi")));
					mgInsert.KSonota = (StringUtil.convertString((String) m.get("KSonota")));
					mgInsert.KKeihi = (StringUtil.convertString((String) m.get("KKeihi")));
					//TODO jsp側のうっかりでキー名をKTotalにしてしまった。時間があれば直す。
					mgInsert.KSum = (StringUtil.convertString((String) m.get("KTotal")));
					mgInsert.MRoumuhi = (StringUtil.convertString((String) m.get("MRoumuhi")));
					mgInsert.MKousu = (StringUtil.convertString((String) m.get("MKousu")));
					mgInsert.MTanka = (StringUtil.convertString((String) m.get("MTanka")));
					mgInsert.MGaityu = (StringUtil.convertString((String) m.get("MGaityu")));
					mgInsert.MRyohi = (StringUtil.convertString((String) m.get("MRyohi")));
					mgInsert.MSonota = (StringUtil.convertString((String) m.get("MSonota")));
					mgInsert.MKeihi = (StringUtil.convertString((String) m.get("MKeihi")));
					mgInsert.MSum = (StringUtil.convertString((String) m.get("MTotal")));
					mgInsert.JRoumuhi = (StringUtil.convertString((String) m.get("JRoumuhi")));
					mgInsert.JKousu = (StringUtil.convertString((String) m.get("JKousu")));
					mgInsert.JTanka = (StringUtil.convertString((String) m.get("JTanka")));
					mgInsert.JGaityu = (StringUtil.convertString((String) m.get("JGaityu")));
					mgInsert.JRyohi = (StringUtil.convertString((String) m.get("JRyohi")));
					mgInsert.JSonota = (StringUtil.convertString((String) m.get("JSonota")));
					mgInsert.JKeihi = (StringUtil.convertString((String) m.get("JKeihi")));
					mgInsert.JSum = (StringUtil.convertString((String) m.get("JTotal")));
					mgInsert.KMGap = (StringUtil.convertString((String) m.get("KMGap")));
					mgInsert.KJGap = (StringUtil.convertString((String) m.get("KJGap")));
					mgInsert.arari = (StringUtil.convertString((String) m.get("Arari")));
					mgInsert.arariPar = (StringUtil.convertString((String) m.get("ArariPar")));
					//TODO キー設定ミスその２
					mgInsert.averageTanka = (StringUtil.convertString((String) m.get("AvgTanka")));

					mgUpdateList.add(mgInsert);

				}else{
					//社員月別工数の更新
					if(Integer.parseInt((String) m.get("gaityuFlag"))==0){
						EmpMonthlyKousu emkInsert = new EmpMonthlyKousu();

						emkInsert.KKousu = (StringUtil.convertString((String) m.get("KKousu")));
						emkInsert.MKousu = (StringUtil.convertString((String) m.get("MKousu")));
						emkInsert.JKousu = (StringUtil.convertString((String) m.get("JKousu")));

						if((String) m.get("emkId")==""){//emkIdがない時はinsert対象
							//計画見込実績がすべて0ならinsertしない
							if(emkInsert.KKousu.add(emkInsert.MKousu).add(emkInsert.JKousu).compareTo(BigDecimal.ZERO)==0)continue;

							emkInsert.empNo = (String) m.get("empNo");
							//テーマNO、年度、月は月別原価テーブルから取得
							emkInsert.themeNo = (String) mapItems.get(0).get("themeNo");
							emkInsert.nendo = Integer.parseInt((String) mapItems.get(0).get("nendo"));
							emkInsert.month = Integer.parseInt((String) mapItems.get(0).get("month"));
							emkInsertList.add(emkInsert);

						}else{//emkIdがあればupdate対象
							emkInsert.emkId = Integer.parseInt((String) m.get("emkId"));
							//計画見込実績がすべて0ならdelete
							if(emkInsert.KKousu.add(emkInsert.MKousu).add(emkInsert.JKousu).compareTo(BigDecimal.ZERO)==0){
								emkDeleteList.add(emkInsert);
							}else emkUpdateList.add(emkInsert);
						}
					}else{
						//外注月別費用の更新
						GaityuMonthlyCost gmcInsert = new GaityuMonthlyCost();

						gmcInsert.KCost = (StringUtil.convertString((String) m.get("KKousu")));
						gmcInsert.MCost = (StringUtil.convertString((String) m.get("MKousu")));
						gmcInsert.JCost = (StringUtil.convertString((String) m.get("JKousu")));

						if((String) m.get("emkId")==""){//emkIdがない時はinsert対象
							//計画見込実績がすべて0ならinsertしない
							if(gmcInsert.KCost.add(gmcInsert.MCost).add(gmcInsert.JCost).compareTo(BigDecimal.ZERO)==0)continue;
							gmcInsert.empNo = (String) m.get("empNo");
							//テーマNO、年度、月は月別原価テーブルから取得
							gmcInsert.themeNo = (String) mapItems.get(0).get("themeNo");
							gmcInsert.nendo = Integer.parseInt((String) mapItems.get(0).get("nendo"));
							gmcInsert.month = Integer.parseInt((String) mapItems.get(0).get("month"));
							gmcInsertList.add(gmcInsert);

						}else{//emkIdがあればupdate対象
							gmcInsert.gmcId = Integer.parseInt((String) m.get("emkId"));
							//計画見込実績がすべて0ならdelete
							if(gmcInsert.KCost.add(gmcInsert.MCost).add(gmcInsert.JCost).compareTo(BigDecimal.ZERO)==0){
								gmcDeleteList.add(gmcInsert);
							}else gmcUpdateList.add(gmcInsert);
						}
					}
				}
			}//mapItemsのfor文
		}//mapItemsItemsのfor文

		//insert, updateの実行
		int[] mgUpdateDebugLog = jdbcManager.updateBatch(mgUpdateList).execute();
		//リストが空だとinsertBatch()がエラーを返すため
		if(!emkInsertList.isEmpty()){
			int[] emkInsertDebugLog = jdbcManager.insertBatch(emkInsertList).execute();
		}
		//リストが空だとinsertBatch()がエラーを返すため
		if(!gmcInsertList.isEmpty()){
			int[] gmcInsertDebugLog = jdbcManager.insertBatch(gmcInsertList).execute();
		}
		//リストが空だとupdateBatch()がエラーを返すため
		if(!emkUpdateList.isEmpty()){

			int[] emkUpdateDebugLog =
					jdbcManager
					.updateBatch(emkUpdateList)
					.excludes(EmpMonthlyKousuNames.empNo() ,EmpMonthlyKousuNames.themeNo(), EmpMonthlyKousuNames.nendo(), EmpMonthlyKousuNames.month())
					.execute();
		}
		//リストが空だとupdateBatch()がエラーを返すため
		if(!gmcUpdateList.isEmpty()){
			int[] gmcUpdateDebugLog =
					jdbcManager
					.updateBatch(gmcUpdateList)
					.excludes(GaityuMonthlyCostNames.empNo() ,GaityuMonthlyCostNames.themeNo(), GaityuMonthlyCostNames.nendo(), GaityuMonthlyCostNames.month())
					.execute();
		}
		//リストが空だとdeleteBatch()がエラーを返すため
		if(!emkDeleteList.isEmpty()){
			int[] emkDeleteDebugLog = jdbcManager.deleteBatch(emkDeleteList).execute();
		}
		//リストが空だとdeleteBatch()がエラーを返すため
		if(!gmcDeleteList.isEmpty()){
			int[] gmcDeleteDebugLog = jdbcManager.deleteBatch(gmcDeleteList).execute();
		}
		//TODO 再表示
		index();

		return "gkDetail.jsp";
		}

	@Execute(validator=false)
	public String showBikou(){
		//TODO 備考を取得

		return "gkBikou.jsp";
	}


	/**
	 * テーマ親番を受け取って、仕掛り系とPJ合計を再計算する。
	 * 売上計画が変化すると仕掛り計の期間や受注額が変動するため、削除、再計算、更新する。
	 * @param themeGroup
	 */
	private void calcInsertGenkaSum(String themeGroup) {
		//まず削除
		int[] deleteDegugLog = monthlyGenkaService.deleteGenkaSum(themeGroup);

		//修正された月別原価情報を再取得
		monthlyGenka = monthlyGenkaService.getMgListForCalcShikakari(themeGroup);

		MonthlyGenka shikakari = new MonthlyGenka();
		MonthlyGenka pjSum = new MonthlyGenka();
		//仕掛り計用単価カウンタ
		int sktCount = 0;
		int smtCount = 0;
		int sjtCount = 0;
		//PJ合計用単価カウンタ
		int ktCount = 0;
		int mtCount = 0;
		int jtCount = 0;
		//次の要素を見たいのでindex管理
		int mgIndex = -1;
		for(MonthlyGenka mg : monthlyGenka){
			mgIndex++;
			// 経費と工数を仕掛り計に加算
			shikakari.KKousu = shikakari.KKousu.add(mg.KKousu);
			shikakari.KRoumuhi = shikakari.KRoumuhi.add(mg.KRoumuhi);
			shikakari.KGaityu = shikakari.KGaityu.add(mg.KGaityu);
			shikakari.KRyohi = shikakari.KRyohi.add(mg.KRyohi);
			shikakari.KSonota = shikakari.KSonota.add(mg.KSonota);
			shikakari.KKeihi = shikakari.KKeihi.add(mg.KKeihi);
			shikakari.KSum = shikakari.KSum.add(mg.KSum);

			shikakari.MKousu = shikakari.MKousu.add(mg.MKousu);
			shikakari.MRoumuhi = shikakari.MRoumuhi.add(mg.MRoumuhi);
			shikakari.MGaityu = shikakari.MGaityu.add(mg.MGaityu);
			shikakari.MRyohi = shikakari.MRyohi.add(mg.MRyohi);
			shikakari.MSonota = shikakari.MSonota.add(mg.MSonota);
			shikakari.MKeihi = shikakari.MKeihi.add(mg.MKeihi);
			shikakari.MSum = shikakari.MSum.add(mg.MSum);

			shikakari.JKousu = shikakari.JKousu.add(mg.JKousu);
			shikakari.JRoumuhi = shikakari.JRoumuhi.add(mg.JRoumuhi);
			shikakari.JGaityu = shikakari.JGaityu.add(mg.JGaityu);
			shikakari.JRyohi = shikakari.JRyohi.add(mg.JRyohi);
			shikakari.JSonota = shikakari.JSonota.add(mg.JSonota);
			shikakari.JKeihi = shikakari.JKeihi.add(mg.JKeihi);
			shikakari.JSum = shikakari.JSum.add(mg.JSum);
			// 単価は平均を出すので0でないときのみ加算し、加算した回数を数える
			if (mg.KTanka.compareTo(BigDecimal.ZERO) != 0) {
				shikakari.KTanka = shikakari.KTanka.add(mg.KTanka);
				sktCount++;
			}
			if (mg.MTanka.compareTo(BigDecimal.ZERO) != 0) {
				shikakari.MTanka = shikakari.MTanka.add(mg.MTanka);
				smtCount++;
			}
			if (mg.JTanka.compareTo(BigDecimal.ZERO) != 0) {
				shikakari.JTanka = shikakari.JTanka.add(mg.JTanka);
				sjtCount++;
			}
			/*
			 * jspの表示に任せて計算しないもの
			 * KMGap, KJGap, arari, arariPar
			 */
			/*
			 * 次の要素のテーマNOが変わったら、または最後の要素なら
			 * 仕掛り計をPJ合計に加算 仕掛り計をインサートしてshikakariをリセット
			 * 評価順を変えるとoutofboundsでエラーになるから注意。
			 */
			if(mgIndex == monthlyGenka.size() - 1 ||
					!monthlyGenka.get(mgIndex + 1).themeNo.equals(mg.themeNo)){

				shikakari.nendo = mg.nendo;
				shikakari.month = mg.month;
				shikakari.themeNo = mg.themeNo;
				shikakari.themeGroup = themeGroup;
				shikakari.gkConditionCode = 402;//仕掛り計

				pjSum.KKousu = pjSum.KKousu.add(shikakari.KKousu);
				pjSum.KRoumuhi = pjSum.KRoumuhi.add(shikakari.KRoumuhi);
				pjSum.KGaityu = pjSum.KGaityu.add(shikakari.KGaityu);
				pjSum.KRyohi = pjSum.KRyohi.add(shikakari.KRyohi);
				pjSum.KSonota = pjSum.KSonota.add(shikakari.KSonota);
				pjSum.KKeihi = pjSum.KKeihi.add(shikakari.KKeihi);
				pjSum.KSum = pjSum.KSum.add(shikakari.KSum);

				pjSum.MKousu = pjSum.MKousu.add(shikakari.MKousu);
				pjSum.MRoumuhi = pjSum.MRoumuhi.add(shikakari.MRoumuhi);
				pjSum.MGaityu = pjSum.MGaityu.add(shikakari.MGaityu);
				pjSum.MRyohi = pjSum.MRyohi.add(shikakari.MRyohi);
				pjSum.MSonota = pjSum.MSonota.add(shikakari.MSonota);
				pjSum.MKeihi = pjSum.MKeihi.add(shikakari.MKeihi);
				pjSum.MSum = pjSum.MSum.add(shikakari.MSum);

				pjSum.JKousu = pjSum.JKousu.add(shikakari.JKousu);
				pjSum.JRoumuhi = pjSum.JRoumuhi.add(shikakari.JRoumuhi);
				pjSum.JGaityu = pjSum.JGaityu.add(shikakari.JGaityu);
				pjSum.JRyohi = pjSum.JRyohi.add(shikakari.JRyohi);
				pjSum.JSonota = pjSum.JSonota.add(shikakari.JSonota);
				pjSum.JKeihi = pjSum.JKeihi.add(shikakari.JKeihi);
				pjSum.JSum = pjSum.JSum.add(shikakari.JSum);

				pjSum.KTanka = pjSum.KTanka.add(shikakari.KTanka);
				ktCount += sktCount;
				pjSum.MTanka = pjSum.MTanka.add(shikakari.MTanka);
				mtCount += smtCount;
				pjSum.JTanka = pjSum.JTanka.add(shikakari.JTanka);
				jtCount += sjtCount;
				//整数で丸める。小数点第一位を四捨五入
				if(shikakari.KTanka.compareTo(BigDecimal.ZERO)!=0){
					shikakari.KTanka = shikakari.KTanka
						.divide(BigDecimal.valueOf(sktCount), 0 , RoundingMode.HALF_UP);
				}
				if(shikakari.MTanka.compareTo(BigDecimal.ZERO)!=0){
				shikakari.MTanka = shikakari.MTanka
						.divide(BigDecimal.valueOf(smtCount), 0 , RoundingMode.HALF_UP);
				}
				if(shikakari.JTanka.compareTo(BigDecimal.ZERO)!=0){
				shikakari.JTanka = shikakari.JTanka
						.divide(BigDecimal.valueOf(sjtCount), 0 , RoundingMode.HALF_UP);
				}
				//挿入
				int insertcheck = jdbcManager.insert(shikakari).execute();
				//初期化
				sktCount = 0;
				smtCount = 0;
				sjtCount = 0;
				shikakari = new MonthlyGenka();
			}

		}
		//forを抜けたら最後にPJ合計を挿入
		pjSum.nendo = monthlyGenka.get(0).nendo;//年度は一番小さい年度
		pjSum.month = 0;//月はゼロ
		pjSum.themeGroup = themeGroup;
		pjSum.gkConditionCode = 403;//PJ合計
		if(pjSum.KTanka.compareTo(BigDecimal.ZERO)!=0){
			pjSum.KTanka = pjSum.KTanka
				.divide(BigDecimal.valueOf(ktCount), 0 , RoundingMode.HALF_UP);
		}
		if(pjSum.MTanka.compareTo(BigDecimal.ZERO)!=0){
			pjSum.MTanka = pjSum.MTanka
				.divide(BigDecimal.valueOf(mtCount), 0 , RoundingMode.HALF_UP);
		}
		if(pjSum.JTanka.compareTo(BigDecimal.ZERO)!=0){
			pjSum.JTanka = pjSum.JTanka
				.divide(BigDecimal.valueOf(jtCount), 0 , RoundingMode.HALF_UP);
		}
		//平均単価にも同じ値を格納。無駄カラムと化した。
		pjSum.averageTanka = pjSum.JTanka;
		//挿入処理
		int count = jdbcManager.insert(pjSum).execute();
	}

	/**
	 * 表示用にフォームを初期化する。
	 */
	private void initializeForm(List<MonthlyGenka> mgList) {
		//フォームにjspから貰ったデータが残っていると誤作動の原因になるため初期化
		gkDetailForm.mapItemsItems = new ArrayList<List<Map<String, Object>>>();

		//テーマ親番から売上計画を取得
		List<UriageKeikaku> ukList = jdbcManager
				.selectBySqlFile(UriageKeikaku.class, SqlFiles.GK_GET_UK_THEME_NO_SUM_FROM_THEME_GROUP, gk.themeGroup)
				.getResultList();
		//売上計画を整形
		List<FixedUk> fixedUkList = createFixedUkList(ukList);
		//開発体制を取得
		List<Kaihatsutaisei> kaihatsuTaisei =
				kaihatsutaiseiService.getKaihatsuTaisei(Integer.parseInt(gkDetailForm.gkId));
		//原価管理表に関連する工数と外注費を取得
		List<EmpMonthlyKousu> emkList = empMonthlyKousuService.getFromThemeGroup(gk.themeGroup);
		List<GaityuMonthlyCost> gmcList = gaityuMonthlyCostService.getFromThemeGroup(gk.themeGroup);
		int emkIndex = 0;
		int gmcIndex = 0;

		for(MonthlyGenka mg : mgList){
			List<Map<String, Object>> mapItems = new ArrayList<Map<String, Object>>();

			// 月別原価テーブルの値をマップに格納
			Map<String, Object> mgMap = new HashMap<String, Object>();
			mgMap.put("monthlyGenkaId", mg.monthlyGenkaId);
			mgMap.put("themeNo", mg.themeNo);
			mgMap.put("themeGroup", mg.themeGroup);
			mgMap.put("nendo", mg.nendo);
			mgMap.put("month", mg.month);
			mgMap.put("gkConditionCode", mg.gkConditionCode);
			mgMap.put("KRoumuhi", mg.KRoumuhi);
			mgMap.put("KKousu", mg.KKousu);
			//TODO 計画単価はマスタから取得
			mgMap.put("KTanka", mg.KTanka);
			mgMap.put("KGaityu", mg.KGaityu);
			mgMap.put("KRyohi", mg.KRyohi);
			mgMap.put("KSonota", mg.KSonota);
			mgMap.put("KKeihi", mg.KKeihi);
			mgMap.put("KSum", mg.KSum);
			mgMap.put("MRoumuhi", mg.MRoumuhi);
			mgMap.put("MKousu", mg.MKousu);
			mgMap.put("MTanka", mg.MTanka);
			mgMap.put("MGaityu", mg.MGaityu);
			mgMap.put("MRyohi", mg.MRyohi);
			mgMap.put("MSonota", mg.MSonota);
			mgMap.put("MKeihi", mg.MKeihi);
			mgMap.put("MSum", mg.MSum);
			mgMap.put("JRoumuhi", mg.JRoumuhi);
			mgMap.put("JKousu", mg.JKousu);
			mgMap.put("JTanka", mg.JTanka);
			mgMap.put("JGaityu", mg.JGaityu);
			mgMap.put("JRyohi", mg.JRyohi);
			mgMap.put("JSonota", mg.JSonota);
			mgMap.put("JKeihi", mg.JKeihi);
			mgMap.put("JSum", mg.JSum);
			mgMap.put("KMGap", mg.KMGap);
			mgMap.put("KJGap", mg.KJGap);
			mgMap.put("arari", mg.arari);
			mgMap.put("arariPar", mg.arariPar);

			//プロジェクト合計ならfixedUkの売上額合計を格納
			if(mg.gkConditionCode==403){
				BigDecimal uriage = BigDecimal.ZERO;
				for(FixedUk fixedUk:fixedUkList){
					uriage = uriage.add(fixedUk.uriage);
				}
				mgMap.put("uriage", uriage);
			}

			//仕掛り計ならfixedUkから年度、月が一致する要素を検索して売上を格納
			if(mg.gkConditionCode==402){
				for(FixedUk fixedUk:fixedUkList){
					if(mg.nendo==(fixedUk.nendo) && mg.month==fixedUk.month){
						mgMap.put("uriage", fixedUk.uriage);
						break;
					}
				}
			}

			// mapItemsの先頭mapItems[0]に月別原価情報を格納
			mapItems.add(mgMap);

			// 開発体制を格納
			// ソート順が正しくないとエラーとなる
			for(Kaihatsutaisei kt : kaihatsuTaisei ){
				Map<String, Object> ktMap = new HashMap<String, Object>();
				ktMap.put("gkId", kt.gkId);
				ktMap.put("empNo", kt.empNo);
				ktMap.put("shortEmpName", kt.empMaster.shortEmpName);
				ktMap.put("gaityuFlag", kt.gaityuFlag);
				ktMap.put("themeNo", mg.themeNo);
				ktMap.put("nendo", mg.nendo);
				ktMap.put("month", mg.month);
				ktMap.put("KKousu", 0);
				ktMap.put("MKousu", 0);
				ktMap.put("JKousu", 0);
				if(emkIndex < emkList.size() && kt.gaityuFlag==0){
					EmpMonthlyKousu emk = emkList.get(emkIndex);
					if(emk.empNo.equals(kt.empNo)
							&& emk.nendo.equals(mg.nendo) && emk.month.equals(mg.month)){
						ktMap.put("emkId", emk.emkId);
						ktMap.put("KKousu", emk.KKousu);
						ktMap.put("MKousu", emk.MKousu);
						ktMap.put("JKousu", emk.JKousu);
						emkIndex++;
					}
				} else if(gmcIndex < gmcList.size() && kt.gaityuFlag==1){
					GaityuMonthlyCost gmc = gmcList.get(gmcIndex);
					if(gmc.empNo.equals(kt.empNo)
							&& gmc.nendo.equals(mg.nendo) && gmc.month.equals(mg.month)){
						/*
						 * jspの処理簡易化のため、gaityuMonthlyCostテーブルの値も
						 * empMonthlyKousuテーブルと同じキーで登録している
						 * */
						ktMap.put("emkId", gmc.gmcId);
						ktMap.put("KKousu", gmc.KCost);
						ktMap.put("MKousu", gmc.MCost);
						ktMap.put("JKousu", gmc.JCost);
						gmcIndex++;
					}
				}
				//mapItems[1]以降に開発体制の情報を格納
				mapItems.add(ktMap);
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
//TODO 年度が上がるとおかしくなる。カレンダークラスに格納し直して判定すべき

		int ukIndex = 0;
		int mgIndex=0;
		int ukMaxIndex = fixedUkList.size();
		int mgMaxIndex= mgList.size();

		String ukCalStr = fixedUkList.get(ukIndex).nendo + "/" + fixedUkList.get(ukIndex).month;
		String mgCalStr = mgList.get(mgIndex).nendo + "/" + mgList.get(mgIndex).month;
		Calendar ukCal = StringUtil.converCalendarFromNendoString(ukCalStr);
		Calendar mgCal = StringUtil.converCalendarFromNendoString(mgCalStr);

		while(mgIndex < mgMaxIndex){

			//テーマNOを格納
			mgList.get(mgIndex).themeNo = fixedUkList.get(ukIndex).themeNo;

			//fixedUkの年月の方が新しいならmgの参照を進める
			if(ukCal.compareTo(mgCal) > 0){
				mgIndex++;
				mgCalStr = mgList.get(mgIndex).nendo + "/" + mgList.get(mgIndex).month;
				mgCal = StringUtil.converCalendarFromNendoString(mgCalStr);
			//mgの年月の方が新しいならfixedUkの参照を進める
			}else if(ukCal.compareTo(mgCal) < 0){
				ukIndex++;
				ukCalStr = fixedUkList.get(ukIndex).nendo + "/" + fixedUkList.get(ukIndex).month;
				ukCal = StringUtil.converCalendarFromNendoString(ukCalStr);
			}else{
				mgIndex++;
				if(mgIndex == mgMaxIndex)break;
				mgCalStr = mgList.get(mgIndex).nendo + "/" + mgList.get(mgIndex).month;
				ukIndex++;
				if(ukIndex == ukMaxIndex)break;
				ukCalStr = fixedUkList.get(ukIndex).nendo + "/" + fixedUkList.get(ukIndex).month;
				mgCal = StringUtil.converCalendarFromNendoString(mgCalStr);
				ukCal = StringUtil.converCalendarFromNendoString(ukCalStr);
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

		//テーマ親番から売上計画を取得
		List<UriageKeikaku> ukList = jdbcManager
				.selectBySqlFile(UriageKeikaku.class, SqlFiles.GK_GET_UK_THEME_NO_SUM_FROM_THEME_GROUP, gk.themeGroup)
				.getResultList();
		//売上計画を整形
		List<FixedUk> fixedUkList = createFixedUkList(ukList);
		//着手月を比較用にCalendarクラスに変換
		Calendar tyakusyuMonth = StringUtil.converCalendarFromString(gk.tyakusyuMonth);
		//fixedUkListから最新売上月を比較用にCalendarクラスに変換
		String latestUriageMonthStr = fixedUkList.get(fixedUkList.size()-1).nendo + "/" + fixedUkList.get(fixedUkList.size()-1).month;
		Calendar latestUriageMonth = StringUtil.converCalendarFromNendoString(latestUriageMonthStr);

		MonthlyGenka mg = monthlyGenka.get(0);
		String checkDateStr = mg.nendo + "/" + mg.month;
		Calendar checkDate = StringUtil.converCalendarFromNendoString(checkDateStr);
		//monthlyGenkatテーブルのうち、もっとも古いテーブルが着手月よりも新しい場合
		//着手月までの月別原価テーブルを作成する
		int insertLog = 0;
		while(checkDate.compareTo(tyakusyuMonth)>0){
			//一月戻る
			checkDate.add(Calendar.MONTH, -1);
			MonthlyGenka insert = new MonthlyGenka();
			insert.themeGroup = gk.themeGroup;
			insert.nendo = StringUtil.getNendoFromCalendar(checkDate);
			insert.month = checkDate.get(Calendar.MONTH)+1;
			insert.gkConditionCode = 401;//コード名称：月別
			insert.themeNo = "";
			//更新
			insertLog = jdbcManager.insert(insert).excludesNull().execute();
		}
		//checkDateを最新の月別原価テーブルに変更
		mg = monthlyGenka.get(monthlyGenka.size()-1);
		checkDateStr = mg.nendo + "/" + mg.month;
		checkDate = StringUtil.converCalendarFromNendoString(checkDateStr);

		//monthlyGenkatテーブルのうち、もっとも新しいテーブルが最新売上月よりも古い場合
		//最新売上月までの月別原価テーブルを作成する。
		while(checkDate.compareTo(latestUriageMonth)<0){
			//一月進める
			checkDate.add(Calendar.MONTH, 1);
			MonthlyGenka insert = new MonthlyGenka();
			insert.themeGroup = gk.themeGroup;
			insert.nendo = StringUtil.getNendoFromCalendar(checkDate);
			insert.month = checkDate.get(Calendar.MONTH)+1;
			insert.gkConditionCode = 401;//コード名称：月別
			insert.themeNo = "";
			//更新
			insertLog = jdbcManager.insert(insert).excludesNull().execute();
		}
		//テーブルを増やしたので一旦再取得
		//月別原価情報を取得
		if(insertLog!=0){
			monthlyGenka = monthlyGenkaService.findByGkIdIncludeDelete(Integer.parseInt(gkDetailForm.gkId));
		}

		for(int i = 0; i < monthlyGenka.size(); i++){
			mg = monthlyGenka.get(i);
			//mg.themeNo = "";//削除する際に、テーマNOから社員別月別工数を削除したいのでそのまま
			checkDateStr = mg.nendo + "/" + mg.month;
			checkDate = StringUtil.converCalendarFromNendoString(checkDateStr);
			//monthlyGenkaテーブルが着手月よりも古い場合は削除
			//monthlyGenkaテーブルが最新売上月よりも新しい場合も削除
			if(checkDate.compareTo(tyakusyuMonth)<0 || checkDate.compareTo(latestUriageMonth)>0){
				deleteMonthlyGenka(mg);
				//削除した月別原価テーブルをリストから除外する。リストのindexが詰め直されるので、iをデクリメント
				monthlyGenka.remove(i);
				i--;
			}else{
				//削除対象コードのテーブルがあるかもしれないので、ただしい期間に存在するテーブルのコードを月別：401に変更
				mg.gkConditionCode = 401;
			}
		}
		//不正データをすべて処理したらテーマNOを再付番
		setThemeNoToMonthlyGenka(monthlyGenka, fixedUkList);
		//月別原価情報をupdate
		//入力されている原価情報を間違ってもいじらないように
		int[] updateBatchLog = jdbcManager
				.updateBatch(monthlyGenka)
				.includes(MonthlyGenkaNames.themeNo(), MonthlyGenkaNames.gkConditionCode())
				.execute();
	}

	/**
	 * mgの工数と合計の計画見込実績値がすべて0ならテーブルを削除する
	 * どれかひとつでも0でないなら入力があるのでgkConditionCode=404:削除対象としてupdate
	 * 関連する社員別工数テーブル、外注別費用テーブルは挿入処理時に合計が0なら削除されているため、この処理では削除しない。
	 * @param mg
	 */
	private void deleteMonthlyGenka(MonthlyGenka mg) {

		BigDecimal sumCheck = mg.KSum.add(mg.MSum).add(mg.JSum);
		BigDecimal kousuCheck = mg.KKousu.add(mg.MKousu).add(mg.JKousu);
		int log;
		//月別原価テーブルに関連する社員別工数テーブル、外注別費用テーブルを検索
		List<EmpMonthlyKousu> emkList = empMonthlyKousuService.getListFromMonthlyGenka(mg);
		List<GaityuMonthlyCost> gmcList = gaityuMonthlyCostService.getListFromMonthlyGenka(mg);
		int[] logs;
		//工数も費用合計も0なら削除
		if(sumCheck.compareTo(BigDecimal.ZERO)==0 && kousuCheck.compareTo(BigDecimal.ZERO)==0){

			//関連テーブルがあれば削除
			if(!emkList.isEmpty()){
				logs = jdbcManager.deleteBatch(emkList).execute();
			}
			if(!gmcList.isEmpty()){
				logs = jdbcManager.deleteBatch(gmcList).execute();
			}
			log = monthlyGenkaService.delete(mg);
		//なにかしら入力がありそうなら削除対象テーブルに状態を移行
		//画面に表示されるけど、集計はされない。入力内容を確認して消してもらうことを前提としている。
		}else{
			mg.gkConditionCode = 404;//削除対象
			log = monthlyGenkaService.update(mg);
			//工数のみ入力がある場合、ここで更新をかけないとupdateが実施されない
			//関連テーブルがあれば更新
			if(!emkList.isEmpty()){
				logs = jdbcManager.updateBatch(emkList).execute();
			}
			if(!gmcList.isEmpty()){
				logs = jdbcManager.updateBatch(gmcList).execute();
			}
		}
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
