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
 * MonthlyGenkaエンティティクラス
 *
 */
@Entity
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.EntityModelFactoryImpl"}, date = "2017/03/07 15:54:09")
public class MonthlyGenka implements Serializable {

	public MonthlyGenka(){
		KKousu = BigDecimal.ZERO;
		KRoumuhi = BigDecimal.ZERO;
		KGaityu = BigDecimal.ZERO;
		KRyohi = BigDecimal.ZERO;
		KSonota = BigDecimal.ZERO;
		KKeihi = BigDecimal.ZERO;
		KSum = BigDecimal.ZERO;
		KJGap = BigDecimal.ZERO;
		KMGap = BigDecimal.ZERO;
		KTanka = BigDecimal.ZERO;

		MKousu = BigDecimal.ZERO;
		MRoumuhi = BigDecimal.ZERO;
		MGaityu = BigDecimal.ZERO;
		MRyohi = BigDecimal.ZERO;
		MSonota = BigDecimal.ZERO;
		MKeihi = BigDecimal.ZERO;
		MSum = BigDecimal.ZERO;
		MTanka = BigDecimal.ZERO;

		JKousu = BigDecimal.ZERO;
		JRoumuhi = BigDecimal.ZERO;
		JGaityu = BigDecimal.ZERO;
		JRyohi = BigDecimal.ZERO;
		JSonota = BigDecimal.ZERO;
		JKeihi = BigDecimal.ZERO;
		JSum = BigDecimal.ZERO;
		JTanka = BigDecimal.ZERO;

		arari = BigDecimal.ZERO;
		arariPar = BigDecimal.ZERO;
		averageTanka = BigDecimal.ZERO;
	}

    private static final long serialVersionUID = 1L;

    /** monthlyGenkaIdプロパティ */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(precision = 10, nullable = false, unique = true)
    public Integer monthlyGenkaId;

    /** themeNoプロパティ */
    @Column(length = 10, nullable = true, unique = false)
    public String themeNo;

    /** themeGroupプロパティ */
    @Column(length = 10, nullable = false, unique = false)
    public String themeGroup;

    /** nendoプロパティ */
    @Column(precision = 10, nullable = false, unique = false)
    public Integer nendo;

    /** monthプロパティ */
    @Column(precision = 10, nullable = false, unique = false)
    public Integer month;

    /** gkConditionCodeプロパティ */
    @Column(precision = 10, nullable = true, unique = false)
    public Integer gkConditionCode;

    /** KRoumuhiプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal KRoumuhi;

    /** KKousuプロパティ */
    @Column(precision = 5, scale = 1, nullable = true, unique = false)
    public BigDecimal KKousu;

    /** KTankaプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal KTanka;

    /** KGaityuプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal KGaityu;

    /** KRyohiプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal KRyohi;

    /** KSonotaプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal KSonota;

    /** KKeihiプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal KKeihi;

    /** KSumプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal KSum;

    /** MRoumuhiプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal MRoumuhi;

    /** MKousuプロパティ */
    @Column(precision = 5, scale = 1, nullable = true, unique = false)
    public BigDecimal MKousu;

    /** MTankaプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal MTanka;

    /** MGaityuプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal MGaityu;

    /** MRyohiプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal MRyohi;

    /** MSonotaプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal MSonota;

    /** MKeihiプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal MKeihi;

    /** MSumプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal MSum;

    /** JRoumuhiプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal JRoumuhi;

    /** JKousuプロパティ */
    @Column(precision = 5, scale = 1, nullable = true, unique = false)
    public BigDecimal JKousu;

    /** JTankaプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal JTanka;

    /** JGaityuプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal JGaityu;

    /** JRyohiプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal JRyohi;

    /** JSonotaプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal JSonota;

    /** JKeihiプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal JKeihi;

    /** JSumプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal JSum;

    /** KMGapプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal KMGap;

    /** KJGapプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal KJGap;

    /** arariプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal arari;

    /** arariParプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal arariPar;

    /** averageTankaプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal averageTanka;

    /** genkaKanri関連プロパティ */
    @ManyToOne
    @JoinColumn(name = "theme_group", referencedColumnName = "theme_group")
    public GenkaKanri genkaKanri;

    /** 年度ソートマスタ関連プロパティ */
    @ManyToOne
    @JoinColumn(name="month", referencedColumnName="month")
    public NendoSortMaster nendoSortMaster;

}