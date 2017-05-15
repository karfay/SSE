package ug.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

import javax.annotation.Generated;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

/**
 * AnkenRirekiエンティティクラス
 *
 */
@Entity
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.EntityModelFactoryImpl"}, date = "2017/03/07 15:54:08")
public class AnkenRireki implements Serializable {

    private static final long serialVersionUID = 1L;

    /** ankenRirekiIdプロパティ */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(precision = 10, nullable = false, unique = true)
    public Integer ankenRirekiId;

    /** ankenRirekiNoプロパティ */
    @Column(precision = 10, nullable = false, unique = false)
    public Integer ankenRirekiNo;

    /** ankenIdプロパティ */
    @Column(precision = 10, nullable = false, unique = false)
    public Integer ankenId;

    /** nendoプロパティ */
    @Column(precision = 10, nullable = false, unique = false)
    public Integer nendo;

    /** kokyakuNameプロパティ */
    @Column(length = 10, nullable = false, unique = false)
    public String kokyakuName;

    /** kokyakuInitialプロパティ */
    @Column(length = 1, nullable = false, unique = false)
    public String kokyakuInitial;

    /** ankenNameプロパティ */
    @Column(length = 100, nullable = false, unique = false)
    public String ankenName;

    /** jutyuNameプロパティ */
    @Column(length = 100, nullable = true, unique = false)
    public String jutyuName;



    /** kaihatsuGroupHeadプロパティ */
    @Column(length = 10, nullable = true, unique = false)
    public String kaihatsuGroupHead;

    /** eigyoプロパティ */
    @Column(length = 10, nullable = false, unique = false)
    public String eigyo;

    /** hattyuTypeCodeプロパティ */
    @Column(precision = 10, nullable = true, unique = false)
    public Integer hattyuTypeCode;

    /** hattyuMikomiDateプロパティ */
    @Column(length = 10, nullable = false, unique = false)
    public String hattyuMikomiDate;

    /** hattyuDateプロパティ */
    @Column(length = 10, nullable = true, unique = false)
    public String hattyuDate;

    /** kensyuDateプロパティ */
    @Column(length = 10, nullable = true, unique = false)
    public String kensyuDate;

    /** kakudoCodeプロパティ */
    @Column(precision = 10, nullable = false, unique = false)
    public Integer kakudoCode;

    /** jutyugakuプロパティ */
    @Column(precision = 14, nullable = false, unique = false)
    public BigDecimal jutyugaku;

    /** notesプロパティ */
    @Column(length = 1000, nullable = true, unique = false)
    public String notes;

    /** ukYokuyokuプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal ukYokuyoku;

    /** ukConditionCodeプロパティ */
    @Column(precision = 10, nullable = false, unique = false)
    public Integer ukConditionCode;

    /** insertDateプロパティ */
    @Column(nullable = false, unique = false)
    public Timestamp insertDate;

    /** insertEmpNoプロパティ */
    @Column(length = 10, nullable = false, unique = false)
    public String insertEmpNo;



    /** empMaster関連プロパティ */
    @ManyToOne
    @JoinColumn(name = "eigyo", referencedColumnName = "emp_no")
    public EmpMaster empMaster;

    /** insert関連プロパティ */
    @ManyToOne
    public EmpMaster insert;

    /** empMaster2関連プロパティ */
    @ManyToOne
    @JoinColumn(name = "kaihatsu_group_head", referencedColumnName = "emp_no")
    public EmpMaster empMaster2;

    /** uriageKeikakuList関連プロパティ */
    @OneToMany(mappedBy = "ankenRireki")
    public List<UriageKeikaku> uriageKeikakuList;

    /** anken関連プロパティ */
    @ManyToOne
    @JoinColumn(name = "anken_id", referencedColumnName = "anken_id")
    public Anken anken;
}