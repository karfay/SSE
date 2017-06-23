package management.action;

import javax.annotation.Resource;

import management.form.MotDaityoInputForm;
import management.logic.MotDaityoInputLogic;
import management.util.ManagementStringUtil;

import org.seasar.struts.annotation.Execute;

import management.constant.MotConstant;
import management.dto.UserDataDto;

import org.seasar.struts.annotation.ActionForm;

/**
 * Mot:社内持込管理システム<br />
 * 持込資料の登録を行う画面（初期画面）
 * @author sse802563
 *
 */
public class MotDaityoInputAction {
    
    @Resource
    public UserDataDto userDataDto;

    @ActionForm
    @Resource
    protected MotDaityoInputForm motDaityoInputForm;

    @Resource
    public MotDaityoInputLogic motDaityoInputLogic;

    
    /**
     * 初期表示
     */
    @Execute(validator = false)
    public String index() {
        
        //初期表示メッセージ
        motDaityoInputForm.motMsg = MotConstant.msg010;
        
        //処理のマスター情報を取得
        motDaityoInputLogic.setProcessMaster(motDaityoInputForm);
        
        //持込資料区分マスター情報の取得
        motDaityoInputLogic.setMaterialCategoryMaster(motDaityoInputForm);
        
        //ユーザIDを取得
        motDaityoInputForm.userId = userDataDto.userId;
        
        //フォームの初期値用に現在時刻を取得
        motDaityoInputForm.time=ManagementStringUtil.getTime();
        
        
        return "index.jsp";
    }

    /**
     * 登録ボタンを押したときのメソッド
     * @return
     */
    @Execute(validator = true, input = "indexErr")
    public String insert() {
        
        //初期表示メッセージ
        motDaityoInputForm.motMsg = MotConstant.msg020;
        
        //処理のマスター情報を取得
        motDaityoInputLogic.setProcessMaster(motDaityoInputForm);
        
        //持込資料区分マスター情報の取得
        motDaityoInputLogic.setMaterialCategoryMaster(motDaityoInputForm);
        
        //ユーザIDを取得
        motDaityoInputForm.userId = userDataDto.userId;
        
        //台帳への登録処理
        motDaityoInputLogic.insertDaityo(motDaityoInputForm);
        
        //登録したデータを検索
        motDaityoInputLogic.setMotikomiDaityoFromTableId(motDaityoInputForm);

        return "/motSearchUpdate/details.jsp";
    }
    
    /**
     * 登録がエラーになった時のメソッド
     * メッセージを変更して、エラー用ページに遷移する
     * @return
     */
    @Execute(validator = false)
    public String indexErr(){
        
        //エラーメッセージ
        motDaityoInputForm.motMsg = MotConstant.msg000;
        
        //処理のマスター情報を取得
        motDaityoInputLogic.setProcessMaster(motDaityoInputForm);
        
        //持込資料区分マスター情報の取得
        motDaityoInputLogic.setMaterialCategoryMaster(motDaityoInputForm);
        
        //ユーザIDを取得
        motDaityoInputForm.userId = userDataDto.userId;
        
        //本日の日付を取得
        motDaityoInputForm.time = ManagementStringUtil.getTime();

        return "indexErr.jsp";
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

    /**
     * 検索・承認画面へボタンを押した際のメソッド
     * 
     * @return
     */
    @Execute(validator = false)
    public String motSearchUpdate() {

        return "/motSearchUpdate/";
    }
    
}
