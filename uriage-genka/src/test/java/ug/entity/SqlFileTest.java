package ug.entity;

import java.io.InputStream;
import java.io.Reader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.annotation.Generated;

import org.seasar.extension.jdbc.JdbcManager;
import org.seasar.extension.jdbc.manager.JdbcManagerImplementor;
import org.seasar.extension.jdbc.util.ConnectionUtil;
import org.seasar.extension.unit.S2TestCase;
import org.seasar.framework.exception.ResourceNotFoundRuntimeException;
import org.seasar.framework.util.InputStreamReaderUtil;
import org.seasar.framework.util.PreparedStatementUtil;
import org.seasar.framework.util.ReaderUtil;
import org.seasar.framework.util.ResourceUtil;
import org.seasar.framework.util.StatementUtil;

/**
 * SQLファイルのテストクラスです。
 * <p>
 * このファイルは修正されることを意図していません。
 * SQLファイルのテストを独自に行いたい場合は、サービスやエンティティのテストクラスを使用してください。
 * </p>
 *
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.SqlFileTestModelFactoryImpl"}, date = "2017/04/28 15:30:37")
public class SqlFileTest extends S2TestCase {

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
     * SQLファイルをテストします。
     * 
     * @throws Exception
     */
    public void testSqlFile0Tx() throws Exception {
        String path = "META-INF/sql/gk/get_anken_rireki_from_theme_group.sql";
        new SqlFile(path).execute();
    }

    /**
     * SQLファイルをテストします。
     * 
     * @throws Exception
     */
    public void testSqlFile1Tx() throws Exception {
        String path = "META-INF/sql/gk/get_gk_for_create.sql";
        new SqlFile(path).execute();
    }

    /**
     * SQLファイルをテストします。
     * 
     * @throws Exception
     */
    public void testSqlFile2Tx() throws Exception {
        String path = "META-INF/sql/gk/get_gk_for_update.sql";
        new SqlFile(path).execute();
    }

    /**
     * SQLファイルをテストします。
     * 
     * @throws Exception
     */
    public void testSqlFile3Tx() throws Exception {
        String path = "META-INF/sql/gk/get_pj_genka_sum.sql";
        new SqlFile(path).execute();
    }

    /**
     * SQLファイルをテストします。
     * 
     * @throws Exception
     */
    public void testSqlFile4Tx() throws Exception {
        String path = "META-INF/sql/gk/get_shikakari_genka_sum.sql";
        new SqlFile(path).execute();
    }

    /**
     * SQLファイルをテストします。
     * 
     * @throws Exception
     */
    public void testSqlFile5Tx() throws Exception {
        String path = "META-INF/sql/gk/get_uk_nendo_sum_from_gk_id.sql";
        new SqlFile(path).execute();
    }

    /**
     * SQLファイルをテストします。
     * 
     * @throws Exception
     */
    public void testSqlFile6Tx() throws Exception {
        String path = "META-INF/sql/gk/get_uk_nendo_sum_from_theme_group.sql";
        new SqlFile(path).execute();
    }

    /**
     * SQLファイルをテストします。
     * 
     * @throws Exception
     */
    public void testSqlFile7Tx() throws Exception {
        String path = "META-INF/sql/gk/get_uk_theme_no_sum_from_theme_group.sql";
        new SqlFile(path).execute();
    }

    /**
     * SQLファイルをテストします。
     * 
     * @throws Exception
     */
    public void testSqlFile8Tx() throws Exception {
        String path = "META-INF/sql/selectUserDataDto.sql";
        new SqlFile(path).execute();
    }

    /**
     * SQLファイルをテストします。
     * 
     * @throws Exception
     */
    public void testSqlFile9Tx() throws Exception {
        String path = "META-INF/sql/ukList/conditional_search.sql";
        new SqlFile(path).execute();
    }

    /**
     * SQLファイルをテストします。
     * 
     * @throws Exception
     */
    public void testSqlFile10Tx() throws Exception {
        String path = "META-INF/sql/ukList/select_nendo_list.sql";
        new SqlFile(path).execute();
    }

    /**
     * SQLファイルを表すクラスです。
     * 
     * @author S2JDBC-Gen
     */
    public class SqlFile {

        /** SQL */
        protected String sql;

        /** 内部的なJDBCマネジャ */
        protected JdbcManagerImplementor implementor;

        /**
         * インスタンスを構築します。
         * 
         * @param path
         *            SQLファイルのパス
         */
        public SqlFile(String path) {
            implementor = JdbcManagerImplementor.class.cast(jdbcManager);
            this.sql = getSql(path);
        }

        /**
         * SQLを返します。
         * 
         * @param path
         *            SQLファイルのパス
         * @return SQL
         */
        protected String getSql(String path) {
            if (path.endsWith(".sql")) {
                path = path.substring(0, path.length() - 4);
            }
            String dbmsName = implementor.getDialect().getName();
            if (dbmsName != null) {
                String sql = readSql(path + "_" + dbmsName);
                if (sql != null) {
                    return sql;
                }
            }
            String sql = readSql(path);
            if (sql != null) {
                return sql;
            }
            throw new ResourceNotFoundRuntimeException(path);
        }

        /**
         * SQLをファイルから読み取ります。
         * 
         * @param path
         *            SQLファイルのパス
         * @return SQL
         */
        protected String readSql(String path) {
            InputStream is = ResourceUtil.getResourceAsStreamNoException(path,
                    "sql");
            if (is == null) {
                return null;
            }
            Reader reader = InputStreamReaderUtil.create(is, "UTF-8");
            String sql = ReaderUtil.readText(reader);
            if (sql.length() > 0 && sql.charAt(0) == '\uFEFF') {
                sql = sql.substring(1);
            }
            sql = sql.trim();
            if (sql.endsWith(";")) {
                sql = sql.substring(0, sql.length() - 1);
            }
            return sql;
        }

        /**
         * SQLを実行します。
         */
        public void execute() {
            System.out.println(sql);
            Connection connection = org.seasar.extension.jdbc.util.DataSourceUtil
                    .getConnection(implementor.getDataSource());
            try {
                PreparedStatement ps = ConnectionUtil.prepareStatement(
                        connection, sql);
                try {
                    PreparedStatementUtil.execute(ps);
                } finally {
                    StatementUtil.close(ps);
                }
            } finally {
                ConnectionUtil.close(connection);
            }
        }
    }
}