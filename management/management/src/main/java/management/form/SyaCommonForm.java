package management.form;

import java.util.List;

import org.seasar.struts.annotation.DateType;
import org.seasar.struts.annotation.IntegerType;
import org.seasar.struts.annotation.Required;

import management.dto.TakePcOutDto;
import management.entity.BaseMaster;
import management.entity.ConditionMaster;
import management.entity.DocumentCategoryMaster;
import management.entity.PersonnelMaster;
import management.entity.TakeDocumentsOut;
import management.entity.TakePcOut;
import management.entity.WirelessLanMaster;
import management.entity.WirelessSlaveMaster;
import management.dto.SyaDaityoLookDto;;

public class SyaCommonForm {

    /** TakePcOutの検索結果を格納するリスト */
    public List<TakePcOut> history;
    
    /** TakeDocumentsOutの検索結果を格納するリスト */
    public List<TakeDocumentsOut> documents;
    
    /** DocumentCategoryMasterの検索結果を格納するリスト */
    public List<DocumentCategoryMaster> documentCategoy;
    
    /** ConditionMasterの検索結果を格納するリスト */
    public List<ConditionMaster> conditionMaster;
    
    /** BaseMasterの検索結果を格納するリスト */
    public List<BaseMaster> baseMaster;
    
    /** WirelessLanMasterの検索結果を格納するリスト */
    public List<WirelessLanMaster> wirelessLanMaster;
    
    /** WirelessSlaveMasterの検索結果を格納するリスト */
    public List<WirelessSlaveMaster> wirelessSlaveMaster;
    
    /**
     * モバイルWi-Fiの持出状況を格納するメソッド
     */
    public List<SyaDaityoLookDto> syaDityoLookDto;
    
    /**
     * TakePcOutDtoにはpersonnelNameがあるため、TakePcOutに社員名を加えた<br />
     * 検索結果を表示したいときに使う
     */
    public List<TakePcOutDto> historyDto;
    
    /**
     * 承認権限を持つ社員の情報を格納するリスト
     */
    public List<PersonnelMaster> approvers;
    
    /**
     * ページング検索の際に、ページング番号を受け取る
     */
    public int pageNumber = 1;
    
    /**
     * ページング検索の際に、検索結果の全件数を受け取る
     */
    public long pageCount;
    
    /**
     * ページング処理の際に、総ページ数を格納する
     */
    public int totalPage;
    
    /**
     * ページング検索の際に、今表示しているページ番号を格納する
     */
    public int currentPage;
    
    /**
     * ページング検索の際に、ページのURLを格納する
     */
    public String pagingUrl;
    
    /**
     * TakePcOutDtoから社員名を受け取る
     */
    public String personnelName;
    
    // TakePcOutのプロパティに対応するフィールド
    /**
     * jspのdate型入力フォームの初期表示用
     */
    public String time;

    /**
     * jspのユーザID入力フォームの初期表示用
     */
    public String userId;
    
    //----------------------------------------------------------------
    // 検索条件に関するフィールド
    //----------------------------------------------------------------
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
    

    //----------------------------------------------------------------
    // take_pc_outテーブルに関するフィールド
    //----------------------------------------------------------------
    /**
     * table_ID テーブルID
     */
    public String tableId;

    /**
     * application_date 申請日
     */
    @Required(target = "submit,updateDaityo")
    @DateType(target = "submit", datePattern = "yyyyMMdd")
    public String appDate;

    /**
     * application_user 申請者
     */
    @Required(target = "submit,updateDaityo")
    public String appUser;

    /**
     * 開始日
     */
    @Required(target = "submit,updateDaityo")
    @DateType(target = "submit,updateDaityo", datePattern = "yyyyMMdd")
    public String startDate;

    /**
     * 終了日
     */
    @Required(target = "submit,updateDaityo")
    @DateType(target = "submit,updateDaityo", datePattern = "yyyyMMdd")
    public String endDate;

    /**
     * destination 持ち出し先
     */
    @Required(target = "submit,updateDaityo")
    public String dest;

    /**
     * PC管理番号
     */
    @IntegerType(target = "submit,updateDaityo")
    public String itLabel;

    /**
     * 無線LanのITラベル
     * バリデーションを削除（2016/1/25）
     */
//    @IntegerType(target = "submit,updateDaityo")
    public String wirelessLan;

    /**
     * フラッシュメモリの識別番号
     * 持ち出し禁止に付き、使用制限
     */
    public String flashMemory;

    /**
     * プロジェクト名
     */
    @Required(target = "submit,updateDaityo")
    public String project;

    /**
     * approval_date 承認日
     */
    @Required(target = "approve")
    @DateType(target = "approve", datePattern = "yyyyMMdd")
    public String approvalDate;

    /**
     * approver 承認者
     */
    @Required(target = "approve")
    public String approver;
    
    /**
     * notes 備考    
     */
    @Required(target = "remand")
    public String notes;
    
    /**
     * other_media その他の持出物
     */
    public String otherMedia;

    
    /**
     * wireless_slave 無線子機
     */
    @IntegerType
    public String wirelessSlave;

    //----------------------------------------------------------------
    // document_category_masterテーブルに関するフィールド
    //----------------------------------------------------------------
    /**
     * category_name<br />
     * カテゴリー名
     */
    public String categoryName;



    //----------------------------------------------------------------
    // take_document_outテーブルに関するフィールド
    //----------------------------------------------------------------
    /**
     * doc_id<br />
     * 紙媒体資料のID
     */
    public String docId;

    /**
     * doc_name<br />
     * 紙媒体資料の名称
     */
    @Required(target = "addDocuments,updateDocument,addDocumentsToUpdate")
    public String docName;

    /**
     * copies<br />
     * 持出部数
     */
    @Required(target = "addDocuments,updateDocument,addDocumentsToUpdate")
    @IntegerType(target = "addDocuments,updateDocument,addDocumentsToUpdate")
    public String copies;

    /**
     * category_id<br />
     * 紙媒体資料の区分ID
     */
    @Required(target = "addDocuments,updateDocument,addDocumentsToUpdate")
    public String categoryId;


    //----------------------------------------------------------------
    // condition_masterテーブルに関するフィールド
    //----------------------------------------------------------------
    /**
     * condition_code 状態コード
     */
    public String conditionCode = "0";

    /**
     * condition_name 状態の名称
     */
    public String conditionName;

}

