package management.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/** 
 * @author sse802563
 * base_masterの検索結果を受け取るエンティティ
 * 各要素はbase_masterテーブルの各カラムに対応している
 */
@Entity(name = "search")
@Table(name="base_master")
public class BaseMaster {
    
    public String itLabel;
    
    public String admin;
    
    public String user;
    
    @Temporal(TemporalType.DATE)
    public Date lendingDate;
    
    @Temporal(TemporalType.DATE)
    public Date collectionDate;
    
    @Temporal(TemporalType.DATE)
    public Date disposalDate;
    
    public String modelNumber;
    
    public String serialNumber;
    
    @Temporal(TemporalType.DATE)
    public Date delivery;
    
    public String os;
    
    public String wirelessLan;
    
    public String hddSpace;
    
    public String dataVolume;
    
    public String ipAddress;

    public String encryptionSoft;

    public String notes;
    
}
