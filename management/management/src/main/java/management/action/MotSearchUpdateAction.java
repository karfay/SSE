package management.action;

import javax.annotation.Resource;

import management.constant.MotConstant;
import management.dto.UserDataDto;
import management.form.MotSearchUpdateForm;
import management.logic.MotSearchUpdateLogic;
import management.util.ManagementStringUtil;

import org.seasar.struts.annotation.ActionForm;
import org.seasar.struts.annotation.Execute;

public class MotSearchUpdateAction {
    @Resource
    public UserDataDto userDataDto;

    @ActionForm
    @Resource
    protected MotSearchUpdateForm motSearchUpdateForm;

    @Resource
    public MotSearchUpdateLogic motSearchUpdateLogic;

    /**
     * 初期表示
     */
    @Execute(validator = false)
    public String index() {

        // 初期表示メッセージ
        motSearchUpdateForm.motMsg = MotConstant.msg110;

        // 処理のマスター情報を取得
        motSearchUpdateLogic.setProcessMaster(motSearchUpdateForm);

        // 持込資料区分マスター情報の取得
        motSearchUpdateLogic.setMaterialCategoryMaster(motSearchUpdateForm);

        // 管理者権限をjspでチェックするためにフォームに格納
        if (userDataDto.authorizations == null) {
            motSearchUpdateForm.authorizations = "0";
        } else {
            motSearchUpdateForm.authorizations = userDataDto.authorizations;
        }

        return "index.jsp";
    }

    /**
     * 全件検索ボタンを押したときのメソッド
     * 
     * @return
     */
    @Execute(validator = true, input = "index.jsp")
    public String searchAll() {

        // 検索メッセージ
        motSearchUpdateForm.motMsg = MotConstant.msg120;

        // 入力された条件で検索した結果を格納
        motSearchUpdateLogic.setAllSearchResult(motSearchUpdateForm);

        // ユーザIDを取得
        motSearchUpdateForm.userId = userDataDto.userId;

        // 本日の日付を取得
        motSearchUpdateForm.time = ManagementStringUtil.getTime();

        // 管理者権限を持つユーザを検索
        motSearchUpdateLogic.setApprovers(motSearchUpdateForm);

        // 管理者権限をjspでチェックするためにフォームに格納
        if (userDataDto.authorizations == null) {
            motSearchUpdateForm.authorizations = "0";
        } else {
            motSearchUpdateForm.authorizations = userDataDto.authorizations;
        }

        return "index.jsp";
    }

    /**
     * 未承認一覧ボタンを押したときのメソッド
     * 
     * @return
     */
    @Execute(validator = false)
    public String searchUnapprovedRecords() {

        // 検索メッセージ
        motSearchUpdateForm.motMsg = MotConstant.msg130;

        // 未承認データを検索して、結果を格納
        motSearchUpdateLogic.setSearchResultUnapprove(motSearchUpdateForm);

        // ユーザIDを取得
        motSearchUpdateForm.userId = userDataDto.userId;

        // 本日の日付を取得
        motSearchUpdateForm.time = ManagementStringUtil.getTime();

        // 管理者権限を持つユーザを検索
        motSearchUpdateLogic.setApprovers(motSearchUpdateForm);

        // 管理者権限をjspでチェックするためにフォームに格納
        if (userDataDto.authorizations == null) {
            motSearchUpdateForm.authorizations = "0";
        } else {
            motSearchUpdateForm.authorizations = userDataDto.authorizations;
        }

        return "index.jsp";
    }

    /**
     * 期限切れデータを探すボタンを押したときのメソッド
     * 
     * @return
     */
    @Execute(validator = false)
    public String searchExpired() {

        // 検索メッセージ
        motSearchUpdateForm.motMsg = MotConstant.msg140;

        // 期限切れデータを検索して、結果を格納
        motSearchUpdateLogic.setSearchResultExpired(motSearchUpdateForm);

        // ユーザIDを取得
        motSearchUpdateForm.userId = userDataDto.userId;

        // 本日の日付を取得
        motSearchUpdateForm.time = ManagementStringUtil.getTime();

        // 管理者権限を持つユーザを検索
        motSearchUpdateLogic.setApprovers(motSearchUpdateForm);

        // 管理者権限をjspでチェックするためにフォームに格納
        if (userDataDto.authorizations == null) {
            motSearchUpdateForm.authorizations = "0";
        } else {
            motSearchUpdateForm.authorizations = userDataDto.authorizations;
        }

        return "index.jsp";
    }

    /**
     * 条件検索ボタンを押したときのメソッド
     * 
     * @return
     */
    @Execute(validator = true, input = "index.jsp")
    public String search() {

        // 検索メッセージ
        motSearchUpdateForm.motMsg = MotConstant.msg120;

        // 入力された条件で検索した結果を格納
        motSearchUpdateLogic.setSearchResult(motSearchUpdateForm);

        // ユーザIDを取得
        motSearchUpdateForm.userId = userDataDto.userId;

        // 本日の日付を取得
        motSearchUpdateForm.time = ManagementStringUtil.getTime();

        // 管理者権限を持つユーザを検索
        motSearchUpdateLogic.setApprovers(motSearchUpdateForm);

        // 管理者権限をjspでチェックするためにフォームに格納
        if (userDataDto.authorizations == null) {
            motSearchUpdateForm.authorizations = "0";
        } else {
            motSearchUpdateForm.authorizations = userDataDto.authorizations;
        }

        return "index.jsp";
    }

    /**
     * 詳細表示ボタンを押した際のメソッド
     * 
     * @return
     */
    @Execute(validator = true, input = "index.jsp")
    public String details() {

        // jspから受け取ったテーブルIDで、対象のデータを検索
        motSearchUpdateLogic.setMotikomiDaityoFromTableId(motSearchUpdateForm);

        // 処理のマスター情報を取得
        // 未処理の場合は返却・廃棄を選択するフォームが出現するため
        motSearchUpdateLogic.setProcessMaster(motSearchUpdateForm);

        // 管理者権限を持つユーザを検索
        // 管理者権限で詳細表示する場合は承認フォームが出現するため
        motSearchUpdateLogic.setApprovers(motSearchUpdateForm);

        // ユーザIDを取得
        motSearchUpdateForm.userId = userDataDto.userId;

        // 本日の日付を取得
        motSearchUpdateForm.time = ManagementStringUtil.getTime();
        
        

        // 管理者権限をjspでチェックするためにフォームに格納
        if (userDataDto.authorizations == null) {
            motSearchUpdateForm.authorizations = "0";
        } else {
            motSearchUpdateForm.authorizations = userDataDto.authorizations;
        }

        return "details.jsp";
    }

    /**
     * 終了対応入力ボタンを押した際のメソッド
     * 
     * @return
     */
    @Execute(validator = true, input = "detailsErr")
    public String process() {

        motSearchUpdateLogic.updateProcess(motSearchUpdateForm);

        // 詳細表示のための一連の処理を呼ぶ
        details();

        return "details.jsp";
    }

    /**
     * 持込承認ボタンを押した際のメソッド
     * 
     * @return
     */
    @Execute(validator = true, input = "detailsErr")
    public String bringApprove() {

        motSearchUpdateLogic.updateApprove(motSearchUpdateForm);

        // 詳細表示のための一連の処理を呼ぶ
        details();

        return "details.jsp";
    }

    /**
     * 持込差し戻しボタンを押した際のメソッド
     * 
     * @return
     */
    @Execute(validator = true, input = "detailsErr")
    public String bringRemand() {

        motSearchUpdateLogic.updateRemand(motSearchUpdateForm);

        // 詳細表示のための一連の処理を呼ぶ
        details();

        return "details.jsp";
    }
    
    
    /**
     * 終了対応承認ボタンを押した際のメソッド
     * 
     * @return
     */
    @Execute(validator = true, input = "detailsErr")
    public String processApprove() {

        motSearchUpdateLogic.updateApprove(motSearchUpdateForm);

        // 詳細表示のための一連の処理を呼ぶ
        details();

        return "details.jsp";
    }

    /**
     * 終了対応差し戻しボタンを押した際のメソッド
     * 
     * @return
     */
    @Execute(validator = true, input = "detailsErr")
    public String processRemand() {

        motSearchUpdateLogic.updateRemand(motSearchUpdateForm);

        // 詳細表示のための一連の処理を呼ぶ
        details();

        return "details.jsp";
    }

    /**
     * 持込情報修正ボタンを押した際のメソッド
     * 
     * @return
     */
    @Execute(validator = false)
    public String bringUpdate() {

        // 持込修正メッセージ
        motSearchUpdateForm.motMsg = MotConstant.msg150;

        // IDから持込情報を取得
        motSearchUpdateLogic.setMotikomiDaityoFromTableId(motSearchUpdateForm);

        // 処理のマスター情報を取得
        motSearchUpdateLogic.setProcessMaster(motSearchUpdateForm);

        // 持込資料区分マスター情報の取得
        motSearchUpdateLogic.setMaterialCategoryMaster(motSearchUpdateForm);
        
        //DBから取り出した日付データにはハイフンが付いているため
        //入力用に日付データのハイフンを削除する
        motSearchUpdateForm.bringDate = ManagementStringUtil.convertDateFormatForInput(motSearchUpdateForm.bringDate);
        motSearchUpdateForm.scheduledDate = ManagementStringUtil.convertDateFormatForInput(motSearchUpdateForm.scheduledDate);
        

        return "update.jsp";
    }

    /**
     * 持込情報修正ボタンを押した際のメソッド
     * 
     * @return
     */
    @Execute(validator = true, input="updateErr")
    public String bringUpdateExecute() {

        motSearchUpdateForm.motMsg = MotConstant.msg160;

        motSearchUpdateLogic.bringUpdate(motSearchUpdateForm);
        
     // 詳細表示のための一連の処理を呼ぶ
        details();

        return "details.jsp";
    }
    
    /**
     * 持込情報修正ページで入力エラーがあったとき、エラーページに遷移する処理
     * @return
     */
    @Execute(validator=false)
    public String updateErr(){
        
        // 処理のマスター情報を取得
        motSearchUpdateLogic.setProcessMaster(motSearchUpdateForm);

        // 持込資料区分マスター情報の取得
        motSearchUpdateLogic.setMaterialCategoryMaster(motSearchUpdateForm);
        
        
        return "updateErr.jsp";
    }
    
    /**
     * 詳細表示画面で終了対応処理の入力や承認をした際に
     * 入力エラーが発生した時に呼ばれるメソッド
     * エラーページへ遷移する
     * @return
     */
    @Execute(validator=false)
    public String detailsErr(){
        details();
        return "detailsErr.jsp";
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
     * 登録画面へボタンを押した際のメソッド
     * 
     * @return
     */
    @Execute(validator = false)
    public String motDaityoInput() {

        return "/motDaityoInput/";
    }
}
