package management.entity;

import javax.persistence.Entity;
import javax.persistence.Id;


/**
 * 
 * @author sse802563
 * TakePcOutテーブルのエンティティ
 *
 */


@Entity
public class TakePcOut {
   
    public TakePcOut(){
    }
    
    /** 
     * table_ID
     * テーブルID
     */
    @Id
    public String tableId;
    
    /**
     * application_date
     * 申請日
     */
    public String appDate;
    
    /**
     * application_user
     * 申請者
     */
    public String appUser;
    
    /**
     * 開始日
     */
    public String startDate;
    
    /**
     * 終了日
     */
    public String endDate;
    
    /**
     * destination
     * 持ち出し先
     */
    public String dest;
    
    /**
     * PC管理番号
     */
    public String itLabel;
    
    /**
     * 無線LanのITラベル
     */
    public String wirelessLan;
    
    /**
     * フラッシュメモリの識別番号
     */
    public String flashMemory;
    
    /**
     * プロジェクト名
     */
    public String project;
    
    /**
     * approval_date
     * 承認日
     */
    public String approvalDate;
    
    /**
     * approver
     * 承認者
     */
    public String approver;
    
    /**
     * condition_code 状態コード
     */
    public String conditionCode;
    
    /**
     * notes 備考
     */
    public String notes;
    
    /**
     * other_media その他の持出物
     */
    public String otherMedia;
    
    /**
     * wireless_slave 無線子機
     */
    public String wirelessSlave;
}
