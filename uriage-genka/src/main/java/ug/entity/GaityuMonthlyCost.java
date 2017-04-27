package ug.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import javax.annotation.Generated;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

/**
 * GaityuMonthlyCostエンティティクラス
 * 
 */
@Entity
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.EntityModelFactoryImpl"}, date = "2017/03/07 15:54:08")
public class GaityuMonthlyCost implements Serializable {

    private static final long serialVersionUID = 1L;

    /** gmcIdプロパティ */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(precision = 10, nullable = false, unique = true)
    public Integer gmcId;

    /** themeNoプロパティ */
    @Column(length = 10, nullable = false, unique = false)
    public String themeNo;

    /** empNoプロパティ */
    @Column(length = 10, nullable = false, unique = false)
    public String empNo;

    /** nendoプロパティ */
    @Column(precision = 10, nullable = false, unique = false)
    public Integer nendo;

    /** monthプロパティ */
    @Column(precision = 10, nullable = false, unique = false)
    public Integer month;

    /** KCostプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal KCost;

    /** MCostプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal MCost;

    /** JCostプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal JCost;

    /** themeMaster関連プロパティ */
    @ManyToOne
    @JoinColumn(name = "theme_no", referencedColumnName = "theme_no")
    public ThemeMaster themeMaster;

    /** empMaster関連プロパティ */
    @ManyToOne
    @JoinColumn(name = "emp_no", referencedColumnName = "emp_no")
    public EmpMaster empMaster;
}