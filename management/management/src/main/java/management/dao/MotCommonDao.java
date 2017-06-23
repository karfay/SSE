package management.dao;

import java.util.List;

import javax.annotation.Resource;

import org.seasar.extension.jdbc.JdbcManager;

import management.constant.MotConstant;
import management.dto.MotikomiDaityoDto;
import management.entity.MaterialCategoryMaster;
import management.entity.ProcessMaster;
import management.parameter.MotSearchFilterParams;

public class MotCommonDao {
    
    final String PREFIX = "META-INF/sql/MotSearchUpdate/";

    @Resource
    public JdbcManager jdbcManager;

    /**
     * procrss_masterテーブルの全件検索結果を返すメソッド
     * 
     * @return
     */
    public List<ProcessMaster> selectProcessMaster() {
        return jdbcManager.from(ProcessMaster.class).getResultList();
    }

    /**
     * material_category_masterテーブルの全件検索結果を返すメソッド
     * @return
     */
    public List<MaterialCategoryMaster> selectMaterialCategoryMaster() {
        return jdbcManager.from(MaterialCategoryMaster.class).getResultList();
    }
    
    /**
     * 持込台帳motikomi_daityoの条件検索を行うメソッド
     * @param motSearchFilterDto
     * @return
     */
    public List<MotikomiDaityoDto> selectMotikomiDaityo(
        MotSearchFilterParams motSearchFilterDto) {
    
    return jdbcManager
    .selectBySqlFile(MotikomiDaityoDto.class, PREFIX+"ConditionalSearch.sql", motSearchFilterDto)
    .getResultList();
}
    
    /**
     * 持込台帳motikomi_daityoの条件検索を行うメソッド
     * ページング対応版　とりあえず↑のオーバーライト
     * @param motSearchFilterDto
     * @return
     */
    public List<MotikomiDaityoDto> selectMotikomiDaityo(
        MotSearchFilterParams motSearchFilterDto, int pageNumber) {
    
    return jdbcManager
    .selectBySqlFile(MotikomiDaityoDto.class, PREFIX+"ConditionalSearch.sql", motSearchFilterDto)
    .limit(MotConstant.pageIndex).offset(MotConstant.pageIndex * (pageNumber-1))
    .getResultList();
    }
    
    /**
     * 持込台帳の条件検索の行数を返すメソッド
     * @param motSearchFilterDto
     * @return
     */
    public long getTotalTable(MotSearchFilterParams motSearchFilterDto){

        return jdbcManager.getCountBySqlFile(PREFIX+"ConditionalSearch.sql", motSearchFilterDto);
    }

}
