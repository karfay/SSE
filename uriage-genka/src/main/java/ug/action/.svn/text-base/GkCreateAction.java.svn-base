package ug.action;

import java.math.BigDecimal;
import java.util.List;

import javax.annotation.Resource;

import org.seasar.extension.jdbc.JdbcManager;
import org.seasar.framework.beans.util.Beans;
import org.seasar.struts.annotation.ActionForm;
import org.seasar.struts.annotation.Execute;

import ug.SqlFiles;
import ug.constant.GkConstant;
import ug.dto.GkDto;
import ug.dto.UserDataDto;
import ug.entity.EmpMaster;
import ug.entity.EmpMonthlyKousu;
import ug.entity.GaityuMonthlyCost;
import ug.entity.GenkaKanri;
import ug.entity.GenkaKanriNames;
import ug.entity.Kaihatsutaisei;
import ug.entity.UriageKeikaku;
import ug.form.GkCreateForm;
import ug.service.EmpMasterService;
import ug.service.EmpMonthlyKousuService;
import ug.service.GaityuMonthlyCostService;
import ug.service.GenkaKanriService;
import ug.service.KaihatsutaiseiService;
import ug.service.ThemeMasterService;

public class GkCreateAction {

	@Resource
	protected UserDataDto userDataDto;
	@Resource
	@ActionForm
	protected GkCreateForm gkCreateForm;
	@Resource
	protected JdbcManager jdbcManager;
	@Resource
	protected GenkaKanriService genkaKanriService;
	@Resource
	protected ThemeMasterService themeMasterService;
	@Resource
	protected EmpMasterService empMasterService;
	@Resource
	protected KaihatsutaiseiService kaihatsutaiseiService;
	@Resource
	protected EmpMonthlyKousuService empMonthlyKousuService;
	@Resource
	protected GaityuMonthlyCostService gaityuMonthlyCostService;

	public GkDto gk;

	/** 最新の売上年月。ボタンによって納期に設定できるようにする */
	public String latestUriageMonth;
	/** 最古の売上年月。ボタンによって着手月に設定できるようにする */
	public String earliestUriageMonth;

	/** PJ管理者の候補リスト */
	public List<EmpMaster> pjAdminList;
	/** PJリーダの候補リスト */
	public List<EmpMaster> pjLeaderList;
	/** PJメンバの候補リスト */
	public List<EmpMaster> pjMemberCandidate;
	/** 外注メンバの候補リスト */
	public List<EmpMaster> gaityuMemberCandidate;
	/** 登録されているのPJメンバのリスト */
	public List<EmpMaster> pjMemberList;
	/** 登録されているの外注メンバのリスト */
	public List<EmpMaster> gaityuMemberList;

	@Execute(validator=false)
	public String index(){

		//TODO 表示テストのためフォームに値を設定
		userDataDto.empNo="sse802563";
		gkCreateForm.gkId = "2";
		gkCreateForm.themeNo = "25401-5317";

		//gkIdがあれば更新用情報を取得する
		if(gkCreateForm.gkId!=null){

			gk = jdbcManager
					.selectBySqlFile(GkDto.class, SqlFiles.GK_GET_GK_FOR_UPDATE, gkCreateForm.gkId)
					.getSingleResult();

			pjAdminList = empMasterService.getPjAdminList();
			pjLeaderList = empMasterService.getPjLederList();
			pjMemberList = empMasterService.getPjMemberList(Integer.parseInt(gk.gkId));
			gaityuMemberList = empMasterService.getGaityuMemberList(Integer.parseInt(gk.gkId));
			pjMemberCandidate = empMasterService.getPjMemberCandidate(Integer.parseInt(gk.gkId));
			gaityuMemberCandidate = empMasterService.getGaityuMemberCandidate(Integer.parseInt(gk.gkId));

		}//themeNoがあれば新規作成用情報を取得する。
		else if(gkCreateForm.themeNo!=null){
			gk = jdbcManager
					.selectBySqlFile(GkDto.class, SqlFiles.GK_GET_GK_FOR_CREATE, gkCreateForm.themeNo)
					.getSingleResult();

			pjAdminList = empMasterService.getPjAdminList();
			pjLeaderList = empMasterService.getPjLederList();

		}

		//最新年月を取得
		setLatestUriageMonth(gk.themeGroup);

		return "gkCreate.jsp";
	}

	/**
	 * 原価管理表を新規作成ボタンを押下したときのメソッド
	 * @return
	 */
	@Execute(input="gkCreate.jsp")
	public String newCreate(){
		GenkaKanri insert = new GenkaKanri();
		Beans.copy(gkCreateForm, insert).excludesWhitespace().execute();
		insert.creater = userDataDto.empNo;
		insert.lastUpdater = userDataDto.empNo;
		//TODO テスト用無駄インサート排除
		//genkaKanriService.insert(insert);

		insert = genkaKanriService.findByThemeGroup(insert.themeGroup);
		gkCreateForm.gkId = String.valueOf(insert.gkId);

		gkCreateForm.sysMessage = GkConstant.createGenkaKanri;

		return "index";
	}

	/**
	 * 原価管理表を修正ボタンを押下したときのメソッド
	 * @return
	 */
	@Execute(input="gkCreate.jsp")
	public String update(){
		GenkaKanri update = new GenkaKanri();
		Beans.copy(gkCreateForm, update).excludesWhitespace().execute();
		update.lastUpdater = userDataDto.empNo;

		int log = jdbcManager.update(update).excludes(GenkaKanriNames.creater()).execute();

		update = genkaKanriService.findByThemeGroup(update.themeGroup);
		gkCreateForm.gkId = String.valueOf(update.gkId);

		gkCreateForm.sysMessage = GkConstant.createGenkaUpdate;

		return "/gkDetail/?gkId="+gkCreateForm.gkId;
	}

	/**
	 * プロジェクトメンバの追加ボタンを押下したときのメソッド
	 * @return
	 */
	@Execute(input="gkCreate.jsp")
	public String addPjMember(){
		Kaihatsutaisei insert = new Kaihatsutaisei();
		insert.gkId = Integer.parseInt(gkCreateForm.gkId);
		insert.empNo = gkCreateForm.pjMember;
		insert.gaityuFlag = 0;
		kaihatsutaiseiService.insert(insert);
		String insertName = empMasterService.findById(insert.empNo).empName;
		gkCreateForm.sysMessage = insertName + GkConstant.addPjMember;

		return "index";
	}

	/**
	 * 外注メンバの追加ボタンを押下したときのメソッド
	 * @return
	 */
	@Execute(input="gkCreate.jsp")
	public String addGaityuMember(){
		Kaihatsutaisei insert = new Kaihatsutaisei();
		insert.gkId = Integer.parseInt(gkCreateForm.gkId);
		insert.empNo = gkCreateForm.gaityuMember;
		insert.gaityuFlag = 1;
		kaihatsutaiseiService.insert(insert);
		String insertName = empMasterService.findById(insert.empNo).empName;
		gkCreateForm.sysMessage = insertName + GkConstant.addGaityuMember;

		return "index";
	}

	/**
	 * pjメンバを外すボタンを押したときのメソッド
	 * @return
	 */
	@Execute(input="gkCreate.jsp")
	public String deletePjMember(){
		//対象社員の当PJにおける工数情報を取得
		List<EmpMonthlyKousu> deleteMemberKousu =
				empMonthlyKousuService.getPjKousu(Integer.parseInt(gkCreateForm.gkId), gkCreateForm.deleteMember);

		//工数入力があるかチェック
		if(deleteMemberKousu!=null){
			for(EmpMonthlyKousu kousu : deleteMemberKousu){
				//null→0変換。原則null入力禁止なのでエラー回避用。
				if(kousu.JKousu==null)kousu.JKousu=BigDecimal.ZERO;
				if(kousu.MKousu==null)kousu.MKousu=BigDecimal.ZERO;
				if(kousu.KKousu==null)kousu.KKousu=BigDecimal.ZERO;
				//計画・見込・実績工数の和が0でないなら、工数入力があるので削除不可
				BigDecimal checksum = kousu.JKousu.add(kousu.MKousu).add(kousu.KKousu);
				if(checksum.compareTo(BigDecimal.ZERO)!=0){
					gkCreateForm.errMessage = GkConstant.deleteKousuCheckErr;
					return "index";
				}
			}
		}

		//開発体制テーブルから削除
		Kaihatsutaisei delete = new Kaihatsutaisei();
		delete.gkId = Integer.parseInt(gkCreateForm.gkId);
		delete.empNo = gkCreateForm.deleteMember;
		kaihatsutaiseiService.delete(delete);
		String deleteName = empMasterService.findById(delete.empNo).empName;
		gkCreateForm.sysMessage = deleteName + GkConstant.deleteMember;

		return "index";

		}

	/**
	 * 外注メンバを外すボタンを押したときのメソッド
	 * @return
	 */

	@Execute(input="gkCreate.jsp")
	public String deleteGaityuMember(){

		//対象の当PJにおける外注費情報を取得
		List<GaityuMonthlyCost> deleteMemberCost =
				gaityuMonthlyCostService.getPjCost(Integer.parseInt(gkCreateForm.gkId), gkCreateForm.deleteMember);
		//外注費入力があるかチェック
		if(deleteMemberCost!=null){
			for(GaityuMonthlyCost cost : deleteMemberCost){
				//null→0変換。原則null入力禁止なのでエラー回避用。
				if(cost.JCost==null)cost.JCost=BigDecimal.ZERO;
				if(cost.MCost==null)cost.MCost=BigDecimal.ZERO;
				if(cost.KCost==null)cost.KCost=BigDecimal.ZERO;
				//計画・見込・実績外注費の和が0でないなら、外注費入力があるので削除不可
				BigDecimal checksum = cost.JCost.add(cost.MCost).add(cost.KCost);
				if(checksum.compareTo(BigDecimal.ZERO)!=0){
					gkCreateForm.errMessage = GkConstant.deleteCostCheckErr;
					return "index";
				}
			}
		}

		//開発体制テーブルから削除
		Kaihatsutaisei delete = new Kaihatsutaisei();
		delete.gkId = Integer.parseInt(gkCreateForm.gkId);
		delete.empNo = gkCreateForm.deleteMember;
		kaihatsutaiseiService.delete(delete);
		String deleteName = empMasterService.findById(delete.empNo).empName;
		gkCreateForm.sysMessage = deleteName + GkConstant.deleteMember;

		return "index";
	}

	/**
	 * テーマ親番から、そのテーマ親番に関連する売上計画をすべて調査し、
	 * 最新の売上年月を返すメソッド。
	 * @param themeGroup
	 * @return
	 */
	private void setLatestUriageMonth(String themeGroup){

		List<UriageKeikaku> ukNendoSum = jdbcManager
				.selectBySqlFile(UriageKeikaku.class, SqlFiles.GK_GET_UK_NENDO_SUM_FROM_THEME_GROUP, themeGroup)
				.getResultList();

		UriageKeikaku uk = ukNendoSum.get(0);
		latestUriageMonth = String.valueOf(uk.nendo) + "/";
		//3,2,1,12,11,~5,4月の順で売上計画を確認し、値があればその月が最新の売上年月となる。
		//compareToは差を計算する。0と比べて差がない=0ということ。
		if(uk.ukMar.compareTo(BigDecimal.ZERO)!=0)latestUriageMonth += "03";
		else if(uk.ukFeb.compareTo(BigDecimal.ZERO)!=0)latestUriageMonth += "02";
		else if(uk.ukJan.compareTo(BigDecimal.ZERO)!=0)latestUriageMonth += "01";
		else if(uk.ukDec.compareTo(BigDecimal.ZERO)!=0)latestUriageMonth += "12";
		else if(uk.ukNov.compareTo(BigDecimal.ZERO)!=0)latestUriageMonth += "11";
		else if(uk.ukOct.compareTo(BigDecimal.ZERO)!=0)latestUriageMonth += "10";
		else if(uk.ukSep.compareTo(BigDecimal.ZERO)!=0)latestUriageMonth += "09";
		else if(uk.ukAug.compareTo(BigDecimal.ZERO)!=0)latestUriageMonth += "08";
		else if(uk.ukJul.compareTo(BigDecimal.ZERO)!=0)latestUriageMonth += "07";
		else if(uk.ukJun.compareTo(BigDecimal.ZERO)!=0)latestUriageMonth += "06";
		else if(uk.ukMay.compareTo(BigDecimal.ZERO)!=0)latestUriageMonth += "05";
		else if(uk.ukApr.compareTo(BigDecimal.ZERO)!=0)latestUriageMonth += "04";

		uk = ukNendoSum.get(ukNendoSum.size()-1);
		earliestUriageMonth = String.valueOf(uk.nendo) + "/";
		//4,5,6,~12,1,2,3月の順で売上計画を確認し、値があればその月が最古の売上年月となる。
		//compareToは差を計算する。0と比べて差がない=0ということ。
		if(uk.ukApr.compareTo(BigDecimal.ZERO)!=0)earliestUriageMonth += "04";
		else if(uk.ukMay.compareTo(BigDecimal.ZERO)!=0)earliestUriageMonth += "05";
		else if(uk.ukJun.compareTo(BigDecimal.ZERO)!=0)earliestUriageMonth += "06";
		else if(uk.ukJul.compareTo(BigDecimal.ZERO)!=0)earliestUriageMonth += "07";
		else if(uk.ukAug.compareTo(BigDecimal.ZERO)!=0)earliestUriageMonth += "08";
		else if(uk.ukSep.compareTo(BigDecimal.ZERO)!=0)earliestUriageMonth += "09";
		else if(uk.ukOct.compareTo(BigDecimal.ZERO)!=0)earliestUriageMonth += "10";
		else if(uk.ukNov.compareTo(BigDecimal.ZERO)!=0)earliestUriageMonth += "11";
		else if(uk.ukDec.compareTo(BigDecimal.ZERO)!=0)earliestUriageMonth += "12";
		else if(uk.ukJan.compareTo(BigDecimal.ZERO)!=0)earliestUriageMonth += "01";
		else if(uk.ukFeb.compareTo(BigDecimal.ZERO)!=0)earliestUriageMonth += "02";
		else if(uk.ukMar.compareTo(BigDecimal.ZERO)!=0)earliestUriageMonth += "03";


	}



}
