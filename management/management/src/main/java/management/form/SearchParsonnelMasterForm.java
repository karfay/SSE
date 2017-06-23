package management.form;

import java.util.List;

import management.entity.PersonnelMaster;;

public class SearchParsonnelMasterForm {
    
    /**
     * 社員No
     */
    public String personnelNumber;
    
    public String getPersonnelNumber() {
        return personnelNumber;
    }

    public void setPersonnelNumber(String personnelNumber) {
        this.personnelNumber = personnelNumber;
    }

    /**
     * 社員名
     */
    public String personnelName;
    
    public String getPersonnelName() {
        return personnelName;
    }

    public void setPersonnelName(String personnelName) {
        this.personnelName = personnelName;
    }

    /**
     * ユーザID
     */
    public String userId;
    
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    /**
     * パスワード
     */
    public String userPass;
    
    public String getUserPass() {
        return userPass;
    }

    public void setUserPass(String userPass) {
        this.userPass = userPass;
    }

    /**
     * 権限
     */
    public String authorizations;

    public String getAuthorizations() {
        return authorizations;
    }

    public void setAuthorizations(String authorizations) {
        this.authorizations = authorizations;
    }

    /** 結果 */
    public List<PersonnelMaster> personSoftware;
}
