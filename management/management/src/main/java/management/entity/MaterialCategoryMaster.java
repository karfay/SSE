package management.entity;

import javax.persistence.Entity;

/**
 * Mot:社内持込管理システム<br />
 * 持込物区分マスターmaterial_category_masterのエンティティ
 * @author sse802563
 *
 */
@Entity
public class MaterialCategoryMaster {
    public MaterialCategoryMaster(){
        
    }

    /**
     * material_name 資料名
     */
    public String categoryName;
    
    /**
     * 資料コード
     */
    public int categoryCode;
}
