package ug.form;

import org.seasar.struts.annotation.Required;

public class LoginForm extends CommonForm{

	public String pageName = "ログイン";

	@Required
	public String loginId;

	@Required
	public String password;
}
