package management.action;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;

import javax.annotation.Resource;

import management.form.SyaDaityoInputForm;
import management.logic.SyaDaityoInputLogic;
import org.seasar.struts.annotation.Execute;

import management.constant.SyaConstant;
import management.dto.UserDataDto;

import org.seasar.struts.annotation.ActionForm;

public class SyaDaityoInputAction {

    @Resource
    public UserDataDto userDataDto;

    @ActionForm
    @Resource
    protected SyaDaityoInputForm syaDaityoInputForm;

    @Resource
    public SyaDaityoInputLogic syaDaityoInputLogic;

    /**
     * 初期表示
     */
    @Execute(validator = false)
    public String index() {

        // 初期表示用データを取得
        initDaityoInput();

        syaDaityoInputForm.sya010msg = SyaConstant.sinkiTouroku;

        return "index.jsp";
    }

    /**
     * 登録画面で入力エラーを受け取った場合呼び出されるメソッド<br />
     * 入力途中のデータの再呼び出しなどをして、エラー用ページに遷移する
     */
    @Execute(validator = false)
    public String insertErr() {

        initDaityoInput();
        syaDaityoInputForm.sya010msg = SyaConstant.inputError;

        syaDaityoInputLogic.setDocumentRecords(syaDaityoInputForm);

        return "indexErr.jsp";
    }

    /**
     * 「あなたの更新履歴を表示」ボタンを押した時のメソッド
     * @throws UnsupportedEncodingException 
     * 
     */
    @Execute(validator = false)
    public String showPersonalRecords() throws UnsupportedEncodingException {

        // ログインユーザの社員名を取得
        syaDaityoInputForm.personnelName = userDataDto.personnelName;
        syaDaityoInputLogic.selectPersonalRecords(syaDaityoInputForm);
        
        //承認者名を社員名で取得
        syaDaityoInputLogic.setApproversData(syaDaityoInputForm);
        syaDaityoInputLogic.setApproverName(syaDaityoInputForm);
        
        syaDaityoInputForm.sya010msg = SyaConstant.kojinRireki;

        initDaityoInput();

        return "parsonalRecords.jsp";
    }

    /**
     * 「資料を追加」ボタンを押したときのメソッド
     * 
     * @return
     */
    @Execute(validator = true, input = "insertErr")
    public String addDocuments() {

        // 登録にはuserIdを使うので登録処理前に実行
        initDaityoInput();

        // take_documents_outテーブルに資料情報を登録
        syaDaityoInputLogic.insertDocuments(syaDaityoInputForm);

        // 紙媒体資料の持出データを再検索
        // List型の値を保持するのが大変だったため、再表示には再検索を行う
        syaDaityoInputLogic.setDocumentRecords(syaDaityoInputForm);

        syaDaityoInputForm.sya010msg = SyaConstant.addDocment;

        return "index.jsp";
    }

    /**
     * 台帳に登録ボタンを押した際のメソッド
     * 
     * @return
     */
    @Execute(validator = true, input = "insertErr")
    public String submit() {

        //持出物の入力がない場合、エラー処理を出力して登録画面に戻る
        if(syaDaityoInputLogic.checkBringObject(syaDaityoInputForm)==false){
            syaDaityoInputForm.sya010msg = SyaConstant.motidashiCkeck;
            this.initDaityoInput();
            return "indexErr.jsp";
        }
        
        //PCのITラベルについての入力チェック
        if(syaDaityoInputLogic.checkItLabel(syaDaityoInputForm) == false){
            syaDaityoInputForm.sya010msg = SyaConstant.itLabelError;
            this.initDaityoInput();
            return "indexErr.jsp";
        }
        
        //登録にはuserIdを使うので登録処理前に実行
        syaDaityoInputForm.userId = userDataDto.userId;

        // 紙媒体資料情報が入力されていたら登録する
        syaDaityoInputLogic.insertDocuments(syaDaityoInputForm);
        // 台帳情報を登録する
        syaDaityoInputLogic.insertTakePcOut(syaDaityoInputForm);

        // 登録情報の確認をする
        // tableIdから最新の台帳と紙媒体資料を取得
        resetDaityoAndDocuments();
        // 紙媒体資料の有無によって出力メッセージを切り替え
        checkDocumentIsEmpty();
        
        // 資料区分のマスタテーブルを表示用に取得
        syaDaityoInputLogic.getConditionMaster(syaDaityoInputForm);

        syaDaityoInputForm.sya010msg = SyaConstant.completeTouroku;

        return "details.jsp";
    }

    /**
     * 個人履歴の検索画面で修正ボタンを押した際のメソッド
     * 
     * @return
     */
    @Execute(validator = false)
    public String update() {
        syaDaityoInputLogic.setRecordFromTableId(syaDaityoInputForm);
        // 紙媒体資料の持出データを再検索
        // List型の値を保持するのが大変だったため、再表示には再検索を行う
        syaDaityoInputLogic.setDocumentRecords(syaDaityoInputForm);
        syaDaityoInputForm.sya010msg = SyaConstant.updateDaityo;
        syaDaityoInputForm.sya011msg = SyaConstant.noticeUpdateDocuments;
        initDaityoInput();

        return "update.jsp";
    }

    /**
     *　修正画面で「資料を追加」ボタンを押した際のメソッド
     * 
     * @return
     */
    @Execute(validator = true, input = "updateErr")
    public String addDocumentsToUpdate() {

        // 紙媒体資料を追加して、戻る画面は修正画面
        syaDaityoInputLogic.insertDocuments(syaDaityoInputForm);

        // 紙媒体資料の内容が変わる=テーブルに修正フラグが立つ
        syaDaityoInputLogic.updateDaityo(syaDaityoInputForm, 1);

        // tableIdから最新の台帳と紙媒体資料を取得
        resetDaityoAndDocuments();

        initDaityoInput();

        return "update.jsp";
    }

    /**
     * 修正画面で紙媒体資料の「削除」ボタンを押したときのメソッド
     * 
     * @return
     */
    @Execute(validator = false)
    public String deleteDocument() {

        // 紙媒体資料を削除して、戻る画面は修正画面
        syaDaityoInputLogic.deleteDocument(syaDaityoInputForm);

        // 紙媒体資料の内容が変わる=テーブルに修正フラグが立つ
        syaDaityoInputLogic.updateDaityo(syaDaityoInputForm, 1);

        // tableIdから最新の台帳と紙媒体資料を取得
        resetDaityoAndDocuments();

        initDaityoInput();

        syaDaityoInputForm.sya010msg = SyaConstant.deleteDocuments;
        return "update.jsp";
    }

    /**
     * 修正画面で紙媒体資料の「修正」ボタンを押したときのメソッド
     * 
     * @return
     */
    @Execute(validator = true, input="updateErr")
    public String updateDocument() {

        // 紙媒体資料を修正して、戻る画面は修正画面
        syaDaityoInputLogic.updateDocuments(syaDaityoInputForm);

        // 紙媒体資料の登録内容が変わる=テーブルに修正フラグが立つ
        syaDaityoInputLogic.updateDaityo(syaDaityoInputForm, 1);

        // tableIdから最新の台帳と紙媒体資料を取得
        resetDaityoAndDocuments();

        initDaityoInput();

        syaDaityoInputForm.sya011msg = SyaConstant.completeUpdateDocuments;
        return "update.jsp";
    }

    /**
     * 修正画面で「台帳を修正」ボタンを押した際のメソッド
     * 
     * @return
     */
    @Execute(validator = true, input = "updateErr")
    public String updateDaityo() {
        
        //TODO 苦肉の策。違う方法をもうちょっと検討
        syaDaityoInputForm.docName = "";
        
        //持出物の入力がない場合、エラー処理を出力して登録画面に戻る
        if(syaDaityoInputLogic.checkBringObject(syaDaityoInputForm)==false){
            syaDaityoInputForm.sya010msg = SyaConstant.motidashiCkeck;
            //最新の台帳の情報を改めて取得
            this.resetDaityoAndDocuments();
            this.initDaityoInput();
            return "update.jsp";
        }
        
        //PCのITラベルについての入力チェック
        if(syaDaityoInputLogic.checkItLabel(syaDaityoInputForm) == false){
            syaDaityoInputForm.sya010msg = SyaConstant.itLabelError;
          //最新の台帳の情報を改めて取得
            this.resetDaityoAndDocuments();
            this.initDaityoInput();
            return "update.jsp";
        }

        /*
         * 20170123バグ発見＆対応
         * 備考にコメントを買いて差し戻しをした後、修正を行うと備考の内容が消える
         * 修正処理の範囲に備考が含まれないように専用メソッドを用意
         */
        syaDaityoInputLogic.updateDaityoExcludesNotes(syaDaityoInputForm);
        syaDaityoInputForm.sya010msg = SyaConstant.completeUpdate;

        // tableIdから最新の台帳と紙媒体資料を取得
        this.resetDaityoAndDocuments();

        this.initDaityoInput();
        syaDaityoInputForm.sya011msg = SyaConstant.noticeUpdateDocuments;

        return "details.jsp";
    }
    
    @Execute(validator=false)
    public String updateErr(){
        update();
        syaDaityoInputForm.sya010msg=SyaConstant.inputError;
        return "update.jsp";
    }

    /**
     * 修正画面で「データを削除」ボタンを押した際のメソッド
     * 
     * @return
     */
    @Execute(validator = false)
    public String deleteDaityo() {

        syaDaityoInputLogic.deleteDaityo(syaDaityoInputForm.tableId);
        syaDaityoInputForm.sya010msg = SyaConstant.deleteDaityo;
        // tableIdから最新のtable情報を取得
        syaDaityoInputLogic.setRecordFromTableId(syaDaityoInputForm);

        // 最新の紙媒体資料情報を取得
        syaDaityoInputLogic.setDocumentRecords(syaDaityoInputForm);
        if (syaDaityoInputForm.documents.isEmpty()) {
            // 削除した台帳情報に関連する紙媒体資料の情報をすべて削除
            syaDaityoInputLogic.deleteAllDocuments(syaDaityoInputForm);
            syaDaityoInputForm.sya011msg = SyaConstant.deleteDocumentsFromDeleteDaityo;
        } else {
            syaDaityoInputForm.sya011msg = "紙媒体資料の持出はありませんでした。";
        }

        initDaityoInput();

        return "showDeleteDaityo.jsp";
    }

    /**
     * 「持出詳細」ボタンを押した際のメソッド
     * 
     * @return
     */
    @Execute(validator = false)
    public String details() {
        syaDaityoInputForm.sya010msg = SyaConstant.showDetails;
        // tableIdから最新の台帳と紙媒体資料を取得
        resetDaityoAndDocuments();
        // 紙媒体資料の有無によって出力メッセージを切り替え
        checkDocumentIsEmpty();

        initDaityoInput();
        return "details.jsp";
    }

    /**
     * 引用ボタンを押した際のメソッド
     * 
     * @return
     */
    @Execute(validator = false)
    public String quote() {

        // tableIdから最新のtable情報を取得
        syaDaityoInputLogic.setRecordFromTableId(syaDaityoInputForm);

        initDaityoInput();
        syaDaityoInputForm.sya010msg = SyaConstant.quoteDaityo;

        // tableIdだけは引用しない
        syaDaityoInputForm.tableId = "";
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
    public String syaSearchApprove() {

        return "/syaSearchApprove/";
    }

    /**
     * 初期表示、および入力フォームの表示を行う際に必ず呼ぶメソッド<br />
     * １．現在時刻の取得<br />
     * ２．ログインユーザIDの取得<br />
     * ３．各種マスタテーブルの取得<br />
     * ４．日付データのフォーマットを入力用に変更<br />
     * 以上を行う
     */
    private void initDaityoInput() {

        // 現在時刻を取得
        syaDaityoInputLogic.getTime(syaDaityoInputForm);

        // ログインユーザIDを取得
        syaDaityoInputForm.userId = userDataDto.userId;

        // 紙媒体資料の区分情報を取得
        syaDaityoInputLogic.getDocmentCategory(syaDaityoInputForm);

        // 日付データのフォーマットを入力用に修正
        syaDaityoInputLogic.convertDateFormatForInput(syaDaityoInputForm);
        
        try {
       // プルダウンリスト用にモバイルWi-FiのITラベルを取得
            syaDaityoInputLogic.selectWirelessLanFromSyanai(syaDaityoInputForm);
       // プルダウンリスト用に無線子機の管理番号を取得
            syaDaityoInputLogic.selectWirelessSlaveFromSyanai(syaDaityoInputForm);
        } catch (ParseException e) {
            // メインメソッドだしキャッチしてみる
            e.printStackTrace();
        }
        
        //プルダウンリスト判定用にモバイルWi-Fiマスタを取得
        syaDaityoInputLogic.getWirelessLanMaster(syaDaityoInputForm);
        
        // 無線子機マスタの情報を取得
        // syaDaityoInputLogic.getWirelessSlaveMaster(syaDaityoInputForm);

        // 状態区分のマスタテーブルを表示用に取得
        syaDaityoInputLogic.getConditionMaster(syaDaityoInputForm);

    }

    /**
     * 台帳の再表示を行いたいときに呼ぶメソッド<br />
     * TableIdから台帳と関連する紙媒体資料の再検索を行う<br />
     * jspからtableIdをとってくること、またinsertやupdateの前で使わないこと
     */
    private void resetDaityoAndDocuments() {
        // テーブルIDから該当する1件の台帳データをフォームに設定
        syaDaityoInputLogic.setRecordFromTableId(syaDaityoInputForm);
        // テーブルIDから台帳データにひもづく紙資料のデータを全て取得
        syaDaityoInputLogic.setDocumentRecords(syaDaityoInputForm);
    }

    /**
     * {@link SyaDaityoInputForm}.documentsが空がどうかを調べるメソッド<br />
     * documentsが空なら紙媒体資料の持出がないことを明示する
     */
    private void checkDocumentIsEmpty() {
        if (syaDaityoInputForm.documents == null) {
            syaDaityoInputForm.sya011msg = SyaConstant.nothingAnyDocuments;
        } else {
            syaDaityoInputForm.sya011msg = SyaConstant.showDocuments;
        }
    }
    
    
}
