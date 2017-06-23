package management.entity;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class DocumentCategoryMaster {
    
    public DocumentCategoryMaster(){
        
    }
  
    
    /**
     * category_id<br />
     * 区分ID
     */
    @Id
    public String categoryId; 
    
    /**
     * category_name<br />
     * カテゴリー名
     */
    public String categoryName;
}
