package management.form;

import java.util.List;

import org.seasar.struts.annotation.DateType;
import org.seasar.struts.annotation.Msg;
import org.seasar.struts.annotation.Required;

import management.dto.PcMasterDto;
import management.entity.PcMaster;
import management.entity.PersonnelMaster;

public class KanPcForm {

    /*
     * 登録、修正の入力フォームを受け取る変数たち
     */
    
    /**
     * ITラベル
     * it_label
     */
    @Required
    public String itLabel;
    
    /**
     * 管理者
     * admin
     */
    public String admin;
    
    public String adminNumber;
    
    /**
     * 利用者
     * user 
     */
    public String user;
    
    public String userNumber;
    
    /**
     * 資産形態
     * assets_mode
     */
    public String assetsMode;

    /**
     * 利用開始日
     * start_date
     */
    @DateType(datePattern="yyyymmdd", msg=@Msg(key="errors.kanPcStartDate"))
    public String startDate;    

    /**
     * 利用終了日
     * end_date
     */
    @DateType(datePattern="yyyymmdd", msg=@Msg(key="errors.kanPcEndDate"))
    public String endDate;  

    /**
     * 終了予定日
     * scheduled_date
     */
    @DateType(datePattern="yyyymmdd", msg=@Msg(key="errors.kanPcScheduledDate"))
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
    
    /**
     * base_masterの検索結果を受け取るList
     */
    public List<PcMasterDto> pcMasterDto;        
    
    /**
     * personnel_masterの検索結果を受け取るリスト
     */
    public List<PersonnelMaster> personnelMaster;
    
    /**
     * update処理用
     */
    public PcMaster old;
    
    /**
     * エラー表示用
     */
    public String message;
    
}
