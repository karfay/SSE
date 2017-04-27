package ug.action;

import javax.annotation.Resource;

import org.seasar.struts.annotation.Execute;

import ug.entity.KeikakuTankaMaster;
import ug.service.KeikakuTankaMasterService;

public class KeikakuTankaAction {

	protected KeikakuTankaMaster keikakuTanka;



	@Resource
	protected KeikakuTankaMasterService keikakuTankaMasterService;

	@Execute(validator = false)
	public String index(){

		int nendo = 2017;
		keikakuTanka = keikakuTankaMasterService.findById(nendo);

		return "index.jsp";
	}
}
