package management.entity;

import javax.persistence.Entity;

/**
 * 記録情報の状態管理用マスタテーブル<br />
 * 承認待ちとか承認済みとか、削除（検索非表示）とか
 * @author sse802563
 *
 */
@Entity
public class ConditionMaster {
    
    public ConditionMaster(){
    }
    
    /**
     * condition_code 状態コード
     */
    public String conditionCode;
    
    /**
     * condition_name 状態の名称
     */
    public String conditionName;

}
