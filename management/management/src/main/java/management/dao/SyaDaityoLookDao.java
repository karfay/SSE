package management.dao;

import java.util.List;

import javax.annotation.Resource;

import org.seasar.extension.jdbc.JdbcManager;

import management.dto.SyaDaityoLookDto;

public class SyaDaityoLookDao extends SyaCommonDao {
    
    @Resource
    public JdbcManager jdbcManager;
    
    final String PREFIX = "META-INF/sql/SyaDaityoLook/";

    /*
     * listUpPc.sqlの記述を用いて、PCの使用状況を検索するメソッド
     */
    public List<SyaDaityoLookDto> listUpPc1() {
        return jdbcManager.selectBySqlFile(SyaDaityoLookDto.class,PREFIX + "listUpPc.sql").getResultList();
    }
    
    public List<SyaDaityoLookDto> listUpPc2() {
        return jdbcManager.selectBySqlFile(SyaDaityoLookDto.class,PREFIX + "listUpPc2.sql").getResultList();
    }

    //TODO Commonに同じ機能のメソッドをおいて呼び出したがNullPointerExceptionでエラーになった
    // またDaityoInputからCommonのメソッドを呼んでもエラーにならない
    // こちらでオーバーライトすれば対応できたため、これで解決にするけど、暇があれば要調査
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
