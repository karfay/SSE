package management.action;

import javax.annotation.Resource;

import management.form.SearchParsonnelMasterForm;

import org.seasar.extension.jdbc.JdbcManager;
import org.seasar.struts.annotation.ActionForm;
import org.seasar.struts.annotation.Execute;

/**
 * ユーザの検索を行うクラス
 * @author sse802507
 *
 */
public class SearchPersonnelMasterAction {
    
    public JdbcManager jdbcManager;
    
    @ActionForm
    @Resource
    public SearchParsonnelMasterForm searchParsonnelMasterForm;
    
    @Execute(validator = false)
    public String index() {
        
        return "index.jsp";
    }
    
}
