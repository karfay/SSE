package management.dao;

import java.util.List;

import javax.annotation.Resource;

import management.entity.WirelessSlaveMaster;
import org.seasar.extension.jdbc.JdbcManager;

/**
 * 無線子機管理ページのDao
 * @author sse802563
 *
 */
public class KanWirelessSlaveDao {

    @Resource
    public JdbcManager jdbcManager;
    
    /**
     * 無線子機マスタを全件検索するメソッド
     * @return 無線子機マスタのエンティティのリスト：List<WirelessSlaveMaster>
     */
    public List<WirelessSlaveMaster> getWirelessSlaveMaster() {
        return jdbcManager.from(WirelessSlaveMaster.class).getResultList();
    }

    
    /**
     * 無線子機マスタにinsert処理を行うメソッド
     * @param wirelessSlaveMaster
     */
    public void insertWirelessSlaveMaster(WirelessSlaveMaster wirelessSlaveMaster) {
        jdbcManager.insert(wirelessSlaveMaster).excludesNull().execute();        
    }


    /**
     * 無線子機マスタにdelete処理を行うメソッド
     * @param wirelessSlaveMaster
     */
    public void deleteWirelessSlaveMaster(WirelessSlaveMaster wirelessSlaveMaster) {
        jdbcManager.delete(wirelessSlaveMaster).execute();        
    }

}
