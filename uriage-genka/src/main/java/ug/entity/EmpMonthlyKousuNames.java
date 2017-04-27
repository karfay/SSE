package ug.entity;

import java.math.BigDecimal;
import javax.annotation.Generated;
import org.seasar.extension.jdbc.name.PropertyName;
import ug.entity.EmpMasterNames._EmpMasterNames;
import ug.entity.ThemeMasterNames._ThemeMasterNames;

/**
 * {@link EmpMonthlyKousu}のプロパティ名の集合です。
 * 
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.NamesModelFactoryImpl"}, date = "2017/04/26 17:27:54")
public class EmpMonthlyKousuNames {

    /**
     * emkIdのプロパティ名を返します。
     * 
     * @return emkIdのプロパティ名
     */
    public static PropertyName<Integer> emkId() {
        return new PropertyName<Integer>("emkId");
    }

    /**
     * themeNoのプロパティ名を返します。
     * 
     * @return themeNoのプロパティ名
     */
    public static PropertyName<String> themeNo() {
        return new PropertyName<String>("themeNo");
    }

    /**
     * empNoのプロパティ名を返します。
     * 
     * @return empNoのプロパティ名
     */
    public static PropertyName<String> empNo() {
        return new PropertyName<String>("empNo");
    }

    /**
     * nendoのプロパティ名を返します。
     * 
     * @return nendoのプロパティ名
     */
    public static PropertyName<Integer> nendo() {
        return new PropertyName<Integer>("nendo");
    }

    /**
     * monthのプロパティ名を返します。
     * 
     * @return monthのプロパティ名
     */
    public static PropertyName<Integer> month() {
        return new PropertyName<Integer>("month");
    }

    /**
     * KKousuのプロパティ名を返します。
     * 
     * @return KKousuのプロパティ名
     */
    public static PropertyName<BigDecimal> KKousu() {
        return new PropertyName<BigDecimal>("KKousu");
    }

    /**
     * MKousuのプロパティ名を返します。
     * 
     * @return MKousuのプロパティ名
     */
    public static PropertyName<BigDecimal> MKousu() {
        return new PropertyName<BigDecimal>("MKousu");
    }

    /**
     * JKousuのプロパティ名を返します。
     * 
     * @return JKousuのプロパティ名
     */
    public static PropertyName<BigDecimal> JKousu() {
        return new PropertyName<BigDecimal>("JKousu");
    }

    /**
     * themeMasterのプロパティ名を返します。
     * 
     * @return themeMasterのプロパティ名
     */
    public static _ThemeMasterNames themeMaster() {
        return new _ThemeMasterNames("themeMaster");
    }

    /**
     * empMasterのプロパティ名を返します。
     * 
     * @return empMasterのプロパティ名
     */
    public static _EmpMasterNames empMaster() {
        return new _EmpMasterNames("empMaster");
    }

    /**
     * @author S2JDBC-Gen
     */
    public static class _EmpMonthlyKousuNames extends PropertyName<EmpMonthlyKousu> {

        /**
         * インスタンスを構築します。
         */
        public _EmpMonthlyKousuNames() {
        }

        /**
         * インスタンスを構築します。
         * 
         * @param name
         *            名前
         */
        public _EmpMonthlyKousuNames(final String name) {
            super(name);
        }

        /**
         * インスタンスを構築します。
         * 
         * @param parent
         *            親
         * @param name
         *            名前
         */
        public _EmpMonthlyKousuNames(final PropertyName<?> parent, final String name) {
            super(parent, name);
        }

        /**
         * emkIdのプロパティ名を返します。
         *
         * @return emkIdのプロパティ名
         */
        public PropertyName<Integer> emkId() {
            return new PropertyName<Integer>(this, "emkId");
        }

        /**
         * themeNoのプロパティ名を返します。
         *
         * @return themeNoのプロパティ名
         */
        public PropertyName<String> themeNo() {
            return new PropertyName<String>(this, "themeNo");
        }

        /**
         * empNoのプロパティ名を返します。
         *
         * @return empNoのプロパティ名
         */
        public PropertyName<String> empNo() {
            return new PropertyName<String>(this, "empNo");
        }

        /**
         * nendoのプロパティ名を返します。
         *
         * @return nendoのプロパティ名
         */
        public PropertyName<Integer> nendo() {
            return new PropertyName<Integer>(this, "nendo");
        }

        /**
         * monthのプロパティ名を返します。
         *
         * @return monthのプロパティ名
         */
        public PropertyName<Integer> month() {
            return new PropertyName<Integer>(this, "month");
        }

        /**
         * KKousuのプロパティ名を返します。
         *
         * @return KKousuのプロパティ名
         */
        public PropertyName<BigDecimal> KKousu() {
            return new PropertyName<BigDecimal>(this, "KKousu");
        }

        /**
         * MKousuのプロパティ名を返します。
         *
         * @return MKousuのプロパティ名
         */
        public PropertyName<BigDecimal> MKousu() {
            return new PropertyName<BigDecimal>(this, "MKousu");
        }

        /**
         * JKousuのプロパティ名を返します。
         *
         * @return JKousuのプロパティ名
         */
        public PropertyName<BigDecimal> JKousu() {
            return new PropertyName<BigDecimal>(this, "JKousu");
        }

        /**
         * themeMasterのプロパティ名を返します。
         * 
         * @return themeMasterのプロパティ名
         */
        public _ThemeMasterNames themeMaster() {
            return new _ThemeMasterNames(this, "themeMaster");
        }

        /**
         * empMasterのプロパティ名を返します。
         * 
         * @return empMasterのプロパティ名
         */
        public _EmpMasterNames empMaster() {
            return new _EmpMasterNames(this, "empMaster");
        }
    }
}