package ug.action;

import static org.seasar.extension.jdbc.operation.Operations.*;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.seasar.extension.jdbc.JdbcManager;
import org.seasar.struts.annotation.ActionForm;
import org.seasar.struts.annotation.Execute;

import ug.constant.CommonConstant;
import ug.constant.GkConstant;
import ug.dto.UserDataDto;
import ug.entity.GenkaKanri;
import ug.entity.MonthlyGenka;
import ug.entity.MonthlyGenkaNames;
import ug.entity.ThemeMaster;
import ug.form.GkListForm;
import ug.service.GenkaKanriService;
import ug.service.ThemeMasterService;
import ug.util.StringUtil;

public class GkListAction {

	@Resource
	@ActionForm
	protected GkListForm gkListForm;

	@Resource
	public UserDataDto userDataDto;

	@Resource
	protected GenkaKanriService genkaKanriService;

	@Resource
	protected JdbcManager jdbcManager;

	@Resource
	protected ThemeMasterService themeMasterService;

	public List<GenkaKanri> gkList;

	public List<MonthlyGenka> nendoList;

	@Execute(validator = false)
	public String index(){

		//TODO 検証用にIDを権限を付与
		userDataDto.gkInsert = "1";

		gkList=new ArrayList<GenkaKanri>();

		/*
		 * monthly_genkaテーブルをnendoでgroupbyした年度データを取得する。
		 * 残念ながらsimpleWhereはgroupby句には対応していないらしい。
		 */
		//TODO 年度リストにとりあえずの値を挿入
		//nendoList = jdbcManager.selectBySql(MonthlyGenka.class, "select nendo from monthly_genka order by nendo").getResultList();
		nendoList=new ArrayList<MonthlyGenka>();
		for(int i=2016; i<2019; i++){
			MonthlyGenka mg = new MonthlyGenka();
			mg.nendo = i;
			nendoList.add(mg);
		}

		gkListForm.nendo = StringUtil.getCurrentNendo();

		gkList = genkaKanriService.getGkList(gkListForm.nendo);

		return "gkList.jsp";
	}

	/**
	 * 検索ボタンを押下したときの実行メソッド
	 * @return
	 */
	@Execute(validator=false)
	public String search(){
		//TODO 検証用にIDを権限を付与
		userDataDto.gkInsert = "1";

		gkList=new ArrayList<GenkaKanri>();

		/*
		 * monthly_genkaテーブルをnendoでgroupbyした年度データを取得する。
		 * 残念ながらsimpleWhereはgroupby句には対応していないらしい。
		 */
		//TODO 年度リストにとりあえずの値を挿入
		//nendoList = jdbcManager.selectBySql(MonthlyGenka.class, "select nendo from monthly_genka order by nendo").getResultList();
		nendoList=new ArrayList<MonthlyGenka>();
		for(int i=2016; i<2019; i++){
			MonthlyGenka mg = new MonthlyGenka();
			mg.nendo = i;
			nendoList.add(mg);
		}

		gkList = genkaKanriService.getGkList(gkListForm.nendo);

		return "gkList.jsp";
	}

	@Execute(input="gkList.jsp")
	public String newCreate(){
		//テーママスタにthemeNoが登録されているか確認する
		ThemeMaster check = themeMasterService.findById(gkListForm.themeNo);
		if(check == null){
			gkListForm.errMessage = CommonConstant.noThemeNoErr;
			return "gkList.jsp";
		}

		long count = jdbcManager.from(MonthlyGenka.class)
				.where(eq(MonthlyGenkaNames.themeNo(), gkListForm.themeNo))
				.getCount();

		//原価管理表が既に作られていないか確認する。
		if(count!=0){
			gkListForm.errMessage = GkConstant.duplicateGkId;
			return "gkList.jsp";
		}
		//TODO テーマNOだけ渡せれば良い。
		//フォームに同値があれば勝手にDIされた気がする

		return "/gkCreate/index";
	}
}
