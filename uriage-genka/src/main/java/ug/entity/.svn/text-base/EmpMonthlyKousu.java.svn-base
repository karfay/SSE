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
 * EmpMonthlyKousuエンティティクラス
 * 
 */
@Entity
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.EntityModelFactoryImpl"}, date = "2017/03/07 15:54:08")
public class EmpMonthlyKousu implements Serializable {

    private static final long serialVersionUID = 1L;

    /** emkIdプロパティ */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(precision = 10, nullable = false, unique = true)
    public Integer emkId;

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

    /** KKousuプロパティ */
    @Column(precision = 5, scale = 1, nullable = true, unique = false)
    public BigDecimal KKousu;

    /** MKousuプロパティ */
    @Column(precision = 5, scale = 1, nullable = true, unique = false)
    public BigDecimal MKousu;

    /** JKousuプロパティ */
    @Column(precision = 5, scale = 1, nullable = true, unique = false)
    public BigDecimal JKousu;

    /** themeMaster関連プロパティ */
    @ManyToOne
    @JoinColumn(name = "theme_no", referencedColumnName = "theme_no")
    public ThemeMaster themeMaster;

    /** empMaster関連プロパティ */
    @ManyToOne
    @JoinColumn(name = "emp_no", referencedColumnName = "emp_no")
    public EmpMaster empMaster;
    
    /** nendoSortMaster関連プロパティ*/
    @ManyToOne
    @JoinColumn(name="month", referencedColumnName="month")
    public NendoSortMaster nendoSortMaster;
}