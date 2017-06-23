package management.action;

import javax.annotation.Resource;

import management.dto.UserDataDto;
import management.entity.PersonnelMaster;
import management.form.LoginForm;

import org.seasar.extension.jdbc.JdbcManager;
import org.seasar.framework.beans.util.Beans; //import org.seasar.framework.container.SingletonS2Container;
//import org.seasar.framework.container.factory.SingletonS2ContainerFactory;
import org.seasar.struts.annotation.ActionForm;
import org.seasar.struts.annotation.Execute;

import org.seasar.struts.util.ActionMessagesUtil;
import org.seasar.struts.util.RequestUtil;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;


public class LoginAction {
    @Resource
    public JdbcManager jdbcManager;

    public PersonnelMaster personnelMaster;

    /**
     * アップデートフォームから値を受け取る
     */
    @ActionForm
    @Resource
    protected LoginForm loginForm;

    @Resource
    protected UserDataDto userDataDto;

    @Execute(validator = false)
    public String index() {

        /*
         * DtoがActionで宣言されただけでインジェクションされるらしいので実験
         * publicで宣言すると利用できる
         * 入力をformで受け取って、dtoの値を出力するモデルが想定されているらしい
         */
        //userDataDto.personnelName = "test";
        
        
        return "index.jsp";
    }

    /**
     * ログインボタンがクリックされた際に実行されるメソッド
     * 
     * @return
     */
    @Execute(validator = true, input = "/login/index.jsp")
    public String login() {
        
        // ログイン画面で入力されたユーザIDとパスワードを検索
        personnelMaster = jdbcManager.selectBySqlFile(
            PersonnelMaster.class,
            "META-INF/sql/login/personnelMasterSearch.sql",
            loginForm).getSingleResult();

        if (personnelMaster != null) {
            // セッションへの保存処理
            // userDtoに値を入れるだけでSessionに保存される
            Beans.copy(this.personnelMaster, this.userDataDto).execute();

            return "/menu/";

        } else {

            //エラーメッセージをセット
            //jspの<html:errors />タグを使ってエラー内容が表示可能
            ActionMessages errors = new ActionMessages();
            //errors.loginをapplication_ja.propertiesで設定することでエラーメッセージを作ることができる
            //new Objectの中身に変数を入れることで変数を使うバリデーションも出来るみたいだけど、そのまま
            //フォームの変数を入れると中身を参照するのでよく分かっていない
            errors.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("errors.login",
                new Object[] {  }));
            ActionMessagesUtil.addErrors(RequestUtil.getRequest(), errors);
            
            // ログインが失敗のためもう一度ログイン画面に遷移
            return "/login/";
        }
    }

}
