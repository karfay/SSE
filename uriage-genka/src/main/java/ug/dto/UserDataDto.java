package ug.dto;

import java.io.Serializable;

import org.seasar.framework.container.annotation.tiger.Component;
import org.seasar.framework.container.annotation.tiger.InstanceType;


/**
 * ログインユーザ情報を保持するセッションDto
 * @author sse802563
 *
 */
@Component(instance = InstanceType.SESSION)
public class UserDataDto implements Serializable{

	private static final long serialVersionUID = 1L;

	public String sessionNumber;

	public String empNo;
	public String empName;
	public String loginId;
	public String password;
	public String authorization;
	public String shortEmpName;
	public String empConditionCode;
	public String ukHistoryLook;
	public String ukInsert;
	public String ukUpdate;
	public String ukDelete;
	public String gkInsert;
	public String gkUpdate;
	public String themeInsert;
	public String themeUpdate;
	public String uriageTankaUpdate;


}
