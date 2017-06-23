package management.dao;

import java.util.List;


import management.dto.SyaDaityoLookDto;
import management.dto.TakePcOutDto;
import management.entity.PcMaster;
import management.entity.TakeDocumentsOut;
import management.entity.TakePcOut;
import management.form.SyaDaityoInputForm;

public class SyaDaityoInputDao extends SyaCommonDao {

    /**
     * takePcOutに格納されている情報をtake_pc_outテーブルにインサートするメソッド
     * 
     * @param takePcOut
     */
    public void insertTakePcOut(TakePcOut takePcOut) {
        jdbcManager.insert(takePcOut).execute();
    }


    /**
     * take_pc_outテーブルからユーザ名が引数と一致するものだけとってくるメソッド<br />
     * 削除状態のデータは取得しない
     * 
     * @param syaDaityoInputForm
     * @return　検索結果
     */
    public List<TakePcOutDto> selectPersonalRecords(SyaDaityoInputForm syaDaityoInputForm) {

        
        //状態コード-1は削除
        //削除状態のデータは取得しない
        return jdbcManager
            .selectBySqlFile(TakePcOutDto.class,
                "META-INF/sql/SyaDaityoInput/selectPersonalRecords.sql", syaDaityoInputForm)
                .getResultList();

    }

    /**
     * take_pc_outテーブルの更新を行う<br />
     * 
     * @param takePcOut
     */
    public void updateTakePcOut(TakePcOut takePcOut) {
        jdbcManager.update(takePcOut).execute();
    }

    /**
     * TakePcOutテーブルのフラグ処理（conditionCodeの変更）を行うメソッド<br />
     * updateTakePcOut()とはNULLの場合、そのカラムをinsert対象に含めない点が異なる
     * @param takePcOut
     */
    public void updateTakePcOutExcludesNull(TakePcOut takePcOut) {
        
        jdbcManager.update(takePcOut).excludesNull().execute();
        
    }
    
    /**
     * takeDocumentsOutに格納されている値を、take_documents_outテーブルにインサートするメソッド
     * 
     * @param takeDocumentsOut
     */
    public void insertTakeDocumentsOut(TakeDocumentsOut takeDocumentsOut) {
        autoIncrementDocId(takeDocumentsOut);
        jdbcManager.insert(takeDocumentsOut).execute();

    }

    /**
     * 引数takeDocumentOutのdocIdを一意に決定するメソッド<br />
     * docIdは１つのtableIdに対して0,1,2,3,4,,,,と決定されていく
     * 
     * @param takeDocumentsOut
     */
    private void autoIncrementDocId(TakeDocumentsOut takeDocumentsOut) {
        
        // 引数から与えられたtableIdをもとにtake_documents_outを検索して、そのテーブル数をdocIdにする
        long tmp = jdbcManager.from(TakeDocumentsOut.class)
            .where("tableId = ?", takeDocumentsOut.tableId).getCount();
        
        takeDocumentsOut.docId = String.valueOf(tmp);
    }

    /**
     * 対象のTakeDocumentsOutテーブルの状態を削除にするメソッド
     * conditioCodeを-1に更新する
     */
    public void updateTakeDocumentsOut(TakeDocumentsOut takeDocumentsOut) {
        
        jdbcManager.update(takeDocumentsOut).execute();

    }
    
    /**
     * take_documents_outテーブルからtable_idが引数と一致するものだけとってくるメソッド<br />
     * 削除状態のデータは取得しない
     * @param tableId
     * @return
     */
    public List<TakeDocumentsOut> getDocumentRecords(String tableId) {
        return jdbcManager.from(TakeDocumentsOut.class).where(
            "table_id = ? AND condition_code <> -1",
            tableId).getResultList();
    }

    /**
     * take_documents_outテーブルからtable_idが引数と一致するものだけとってくるメソッド<br />
     * 削除状態のデータを含めてすべて取得する
     * @param tableId
     * @return
     */
    public List<TakeDocumentsOut> getDocumentRecordsIncludeDelete(String tableId) {
        return jdbcManager.from(TakeDocumentsOut.class).where(
            "table_id = ?", tableId).getResultList();
    }


    /**
     * pc_materを引数のit_labelで検索した結果を返す
     * 戻り値はlongで1なら検索結果がある、0なら検索結果はない
     * @param itLabel
     */
    public long selectPcMasterFromItLabel(String itLabel) {
        return jdbcManager.from(PcMaster.class).where("it_label = ?", itLabel).getCount();
        
    }


    /**
     * take_pc_outテーブルの備考以外を更新する処理
     * @param takePcOut
     */
    public void updateTakePcOutExcludesNotes(TakePcOut takePcOut) {
        jdbcManager.update(takePcOut).excludes("notes").execute();
        
    }
 
    //TODO sqlに不具合あり
    /**
     * 持出し可能なモバイルWi-Fiの使用状況を検索するメソッド
     * @return
     */
    /*
    public List<String> listUpWirelessLan1() {
        return jdbcManager.selectBySqlFile(String.class, daityoInputPREFIX + "findAvailableWirelessLan.sql").getResultList();
    }
    */
    //TODO 上のメソッドで一本化できたら、削除予定
    /**
     * listUpWirelessLan2.sqlの記述を用いて、モバイルWi-Fiの使用状況を検索するメソッド
     * こちらは持出履歴のないデータをマスタテーブルから取り出す
     * DaityoLookのみで使用していたが、DaityoInputで使うためにCommonに移動
     * @return
     */
    /*
    public List<SyaDaityoLookDto> listUpWirelessLan2() {
        return jdbcManager.selectBySqlFile(SyaDaityoLookDto.class,daityoLookPREFIX + "listUpWirelessLan2.sql").getResultList();
    } 
    */
}
