package management.action;

import org.seasar.struts.annotation.Execute;

public class UserRegistrationAction {

    @Execute(validator=false)
    public String index(){
        
        return "index.jsp";
    }
}
