package management.logic;

import javax.annotation.Resource;

import org.seasar.framework.beans.util.Beans;

import management.dao.KanWirelessLanDao;
import management.entity.WirelessLanMaster;
import management.form.KanWirelessLanForm;

public class KanWirelessLanLogic {
    
    @Resource
    KanWirelessLanDao kanWirelessLanDao;

    /**
     * wirelee_lan_masterの全権検索の結果をFormのList<WirelessLanMaser>に格納するメソッド
     * @param kanWirelessLanForm
     */
    public void getWirelessLanMaster(KanWirelessLanForm kanWirelessLanForm) {
        kanWirelessLanForm.wirelessLanMasterDto = kanWirelessLanDao.selectAll();
        return;
    }

    /**
     * wireless_lan_masterにFormから受け取ったテーブル情報をもとに新規テーブルをinsertするメソッド
     * @param kanWirelessLanForm
     */
    public void insertWirelessLanMaster(KanWirelessLanForm kanWirelessLanForm) {
        // Formの入力をマスタエンティティに格納
        // null値はコピーしないように除外
        WirelessLanMaster wirelessLanMaster = new WirelessLanMaster();
        Beans.copy(kanWirelessLanForm, wirelessLanMaster).excludesNull().execute();
        
        kanWirelessLanDao.insert(wirelessLanMaster);
        return;
    }

    /**
     * wireless_lan_masterをFormから受け取ったテーブル情報をもとに更新するメソッド
     * @param kanWirelessLanForm
     */
    public void updateWirelessLanMaster(KanWirelessLanForm kanWirelessLanForm) {
        // Fromの入力をマスタエンティティに格納
        WirelessLanMaster wirelessLanMaster = new WirelessLanMaster();
        Beans.copy(kanWirelessLanForm, wirelessLanMaster).excludesNull().execute();
        
        kanWirelessLanDao.update(wirelessLanMaster);
        return;
    }

    /**
     * wireless_lan_masterのテーブルをFormから受け取ったテーブル情報をもとにdeleteするメソッド
     * @param kanWirelessLanForm
     */
    public void deleteWirelessLanMaster(KanWirelessLanForm kanWirelessLanForm) {
        // 削除テーブルの情報をマスタエンティティに格納
        WirelessLanMaster wirelessLanMaster = new WirelessLanMaster();
        Beans.copy(kanWirelessLanForm, wirelessLanMaster).execute();
        kanWirelessLanDao.delete(wirelessLanMaster);
        return;
        
    }

    /**
     * フォームで入力された情報をoldにコピーするメソッド
     * @param kanWirelessLanForm
     */
    public void copyOld(KanWirelessLanForm kanWirelessLanForm) {
        kanWirelessLanForm.old = new WirelessLanMaster();
        Beans.copy(kanWirelessLanForm, kanWirelessLanForm.old).execute();
        return;
        
    }

}
