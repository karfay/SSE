package management.action;

import java.text.ParseException;

import javax.annotation.Resource;
import org.seasar.struts.annotation.ActionForm;

import management.dto.UserDataDto;
import management.form.SyaDaityoLookForm;
import management.logic.SyaDaityoLookLogic;

import org.seasar.struts.annotation.Execute;


/**
 * 持出状況参照ページのアクション
 * 持出台帳からデータを参照するため頭文字はSyaで分類。
 * @author sse802563
 *
 */
public class SyaDaityoLookAction {
    @Resource
    public UserDataDto userDataDto;;
    
    @ActionForm
    @Resource
    protected SyaDaityoLookForm syaDaityoLookForm;
    
    @Resource
    public SyaDaityoLookLogic syaDaityoLookLogic;
    
    
    @Execute(validator=false)
    public String index(){
        
        return "lookWirelessLan.jsp";
    }

    /*
     * PCをリストアップするメソッド
     * Formのフラグを立てて検索するLogicを呼ぶだけ
     */
    @Execute(validator=false)
    public String pcListUp() throws ParseException{
        
        syaDaityoLookForm.includePc = "1";
        syaDaityoLookForm.includeWirelesslan = "0";
        syaDaityoLookForm.includeWirelessSlave = "0";
        syaDaityoLookLogic.listUp(syaDaityoLookForm);
       
        return "lookPc.jsp";
    }
    
    /*
     * 無線Lanをリストアップするメソッド
     * Formのフラグを立てて検索するLogicを呼ぶだけ
     */
    @Execute(validator=false)
    public String wirelessLanListUp() throws ParseException{
        
        syaDaityoLookForm.includePc = "0";
        syaDaityoLookForm.includeWirelesslan = "1";
        syaDaityoLookForm.includeWirelessSlave = "0";
        syaDaityoLookLogic.listUp(syaDaityoLookForm);
        
        return "lookWirelessLan.jsp";
    }
    
    
    @Execute(validator=false)
    public String wirelessSlaveListUp() throws ParseException{
        
        syaDaityoLookForm.includePc = "0";
        syaDaityoLookForm.includeWirelesslan = "0";
        syaDaityoLookForm.includeWirelessSlave = "1";
        syaDaityoLookLogic.listUp(syaDaityoLookForm);
        
        return "lookWirelessSlave.jsp";
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

    /**
     * メニュー画面へボタンを押した際のメソッド
     * 
     * @return
     */
    @Execute(validator = false)
    public String menu() {

        return "/menu/?redirect=true";
    }
    
}
