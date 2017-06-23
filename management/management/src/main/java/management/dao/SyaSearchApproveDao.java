package management.dao;

import java.util.List;

import management.dto.TakePcOutDto;
import management.entity.TakePcOut;
import management.parameter.TakePcOutParams;


public class SyaSearchApproveDao extends SyaCommonDao {

    final String PREFIX = "META-INF/sql/SyaSearchApprove/";

    /**
     * 未承認のテーブルをとってくるメソッド<br />
     * ページング対応　ページに該当する結果だけhistoryに格納する
     * @return
     */
    public List<TakePcOutDto> getUnapprovedRecords(int pageNumber) {
        return selectPagingSearch(PREFIX + "getUnapprovedRecords.sql", pageNumber);
    }
    
    /**
     * ページング処理のために、検索結果の行数を取得するメソッド<br />
     * 未承認検索showUnapprovedRecords用
     * @return
     */
    public long countUnapprovedRecords() {
        
        return getCountFromTakePcOut(PREFIX + "getUnapprovedRecords.sql");
    }

    /**
     * take_pc_outテーブルの更新を行う<br />
     * 承認もこのメソッドで対応している
     * 
     * @param takePcOut
     *            　エンティティ
     */
    public void updateTakePcOut(TakePcOut takePcOut) {

        jdbcManager.update(takePcOut).excludesNull().execute();
    }

    
    /**
     * take_pc_outテーブルの全件検索をするメソッド<br />
     * ページング対応　ページに該当する結果だけhistoryに格納する
     * @param pageNumber
     * @return
     */
    public List<TakePcOutDto> selectAllRecords(int pageNumber) {
        //ページ番号を渡してページング検索
        return selectPagingSearch(PREFIX + "selectAll.sql", pageNumber);
    }

    /**
     * ページング処理のために、検索結果の行数を取得するメソッド<br />
     * 全件検索showAll用
     * @return
     */
    public long countSelectAll() {
        
        return getCountFromTakePcOut(PREFIX + "selectAll.sql");
    }
    
    /**
     * take_pc_outの条件検索を行うメソッド
     * 
     * @param searchTakePcOutParameter
     *            条件の値を入れておくプロパティ
     * @return 検索結果
     */
    public List<TakePcOutDto> selectTakePcOut(int pageNumber, TakePcOutParams params) {

        return selectPagingSearch(pageNumber, params);
            

    }

}
