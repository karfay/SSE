package management.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import management.entity.PersonnelMaster;
import management.entity.WirelessLanMaster;
import management.form.NestListTestForm;

import org.seasar.extension.jdbc.JdbcManager;
import org.seasar.struts.annotation.ActionForm;
import org.seasar.struts.annotation.Execute;

public class NestListTestAction {

    @ActionForm
    @Resource
    protected NestListTestForm nestListTestform;
    
    @Resource
    public JdbcManager jdbcManager;
    
    public List<PersonnelMaster> pmList;
    
    public List<WirelessLanMaster> wirelessLanList;
    
    
    
    @Execute(validator = false)
    public String index() {
        
        pmList = jdbcManager.selectBySql(PersonnelMaster.class, "select * from personnel_master").getResultList();
        wirelessLanList = jdbcManager.selectBySql(WirelessLanMaster.class, "select * from wireless_lan_master").getResultList();
        
        //nestListTestform.initialize();
/*      
        int column = 5;
        for(int i=0; i<5; i++){
            List<Map<String, Object>> mapItems = new ArrayList<Map<String, Object>>();
            for (int j = i*column; j < (i+1)*column; j++) {
                Map<String, Object> m = new HashMap<String, Object>();
                if(j==i*column){
                    m.put("pm", pmList.get(i).personnelName);
                }
                else{
                    m.put("itLabel", wirelessLanList.get(j).itLabel);
                    m.put("number", wirelessLanList.get(j).phoneNumber);
                }
                mapItems.add(m);
            }
            nestListTestform.mapItemsItems.add(mapItems);
        }
*/   
        
        int column = 5;
        for(int i=0; i<5; i++){
            List<Map<String, Object>> mapItems = new ArrayList<Map<String, Object>>();
            for (int j = i*column; j < (i+1)*column; j++) {
                Map<String, Object> m = new HashMap<String, Object>();
                if(j==i*column){
                    m.put("pm", pmList.get(i).personnelName);
                }
                else{
                    m.put("itLabel", wirelessLanList.get(j).itLabel);
                    m.put("number", wirelessLanList.get(j).phoneNumber);
                }
                mapItems.add(m);
            }
            nestListTestform.mapItemsItems.add(mapItems);
        }
        
        return "index.jsp";
    }
    
    
    public String userId;
    

    @Execute(validator = false)
    public String submit() {
        
        userId = "sse802563";
        
        return "/login/login?userId="+ userId + "&userPass=admin&redirect=true";
    }
    
    @Execute(validator = false)
    public String limited(){
        return "index.jsp";
    }
}
