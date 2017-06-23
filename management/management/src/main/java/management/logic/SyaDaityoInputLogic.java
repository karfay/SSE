package management.logic;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;

import javax.annotation.Resource;

import org.seasar.framework.beans.util.Beans;

import management.dao.SyaDaityoInputDao;
import management.dto.SyaDaityoLookDto;
import management.entity.BaseMaster;
import management.entity.TakeDocumentsOut;
import management.entity.TakePcOut;
import management.form.SyaDaityoInputForm;
import management.util.ManagementStringUtil;
import java.util.Collections; 

public class SyaDaityoInputLogic extends SyaCommonLogic {

    @Resource
    public SyaDaityoInputDao syaDaityoInputDao;

    /**
     * 新規登録を行うメソッド<br />
     * 各エンティティのプロパティにSyaDaityoInput.Formの対応するフィールドの値を格納する
     */
    public void insertTakePcOut(SyaDaityoInputForm syaDaityoInputForm) {

        TakePcOut takePcOut = new TakePcOut();

        // 先に紙媒体資料テーブルにinsertしているときは、tableIdが格納されている
        // そうでなければ新規登録なのでtableIdを生成する
        if (syaDaityoInputForm.tableId.equals("")) {
            ManagementStringUtil.setTableId(syaDaityoInputForm);
        }

        // エンティティのオブジェクトに、jspからとってきたsYA010Fromの値を格納
        Beans
            .copy(syaDaityoInputForm, takePcOut)
            .excludesWhitespace()
            .execute();

        // insertでは必ず承認に関する項目はnullになる
        takePcOut.approvalDate = null;
        takePcOut.approver = null;

        super.convertFieldsForDaityo(takePcOut);

        syaDaityoInputDao.insertTakePcOut(takePcOut);
    }

    /**
     * ログインユーザの申請履歴を表示するメソッド
     * 
     * @param syaDaityoInputForm
     * @throws UnsupportedEncodingException 
     */
    public void selectPersonalRecords(SyaDaityoInputForm syaDaityoInputForm) throws UnsupportedEncodingException {
        // 個人履歴を検索できるように条件を整える
        // 社員名で検索
        syaDaityoInputForm.searchName = syaDaityoInputForm.personnelName;
        // 削除データ以外を対象に含める
        syaDaityoInputForm.includeApproved = "1";
        syaDaityoInputForm.includeCorrected = "1";
        syaDaityoInputForm.includeRemanded = "1";
        syaDaityoInputForm.includeUnapproved = "1";
        
        setSearchResult(syaDaityoInputForm);
        
        //urlを生成
        syaDaityoInputForm.pagingUrl = ManagementStringUtil.createPagingUrlForShowPersonalRecords();
    }

    /**
     * TakePcOutテーブルの修正を行うメソッド<br />
     * 承認状態のテーブルの修正を行うとconditionCode=2("修正")になり、再承認が必要になる<br />
     * flg=0なら台帳情報を修正する<br />
     * flg=1なら紙媒体資料の修正に伴って、台帳のconditionCodeを変更するだけ
     * 
     * @param syaDaityoInputForm
     * @param flg
     */
    public void updateDaityo(SyaDaityoInputForm syaDaityoInputForm, int flg) {
        TakePcOut takePcOut = new TakePcOut();

        // エンティティのオブジェクトtpoに、jspからとってきたsyaDaityoInputFormの値を格納
        Beans
            .copy(syaDaityoInputForm, takePcOut)
            .excludesWhitespace()
            .execute();

        // 修正を行ったら、承認項目をNULLにして未承認の状態に戻す
        takePcOut.approvalDate = null;
        takePcOut.approver = null;

        // 承認状態または差し戻し状態なら修正状態に変更
        if (takePcOut.conditionCode.equals("1")
            || takePcOut.conditionCode.equals("3")) {
            takePcOut.conditionCode = "2";
        }

        super.convertFieldsForDaityo(takePcOut);

        if (flg == 0) {
            syaDaityoInputDao.updateTakePcOut(takePcOut);
        } else {
            syaDaityoInputDao.updateTakePcOutExcludesNull(takePcOut);
        }
    }

    /**
     * 20170123バグ発見＆対応
     * 修正の際に備考を含まないように修正
     * @param form
     */
    public void updateDaityoExcludesNotes(SyaDaityoInputForm form){
        TakePcOut takePcOut = new TakePcOut();
        
        Beans.copy(form, takePcOut).excludesWhitespace().execute();
        
        // 修正を行ったら、承認項目をNULLにして未承認の状態に戻す
        takePcOut.approvalDate = null;
        takePcOut.approver = null;

        // 承認状態または差し戻し状態なら修正状態に変更
        if (takePcOut.conditionCode.equals("1")
            || takePcOut.conditionCode.equals("3")) {
            takePcOut.conditionCode = "2";
        }

        super.convertFieldsForDaityo(takePcOut);
        
        syaDaityoInputDao.updateTakePcOutExcludesNotes(takePcOut);
        
        
    }
    
    /**
     * take_documents_outテーブルに資料情報のみを登録するメソッド<br />
     * 登録が実行されると{@link SyaDaityoInputForm}のdocNameとcopiesを空白にする
     * 
     * @param syaDaityoInputForm
     */
    public void insertDocuments(SyaDaityoInputForm syaDaityoInputForm) {
        // docNameまたはcopies,categoryIdの入力がない場合はエラー
        // 「資料を追加」ボタンのときはバリデータでエラーをとらえるが、
        // 台帳に登録or修正するときは紙媒体資料の持出なしも許容するためこの処理でエラーを拾う
        if (syaDaityoInputForm.docName.equals("")
            && syaDaityoInputForm.copies.equals("")
            && syaDaityoInputForm.categoryId.equals("")) {
            syaDaityoInputForm.sya011msg = "紙媒体資料の入力が正しくありません。";
            syaDaityoInputForm.sya010msg = "紙媒体資料の追加でエラーが発生しています。";
            return;
        } else if (syaDaityoInputForm.docName.equals("")
            || syaDaityoInputForm.copies.equals("")
            || syaDaityoInputForm.categoryId.equals("")) {
            syaDaityoInputForm.sya011msg = "紙媒体資料の入力が正しくありません。";
            syaDaityoInputForm.sya010msg = "紙媒体資料の追加でエラーが発生しています。";
            return;
        }

        TakeDocumentsOut takeDocumentsOut = new TakeDocumentsOut();

        // 先に紙媒体資料テーブルにinsertしているときは、tableIdが格納されている
        // そうでなければ新規登録なのでtableIdを生成する
        if (syaDaityoInputForm.tableId.equals("")) {
            ManagementStringUtil.setTableId(syaDaityoInputForm);
        }

        // 用意したtableIdで登録されている紙媒体資料の情報を検索
        syaDaityoInputForm.documents = syaDaityoInputDao
            .getDocumentRecords(syaDaityoInputForm.tableId);

        // 同じtableIdで同名の資料が既に登録されていたらエラー
        for (TakeDocumentsOut document : syaDaityoInputForm.documents) {
            if (document.docName.equals(syaDaityoInputForm.docName)) {
                syaDaityoInputForm.sya011msg = document.docName
                    + "は既に登録されています。";
                syaDaityoInputForm.sya010msg = "紙媒体資料の追加でエラーが発生しています。";
                return;
            }
        }

        // エンティティのオブジェクトに、jspからとってきたsYA010Fromの値を格納
        Beans.copy(syaDaityoInputForm, takeDocumentsOut).execute();

        super.convertFieldsForDocuments(takeDocumentsOut);

        syaDaityoInputDao.insertTakeDocumentsOut(takeDocumentsOut);

        // 再表示の際に入力フォームに値を残さないように削除
        syaDaityoInputForm.docName = "";
        syaDaityoInputForm.copies = "";

        syaDaityoInputForm.sya011msg = "資料を追加しました。";
        syaDaityoInputForm.sya010msg = "修正しました。修正した申請には再承認が必要です。";

    }

    /**
     * takeDocumentOutテーブルの指定されたデータの削除フラグを立てるメソッド
     * 
     * @param syaDaityoInputForm
     */
    public void deleteDocument(SyaDaityoInputForm syaDaityoInputForm) {

        TakeDocumentsOut takeDocumentsOut = new TakeDocumentsOut();

        Beans.copy(syaDaityoInputForm, takeDocumentsOut).execute();
        // 状態コード-1は削除
        takeDocumentsOut.conditionCode = "-1";

        syaDaityoInputDao.updateTakeDocumentsOut(takeDocumentsOut);

    }

    /**
     * TakeDocumentsOutテーブルの指定されたデータの更新を行うメソッド
     * 
     * @param syaDaityoInputForm
     */
    public void updateDocuments(SyaDaityoInputForm syaDaityoInputForm) {

        //フォームの値を資料の持出台帳テーブル（take_documents_out）に対応する
        //エンティティにコピー
        TakeDocumentsOut takeDocumentsOut = new TakeDocumentsOut();
        Beans.copy(syaDaityoInputForm, takeDocumentsOut).execute();

        //全角→半角変換
        //TODO 入力フォームのime-mode制御で半角指定は半角以外受け付けなくなっているはずなので、調査して順次消して良い処理かも
        super.convertFieldsForDocuments(takeDocumentsOut);

        syaDaityoInputDao.updateTakeDocumentsOut(takeDocumentsOut);

    }

    /**
     * 引数のテーブルIDを用いて、TakePcOutテーブルのデータの削除フラグを立てるメソッド
     * 
     * @param tableId
     */
    public void deleteDaityo(String tableId) {

        TakePcOut takePcOut = new TakePcOut();

        takePcOut.tableId = tableId;
        takePcOut.conditionCode = "-1";

        syaDaityoInputDao.updateTakePcOutExcludesNull(takePcOut);
    }

    /**
     * {@link SyaDaityoInputForm}.documentsに含まれる紙媒体情報をすべて削除するメソッド
     * 
     * @param syaDaityoInputForm
     */
    public void deleteAllDocuments(SyaDaityoInputForm syaDaityoInputForm) {
        for (TakeDocumentsOut document : syaDaityoInputForm.documents) {
            // ↓もしかして仮登録してやっぱりやめたーってなった場合にも走るメソッドですか？
            // そうすると、本登録してから修正で消したものと区別が付かなくない？
            // 仮登録の場合データの保持する必要ないですよね？
            
            /*
             * 仮登録したデータは資料の持出台帳テーブル（take_documents_out）にそのまま登録される（condition_code=1）
             * ただし、持出台帳テーブル（take_pc_out）に持出情報が登録されなかった場合、
             * 資料データは持出データと（table_id）で紐付かないためシステムの検索結果に表示されることはない
             * 
             * 仮登録のデータはゴミデータとして資料の持出台帳テーブル（take_documents_out）にたまっていくが、
             * 検索結果に表示されることはない一方、登録後の削除済みデータは持出データがあり、検索に引っかかるため明確に区別ができる
             * 
             * あえて問題点を上げるならゴミデータが資料の持出台帳テーブル（take_documents_out）を単品で見た際に
             * ゴミデータと判断できないが、持出台帳テーブル（take_pc_out）と（table_id）で結合すれば除外できる
             */

            document.conditionCode = "-1";
            syaDaityoInputDao.updateTakeDocumentsOut(document);
        }

    }

    /**
     * 入力されたPCのITラベルをチェックするメソッド
     * @return boolean 
     * ITラベルが正しければ（マスタテーブルに存在する）Ture、誤りならばFalse
     */
    public boolean checkItLabel(SyaDaityoInputForm syaDaityoInputForm) {
        
        //TODO PCのマスタテーブル実装の目処が立たないため、一旦処理をスキップ
        //if(true)return true;
        //この記述を外せば入力チェックは動く
        
        // PCのITラベル欄に入力がなければtrueを返す
        if(("").equals(syaDaityoInputForm.itLabel)){
            return true;
        }
        
        //TODO 下の処理はitLabelの検索結果があるかないかで判断できるのでは？
        long result = syaDaityoInputDao.selectPcMasterFromItLabel(syaDaityoInputForm.itLabel);
        if(result == 1){
            return true;
        }
        else{
            return false;
        }
//        syaDaityoInputForm.baseMaster = syaDaityoInputDao.getBaseMaster();
//        
//        for(BaseMaster baseMaster: syaDaityoInputForm.baseMaster){
//           
//            //equalsで比較を行うため、対象となる変数がnullでないように確認
//            if(baseMaster.itLabel != null){
//                //入力されたITラベルがbase_masterのデータと一致したらtrueを返す
//                if(syaDaityoInputForm.itLabel.equals(baseMaster.itLabel)){
//                    return true;
//                }
//            }
//        }
//        //base_masterに入力されたITラベルが存在しなければ、不正入力とみなしてfalseを返す
//        return false;
    }
    
    /**
     * Fromに持出物に関する入力があるかチェックするメソッド
     * 持出物の入力が正しいかどうかは各種登録時に別途チェックをしている
     * @param syaDaityoInputForm
     * @return boolean
     * 持出物があればTure、なければFalse
     */
    public boolean checkBringObject(SyaDaityoInputForm syaDaityoInputForm){
        //PCのITラベルに入力があれば、持出物があるのでtrueを返す
        if(!("").equals(syaDaityoInputForm.itLabel)){
            return true;
        //無線LANのITラベルに入力があれば、持出物があるのでtrueを返す
        }else if(!("").equals(syaDaityoInputForm.wirelessLan)){
            return true;
        //無線子機の管理番号に入力があれば、持出物があるのでtrueを返す
        }else if(!("").equals(syaDaityoInputForm.wirelessSlave)){
            return true;
        //その他資料に入力があれば、持出物があるのでtrueを返す
        }else if(!("").equals(syaDaityoInputForm.otherMedia)){
            return true;
        //紙媒体資料の名前に入力があれば、持出物があるのでtrueを返す
        }else if(!("").equals(syaDaityoInputForm.docName)){
            return true;
        //紙媒体資料が登録されている場合、設定されているtableIdを使って紙媒体資料を検索する
        //検索した紙媒体資料の中に削除されていないデータがあれば、持出物はあるのでtrueを返す
        //検索した紙媒体資料全てに削除フラグが設定されていた場合、持出物はないのでFalseを返す
        }else{
            syaDaityoInputForm.documents = 
                syaDaityoInputDao.getDocumentRecordsIncludeDelete(syaDaityoInputForm.tableId);
            
            for(TakeDocumentsOut documents:syaDaityoInputForm.documents){
                if(!("-1").equals(documents.conditionCode)){
                    return true;
                }
            }
            
            return false;
            
        }
    }
    
    
    //TODO メソッド内容を変更（2016/09/01）運用チェックが終わったらこちらを消す
    /**
     * form.SyaDaityoLookDtoを使って、モバイルWi-Fiの持出状況を参照した後、社内にあるものだけを
     * 抽出してそのITラベルをform.wirelessLanMasterに格納するメソッド
     * 持出台帳の登録・修正時に、現在社内にあるモバイルWi-FiのITラベルのみを表示するために利用
     * @param syaCommonForm
     * @throws ParseException 
     */
    public void selectWirelessLanFromSyanai(SyaDaityoInputForm syaDaityoInputForm) throws ParseException{
        
        Date currentDate = new Date();
        
        syaDaityoInputForm.syaDityoLookDto = syaCommonDao.listUpWirelessLan1();
        //現在日時が最新の持出終了日よりも新しければ、社内にあるのでwirelessLanLabelsに追加
        for(SyaDaityoLookDto t : syaDaityoInputForm.syaDityoLookDto){
           if(currentDate.compareTo(ManagementStringUtil.toDate(t.maxEndDate)) > 0){
               syaDaityoInputForm.wirelessLanLabels.add(t.itLabel);
           }
       }
        
        //持出履歴のないモバイルWi-FiのITラベルをwirelessLanLabelsに追加
        syaDaityoInputForm.syaDityoLookDto = syaCommonDao.listUpWirelessLan2();
        for(SyaDaityoLookDto t : syaDaityoInputForm.syaDityoLookDto){
            syaDaityoInputForm.wirelessLanLabels.add(t.itLabel);
        }
        
        //並べ替え
        Collections.sort(syaDaityoInputForm.wirelessLanLabels);
    }
    
    //TODO 調整中
    /**
     * 上のメソッドの最新調整版
     * 処理全体をsql１本に任せるように変更
     */
    /*
    public void selectWirelessLanFromSyanai(SyaDaityoInputForm syaDaityoInputForm){
        syaDaityoInputForm.wirelessLanLabels = syaDaityoInputDao.listUpWirelessLan1();
    }
    */

    /**
     * form.SyaDaityoLookDtoを使って、無線子機の持出状況を参照した後、社内にあるものだけを
     * 抽出してそのITラベルをform.wirelessLanMasterに格納するメソッド
     * 持出台帳の登録・修正時に、現在社内にある無線子機の管理番号のみを表示するために利用
     * @param syaCommonForm
     * @throws ParseException 
     * @throws ParseException 
     */
    public void selectWirelessSlaveFromSyanai(SyaDaityoInputForm syaDaityoInputForm) throws ParseException {
        
        Date currentDate = new Date();
        
        syaDaityoInputForm.syaDityoLookDto = syaDaityoInputDao.listUpWirelessSlave1();
        for(SyaDaityoLookDto t : syaDaityoInputForm.syaDityoLookDto){
            if(currentDate.compareTo(ManagementStringUtil.toDate(t.maxEndDate)) > 0){
                syaDaityoInputForm.wirelessSlaveNumbers.add(t.itLabel);
            }
        }
        
        //持出履歴のないモバイルWi-FiのITラベルをwirelessLanLabelsに追加
        syaDaityoInputForm.syaDityoLookDto = syaDaityoInputDao.listUpWirelessSlave2();
        for(SyaDaityoLookDto t : syaDaityoInputForm.syaDityoLookDto){
            syaDaityoInputForm.wirelessSlaveNumbers.add(t.itLabel);
        }
        
        //並べ替え
        Collections.sort(syaDaityoInputForm.wirelessSlaveNumbers);
    }




}
