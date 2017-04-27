package ug.entity;

import static ug.entity.AnkenRirekiNames.*;

import javax.annotation.Generated;

import org.seasar.extension.jdbc.JdbcManager;
import org.seasar.extension.unit.S2TestCase;

/**
 * {@link AnkenRireki}のテストクラスです。
 *
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.EntityTestModelFactoryImpl"}, date = "2017/03/07 15:54:19")
public class AnkenRirekiTest extends S2TestCase {

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
        jdbcManager.from(AnkenRireki.class).id(1).getSingleResult();
    }

    /**
     * empMasterとの外部結合をテストします。
     *
     * @throws Exception
     */
    public void testLeftOuterJoin_empMaster() throws Exception {
        jdbcManager.from(AnkenRireki.class).leftOuterJoin(empMaster()).id(1).getSingleResult();
    }

    /**
     * insertとの外部結合をテストします。
     *
     * @throws Exception
     */
    public void testLeftOuterJoin_insert() throws Exception {
        jdbcManager.from(AnkenRireki.class).leftOuterJoin(insert()).id(1).getSingleResult();
    }

    /**
     * empMaster2との外部結合をテストします。
     *
     * @throws Exception
     */
    public void testLeftOuterJoin_empMaster2() throws Exception {
        jdbcManager.from(AnkenRireki.class).leftOuterJoin(empMaster2()).id(1).getSingleResult();
    }

    /**
     * uriageKeikakuListとの外部結合をテストします。
     *
     * @throws Exception
     */
    public void testLeftOuterJoin_uriageKeikakuList() throws Exception {
        jdbcManager.from(AnkenRireki.class).leftOuterJoin(uriageKeikakuList()).id(1).getSingleResult();
    }
}