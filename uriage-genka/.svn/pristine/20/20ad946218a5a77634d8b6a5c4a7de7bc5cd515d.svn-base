package ug.action;



import java.util.List;

import javax.annotation.Resource;

import org.seasar.extension.jdbc.JdbcManager;
import org.seasar.framework.beans.util.Beans;
import org.seasar.struts.annotation.ActionForm;
import org.seasar.struts.annotation.Execute;

import ug.constant.ThemeMasterConstant;
import ug.dto.UserDataDto;
import ug.entity.ThemeMaster;
import ug.entity.ThemeMasterNames;
import ug.form.ThemeMasterForm;
import ug.service.ThemeMasterService;

public class ThemeMasterAction {


    public List<ThemeMaster> themeMasterItems;

    @ActionForm
    @Resource
    protected ThemeMasterForm themeMasterForm;

    @Resource
    protected ThemeMasterService themeMasterService;

    @Resource
    protected UserDataDto userDataDto;

    @Resource
    public JdbcManager jdbcManager;

    @Execute(validator = false)
    public String index() {

    	themeMasterForm.themeInsert = userDataDto.themeInsert;
    	themeMasterForm.themeUpdate = userDataDto.themeUpdate;

        themeMasterItems = themeMasterService.findAllOrderByUketsukeDate();

        return "list.jsp";
    }

    /**
     * 「削除」ボタン押下時のメソッド
     * テーマは物理削除される。
     * @return
     */
    @Execute(validator = false)
    public String delete() {
        ThemeMaster entity = Beans.createAndCopy(ThemeMaster.class, themeMasterForm)
        		.numberConverter("###,###", ThemeMasterNames.jutyuKingaku()).excludesWhitespace().execute();
        themeMasterService.delete(entity);
        themeMasterForm.sysMessage=ThemeMasterConstant.delete;
        index();
        return "list.jsp";
    }

    /**
     * 「新規作成」ボタンの実行メソッド
     * Beanの詰め替え時にexcludesWhitespace()をやらないと、空白文字列でテーブルが新規作成されるので注意。
     * @return
     */
    @Execute(input = "list.jsp")
    public String insert() {
        ThemeMaster entity = Beans.createAndCopy(ThemeMaster.class, themeMasterForm)
        		.numberConverter("###,###", ThemeMasterNames.jutyuKingaku()).excludesWhitespace().execute();
        //テーマNOの重複登録を検証
        if(themeMasterService.findById(entity.themeNo)!=null){
        	themeMasterForm.errMessage = ThemeMasterConstant.insertDuplicationErr;
        	return "list.jsp";
        }
        themeMasterService.insert(entity);
        //新規作成したテーマNOをフォームに記録
        themeMasterForm.newInsert = entity.themeNo;
        themeMasterForm.sysMessage=ThemeMasterConstant.insertList;
        index();
        return "list.jsp";
    }

    /**
     * 「更新」ボタン押下時のメソッド
     * 入力のない項目を除いて、更新処理を行う。
     * @return
     */
    @Execute(input = "list.jsp")
    public String update() {
        ThemeMaster entity = Beans.createAndCopy(ThemeMaster.class, themeMasterForm)
        		.numberConverter("###,###", ThemeMasterNames.jutyuKingaku()).excludesWhitespace().execute();
        themeMasterService.update(entity);
        //更新したテーマNOをフォームに記録
        themeMasterForm.newUpdate = entity.themeNo;
        themeMasterForm.sysMessage=ThemeMasterConstant.updateList;
        index();
        return "list.jsp";
    }
}