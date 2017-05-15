package ug.action;

import java.sql.Timestamp;

import javax.annotation.Resource;

import org.seasar.extension.jdbc.JdbcManager;
import org.seasar.struts.annotation.Execute;

import ug.dto.UserDataDto;
import ug.entity.LoginLog;

public class MenuAction {

    @Resource
    protected UserDataDto userDataDto;

    @Resource
    public JdbcManager jdbcManager;

    public String sysMessage;
    public String sysName = "売上原価管理システム";
    public String pageName = "メニュー";

    @Execute(validator=false)
    public String index(){

    	sysMessage = "ようこそ、　" + userDataDto.empName + "　さん";

        return "menu.jsp";
    }

    /**
     * ログアウトボタンを押した際のメソッド
     *
     * @return
     */
    @Execute(validator = false)
    public String logout() {

		//ログアウト打刻
		LoginLog updateLoginLog = new LoginLog();
		updateLoginLog.sessionNumber = Integer.parseInt(userDataDto.sessionNumber);
		updateLoginLog.logoutTimestamp = new Timestamp(System.currentTimeMillis());
		jdbcManager.update(updateLoginLog).excludesNull().execute();
		userDataDto.sessionNumber=null;
        return "/login/?redirect=true";


    }




}