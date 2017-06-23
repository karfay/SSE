package management.entity;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class TakeDocumentsOut {

    public TakeDocumentsOut(){
    }
        /**
         * doc_id<br />
         * 紙媒体資料のID
         */
        @Id
        public String docId;
        
        /**
         * doc_name<br />
         * 紙媒体資料の名称
         */
        public String docName;
        
        /**
         * copies<br />
         * 持出部数
         */
        public String copies;
        
        /**
         * table_id<br />
         * 外部接続の所有者をあらわす<br />
         * 持出台帳の記録１つに対して、持ち出す紙媒体資料は複数である
         */
        @Id
        public String tableId;
        
        /**
         * category_id<br />
         * 紙媒体資料の区分ID
         */
        public String categoryId;
        
        /**
         * condition_code 状態コード
         */
        public String conditionCode;
                
}
