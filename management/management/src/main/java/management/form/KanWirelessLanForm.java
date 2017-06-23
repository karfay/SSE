package management.form;

import java.util.List;

import org.seasar.struts.annotation.Required;

import management.dto.WirelessLanMasterDto;
import management.entity.WirelessLanMaster;;

public class KanWirelessLanForm {
    
    /*
     * 新規登録、修正の入力フォームを受け取る変数たち
     */

    /*
     * 電話番号
     * phone_number
     */
    @Required
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
    @Required
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

    /**
     * WirelessLanMasterの検索結果を受け取るList
     */
    public List<WirelessLanMasterDto> wirelessLanMasterDto;

    /**
     * 処理メッセージを格納する
     */
    public String msg01;
    
    /**
     * 更新ページで旧テーブルの情報を受け取るフィールド
     */
    public WirelessLanMaster old;

    /**
     * 権限情報を格納するフィールド
     */
    public String authorizations;
    
    /**
     * フォームの要素をすべて空にするメソッド　nullではない
     */
    public void clear(){
        phoneNumber = "";
        model = "";
        plan = "";
        pinCode = "";
        serialNumber = "";
        itLabel = "";
        admin = "";
        post = "";
        iccid = "";
        pinReleaseCode = "";
        user = "";
    }

}
