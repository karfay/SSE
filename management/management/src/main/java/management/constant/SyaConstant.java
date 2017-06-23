package management.constant;

/**
 * 社外持出台帳システムで扱う定数を管理するクラス
 * 
 * @author sse802563
 * 
 */
public class SyaConstant {

    public SyaConstant() {
    }

    /**
     * 検索結果を１ページにいくつ表示するかを定める
     */
    public final static int pageIndex = 10;

    /*
     * 持出台帳の新規登録、修正、引用、削除、詳細表示を行うSyaDaityoInputで使用するメッセージ
     */
    
    public final static String sinkiTouroku = "台帳へ新規申請を行います。";
    
    public final static String inputError = "入力エラーがあります。";
    
    public final static String kojinRireki = "あなたの申請履歴を表示します。";
    
    public final static String addDocment = "資料の追加が完了したら、登録ボタンで台帳に登録してください。";
    
    public final static String completeTouroku = "以下の情報で登録が完了しました。";
    
    public final static String motidashiCkeck = "持ち出し物の入力がありません。";
    
    public final static String itLabelError = "PCのITラベルが不正です。入力に間違いがない場合は管理者に問い合わせてください。";

    public final static String updateDaityo = "修正を行います。修正した申請には再承認が必要です。";
    
    public final static String completeUpdate = "修正しました。修正した申請には再承認が必要です。";
    
    public final static String noticeUpdateDocuments = "紙媒体資料は個別に修正・削除を行ってください。";
    
    public final static String completeUpdateDocuments = "選択した紙媒体資料の修正を行いました。";
    
    public final static String deleteDocuments = "選択した紙媒体資料を削除しました。";
    
    public final static String deleteDaityo = "このテーブルを削除しました。";
    
    public final static String deleteDocumentsFromDeleteDaityo = "以下の紙媒体資料の持出情報も削除しました。";
    
    public final static String showDetails = "詳細を表示します";
    
    public final static String quoteDaityo = "引用しました。日付の項目は本日の日付になっています。注意しましょう。";
    
    public final static String nothingAnyDocuments = "紙媒体資料の持出はありませんでした。";
    
    public final static String showDocuments = "紙媒体資料の持出情報を以下に表示します。";
    
    /*
     * 持出台帳の検索、修正を行うSyaSearchApproveで使用するメッセージ
     */
    
    public final static String searchDaityo = "検索を行います。";
    
    public final static String showAll = "データを全件表示します。";
    
    public final static String approveDaityo = "承認しました。";
    
    public final static String nothingAnyData = "条件に当てはまる登録データはありませんでした。";
    
    public final static String showSearchResults = "検索結果を表示します。";
    
    public final static String nothingAnyUnnaproveData = "未承認データはありませんでした。";
    
    public final static String showUnnapproveData = "未承認データを一覧表示します。";
    
}
