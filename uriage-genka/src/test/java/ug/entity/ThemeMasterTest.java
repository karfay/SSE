package ug.entity;

import static ug.entity.ThemeMasterNames.*;

import javax.annotation.Generated;

import org.seasar.extension.jdbc.JdbcManager;
import org.seasar.extension.unit.S2TestCase;

/**
 * {@link ThemeMaster}のテストクラスです。
 *
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.EntityTestModelFactoryImpl"}, date = "2017/03/07 15:54:19")
public class ThemeMasterTest extends S2TestCase {

    private JdbcManager jdbcManager;

    /**
     * 事前処理をします。
     *
     * @throws Exception
     */
    @Override
    protected void setUp() throws Exception {
        super.setUp();
        include("s2jdbc.dicon");
    }

    /**
     * 識別子による取得をテストします。
     *
     * @throws Exception
     */
    public void testFindById() throws Exception {
        jdbcManager.from(ThemeMaster.class).id("aaa").getSingleResult();
    }

    /**
     * empMonthlyKousuListとの外部結合をテストします。
     *
     * @throws Exception
     */
    public void testLeftOuterJoin_empMonthlyKousuList() throws Exception {
        jdbcManager.from(ThemeMaster.class).leftOuterJoin(empMonthlyKousuList()).id("aaa").getSingleResult();
    }

    /**
     * gaityuMonthlyCostListとの外部結合をテストします。
     *
     * @throws Exception
     */
    public void testLeftOuterJoin_gaityuMonthlyCostList() throws Exception {
        jdbcManager.from(ThemeMaster.class).leftOuterJoin(gaityuMonthlyCostList()).id("aaa").getSingleResult();
    }

    /**
     * uriageKeikakuListとの外部結合をテストします。
     *
     * @throws Exception
     */
    public void testLeftOuterJoin_uriageKeikakuList() throws Exception {
        jdbcManager.from(UriageKeikaku.class).leftOuterJoin(uriageKeikakuList()).id("aaa").getSingleResult();
    }

}