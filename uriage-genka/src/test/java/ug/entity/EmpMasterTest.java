package ug.entity;

import javax.annotation.Generated;
import org.seasar.extension.jdbc.JdbcManager;
import org.seasar.extension.unit.S2TestCase;

import static ug.entity.EmpMasterNames.*;

/**
 * {@link EmpMaster}のテストクラスです。
 * 
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.EntityTestModelFactoryImpl"}, date = "2017/03/07 15:54:19")
public class EmpMasterTest extends S2TestCase {

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
        jdbcManager.from(EmpMaster.class).id("aaa").getSingleResult();
    }

    /**
     * ankenRirekiListとの外部結合をテストします。
     * 
     * @throws Exception
     */
    public void testLeftOuterJoin_ankenRirekiList() throws Exception {
        jdbcManager.from(EmpMaster.class).leftOuterJoin(ankenRirekiList()).id("aaa").getSingleResult();
    }

    /**
     * ankenRirekiList2との外部結合をテストします。
     * 
     * @throws Exception
     */
    public void testLeftOuterJoin_ankenRirekiList2() throws Exception {
        jdbcManager.from(EmpMaster.class).leftOuterJoin(ankenRirekiList2()).id("aaa").getSingleResult();
    }

    /**
     * ankenRirekiList3との外部結合をテストします。
     * 
     * @throws Exception
     */
    public void testLeftOuterJoin_ankenRirekiList3() throws Exception {
        jdbcManager.from(EmpMaster.class).leftOuterJoin(ankenRirekiList3()).id("aaa").getSingleResult();
    }

    /**
     * empAuthRelationListとの外部結合をテストします。
     * 
     * @throws Exception
     */
    public void testLeftOuterJoin_empAuthRelationList() throws Exception {
        jdbcManager.from(EmpMaster.class).leftOuterJoin(empAuthRelationList()).id("aaa").getSingleResult();
    }

    /**
     * empConditionMasterとの外部結合をテストします。
     * 
     * @throws Exception
     */
    public void testLeftOuterJoin_empConditionMaster() throws Exception {
        jdbcManager.from(EmpMaster.class).leftOuterJoin(empConditionMaster()).id("aaa").getSingleResult();
    }

    /**
     * empMonthlyKousuListとの外部結合をテストします。
     * 
     * @throws Exception
     */
    public void testLeftOuterJoin_empMonthlyKousuList() throws Exception {
        jdbcManager.from(EmpMaster.class).leftOuterJoin(empMonthlyKousuList()).id("aaa").getSingleResult();
    }

    /**
     * gaityuMonthlyCostListとの外部結合をテストします。
     * 
     * @throws Exception
     */
    public void testLeftOuterJoin_gaityuMonthlyCostList() throws Exception {
        jdbcManager.from(EmpMaster.class).leftOuterJoin(gaityuMonthlyCostList()).id("aaa").getSingleResult();
    }

    /**
     * genkaKanriListとの外部結合をテストします。
     * 
     * @throws Exception
     */
    public void testLeftOuterJoin_genkaKanriList() throws Exception {
        jdbcManager.from(EmpMaster.class).leftOuterJoin(genkaKanriList()).id("aaa").getSingleResult();
    }

    /**
     * genkaKanriList2との外部結合をテストします。
     * 
     * @throws Exception
     */
    public void testLeftOuterJoin_genkaKanriList2() throws Exception {
        jdbcManager.from(EmpMaster.class).leftOuterJoin(genkaKanriList2()).id("aaa").getSingleResult();
    }

    /**
     * genkaKanriList3との外部結合をテストします。
     * 
     * @throws Exception
     */
    public void testLeftOuterJoin_genkaKanriList3() throws Exception {
        jdbcManager.from(EmpMaster.class).leftOuterJoin(genkaKanriList3()).id("aaa").getSingleResult();
    }

    /**
     * kaihatsutaiseiListとの外部結合をテストします。
     * 
     * @throws Exception
     */
    public void testLeftOuterJoin_kaihatsutaiseiList() throws Exception {
        jdbcManager.from(EmpMaster.class).leftOuterJoin(kaihatsutaiseiList()).id("aaa").getSingleResult();
    }
}