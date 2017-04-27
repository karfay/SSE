package ug.entity;

import java.io.Serializable;
import java.util.List;
import javax.annotation.Generated;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

/**
 * EmpMasterエンティティクラス
 * 
 */
@Entity
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.EntityModelFactoryImpl"}, date = "2017/03/07 15:54:08")
public class EmpMaster implements Serializable {

    private static final long serialVersionUID = 1L;

    /** empNoプロパティ */
    @Id
    @Column(length = 10, nullable = false, unique = true)
    public String empNo;

    /** empNameプロパティ */
    @Column(length = 20, nullable = false, unique = false)
    public String empName;

    /** loginIdプロパティ */
    @Column(length = 10, nullable = true, unique = false)
    public String loginId;

    /** passwordプロパティ */
    @Column(length = 10, nullable = true, unique = false)
    public String password;

    /** authorizationプロパティ */
    @Column(length = 10, nullable = true, unique = false)
    public String authorization;

    /** shortEmpNameプロパティ */
    @Column(length = 10, nullable = false, unique = false)
    public String shortEmpName;

    /** empConditionCodeプロパティ */
    @Column(precision = 10, nullable = false, unique = false)
    public Integer empConditionCode;

    /** ankenRirekiList関連プロパティ */
    @OneToMany(mappedBy = "empMaster")
    public List<AnkenRireki> ankenRirekiList;

    /** ankenRirekiList2関連プロパティ */
    @OneToMany(mappedBy = "insert")
    public List<AnkenRireki> ankenRirekiList2;

    /** ankenRirekiList3関連プロパティ */
    @OneToMany(mappedBy = "empMaster2")
    public List<AnkenRireki> ankenRirekiList3;

    /** empAuthRelationList関連プロパティ */
    @OneToMany(mappedBy = "empMaster")
    public List<EmpAuthRelation> empAuthRelationList;

    /** empConditionMaster関連プロパティ */
    @ManyToOne
    @JoinColumn(name = "emp_condition_code", referencedColumnName = "emp_condition_code")
    public EmpConditionMaster empConditionMaster;

    /** empMonthlyKousuList関連プロパティ */
    @OneToMany(mappedBy = "empMaster")
    public List<EmpMonthlyKousu> empMonthlyKousuList;

    /** gaityuMonthlyCostList関連プロパティ */
    @OneToMany(mappedBy = "empMaster")
    public List<GaityuMonthlyCost> gaityuMonthlyCostList;

    /** genkaKanriList関連プロパティ */
    @OneToMany(mappedBy = "empMaster")
    public List<GenkaKanri> genkaKanriList;

    /** genkaKanriList2関連プロパティ */
    @OneToMany(mappedBy = "empMaster2")
    public List<GenkaKanri> genkaKanriList2;

    /** genkaKanriList3関連プロパティ */
    @OneToMany(mappedBy = "empMaster3")
    public List<GenkaKanri> genkaKanriList3;

    /** kaihatsutaiseiList関連プロパティ */
    @OneToMany(mappedBy = "empMaster")
    public List<Kaihatsutaisei> kaihatsutaiseiList;
}