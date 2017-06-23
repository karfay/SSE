package management.dto;

import management.entity.WirelessLanMaster;

/**
 * モバイルWi-Fiマスタ（Wireless_lan_master）の検索結果を格納する際表示用に社員マスタ（perssonnel_master）と結合して、社員番号から社員名を取り出す。<br />
 * その時に管理者氏名と使用者氏名を受け取るための検索結果受け取り用Dtoで、insertやupdateには使わず、selectの場合のみ使用する。
 * @author sse802563
 *
 */
public class WirelessLanMasterDto extends WirelessLanMaster {
    
    /**
     * 管理者氏名 admin_name
     */
    public String adminName;
    
    /**
     * 使用者氏名 user_name
     */
    public String userName;
}
