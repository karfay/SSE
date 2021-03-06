package ug.action;

//loginMasterNamesを利用することでタイプセーフにカラム名を利用可能
import static org.seasar.extension.jdbc.operation.Operations.*;
import static ug.entity.EmpMasterNames.*;

import java.sql.Timestamp;

import javax.annotation.Resource;

import org.seasar.extension.jdbc.JdbcManager;
import org.seasar.framework.beans.util.Beans;
import org.seasar.struts.annotation.ActionForm;
import org.seasar.struts.annotation.Execute;

import ug.SqlFiles;
import ug.constant.LoginConstant;
import ug.dto.UserDataDto;
import ug.entity.EmpMaster;
import ug.entity.EmpMasterNames;
import ug.entity.LoginLog;
import ug.entity.LoginLogNames;
import ug.form.LoginForm;

public class LoginAction {

	@Resource
	public JdbcManager jdbcManager;

	@ActionForm
	@Resource
	protected LoginForm loginForm;

	@Resource
	protected UserDataDto userDataDto;

	@Execute(validator = false)
	public String index(){
		//ログインしていたらログアウト処理
		if(userDataDto.sessionNumber!=null){
			//ログアウト打刻
			LoginLog updateLoginLog = new LoginLog();
			updateLoginLog.sessionNumber = Integer.parseInt(userDataDto.sessionNumber);
			updateLoginLog.logoutTimestamp = new Timestamp(System.currentTimeMillis());
			jdbcManager.update(updateLoginLog).excludesNull().execute();
			userDataDto.sessionNumber=null;
		}

		return "login.jsp";
	}

	/**
	 * indexでログアウト処理をしているため、エラー表示の際に重複ログインエラーが解決してしまう場合がある。
	 * エラーの際には何もしない。
	 * @return
	 */
	@Execute(input="errIndex")
	public String errIndex(){
		return "index.jsp";
	}

	@Execute(input="index")
	public String login(){


		EmpMaster empMaster = Beans.createAndCopy(EmpMaster.class, loginForm).execute();
		//ユーザ認証
		long count = jdbcManager
				.from(EmpMaster.class)
				.where(
					eq(EmpMasterNames.loginId(), empMaster.loginId)
					,eq(password(), empMaster.password)
					,eq(empConditionCode(), 0))
				.getCount();
		//ユーザ認証チェック
		if(count==0){
			loginForm.errMessage=LoginConstant.loginConformErr;
			return index();
		}else{
			//最新のログイン履歴を取得
			LoginLog loginLog = jdbcManager
					.from(LoginLog.class)
					.where(
						eq(LoginLogNames.loginId(), empMaster.loginId))
					.orderBy(desc(LoginLogNames.loginTimestamp()))
					.limit(1)
					.getSingleResult();
			//初回ログインの場合、NULLなので処理を飛ばす
			if(loginLog!=null){
				//重複ログインチェック
				//TODO 重複ログインは一旦無視
				/*
				if(loginLog.logoutTimestamp==null){
					loginForm.errMessage=LoginConstant.loginDuplicationErr;
					return index();
				}
				*/
			}
		}

		//jdbcManagerの戻り値をそのままセッションに格納しようとすると、違うアドレスに格納されてしまう
		//一度別の容れ物に格納した後、beansか何かで入れ替え処理をすること

		 UserDataDto temp = jdbcManager
				 .selectBySqlFile(UserDataDto.class, SqlFiles.SQL_SELECT_USER_DATA_DTO, empMaster)
				 .getSingleResult();

		 Beans.copy(temp, this.userDataDto).execute();

		 //System.out.println("debug");


		 //ログイン打刻
		 LoginLog insertLoginLog = new LoginLog();
		 insertLoginLog.loginId = loginForm.loginId;
		 jdbcManager.insert(insertLoginLog).excludesNull().execute();

		 //挿入したテーブルを取得
		 LoginLog session = jdbcManager
				 .selectBySql(LoginLog.class, "select * from login_log where session_number = last_insert_id()")
				 .getSingleResult();
		 userDataDto.sessionNumber = Integer.toString(session.sessionNumber);

		return "/menu/";
	}

	@Execute(validator=false)
	public String logout(){
		return "/login/";
	}


}
