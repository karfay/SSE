package management.entity;

import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * personnel_masterテーブルのエンティティ
 * @author sse802563
 *
 */
@Entity
public class PersonnelMaster {
    
    public PersonnelMaster(){
        
    }

    /**
     * personnelNumber<br />
     * 社員番号
     */
    @Id
    public String personnelNumber;
    
    /**
     * personnelName<br />
     * 社員名
     */
    public String personnelName;
    
    /**
     * userId<br />
     * ユーザID　現状では社員番号と同じ
     */
    public String userId;
    
    /**
     * userPass<br />
     * パスワード　現状では社員番号と同じ
     */
    public String userPass;
    
    /**
     * authorizations<br />
     * 権限のフラグ<br />
     * 1ならば承認権限を持つ
     */
    public String authorizations;
}
