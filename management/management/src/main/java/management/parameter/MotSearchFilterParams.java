package management.parameter;

import java.util.Date;

/**
 * Mot:社内持込管理システム<br />
 * 持込台帳（motikomi_daityoテーブル）を検索するための条件を格納するクラス
 * @author sse802563
 *
 */
public class MotSearchFilterParams {
    public MotSearchFilterParams(){
        // 状態コードを全て含む条件で初期化
        includeDeleted = "1";
        
        includeBringUnapproved = "1";
        
        includeBringApproved = "1";
       
        includeBringUpdate = "1";
        
        includeBringRemand = "1";
        
        includeProcessUnapproved = "1";
        
        includeProcessApproved = "1";
        
        includeProcessUpdate = "1";
        
        includeProcessRemand = "1";
        
        includeExpired = "0";
            
        currentTime = new Date();
    }
    
    /**
     * 検索条件　持込日
     */
    public String bringDate;
    
    /**
     * 検索条件　持込者
     */
    public String bringPerson;
    
    /**
     * 検索条件　預かり元
     */
    public String clientName;
    
    /**
     * 検索条件　プロジェクト名
     */
    public String project;
    
    /**
     * 検索条件　テーブルID
     */
    public String tableId;
    
    /**
     * 検索結果に削除テーブルを含む
     */
    public String includeDeleted;
    
    /**
     * 検索結果に持込未承認テーブルを含む
     */
    public String includeBringUnapproved;
    
    /**
     * 検索結果に持込承認済みテーブルを含む
     */
    public String includeBringApproved;
    
    /**
     * 検索結果に持込修正テーブルを含む
     */
    public String includeBringUpdate;
    
    /**
     * 検索結果に持込差し戻しテーブルを含む
     */
    public String includeBringRemand;
    
    /**
     * 検索結果に処理未承認テーブルを含む
     */
    public String includeProcessUnapproved;
    
    /**
     * 検索結果に処理承認済みテーブルを含む
     */
    public String includeProcessApproved;
    
    /**
     * 検索結果に処理修正テーブルを含む
     */
    public String includeProcessUpdate;
    
    /**
     * 検索結果に処理差し戻しテーブルを含む
     */
    public String includeProcessRemand;
    
    
    /**
     * 検索結果に期限切れを含む
     */
    public String includeExpired;
    
    /**
     * 現在時刻
     */
    public Date currentTime;
}
