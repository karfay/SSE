package ug.entity;

import static ug.entity.UriageKeikakuNames.*;

import javax.annotation.Generated;

import org.seasar.extension.jdbc.JdbcManager;
import org.seasar.extension.unit.S2TestCase;

/**
 * {@link UriageKeikaku}のテストクラスです。
 *
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.EntityTestModelFactoryImpl"}, date = "2017/03/07 15:54:19")
public class UriageKeikakuTest extends S2TestCase {

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
        jdbcManager.from(UriageKeikaku.class).id(1, 1).getSingleResult();
    }

    /**
     * ankenRirekiとの外部結合をテストします。
     *
     * @throws Exception
     */
    public void testLeftOuterJoin_ankenRireki() throws Exception {
        jdbcManager.from(UriageKeikaku.class).leftOuterJoin(ankenRireki()).id(1, 1).getSingleResult();
    }

    /**
     * themeMasterとの外部結合をテストします。
     *
     * @throws Exception
     */
    public void testLeftOuterJoin_themeMaster() throws Exception {
        jdbcManager.from(ThemeMaster.class).leftOuterJoin(themeMaster()).id(1, 1).getSingleResult();
    }
}