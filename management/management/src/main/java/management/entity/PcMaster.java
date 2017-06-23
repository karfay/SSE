package management.entity;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class PcMaster {

    
    /**
     * ITラベル
     * it_label
     */
    @Id
    public String itLabel;
    
    /**
     * 管理者
     * admin
     */
    public String admin;
    
    /**
     * 利用者
     * user
     */
    public String user;
    
    /**
     * 資産形態
     * assets_mode
     */
    public String assetsMode;

    /**
     * 利用開始日
     * start_date
     */
    public String startDate;    

    /**
     * 利用終了日
     * end_date
     */
    public String endDate;  

    /**
     * 終了予定日
     * scheduled_date
     */
    public String scheduledDate;
    
    /**
     * メーカー
     * maker
     */
    public String maker;
    
    /**
     * 型番
     * model_number
     */
    public String modelNumber;
    
    /**
     * 製造番号
     * serial_number
     */
    public String serialNumber;
    
    /**
     * OS
     * os
     */
    public String os;
    
    /**
     * 無線LAN
     * wireless_lan
     */
    public String wirelessLan;

    /**
     * 暗号化ソフト
     * encryption
     */
    public String encryption;

    /**
     * 備考
     * notes
     */
    public String notes;
    
    /**
     * 調査用：更新者
     * update_user
     */
    public String updateUser;
    
    /**
     * 調査用：更新日
     * updateDate
     */
    public String updateDate;
}
