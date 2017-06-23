package management.dao;

import java.util.List;

import javax.annotation.Resource;

import org.seasar.extension.jdbc.JdbcManager;

import management.dto.WirelessLanMasterDto;
import management.entity.WirelessLanMaster;

public class KanWirelessLanDao {
    
    @Resource
    public JdbcManager jdbcManager;
    
    private final String KanPREFIX = "META-INF/sql/Kan/";

    /**
     * wireless_lan_masterを全件検索するメソッド
     * @return　検索結果のリスト
     */
    public List<WirelessLanMasterDto> selectAll() {
        
        return jdbcManager.selectBySqlFile(WirelessLanMasterDto.class, KanPREFIX+"selectAllWirelessLan.sql").getResultList();
    }

    /**
     * wireless_lan_masterに新規登録するメソッド
     * @param wirelessLanMaster　新規登録の情報を持ったマスタエンティティ
     */
    public void insert(WirelessLanMaster wirelessLanMaster) {
        
        jdbcManager.insert(wirelessLanMaster).execute();
        return;
        
    }

    /**
     * wireless_lan_masterを更新するメソッド
     * @param wirelessLanMaster　更新の情報を持ったマスタエンティティ
     */
    public void update(WirelessLanMaster wirelessLanMaster) {
        
        jdbcManager.update(wirelessLanMaster).execute();
        return;
        
    }

    /**
     * wireless_lan_masterを削除するメソッド
     * @param wirelessLanMaster　削除の情報を持ったマスタエンティティ
     */
    public void delete(WirelessLanMaster wirelessLanMaster) {
        
        jdbcManager.delete(wirelessLanMaster).execute();
        return;
    }


}
