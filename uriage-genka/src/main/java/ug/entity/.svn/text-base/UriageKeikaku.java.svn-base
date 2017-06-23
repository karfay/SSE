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
 * UriageKeikakuエンティティクラス
 *
 */
@Entity
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.EntityModelFactoryImpl"}, date = "2017/03/07 15:54:09")
public class UriageKeikaku implements Serializable {

    private static final long serialVersionUID = 1L;

    //private static DecimalFormat df1 = new DecimalFormat("###,###");

    /** ukIdプロパティ */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(precision = 10, nullable = false, unique = true)
    public Integer ukId;

    /** ankenRirekiIdプロパティ */
    @Column(precision = 10, nullable = false, unique = false)
    public Integer ankenRirekiId;

    /** themeNoプロパティ */
    @Column(length = 10, nullable = true, unique = false)
    public String themeNo;

    /** nendoプロパティ */
    @Id
    @Column(precision = 10, nullable = false, unique = false)
    public Integer nendo;

    /** ukAprプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal ukApr;

    /** ukMayプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal ukMay;

    /** ukJunプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal ukJun;

    /** ukJulプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal ukJul;

    /** ukAugプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal ukAug;

    /** ukSepプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal ukSep;

    /** ukOctプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal ukOct;

    /** ukNovプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal ukNov;

    /** ukDecプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal ukDec;

    /** ukJanプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal ukJan;

    /** ukFebプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal ukFeb;

    /** ukMarプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal ukMar;

    /** ankenRireki関連プロパティ */
    @ManyToOne
    @JoinColumn(name = "anken_rireki_id", referencedColumnName = "anken_rireki_id")
    public AnkenRireki ankenRireki;

    /** ukKamikiプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
	public BigDecimal ukKamiki;

    /** ukShimokiプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
	public BigDecimal ukShimoki;

    /** ukTotalプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
	public BigDecimal ukTotal;

    /** themeMaster関連プロパティ */
    @ManyToOne
    @JoinColumn(name = "theme_no", referencedColumnName = "theme_no")
    public ThemeMaster themeMaster;


}