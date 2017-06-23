package management.action;

import management.form.KanPersonnelForm;
import management.logic.KanPersonnelLogic;
import management.dto.UserDataDto;
import org.seasar.struts.annotation.ActionForm;
import javax.annotation.Resource;
import org.seasar.struts.annotation.Execute;

public class KanPersonnelAction {
    
    @Resource
    public UserDataDto userDataDto;
    
    @ActionForm
    @Resource
    public KanPersonnelForm kanPersonnelForm;
    
    @Resource
    public KanPersonnelLogic kanPersonnelLogic;
    
    /**
     * 初期表示
     * @return
     */
    @Execute(validator=false)
    public String index(){
        
        //表示用に権限を取得
        kanPersonnelForm.condAuthorizations = userDataDto.authorizations;
        
        //社員マスタを全件取得
        kanPersonnelLogic.getPersonnelMaster(kanPersonnelForm);
        
        return "index.jsp";
    }
    
    /**
     * 登録ボタンを押した時の処理
     * @return
     */
    @Execute(validator=true, input="insertErr")
    public String insert(){
        //社員マスタにinsert処理を行う
        kanPersonnelLogic.insertPersonnelMaster(kanPersonnelForm);
        return index();
    }

    /**
     * 登録ボタンを押した時、入力エラーがあった場合に呼ばれる
     * @return
     */
    @Execute(validator=false)
    public String insertErr(){
        //表示用の処理
        index();  
        return "indexErr.jsp";
    }
    
    /**
     * 修正ボタンを押した時の処理
     * @return
     */
    @Execute(validator=false)
    public String jumpUpdate(){
        //更新前のデータを表示用に取得
        kanPersonnelLogic.copyOld(kanPersonnelForm);
        return "update.jsp";
    }
    
    /**
     * 修正ページupdate.jspで修正ボタンを押した時の処理
     * @return
     */
    @Execute(validator=false)
    public String update(){
        
        return "index.jsp";
    }
    
    /**
     * 削除ボタンを押した時の処理
     * @return
     */
    @Execute(validator=false)
    public String delete(){
        
        kanPersonnelLogic.deletePersonnelMaster(kanPersonnelForm);
        
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
