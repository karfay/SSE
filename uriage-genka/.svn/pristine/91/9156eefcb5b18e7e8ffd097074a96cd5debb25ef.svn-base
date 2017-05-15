package ug.action;



import javax.annotation.Resource;

import org.apache.struts.action.ActionMessages;
import org.seasar.framework.beans.util.Beans;
import org.seasar.struts.annotation.ActionForm;
import org.seasar.struts.annotation.Execute;
import java.util.List;

import org.seasar.extension.jdbc.JdbcManager;
import org.seasar.extension.jdbc.where.SimpleWhere;

import ug.entity.EmpMaster;
import ug.service.EmpMasterService;
import ug.form.EmpMasterForm;

public class EmpMasterAction {


    public List<EmpMaster> empMasterItems;
    
    @ActionForm
    @Resource
    protected EmpMasterForm empMasterForm;

    @Resource
    protected EmpMasterService empMasterService;

    public JdbcManager jdbcManager;

    @Execute(validator = false)
    public String index() {
        empMasterItems = empMasterService.findAll();

        return "list.jsp";
    }





    @Execute(validator = false, urlPattern = "show/{empNo}")
    public String show() {
        EmpMaster entity = empMasterService.findById(empMasterForm.empNo);
        Beans.copy(entity, empMasterForm).dateConverter("yyyy-MM-dd").execute();
        return "show.jsp";
    }

    @Execute(validator = false, urlPattern = "edit/{empNo}")
    public String edit() {
        EmpMaster entity = empMasterService.findById(empMasterForm.empNo);
        Beans.copy(entity, empMasterForm).dateConverter("yyyy-MM-dd").execute();
        return "edit.jsp";
    }

    @Execute(validator = false)
    public String create() {
        return "create.jsp";
    }

    @Execute(validator = false, urlPattern = "delete/{empNo}", redirect = true)
    public String delete() {
        EmpMaster entity = Beans.createAndCopy(EmpMaster.class, empMasterForm).dateConverter("yyyy-MM-dd").execute();
        empMasterService.delete(entity);
        return "/empMaster/";
    }

    @Execute(input = "create.jsp", redirect = true)
    public String insert() {
        EmpMaster entity = Beans.createAndCopy(EmpMaster.class, empMasterForm).dateConverter("yyyy-MM-dd").execute();
        empMasterService.insert(entity);
        return "/empMaster/";
    }

    @Execute(input = "edit.jsp", redirect = true)
    public String update() {
        EmpMaster entity = Beans.createAndCopy(EmpMaster.class, empMasterForm).dateConverter("yyyy-MM-dd").execute();
        empMasterService.update(entity);
        return "/empMaster/";
    }
}