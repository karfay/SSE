package ug.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;

import javax.annotation.Generated;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

/**
 * ThemeMasterエンティティクラス
 *
 */
@Entity
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.EntityModelFactoryImpl"}, date = "2017/03/07 15:54:09")
public class ThemeMaster implements Serializable {

    private static final long serialVersionUID = 1L;

    /** themeNoプロパティ */
    @Id
    @Column(length = 10, nullable = false, unique = true)
    public String themeNo;

    /** themeNameプロパティ */
    @Column(length = 100, nullable = false, unique = false)
    public String themeName;

    /** themeGroupプロパティ */
    @Column(length = 10, nullable = false, unique = false)
    public String themeGroup;

    /** shortThemeNameプロパティ */
    @Column(length = 100, nullable = true, unique = false)
    public String shortThemeName;

    /** naiyoKubunプロパティ */
    @Column(length = 10, nullable = true, unique = false)
    public String naiyoKubun;

    /** uketsukeDateプロパティ */
    @Column(length = 100, nullable = true, unique = false)
    public String uketsukeDate;

    /** iraiDateプロパティ */
    @Column(length = 10, nullable = true, unique = false)
    public String iraiDate;

    /** noukiプロパティ */
    @Column(length = 10, nullable = true, unique = false)
    public String nouki;

    /** jutyuKingakuプロパティ */
    @Column(precision = 14, nullable = true, unique = false)
    public BigDecimal jutyuKingaku;

    /** keikakuGenkaParプロパティ */
    @Column(precision = 22, nullable = true, unique = false)
    public Double keikakuGenkaPar;

    /** torihikisakiCodeプロパティ */
    @Column(length = 100, nullable = true, unique = false)
    public String torihikisakiCode;

    /** tantouBumonプロパティ */
    @Column(length = 100, nullable = true, unique = false)
    public String tantouBumon;

    /** uriageMonthKubunプロパティ */
    @Column(length = 10, nullable = true, unique = false)
    public String uriageMonthKubun;

    /** notesUriageMonthKubunプロパティ */
    @Column(length = 100, nullable = true, unique = false)
    public String notesUriageMonthKubun;

    /** uriageYearMonthプロパティ */
    @Column(length = 10, nullable = true, unique = false)
    public String uriageYearMonth;

    /** ankenRirekiList関連プロパティ */
    @OneToMany(mappedBy = "themeMaster")
    public List<UriageKeikaku> uriageKeikakuList;

    /** empMonthlyKousuList関連プロパティ */
    @OneToMany(mappedBy = "themeMaster")
    public List<EmpMonthlyKousu> empMonthlyKousuList;

    /** gaityuMonthlyCostList関連プロパティ */
    @OneToMany(mappedBy = "themeMaster")
    public List<GaityuMonthlyCost> gaityuMonthlyCostList;

    //TODO 新しく結合エンティティを追加したので試しにmigrateしてみる
    /** genkaKanri関連プロパティ */
    @ManyToOne
    @JoinColumn(name="theme_group", referencedColumnName="theme_group")
    public GenkaKanri genkaKanri;
}