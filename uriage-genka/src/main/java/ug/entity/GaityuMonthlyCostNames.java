package ug.entity;

import java.math.BigDecimal;
import javax.annotation.Generated;
import org.seasar.extension.jdbc.name.PropertyName;
import ug.entity.EmpMasterNames._EmpMasterNames;
import ug.entity.ThemeMasterNames._ThemeMasterNames;

/**
 * {@link GaityuMonthlyCost}のプロパティ名の集合です。
 * 
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.NamesModelFactoryImpl"}, date = "2017/04/26 17:27:54")
public class GaityuMonthlyCostNames {

    /**
     * gmcIdのプロパティ名を返します。
     * 
     * @return gmcIdのプロパティ名
     */
    public static PropertyName<Integer> gmcId() {
        return new PropertyName<Integer>("gmcId");
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
     * KCostのプロパティ名を返します。
     * 
     * @return KCostのプロパティ名
     */
    public static PropertyName<BigDecimal> KCost() {
        return new PropertyName<BigDecimal>("KCost");
    }

    /**
     * MCostのプロパティ名を返します。
     * 
     * @return MCostのプロパティ名
     */
    public static PropertyName<BigDecimal> MCost() {
        return new PropertyName<BigDecimal>("MCost");
    }

    /**
     * JCostのプロパティ名を返します。
     * 
     * @return JCostのプロパティ名
     */
    public static PropertyName<BigDecimal> JCost() {
        return new PropertyName<BigDecimal>("JCost");
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
    public static class _GaityuMonthlyCostNames extends PropertyName<GaityuMonthlyCost> {

        /**
         * インスタンスを構築します。
         */
        public _GaityuMonthlyCostNames() {
        }

        /**
         * インスタンスを構築します。
         * 
         * @param name
         *            名前
         */
        public _GaityuMonthlyCostNames(final String name) {
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
        public _GaityuMonthlyCostNames(final PropertyName<?> parent, final String name) {
            super(parent, name);
        }

        /**
         * gmcIdのプロパティ名を返します。
         *
         * @return gmcIdのプロパティ名
         */
        public PropertyName<Integer> gmcId() {
            return new PropertyName<Integer>(this, "gmcId");
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
         * KCostのプロパティ名を返します。
         *
         * @return KCostのプロパティ名
         */
        public PropertyName<BigDecimal> KCost() {
            return new PropertyName<BigDecimal>(this, "KCost");
        }

        /**
         * MCostのプロパティ名を返します。
         *
         * @return MCostのプロパティ名
         */
        public PropertyName<BigDecimal> MCost() {
            return new PropertyName<BigDecimal>(this, "MCost");
        }

        /**
         * JCostのプロパティ名を返します。
         *
         * @return JCostのプロパティ名
         */
        public PropertyName<BigDecimal> JCost() {
            return new PropertyName<BigDecimal>(this, "JCost");
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