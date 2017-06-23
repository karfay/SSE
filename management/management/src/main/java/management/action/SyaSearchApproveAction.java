package management.action;

import java.io.UnsupportedEncodingException;

import javax.annotation.Resource;

import management.form.SyaSearchApproveForm;
import management.logic.SyaSearchApproveLogic;
import management.constant.SyaConstant;
import management.dto.UserDataDto;

import org.seasar.framework.util.StringUtil;
import org.seasar.struts.annotation.Execute;
import org.seasar.struts.annotation.ActionForm;

/**
 * 社外持出台帳テーブル(take_pc_out)の検索と承認者権限による承認を行う
 * 
 * @author sse802563
 * 
 */
public class SyaSearchApproveAction {

    /**
     * セッションで持ってるDto
     */
    @Resource
    public UserDataDto userDataDto;

    @ActionForm
    @Resource
    protected SyaSearchApproveForm syaSearchApproveForm;

    @Resource
    public SyaSearchApproveLogic syaSearchApproveLogic;

    /**
     * 初期表示
     */
    @Execute(validator = false)
    public String index() {

        // 初期表示用メソッド
        getSearchFields();

        syaSearchApproveForm.sya020msg = SyaConstant.searchDaityo;

        /* 管理者ページは「未承認一覧ボタン」以外では遷移しないように変更
        // 管理者権限を持っているユーザは管理者用ページへ
        if (StringUtil.isNotEmpty(userDataDto.authorizations)
            && userDataDto.authorizations.equals("1")) {
            return "index.jsp";
        } else {
            // index2.jsp専用、承認者名を社員名に変換するメソッド
            syaSearchApproveLogic.setApproverName(syaSearchApproveForm);
            return "index2.jsp";
        }
        */
        return "index2.jsp";
    }

    /**
     * 「全件表示」ボタンを押した時のメソッド
     * 
     */
    @Execute(validator = false)
    public String showAll() {

        syaSearchApproveLogic.selectAllRecords(syaSearchApproveForm);

        syaSearchApproveLogic.setAllConditions(syaSearchApproveForm);
        
        syaSearchApproveForm.sya020msg = SyaConstant.showAll;

        getSearchFields();

        // 全件表示は承認が出来ない
        // index2.jsp専用、承認者名を社員名に変換するメソッド
        syaSearchApproveLogic.setApproverName(syaSearchApproveForm);
        return "index2.jsp";
    }

    /**
     * 未承認一覧ボタンを押した際のメソッド
     * 
     * @return
     */
    @Execute(validator = false)
    public String showUnapprovedRecords() {
        // 未承認データを検索する、結果が1件もない場合はそれが分かるような文言を表示
        syaSearchApproveLogic.setUnapprovedRecords(syaSearchApproveForm);
        checkDaityoIsEmptyForUnapprove();

        syaSearchApproveLogic.setUnapproveCondition(syaSearchApproveForm);
        
        getSearchFields();

        // 管理者権限を持っているユーザは管理者用ページへ
        if (StringUtil.isNotEmpty(userDataDto.authorizations)
            && userDataDto.authorizations.equals("1")) {
            // 承認フォームの初期値を取得
            getApproveFields();

            return "index.jsp";
        } else {
            // index2.jsp専用、承認者名を社員名に変換するメソッド
            syaSearchApproveLogic.setApproverName(syaSearchApproveForm);
            return "index2.jsp";
        }
    }

    /**
     * 承認ボタンを押した際のメソッド
     * 
     * @return
     */
    @Execute(validator = true, input = "index.jsp", urlPattern = "syaSearchApproveForm")
    public String approve() {

        syaSearchApproveLogic.approveRecords(syaSearchApproveForm);
        syaSearchApproveForm.sya020msg = SyaConstant.approveDaityo;

        // 未承認者一覧を表示
        syaSearchApproveLogic.setUnapprovedRecords(syaSearchApproveForm);

        // 承認フォームの初期値を取得
        getApproveFields();

        getSearchFields();
        
        syaSearchApproveLogic.setUnapproveCondition(syaSearchApproveForm);
        
        // ログインユーザIDを取得
        syaSearchApproveForm.userId = userDataDto.userId;

        return "index.jsp";
    }

    /**
     * 「詳細表示」ボタンを押した際のメソッド
     * 
     * @return
     */
    @Execute(validator = false)
    public String details() {
        syaSearchApproveForm.sya020msg = "詳細を表示します。";

        syaSearchApproveLogic.setRecordFromTableId(syaSearchApproveForm);

        // jspから受け取ったtableIdを元に紙媒体資料の持出データをとってくる
        syaSearchApproveLogic.setDocumentRecords(syaSearchApproveForm);
        if (syaSearchApproveForm.documents.isEmpty()) {
            syaSearchApproveForm.sya021msg = SyaConstant.nothingAnyDocuments;
        } else {
            syaSearchApproveForm.sya021msg = SyaConstant.showDocuments;
        }

        getSearchFields();
        getApproveFields();

        // ユーザ権限情報を取得
        syaSearchApproveForm.authorizations = userDataDto.authorizations;
        // ログインユーザIDを取得
        syaSearchApproveForm.userId = userDataDto.userId;
        return "details.jsp";
    }

    /**
     * 「この条件で検索」ボタンを押した際のメソッド
     * 
     * @return
     * @throws UnsupportedEncodingException 
     */
    @Execute(validator = false)
    public String search() throws UnsupportedEncodingException {
        // 条件検索の結果をFormに格納する
        syaSearchApproveLogic.setSearchResult(syaSearchApproveForm);
        // 検索結果によって表示する文言を変更
        checkDaityoIsEmpty();

        getSearchFields();

        //条件検索の一覧表示から簡易承認は出来ないように変更
        /*
        // 管理者権限を持っているユーザは管理者用ページへ
        if (StringUtil.isNotEmpty(userDataDto.authorizations)
            && userDataDto.authorizations.equals("1")) {
            // 承認フォームの初期値を取得
            getApproveFields();

            return "index.jsp";
        } else {
            // index2.jsp専用、承認者名を社員名に変換するメソッド
            syaSearchApproveLogic.setApproverName(syaSearchApproveForm);
            
            return "index2.jsp";
        }
        */
        // index2.jsp専用、承認者名を社員名に変換するメソッド
        syaSearchApproveLogic.setApproverName(syaSearchApproveForm);
        return "index2.jsp";
    }

    /**
     * 「差し戻し」ボタンを押した際のメソッド
     * 
     * @return
     * @throws UnsupportedEncodingException 
     */
    @Execute(validator = true, input = "details")
    public String remand() throws UnsupportedEncodingException {

        syaSearchApproveLogic.remandRecords(syaSearchApproveForm);
        syaSearchApproveForm.sya020msg = "差し戻しをしました。";
        
        //差し戻しテーブルの検索を行うための条件をセット
        syaSearchApproveLogic.setRemandConditon(syaSearchApproveForm);
        //セットした条件で検索
        syaSearchApproveLogic.setSearchResult(syaSearchApproveForm);

        /*
        // 管理者権限を持っているユーザは管理者用ページへ
        if (StringUtil.isNotEmpty(userDataDto.authorizations)
            && userDataDto.authorizations.equals("1")) {
            // 承認フォームの初期値を取得
            getApproveFields();

            return "index.jsp";
        } else {
            // index2.jsp専用、承認者名を社員名に変換するメソッド
            syaSearchApproveLogic.setApproverName(syaSearchApproveForm);
            return "index2.jsp";
        }
        */
        
        getSearchFields();
        syaSearchApproveLogic.setApproverName(syaSearchApproveForm);
        return "index2.jsp";
    }
    
    @Execute(validator=false)
    public String showPersonalRecords(){
        return "/syaDaityoInput/showPersonalRecords";
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
    public String syaDaityoInput() {

        return "/syaDaityoInput/";
    }

    /**
     * 入力フォームの表示を行う際に必ず呼ぶメソッド<br />
     * １．現在時刻の取得<br />
     * ２．ログインユーザIDの取得<br />
     * 以上を行う
     */
    private void getApproveFields() {

        // 現在時刻を取得
        syaSearchApproveLogic.getTime(syaSearchApproveForm);

        // ログインユーザIDを取得
        syaSearchApproveForm.userId = userDataDto.userId;

        // jspから日付データを受け取っているときは日付データのフォーマットを表示用に修正
        syaSearchApproveLogic.convertDateFormatForInput(syaSearchApproveForm);

        // 承認者の名前をフォームに格納するメソッド
        syaSearchApproveLogic.setApproversData(syaSearchApproveForm);

    }

    /**
     * 検索結果の表示に必要な処理を行うメソッド<br />
     * 各種マスタテーブルの取得を行う
     */
    private void getSearchFields() {

        // 紙媒体資料の情報を取得
        syaSearchApproveLogic.getDocmentCategory(syaSearchApproveForm);
        // 資料区分の情報を取得
        syaSearchApproveLogic.getConditionMaster(syaSearchApproveForm);

        // 承認者の名前をフォームに格納するメソッド
        syaSearchApproveLogic.setApproversData(syaSearchApproveForm);
    }

    /**
     * 検索結果の有無によって文言を変更するメソッド<br />
     * 検索結果がない場合は、なかったことを明示する
     */
    private void checkDaityoIsEmpty() {
        if (syaSearchApproveForm.historyDto.isEmpty()) {
            syaSearchApproveForm.sya020msg = SyaConstant.nothingAnyData;
        } else {
            syaSearchApproveForm.sya020msg = SyaConstant.showSearchResults;
        }
    }

    /**
     * 検索結果の有無によって文言を変更するメソッドの未承認検索版<br />
     * 検索結果がない場合は、なかったことを明示する
     */
    private void checkDaityoIsEmptyForUnapprove() {
        if (syaSearchApproveForm.historyDto.isEmpty()) {
            syaSearchApproveForm.sya020msg = SyaConstant.nothingAnyUnnaproveData;
        } else {
            syaSearchApproveForm.sya020msg = SyaConstant.showUnnapproveData;
        }
    }
}
