package management.entity;

import javax.persistence.Entity;

/**
 * Mot:社内持込管理システム<br />
 * 処理マスターprocess_masterのエンティティ
 * @author sse802563
 *
 */
@Entity
public class ProcessMaster {
    public ProcessMaster(){
        
    }

    /**
     * 処理コード
     */
    public int processCode;
    
    /**
     * 処理名称
     */
    public String processName;
}
