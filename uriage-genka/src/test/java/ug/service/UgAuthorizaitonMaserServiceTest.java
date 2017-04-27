package ug.service;

import javax.annotation.Generated;
import org.seasar.extension.unit.S2TestCase;

/**
 * {@link UgAuthorizaitonMaserService}のテストクラスです。
 * 
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.ServiceTestModelFactoryImpl"}, date = "2017/03/07 15:54:22")
public class UgAuthorizaitonMaserServiceTest extends S2TestCase {

    private UgAuthorizaitonMaserService ugAuthorizaitonMaserService;

    /**
     * 事前処理をします。
     * 
     * @throws Exception
     */
    @Override
    protected void setUp() throws Exception {
        super.setUp();
        include("app.dicon");
    }

    /**
     * {@link #ugAuthorizaitonMaserService}が利用可能であることをテストします。
     * 
     * @throws Exception
     */
    public void testAvailable() throws Exception {
        assertNotNull(ugAuthorizaitonMaserService);
    }
}