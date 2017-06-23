package management.entity;

import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * 無線子機マスタwireless_slave_masterのエンティティ
 * @author sse802563
 *
 */
@Entity
public class WirelessSlaveMaster {
    
    public WirelessSlaveMaster(){
        
    }
    
    /**
     * 管理番号：number
     * 主キー
     */
    @Id
    public String number;
}
