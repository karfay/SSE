package management.action;

import javax.annotation.Resource;

import management.form.KanWirelessLanForm;
import management.logic.KanWirelessLanLogic;

import org.seasar.struts.annotation.Execute;

import management.constant.KanConstant;
import management.dto.UserDataDto;

import org.seasar.struts.annotation.ActionForm;

public class KanWirelessLanAction {

    @Resource
    public UserDataDto userDataDto;
    
    @ActionForm
    @Resource
    protected KanWirelessLanForm kanWirelessLanForm;
    
    @Resource
    public KanWirelessLanLogic kanWirelessLanLogic;
    
    /**
     * 初期表示
     * @return index.jsp
     */
    @Execute(validator=false)
    public String index(){
        
        //フォームで値を受け取っていると新規登録のフォームに値が入ってしまうのでクリアする
        kanWirelessLanForm.clear();
        
        //base_masterを全検索する
        kanWirelessLanLogic.getWirelessLanMaster(kanWirelessLanForm);
        
        //ユーザの権限情報を取得
        kanWirelessLanForm.authorizations = userDataDto.authorizations;
        
        return "index.jsp";
    }
    
    /**
     * 新規登録ボタンを押した時のアクション
     * @return index.jsp
     */
    @Execute(validator=true, input="indexErr")
    public String insert(){
        
                
        kanWirelessLanLogic.insertWirelessLanMaster(kanWirelessLanForm);
        
        //メッセージを挿入
        kanWirelessLanForm.msg01 = KanConstant.insert;
        return index();
    }
    
    /**
     * 新規登録がエラーになったときにエラーページに飛ぶ処理
     * @return
     */
    @Execute(validator=false)
    public String indexErr(){
        
        //base_masterを全検索する
        kanWirelessLanLogic.getWirelessLanMaster(kanWirelessLanForm);
        
        //ユーザの権限情報を取得
        kanWirelessLanForm.authorizations = userDataDto.authorizations;
        
        return "indexErr.jsp";
    }
    /**
     * index.jspで更新ボタンを押したときのアクション
     * 更新ページupdate.jspに遷移する
     * @return update.jsp
     */
    @Execute(validator=false)
    public String jumpUpdate(){
        
        //Formはindex.jspからhiddenでテーブルのキー情報を受け取っているので遷移するだけ
        kanWirelessLanLogic.copyOld(kanWirelessLanForm);
        
        return "update.jsp";
    }
    
    /**
     * 更新ボタンを押した時のアクション
     * @return update.jsp
     */
    @Execute(validator=true, input = "updateErr")
    public String update(){
        
        kanWirelessLanLogic.updateWirelessLanMaster(kanWirelessLanForm);
        
        //メッセージを挿入
        kanWirelessLanForm.msg01 = KanConstant.update;
        
        return index();
    }
    
    @Execute(validator=false)
    public String updateErr(){
        return "updateErr.jsp";
    }
    
    /**
     * 削除ボタンを押した時のアクション
     * @return index.jsp
     */
    @Execute(validator=false)
    public String delete(){
        
        kanWirelessLanLogic.deleteWirelessLanMaster(kanWirelessLanForm);
        
        //メッセージを挿入
        kanWirelessLanForm.msg01 = KanConstant.delete;
        
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
