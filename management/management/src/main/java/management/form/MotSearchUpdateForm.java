package management.form;

import java.util.Date;
import java.util.List;

import management.entity.PersonnelMaster;

public class MotSearchUpdateForm extends MotCommonForm {

    /**
     * 承認権限チェック用
     */
    public String authorizations;
    
    /**
     * 承認者一覧のデータを受け取るリスト
     */
    public List<PersonnelMaster> approvers;

    
    /////////////////////////////////////////////
    //検索条件MotSearchFilterParamsの条件表示用//
    /////////////////////////////////////////////
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
