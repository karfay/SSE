package ug.entity;

import java.io.Serializable;
import java.util.List;
import javax.annotation.Generated;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;

/**
 * EmpConditionMasterエンティティクラス
 * 
 */
@Entity
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.EntityModelFactoryImpl"}, date = "2017/03/07 15:54:08")
public class EmpConditionMaster implements Serializable {

    private static final long serialVersionUID = 1L;

    /** empConditionCodeプロパティ */
    @Id
    @Column(precision = 10, nullable = false, unique = true)
    public Integer empConditionCode;

    /** empConditionNameプロパティ */
    @Column(length = 10, nullable = false, unique = false)
    public String empConditionName;

    /** empMasterList関連プロパティ */
    @OneToMany(mappedBy = "empConditionMaster")
    public List<EmpMaster> empMasterList;
}