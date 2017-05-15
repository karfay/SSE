package ug.action;



import javax.annotation.Resource;

import org.apache.struts.action.ActionMessages;
import org.seasar.framework.beans.util.Beans;
import org.seasar.struts.annotation.ActionForm;
import org.seasar.struts.annotation.Execute;
import java.util.List;

import org.seasar.extension.jdbc.JdbcManager;
import org.seasar.extension.jdbc.where.SimpleWhere;

import ug.entity.KeikakuTankaMaster;
import ug.service.KeikakuTankaMasterService;
import ug.form.KeikakuTankaMasterForm;

public class KeikakuTankaMasterAction {


    public List<KeikakuTankaMaster> keikakuTankaMasterItems;
    
    @ActionForm
    @Resource
    protected KeikakuTankaMasterForm keikakuTankaMasterForm;

    @Resource
    protected KeikakuTankaMasterService keikakuTankaMasterService;

    public JdbcManager jdbcManager;

    @Execute(validator = false)
    public String index() {
        keikakuTankaMasterItems = keikakuTankaMasterService.findAll();

        return "list.jsp";
    }





    @Execute(validator = false, urlPattern = "show/{nendo}")
    public String show() {
        KeikakuTankaMaster entity = keikakuTankaMasterService.findById(Integer.valueOf(keikakuTankaMasterForm.nendo));
        Beans.copy(entity, keikakuTankaMasterForm).dateConverter("yyyy-MM-dd").execute();
        return "show.jsp";
    }

    @Execute(validator = false, urlPattern = "edit/{nendo}")
    public String edit() {
        KeikakuTankaMaster entity = keikakuTankaMasterService.findById(Integer.valueOf(keikakuTankaMasterForm.nendo));
        Beans.copy(entity, keikakuTankaMasterForm).dateConverter("yyyy-MM-dd").execute();
        return "edit.jsp";
    }

    @Execute(validator = false)
    public String create() {
        return "create.jsp";
    }

    @Execute(validator = false, urlPattern = "delete/{nendo}", redirect = true)
    public String delete() {
        KeikakuTankaMaster entity = Beans.createAndCopy(KeikakuTankaMaster.class, keikakuTankaMasterForm).dateConverter("yyyy-MM-dd").execute();
        keikakuTankaMasterService.delete(entity);
        return "/keikakuTankaMaster/";
    }

    @Execute(input = "create.jsp", redirect = true)
    public String insert() {
        KeikakuTankaMaster entity = Beans.createAndCopy(KeikakuTankaMaster.class, keikakuTankaMasterForm).dateConverter("yyyy-MM-dd").execute();
        keikakuTankaMasterService.insert(entity);
        return "/keikakuTankaMaster/";
    }

    @Execute(input = "edit.jsp", redirect = true)
    public String update() {
        KeikakuTankaMaster entity = Beans.createAndCopy(KeikakuTankaMaster.class, keikakuTankaMasterForm).dateConverter("yyyy-MM-dd").execute();
        keikakuTankaMasterService.update(entity);
        return "/keikakuTankaMaster/";
    }
}