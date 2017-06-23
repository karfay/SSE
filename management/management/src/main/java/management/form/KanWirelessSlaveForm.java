package management.form;

import java.util.List;

import org.seasar.struts.annotation.IntegerType;
import org.seasar.struts.annotation.Required;

import management.entity.WirelessSlaveMaster;

/**
 * 無線子機マスタのフォーム
 * @author sse802563
 *
 */
public class KanWirelessSlaveForm {
    public KanWirelessSlaveForm(){
        
    }
    
    /**
     * 管理番号：number
     * 必須かつ整数
     */
    @IntegerType(target="insert")
    @Required(target="insert")
    public String number;
    
    /**
     * 検索結果を格納するエンティティのリスト
     */
    public List<WirelessSlaveMaster> wirelessSlaveMaster;
    
    /**
     * メッセージ表示用のフォーム
     */
    public String msg;

    /**
     * 管理者権限の有無
     */
    public String authorizations;
}
