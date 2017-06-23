package management.parameter;

/**
 * take_pc_outテーブルの検索条件を格納するクラス
 * @author sse802563
 *
 */
public class TakePcOutParams {

public TakePcOutParams(){
    searchDateAfter = "";
    searchDateBefore = "";
    searchDest = "";
    searchName = "";
    searchPastRecords = "";
    includeApproved = "";
    includeCorrected = "";
    includeDeleted = "";
    includeRemanded = "";
    includeUnapproved = "";
    }
    
    /**
     * 検索条件　申請日の以前検索
     */
    public String searchDateBefore;
    
    /**
     * 検索条件　申請日の以後検索
     */
    public String searchDateAfter;
    
    /**
     * 検索条件　申請者名
     */
    public String searchName;
    
    /**
     * 検索条件
     */
    public String searchDest;
    
    /** 削除データを検索条件に含むためのフラグ */
    public String includeDeleted;
    
    /** 未承認データを検索条件に含むためのフラグ */
    public String includeUnapproved;
    
    /** 承認済みデータを検索条件に含むためのフラグ */
    public String includeApproved;
    
    /** 修正データを検索条件に含むためのフラグ */
    public String includeCorrected;
    
    /** 差し戻しデータを検索条件に含むためのフラグ */
    public String includeRemanded;
    
    /**
     * 検索条件　過去履歴
     */
    public String searchPastRecords;
}
