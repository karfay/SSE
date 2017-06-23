package management.logic;

import javax.annotation.Resource;

import org.seasar.framework.beans.util.Beans;

import management.dao.KanWirelessSlaveDao;
import management.entity.WirelessSlaveMaster;
import management.form.KanWirelessSlaveForm;

/**
 * 無線子機管理ページのLogic
 * @author sse802563
 *
 */
public class KanWirelessSlaveLogic {
    
    @Resource
    public KanWirelessSlaveDao kanWirelessSlaveDao;
    
    WirelessSlaveMaster wirelessSlaveMaster = new WirelessSlaveMaster();

    /**
     * 無線子機マスタの情報を全件検索して取得するメソッド
     * @param kanWirelessSlaveForm
     */
    public void getWirelessSlaveMaster(KanWirelessSlaveForm kanWirelessSlaveForm) {
        
        kanWirelessSlaveForm.wirelessSlaveMaster = kanWirelessSlaveDao.getWirelessSlaveMaster();
    }

    /**
     * 無線子機マスタにinsert処理を行うメソッド
     * @param kanWirelessSlaveForm
     */
    public void insertWirelessSlaveMaster(
            KanWirelessSlaveForm kanWirelessSlaveForm) {
        Beans.copy(kanWirelessSlaveForm, wirelessSlaveMaster).excludesNull().execute();
        
        kanWirelessSlaveDao.insertWirelessSlaveMaster(wirelessSlaveMaster);
        
    }

    /**
     * 無線子機マスタにdelete処理を行うメソッド
     * @param kanWirelessSlaveForm
     */
    public void deleteWirelessSlaveMaster(
            KanWirelessSlaveForm kanWirelessSlaveForm) {
        Beans.copy(kanWirelessSlaveForm, wirelessSlaveMaster).excludesNull().execute();
        
        kanWirelessSlaveDao.deleteWirelessSlaveMaster(wirelessSlaveMaster);
        
    }

}
