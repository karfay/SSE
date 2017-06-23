package ug.entity;

import java.io.Serializable;
import javax.annotation.Generated;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

/**
 * EmpAuthRelationエンティティクラス
 * 
 */
@Entity
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.EntityModelFactoryImpl"}, date = "2017/03/07 15:54:08")
public class EmpAuthRelation implements Serializable {

    private static final long serialVersionUID = 1L;

    /** empNoプロパティ */
    @Id
    @Column(length = 10, nullable = false, unique = false)
    public String empNo;

    /** authIdプロパティ */
    @Id
    @Column(precision = 10, nullable = false, unique = false)
    public Integer authId;

    /** sysIdプロパティ */
    @Id
    @Column(length = 10, nullable = false, unique = false)
    public String sysId;

    /** empMaster関連プロパティ */
    @ManyToOne
    @JoinColumn(name = "emp_no", referencedColumnName = "emp_no")
    public EmpMaster empMaster;

    /** ugAuthorizaitonMaser関連プロパティ */
    @ManyToOne
    @JoinColumn(name = "auth_id", referencedColumnName = "auth_id")
    public UgAuthorizaitonMaser ugAuthorizaitonMaser;
}