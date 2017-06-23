package management.action;

import javax.annotation.Resource;

import org.seasar.struts.annotation.ActionForm;
import org.seasar.struts.annotation.Execute;

import management.constant.KanConstant;
import management.dto.UserDataDto;
import management.form.KanWirelessSlaveForm;
import management.logic.KanWirelessSlaveLogic;

/**
 * 無線子機マスタの管理ページ
 * @author sse802563
 *
 */
public class KanWirelessSlaveAction {
    
    @Resource
    public UserDataDto userDataDto;
    
    @ActionForm
    @Resource
    protected KanWirelessSlaveForm kanWirelessSlaveForm;
    
    @Resource
    public KanWirelessSlaveLogic kanWirelessSlaveLogic;
    
    /**
     * 初期表示
     * @return index.jsp
     */
    @Execute(validator=false)
    public String index(){
        
        kanWirelessSlaveLogic.getWirelessSlaveMaster(kanWirelessSlaveForm);
        kanWirelessSlaveForm.authorizations = userDataDto.authorizations;
        
        return "index.jsp";
    }
    
    /**
     * 新規登録ボタンから値を受け取って、新規登録処理を行う
     * 値が不正な場合はhtmlで不正とポップアップを表示したい
     * @return index.jsp
     */
    @Execute(validator=true, input="indexErr")
    public String insert(){
        kanWirelessSlaveLogic.insertWirelessSlaveMaster(kanWirelessSlaveForm);
        kanWirelessSlaveForm.msg = KanConstant.insert;
        
        return index();
    }

    /**
     * 新規登録がエラーになったときにエラーページに飛ぶ処理
     * @return
     */
    @Execute(validator=false)
    public String indexErr(){
        index();  
        return "indexErr.jsp";
    }
    
    /**
     * 削除ボタンから値を受け取って、削除処理を行う
     * @return
     */
    @Execute(validator=false)
    public String delete(){
        kanWirelessSlaveLogic.deleteWirelessSlaveMaster(kanWirelessSlaveForm);
        kanWirelessSlaveForm.msg = KanConstant.delete;
        
        return index();
    }
    
    
    /**
     * ログアウトボタンを押した際のメソッド
     * 
     * @return
     */
    @Execute(validator = false)
    public String logout() {

        userDataDto.userId = null;

        return "/login/?redirect=true";
    }

    /**
     * メニュー画面へボタンを押した際のメソッド
     * 
     * @return
     */
    @Execute(validator = false)
    public String menu() {

        return "/menu/?redirect=true";
    }

}
