package management.dao;

import java.util.List;

import javax.annotation.Resource;

import org.seasar.extension.jdbc.JdbcManager;

import management.constant.SyaConstant;
import management.dto.SyaDaityoLookDto;
import management.dto.TakePcOutDto;
import management.entity.BaseMaster;
import management.entity.ConditionMaster;
import management.entity.DocumentCategoryMaster;
import management.entity.PersonnelMaster;
import management.entity.TakeDocumentsOut;
import management.entity.WirelessLanMaster;
import management.entity.WirelessSlaveMaster;
import management.parameter.TakePcOutParams;

public class SyaCommonDao {

    @Resource
    public JdbcManager jdbcManager;

    public final String commonPREFIX = "META-INF/sql/SyaCommon/";
    
    public final String daityoLookPREFIX = "META-INF/sql/SyaDaityoLook/";
    
    public final String daityoInputPREFIX = "META-INF/sql/SyaDaityoInput/";

    /**
     * documents_category_masterを全件取得したエンティティのリストを返すメソッド
     * 
     * @param documentsCategoryMaster
     * @return
     */
    public List<DocumentCategoryMaster> getDocmentCategory() {
        return jdbcManager.from(DocumentCategoryMaster.class).getResultList();

    }

    /**
     * condition_masterテーブルから全件取得した結果を返すメソッド
     * 
     * @return
     */
    public List<ConditionMaster> getConditionMaster() {
        return jdbcManager
            .from(ConditionMaster.class)
            .orderBy("condition_code")
            .getResultList();
    }
    
    /**
     * base_Masterテーブルから全件取得した結果を返すメソッド
     * @return List<BaseMaster>
     */
    public List<BaseMaster> getBaseMaster(){
        return jdbcManager.from(BaseMaster.class).orderBy("it_label").getResultList();
    }
    

    /**
     * TakePcOutテーブルからtableIdが引数のテーブルを検索して返すメソッド<br>
     * 検索結果は必ず1件のため、戻り値はListではなくEntityクラス
     * 
     * @param tableId
     *            syaCommonForm.tableIdを検索条件に利用
     * @return
     */
    public TakePcOutDto getRecordFromTableId(String tableId) {

        // このままSQL文を生成するとtableIdを数字としてSQL文を作ってしまう
        // tableIdはデータベースでも文字列として扱っているので、
        // 整合性を持たせるためにシングルクォーテーションで囲む
        tableId = "'" + tableId + "'";

        return jdbcManager.selectBySqlFile(
            TakePcOutDto.class,
            commonPREFIX + "getPersonnelName.sql",
            tableId).getSingleResult();
    }

    /**
     * take_documents_outテーブルからtable_idが引数と一致するものだけとってくるメソッド<br />
     * 削除状態のデータは取得しない
     * 
     * @param tableId
     * @return
     */
    public List<TakeDocumentsOut> getDocumentRecords(String tableId) {
        return jdbcManager.from(TakeDocumentsOut.class).where(
            "table_id = ? AND condition_code <> -1",
            tableId).getResultList();
    }

    /**
     * 承認者権限を持つユーザのデータをpersonnel_masterテーブルから取得するメソッド
     * 
     * @return personnel_master.authorizations=1のテーブル
     */
    public List<PersonnelMaster> selectApprovers() {

        return jdbcManager.selectBySqlFile(
            PersonnelMaster.class,
            commonPREFIX + "selectApprovers.sql").getResultList();

    }

    /**
     * ページング検索を行うメソッド<br />
     * 引数にページ番号がない場合は初期表示としてはじめからpageIndex件数分、検索結果を返す
     * 
     * @param filePath
     * @return
     */
    public List<TakePcOutDto> selectPagingSearch(String filePath) {
        return jdbcManager.selectBySqlFile(TakePcOutDto.class, filePath).limit(
            SyaConstant.pageIndex).offset(0).getResultList();

    }

    // TODO 全て共通対応予定　出来たら消す
    /**
     * ページング検索を行うメソッド<br />
     * 引数にページ番号がある場合は、そのページ番号に該当するレコードを返す
     * 
     * @param filePath
     * @param pageNumber
     */
    public List<TakePcOutDto> selectPagingSearch(String filePath, int pageNumber) {
        return jdbcManager.selectBySqlFile(TakePcOutDto.class, filePath).limit(
            SyaConstant.pageIndex).offset(
            SyaConstant.pageIndex * (pageNumber - 1)).getResultList();

    }

    public List<TakePcOutDto> selectPagingSearch(int pageNumber,TakePcOutParams params) {
        return jdbcManager
        .selectBySqlFile(TakePcOutDto.class,commonPREFIX + "conditionalSearch.sql",params)
        .limit(SyaConstant.pageIndex).offset(SyaConstant.pageIndex * (pageNumber - 1))
        .getResultList();
    }

    // TODO 全て共通対応予定　できたら消す
    /**
     * 与えられたsqlファイルの検索結果の行数を取得する、メソッド
     * 
     * @param filePath
     *            　sqlファイルの格納されているパス
     * @return　検索結果の行数
     */
    public long getCountFromTakePcOut(String filePath) {

        return jdbcManager.getCountBySqlFile(filePath);
    }

    public long getCountFromTakePcOut(TakePcOutParams params) {

        return jdbcManager.getCountBySqlFile(commonPREFIX
            + "conditionalSearch.sql", params);
    }

    /**
     * wireless_lan_masterを全件検索した結果を返すメソッド
     * @return List<WirelessLanMaster>
     */
    public List<WirelessLanMaster> getWirelessLanMaster() {
        return jdbcManager.from(WirelessLanMaster.class).orderBy("it_label").getResultList();
    }

    /**
     * listUpWirelessLan.sqlの記述を用いて、モバイルWi-Fiの使用状況を検索するメソッド
     * DaityoLookのみで使用していたが、DaityoInputで使うためにCommonに移動
     * @return
     */
    public List<SyaDaityoLookDto> listUpWirelessLan1() {
        return jdbcManager.selectBySqlFile(SyaDaityoLookDto.class, daityoLookPREFIX + "listUpWirelessLan.sql").getResultList();
    }
    
    /**
     * listUpWirelessLan2.sqlの記述を用いて、モバイルWi-Fiの使用状況を検索するメソッド
     * こちらは持出履歴のないデータをマスタテーブルから取り出す
     * DaityoLookのみで使用していたが、DaityoInputで使うためにCommonに移動
     * @return
     */
    public List<SyaDaityoLookDto> listUpWirelessLan2() {
        return jdbcManager.selectBySqlFile(SyaDaityoLookDto.class,daityoLookPREFIX + "listUpWirelessLan2.sql").getResultList();
    }

    /**
     * 無線子機マスタ（wireless_slave_master）を全件検索した結果を返すメソッド
     * @return
     */
    public List<WirelessSlaveMaster> getWirelessSlaveMaster() {
        return jdbcManager.from(WirelessSlaveMaster.class).getResultList();
    }

    /**
     * listUpWirelessSlave.sqlの記述を用いて、無線子機の使用状況を検索するメソッド
     * @return
     */
    public List<SyaDaityoLookDto> listUpWirelessSlave1() {
        return jdbcManager.selectBySqlFile(SyaDaityoLookDto.class, daityoLookPREFIX + "listUpWirelessSlave1.sql").getResultList();
    }

    /**
     * listUpWirelessSlave.sqlの記述を用いて、無線子機の使用状況を検索するメソッド
     * @return
     */
    public List<SyaDaityoLookDto> listUpWirelessSlave2() {
        return jdbcManager.selectBySqlFile(SyaDaityoLookDto.class, daityoLookPREFIX + "listUpWirelessSlave2.sql").getResultList();
    }

}
