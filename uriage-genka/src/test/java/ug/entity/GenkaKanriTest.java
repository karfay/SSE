package ug.entity;

import javax.annotation.Generated;
import org.seasar.extension.jdbc.JdbcManager;
import org.seasar.extension.unit.S2TestCase;

import static ug.entity.GenkaKanriNames.*;

/**
 * {@link GenkaKanri}のテストクラスです。
 * 
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.EntityTestModelFactoryImpl"}, date = "2017/03/07 15:54:19")
public class GenkaKanriTest extends S2TestCase {

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
        jdbcManager.from(GenkaKanri.class).id(1).getSingleResult();
    }

    /**
     * empMasterとの外部結合をテストします。
     * 
     * @throws Exception
     */
    public void testLeftOuterJoin_empMaster() throws Exception {
        jdbcManager.from(GenkaKanri.class).leftOuterJoin(empMaster()).id(1).getSingleResult();
    }

    /**
     * empMaster2との外部結合をテストします。
     * 
     * @throws Exception
     */
    public void testLeftOuterJoin_empMaster2() throws Exception {
        jdbcManager.from(GenkaKanri.class).leftOuterJoin(empMaster2()).id(1).getSingleResult();
    }

    /**
     * empMaster3との外部結合をテストします。
     * 
     * @throws Exception
     */
    public void testLeftOuterJoin_empMaster3() throws Exception {
        jdbcManager.from(GenkaKanri.class).leftOuterJoin(empMaster3()).id(1).getSingleResult();
    }

    /**
     * gkMemoTableListとの外部結合をテストします。
     * 
     * @throws Exception
     */
    public void testLeftOuterJoin_gkMemoTableList() throws Exception {
        jdbcManager.from(GenkaKanri.class).leftOuterJoin(gkMemoTableList()).id(1).getSingleResult();
    }

    /**
     * kaihatsutaiseiListとの外部結合をテストします。
     * 
     * @throws Exception
     */
    public void testLeftOuterJoin_kaihatsutaiseiList() throws Exception {
        jdbcManager.from(GenkaKanri.class).leftOuterJoin(kaihatsutaiseiList()).id(1).getSingleResult();
    }

    /**
     * monthlyGenkaListとの外部結合をテストします。
     * 
     * @throws Exception
     */
    public void testLeftOuterJoin_monthlyGenkaList() throws Exception {
        jdbcManager.from(GenkaKanri.class).leftOuterJoin(monthlyGenkaList()).id(1).getSingleResult();
    }
}