package management.dao;

import java.util.List;

import javax.annotation.Resource;

import org.seasar.extension.jdbc.JdbcManager;
import org.seasar.extension.jdbc.SqlLogRegistryLocator;

import management.dto.PcMasterDto;
import management.entity.PcMaster;
import management.entity.PersonnelMaster;

public class KanPcDao {
    
    @Resource
    public JdbcManager jdbcManager;
    
    private static final String PREFIX = "META-INF/sql/KanPc/";
    
    /**
     * pc_masterを全検索した結果をListで返すメソッド
     * @return List<BaseMaster>
     */
    public List<PcMasterDto> getPcMaster(){
        return jdbcManager.selectBySqlFile(PcMasterDto.class, PREFIX + "selectPcMaster.sql").getResultList();
    }

    /**
     * pcMasterエンティティを受け取ってインサート処理を行うメソッド
     * @param baseMaster
     */
    public void insertPcMaster(PcMaster PcMaster) {
        jdbcManager.insert(PcMaster).excludesNull().execute();
        
    }

    /**
     * pcMasterエンティティを受け取ってデリート処理を行うメソッド
     * @param pcMaster
     */
    public void deletePcMaster(PcMaster pcMaster) {
        jdbcManager.delete(pcMaster).execute();
        //デバッグ用、S2JDBCで作成したsql文を参照できる
        //String completeSql = SqlLogRegistryLocator.getInstance().getLast().getCompleteSql();

        
    }

    public void updatePcMaster(PcMaster pcMaster) {
        jdbcManager.update(pcMaster).execute();
        //String completeSql = SqlLogRegistryLocator.getInstance().getLast().getCompleteSql();
        
    }

    /**
     * personnel_masterを全件検索した結果をListで返すメソッド
     * @return
     */
    public List<PersonnelMaster> getPersonnelMaster() {
        
        return jdbcManager.from(PersonnelMaster.class).getResultList();
        
    }
}
