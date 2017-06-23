package management.dao;

import java.util.List;

import javax.annotation.Resource;

import org.seasar.extension.jdbc.JdbcManager;

import management.entity.PersonnelMaster;

public class KanPersonnelDao {
    
    @Resource
    public JdbcManager jdbcManager;
    
    public final String PREFIX = "META-INF/sql/Kan/";

    /**
     * 全件検索をするメソッド
     * @return
     */
    public List<PersonnelMaster> selectPersonnelMaster() {
        return jdbcManager.from(PersonnelMaster.class).getResultList();
    }

    /**
     * personnel_masterにinsert処理を行うメソッド
     * @param personnelMaster
     */
    public void insertPsesonnelMaster(PersonnelMaster personnelMaster) {
        //入力のない（nullの）カラムを除いてinsert
        jdbcManager.insert(personnelMaster).excludesNull().execute();
        return;
    }

    public void deletePersonnelMaster(PersonnelMaster personnelMaster) {
        jdbcManager.delete(personnelMaster).execute();
    }

}
