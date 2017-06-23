package management.logic;

import javax.annotation.Resource;

import org.seasar.framework.beans.util.Beans;

import management.dao.KanPersonnelDao;
import management.entity.PersonnelMaster;
import management.form.KanPersonnelForm;

public class KanPersonnelLogic {
    
    @Resource
    public KanPersonnelForm kanPersonnelForm;
    
    @Resource
    public KanPersonnelDao kanPersonnelDao;
    
    public void getPersonnelMaster(KanPersonnelForm kanPersonnelForm){
        kanPersonnelForm.personnelMaster = kanPersonnelDao.selectPersonnelMaster();
    }

    public void insertPersonnelMaster(KanPersonnelForm kanPersonnelForm) {
        //insert処理用のエンティティを宣言
        PersonnelMaster  personnelMaster = new PersonnelMaster();
        //姓と名の間に全角空白を入れて、社員名にする
        kanPersonnelForm.personnelName = kanPersonnelForm.familyName + "　" + kanPersonnelForm.firstName;
        //formの値をエンティティにコピー、空白は除く
        Beans.copy(kanPersonnelForm, personnelMaster).excludesWhitespace().execute();
        kanPersonnelDao.insertPsesonnelMaster(personnelMaster);
    }

    public void copyOld(KanPersonnelForm kanPersonnelForm) {
        
        kanPersonnelForm.old = new PersonnelMaster();
        Beans.copy(kanPersonnelForm, kanPersonnelForm.old).excludesNull().execute();       
    }

    public void deletePersonnelMaster(KanPersonnelForm kanPersonnelForm) {
      //delete処理用のエンティティを宣言
        PersonnelMaster  personnelMaster = new PersonnelMaster();
        Beans.copy(kanPersonnelForm, personnelMaster).execute();
        kanPersonnelDao.deletePersonnelMaster(personnelMaster);
        
    }

}
