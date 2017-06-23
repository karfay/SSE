package management.dto;

import javax.persistence.Id;

/**
 * 社内持込台帳motikomi_daityoテーブルの検索結果を受け取るDto<br />
 * 検索結果として表示したい要素を格納できるようにフィールドを拡張している
 * @author sse802563
 *
 */
public class MotikomiDaityoDto {
    
    /**
     * 持込者の社員名（peersonnel_master.personnel_name）を格納するフィールド
     */
    public String bringPersonName;
    
    /**
     * 持込物区分名（material_category_master.category_name）を格納するフィールド
     */
    public String categoryName;
    
    /**
     * 予定処理名称（process_master.process_name）を格納するフィールド<br />
     * 検索に使うsql文でエイリアスを用いて出力名を変えている
     */
    public String scheduledName;
    
    /**
     * 実施処理名称（process_master.process_name）を格納するフィールド<br />
     */
    public String processName;
    
    /**
     * 持込確認者の社員名（peersonnel_master.personnel_name）を格納するフィールド
     */
    public String bringApproverName;
    
    /**
     * 終了時対応者の社員名（peersonnel_master.personnel_name）を格納するフィールド
     */
    public String processPersonName;
    
    /**
     * 終了時対応確認者の社員名（peersonnel_master.personnel_name）を格納するフィールド
     */
    public String processApproverName;
    
    /**
     * 状態名称
     */
    public String conditionName;
    
    //------------------------------------------------//
    //MoticomiDaityoエンティティに対応するフィールド
    //------------------------------------------------//
    /**
     * table_id　テーブルID
     */
    @Id
    public String tableId;
    
    /**
     * bring_person　持込者
     */
    public String bringPerson;
    
    /**
     * bring_date　持込日
     */
    public String bringDate;
    
    /**
     * client_name　預かり元
     */
    public String clientName;
    
    /**
     * project　プロジェクト名
     */
    public String project;
    
    /**
     * material_name　持込物名称
     */
    public String materialName;
    
    /**
     * category_code　持込物区分コード
     */
    public String categoryCode;
    
    /**
     * depository　保管場所
     */
    public String depository;
    
    /**
     * copies　部数
     */
    public String copies;
    
    /**
     * confidential　機密フラグ
     */
    public String confidential;
    
    /**
     * bring_notes　持込時備考
     */
    public String bringNotes;
    
    /**
     * scheduled_date　保管終了予定日
     */
    public String scheduledDate;
    
    /**
     * scheduled_code　終了時予定対応コード
     */
    public String scheduledCode;
    
    /**
     * processing_date　終了時予定対応日
     */
    public String processDate;
    
    /**
     * process_code　終了時実施対応コード
     */
    public String processCode;
    
    /**
     * process_person　終了時実施対応者
     */
    public String processPerson;
    
    /**
     * process_notes　終了時備考
     */
    public String processNotes;

    /**
     * bring_approval_date　持込確認日
     */
    public String bringApprovalDate;
    
    /**
     * bring_approver 持込確認者
     */
    public String bringApprover;
    
    /**
     * bring_approve_notes　持込時備考
     */
    public String bringApproveNotes;
    
    /**
     * bring_approval_date　終了対応確認日
     */
    public String processApprovalDate;
    
    /**
     * process_approver 終了対応確認者
     */
    public String processApprover;
    
    /**
     * process_approve_notes　終了対応時備考
     */
    public String processApproveNotes;
    
    /**
     * condition_code状態コード
     */
    public String conditionCode;
    //------------------------------------------------//
    //MoticomiDaityoエンティティに対応するフィールド
    //------------------------------------------------//
}
