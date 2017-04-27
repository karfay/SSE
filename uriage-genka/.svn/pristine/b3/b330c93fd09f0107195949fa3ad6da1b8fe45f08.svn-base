package ug.entity;

import javax.annotation.Generated;
import org.seasar.extension.jdbc.JdbcManager;
import org.seasar.extension.unit.S2TestCase;

import static ug.entity.UgAuthorizaitonMaserNames.*;

/**
 * {@link UgAuthorizaitonMaser}のテストクラスです。
 * 
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.EntityTestModelFactoryImpl"}, date = "2017/03/07 15:54:19")
public class UgAuthorizaitonMaserTest extends S2TestCase {

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
        jdbcManager.from(UgAuthorizaitonMaser.class).id(1).getSingleResult();
    }

    /**
     * empAuthRelationListとの外部結合をテストします。
     * 
     * @throws Exception
     */
    public void testLeftOuterJoin_empAuthRelationList() throws Exception {
        jdbcManager.from(UgAuthorizaitonMaser.class).leftOuterJoin(empAuthRelationList()).id(1).getSingleResult();
    }
}