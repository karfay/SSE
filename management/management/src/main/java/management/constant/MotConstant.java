package management.constant;

/**
 * Mot:社内持込管理システム<br />
 * メッセージなどの定数を管理するクラス
 * @author sse802563
 *
 */
public class MotConstant {

    public MotConstant(){
        
    }
    
    /**
     * 検索結果として一度に表示するテーブル数
     */
    public static final int pageIndex = 10;
    
    /**
     * 新規登録の初期表示メッセージ
     */
    public static final String msg010 =  "持込台帳へ新規申請を行います。";
    
    /**
     * 登録エラーのメッセージ
     */
    public static final String msg000 = "入力エラーがあります";
    
    /**
     * 新規登録の完了メッセージ
     */
    public static final String msg020 = "登録しました。\n登録結果を表示します。";
    
    /**
     * 検索・更新ページの初期メッセージ
     */
    public static final String msg110 = "持込台帳の検索を行います。";
    
    /**
     * 全件検索のメッセージ
     */
    public static final String msg120 = "全件表示します。";
    
    /**
     * 未承認データの検索メッセージ
     */
    public static final String msg130 = "未承認一覧を表示します";
    
    /**
     * 期限切れデータの検索メッセージ
     */
    public static final String msg140 = "持込終了予定日が過ぎたデータを表示します。";
    
    /**
     * 修正画面の初期メッセージ
     */
    public static final String msg150 = "持込情報の修正を行います。";
    
    /**
     * 修正結果の表示用メッセージ
     */
    public static final String msg160 = "修正しました。\n結果を表示します。";


}
