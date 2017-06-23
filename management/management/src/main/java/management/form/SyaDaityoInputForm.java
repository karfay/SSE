package management.form;

import java.util.ArrayList;
import java.util.List;

public class SyaDaityoInputForm extends SyaCommonForm {

    /** historyリストのインデックス（添え字）を格納する */
    public int historyIndex;

    /**
     * 操作履歴等の確認メッセージ表示用（ほぼデバッグ用）
     */
    public String sya010msg;

    /**
     * エラーメッセージ表示用（ほぼデバッグ用）
     */
    public String sya011msg;
    
    /**
     * プルダウンリストで表示するモバイルWi-FiのITラベルを格納するリスト
     */
    public List<String> wirelessLanLabels = new ArrayList<String>();
    
    /**
     * プルダウンリストで表示する無線子機の管理番号を格納するリスト
     */
    public ArrayList<String> wirelessSlaveNumbers = new ArrayList<String>();

}