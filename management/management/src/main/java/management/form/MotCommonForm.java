package management.form;

import java.util.List;

import javax.persistence.Id;

import org.seasar.struts.annotation.DateType;
import org.seasar.struts.annotation.Required;

import management.dto.MotikomiDaityoDto;
import management.entity.MaterialCategoryMaster;
import management.entity.ProcessMaster;

/**
 * Mot:社内持込管理システム<br />
 * 持ち込み管理システムで汎用的に使うフォームのフィールドを扱う
 * 
 * @author sse802563
 * 
 */
public class MotCommonForm {
    public MotCommonForm() {

    }

    /**
     * メッセージ表示用
     */
    public String motMsg;
    
    /**
     * ユーザID表示用
     */
    public String userId;
    
    /**
     * 現在日時表示用
     */
    public String time;

    /**
     * 持込管理台帳（moticomi_daityoテーブル）の検索結果を格納するリスト
     */
    public List<MotikomiDaityoDto> historyDto;

    /**
     * 処理マスター（process_masterテーブル）の検索結果を格納するリスト
     */
    public List<ProcessMaster> processMaster;

    /**
     * 持込物区分マスター（material_category_masterテーブル）の検索結果を格納するリスト
     */
    public List<MaterialCategoryMaster> materialCategoryMaster;

    // ------------------------------------------------//
    // 検索条件（MotSearchFilterDto）に対応するフィールド
    // ------------------------------------------------//

    /**
     * 検索結果に削除テーブルを含む条件
     */
    public String includeDeleted;
    
    /**
     * 検索結果に持込未承認テーブルを含む条件
     */
    public String includeBringUnapproved;
    
    /**
     * 検索結果に持込承認済みテーブルを含む条件
     */
    public String includeBringApproved;
    
    /**
     * 検索結果に処理未承認テーブルを含む条件
     */
    public String includeProcessUnapproved;
    
    /**
     * 検索結果に処理承認済みテーブルを含む条件
     */
    public String includeProcessApproved;
    
    // ------------------------------------------------//
    // 検索条件（MotSearchFilterDto）に対応するフィールド
    // ------------------------------------------------//

    // ------------------------------------------------//
    // MoticomiDaityoエンティティに対応するフィールド
    // ------------------------------------------------//
    /**
     * table_id　テーブルID
     */
    @Id
    public String tableId;

    /**
     * bring_person　持込者
     */
    @Required(target = "insert, bringUpdateExecute")
    public String bringPerson;

    /**
     * bring_date　持込日
     */
    @Required(target = "insert, bringUpdateExecute")
    @DateType(target = "insert, bringUpdateExecute", datePattern = "yyyyMMdd")
    public String bringDate;

    /**
     * client_name　預かり元
     */
    @Required(target = "insert, bringUpdateExecute")
    public String clientName;

    /**
     * project　プロジェクト名
     */
    @Required(target = "insert, bringUpdateExecute")
    public String project;

    /**
     * material_name　持込物名称
     */
    @Required(target = "insert, bringUpdateExecute")
    public String materialName;

    /**
     * category_code　持込物区分コード
     */
    @Required(target = "insert, bringUpdateExecute")
    public String categoryCode;

    /**
     * depository　保管場所
     */
    @Required(target = "insert, bringUpdateExecute")
    public String depository;
    
    /**
     * 部数
     */
    @Required(target = "insert, bringUpdateExecute")
    public String copies;
    
    /**
     * confidential　機密フラグ
     */
    @Required(target = "insert, bringUpdateExecute")
    public String confidential;
    
    /**
     * bring_notes　持込時備考
     */
    public String bringNotes;

    /**
     * scheduled_date　保管終了予定日
     */
    @Required(target = "insert, bringUpdateExecute")
    @DateType(target = "insert, bringUpdateExecute", datePattern = "yyyyMMdd")
    public String scheduledDate;

    /**
     * scheduled_code　終了時予定対応コード
     */
    @Required(target = "insert, bringUpdateExecute")
    public String scheduledCode;

    /**
     * processing_date　終了時予定対応日
     */
    @Required(target = "process")
    @DateType(target = "process", datePattern = "yyyyMMdd")
    public String processDate;

    /**
     * process_code　終了時実施対応コード
     */
    @Required(target = "process")
    public String processCode;

    /**
     * process_person　終了時実施対応者
     */
    @Required(target = "process")
    public String processPerson;
    
    /**
     * process_notes　終了時備考
     */
    public String processNotes;
    
    /**
     * bring_approval_date　持込確認日
     */
    @Required(target = "bringApprove")
    @DateType(target = "bringApprove", datePattern = "yyyyMMdd")
    public String bringApprovalDate;

    /**
     * bring_approver 持込確認者
     */
    @Required(target = "bringApprove")
    public String bringApprover;
    
    /**
     * bring_approve_notes　持込時備考
     */
    @Required(target = "bringRemand")
    public String bringApproveNotes;
    
    /**
     * bring_approval_date　終了対応確認日
     */
    @Required(target = "processApprove")
    @DateType(target = "processApprove", datePattern = "yyyyMMdd")
    public String processApprovalDate;
    
    /**
     * process_approver 終了対応確認者
     */
    @Required(target = "processApprove")
    public String processApprover;
    
    /**
     * process_approve_notes　終了対応時備考
     */
    @Required(target = "processRemand")
    public String processApproveNotes;
    
    /**
     * 状態コード
     */
    public String conditionCode;

    // ------------------------------------------------//
    // MoticomiDaityoエンティティに対応するフィールド
    // ------------------------------------------------//
    
    // ------------------------------------------------//
    // ページング用のフィールド
    // ------------------------------------------------//
    
    public int pageNumber = 1;
    
    public long totalTable;
    
    public long totalPage;
    
}
