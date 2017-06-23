package management.entity;

import javax.persistence.Entity;
import javax.persistence.Id;

/*
 * wireless_lan_masterテーブルのエンティティ
 */
@Entity
public class WirelessLanMaster {
    
    public WirelessLanMaster(){        
    }
        /*
         * 電話番号
         * phone_number
         */
        @Id
        public String phoneNumber;
        
        /*
         * 機種
         * model
         */
        public String model;
        
        /*
         * プラン
         * plan
         */
        public String plan;
        
        /*
         * 機種PIN
         * pin_code
         */
        public String pinCode;
        
        /*
         * 製造番号
         * serial_number
         */
        public String serialNumber;
        
        /*
         * ITラベル
         * it_label
         */
        @Id
        public String itLabel;
        
        /*
         * 管理者名
         * admin
         */
        public String admin;
        
        /*
         * 部署名
         * post
         */
        public String post;
        
        /*
         * ICCID
         * iccid
         */
        public String iccid;
        
        /*
         * PIN解除コード
         * pin_release_code
         */
        public String pinReleaseCode;
        
        /**
         * 使用者
         * user
         */
        public String user;
}
