package ug.entity;

import java.io.Serializable;
import javax.annotation.Generated;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

/**
 * Kaihatsutaiseiエンティティクラス
 * 
 */
@Entity
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.EntityModelFactoryImpl"}, date = "2017/03/07 15:54:09")
public class Kaihatsutaisei implements Serializable {

    private static final long serialVersionUID = 1L;

    /** gkIdプロパティ */
    @Id
    @Column(precision = 10, nullable = false, unique = false)
    public Integer gkId;

    /** empNoプロパティ */
    @Id
    @Column(length = 10, nullable = false, unique = false)
    public String empNo;

    /** gaityuFlagプロパティ */
    @Column(precision = 10, nullable = false, unique = false)
    public Integer gaityuFlag;

    /** genkaKanri関連プロパティ */
    @ManyToOne
    @JoinColumn(name = "gk_id", referencedColumnName = "gk_id")
    public GenkaKanri genkaKanri;

    /** empMaster関連プロパティ */
    @ManyToOne
    @JoinColumn(name = "emp_no", referencedColumnName = "emp_no")
    public EmpMaster empMaster;
}