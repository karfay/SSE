package management.form;

import java.util.List;

import management.entity.Pc_software;

import org.seasar.struts.annotation.Required;

public class LoginForm {

    /** ユーザId */
    @Required
    public String userId;
    

//    public String getUserId() {
//        return userId;
//    }
//
//    public void setUserId(String userId) {
//        this.userId = userId;
//    }

    @Required
    /** ユーザパスワード */
    public String userPass;
    
//    public String getUserPass() {
//        return userPass;
//    }
//
//    public void setUserPass(String userPass) {
//        this.userPass = userPass;
//    }
    
    public String authorizations;
    
    public String loginMsg;

    /** 結果 */
    public List<Pc_software> personSoftware;
    
    
}
