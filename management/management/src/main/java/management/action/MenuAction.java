package management.action;

import javax.annotation.Resource;

import management.dto.UserDataDto;

import org.seasar.struts.annotation.Execute;

public class MenuAction {
    
    @Resource
    public UserDataDto userDataDto;

    @Execute(validator=false)
    public String index(){
        
        return "index.jsp";
    }
    
    @Execute(validator=false)
    public String kanri(){
        
        return "kanri.jsp";
    }
    
    /**
     * ログアウトボタンを押した際のメソッド
     * 
     * @return
     */
    @Execute(validator = false)
    public String logout() {

        userDataDto.userId = null;

        return "/login/?redirect=true";
    }
}
