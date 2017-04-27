package ug.entity;

import javax.annotation.Generated;
import org.seasar.extension.jdbc.name.PropertyName;
import ug.entity.AnkenRirekiNames._AnkenRirekiNames;
import ug.entity.EmpAuthRelationNames._EmpAuthRelationNames;
import ug.entity.EmpConditionMasterNames._EmpConditionMasterNames;
import ug.entity.EmpMonthlyKousuNames._EmpMonthlyKousuNames;
import ug.entity.GaityuMonthlyCostNames._GaityuMonthlyCostNames;
import ug.entity.GenkaKanriNames._GenkaKanriNames;
import ug.entity.KaihatsutaiseiNames._KaihatsutaiseiNames;

/**
 * {@link EmpMaster}のプロパティ名の集合です。
 * 
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.NamesModelFactoryImpl"}, date = "2017/04/26 17:27:54")
public class EmpMasterNames {

    /**
     * empNoのプロパティ名を返します。
     * 
     * @return empNoのプロパティ名
     */
    public static PropertyName<String> empNo() {
        return new PropertyName<String>("empNo");
    }

    /**
     * empNameのプロパティ名を返します。
     * 
     * @return empNameのプロパティ名
     */
    public static PropertyName<String> empName() {
        return new PropertyName<String>("empName");
    }

    /**
     * loginIdのプロパティ名を返します。
     * 
     * @return loginIdのプロパティ名
     */
    public static PropertyName<String> loginId() {
        return new PropertyName<String>("loginId");
    }

    /**
     * passwordのプロパティ名を返します。
     * 
     * @return passwordのプロパティ名
     */
    public static PropertyName<String> password() {
        return new PropertyName<String>("password");
    }

    /**
     * authorizationのプロパティ名を返します。
     * 
     * @return authorizationのプロパティ名
     */
    public static PropertyName<String> authorization() {
        return new PropertyName<String>("authorization");
    }

    /**
     * shortEmpNameのプロパティ名を返します。
     * 
     * @return shortEmpNameのプロパティ名
     */
    public static PropertyName<String> shortEmpName() {
        return new PropertyName<String>("shortEmpName");
    }

    /**
     * empConditionCodeのプロパティ名を返します。
     * 
     * @return empConditionCodeのプロパティ名
     */
    public static PropertyName<Integer> empConditionCode() {
        return new PropertyName<Integer>("empConditionCode");
    }

    /**
     * ankenRirekiListのプロパティ名を返します。
     * 
     * @return ankenRirekiListのプロパティ名
     */
    public static _AnkenRirekiNames ankenRirekiList() {
        return new _AnkenRirekiNames("ankenRirekiList");
    }

    /**
     * ankenRirekiList2のプロパティ名を返します。
     * 
     * @return ankenRirekiList2のプロパティ名
     */
    public static _AnkenRirekiNames ankenRirekiList2() {
        return new _AnkenRirekiNames("ankenRirekiList2");
    }

    /**
     * ankenRirekiList3のプロパティ名を返します。
     * 
     * @return ankenRirekiList3のプロパティ名
     */
    public static _AnkenRirekiNames ankenRirekiList3() {
        return new _AnkenRirekiNames("ankenRirekiList3");
    }

    /**
     * empAuthRelationListのプロパティ名を返します。
     * 
     * @return empAuthRelationListのプロパティ名
     */
    public static _EmpAuthRelationNames empAuthRelationList() {
        return new _EmpAuthRelationNames("empAuthRelationList");
    }

    /**
     * empConditionMasterのプロパティ名を返します。
     * 
     * @return empConditionMasterのプロパティ名
     */
    public static _EmpConditionMasterNames empConditionMaster() {
        return new _EmpConditionMasterNames("empConditionMaster");
    }

    /**
     * empMonthlyKousuListのプロパティ名を返します。
     * 
     * @return empMonthlyKousuListのプロパティ名
     */
    public static _EmpMonthlyKousuNames empMonthlyKousuList() {
        return new _EmpMonthlyKousuNames("empMonthlyKousuList");
    }

    /**
     * gaityuMonthlyCostListのプロパティ名を返します。
     * 
     * @return gaityuMonthlyCostListのプロパティ名
     */
    public static _GaityuMonthlyCostNames gaityuMonthlyCostList() {
        return new _GaityuMonthlyCostNames("gaityuMonthlyCostList");
    }

    /**
     * genkaKanriListのプロパティ名を返します。
     * 
     * @return genkaKanriListのプロパティ名
     */
    public static _GenkaKanriNames genkaKanriList() {
        return new _GenkaKanriNames("genkaKanriList");
    }

    /**
     * genkaKanriList2のプロパティ名を返します。
     * 
     * @return genkaKanriList2のプロパティ名
     */
    public static _GenkaKanriNames genkaKanriList2() {
        return new _GenkaKanriNames("genkaKanriList2");
    }

    /**
     * genkaKanriList3のプロパティ名を返します。
     * 
     * @return genkaKanriList3のプロパティ名
     */
    public static _GenkaKanriNames genkaKanriList3() {
        return new _GenkaKanriNames("genkaKanriList3");
    }

    /**
     * kaihatsutaiseiListのプロパティ名を返します。
     * 
     * @return kaihatsutaiseiListのプロパティ名
     */
    public static _KaihatsutaiseiNames kaihatsutaiseiList() {
        return new _KaihatsutaiseiNames("kaihatsutaiseiList");
    }

    /**
     * @author S2JDBC-Gen
     */
    public static class _EmpMasterNames extends PropertyName<EmpMaster> {

        /**
         * インスタンスを構築します。
         */
        public _EmpMasterNames() {
        }

        /**
         * インスタンスを構築します。
         * 
         * @param name
         *            名前
         */
        public _EmpMasterNames(final String name) {
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
        public _EmpMasterNames(final PropertyName<?> parent, final String name) {
            super(parent, name);
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
         * empNameのプロパティ名を返します。
         *
         * @return empNameのプロパティ名
         */
        public PropertyName<String> empName() {
            return new PropertyName<String>(this, "empName");
        }

        /**
         * loginIdのプロパティ名を返します。
         *
         * @return loginIdのプロパティ名
         */
        public PropertyName<String> loginId() {
            return new PropertyName<String>(this, "loginId");
        }

        /**
         * passwordのプロパティ名を返します。
         *
         * @return passwordのプロパティ名
         */
        public PropertyName<String> password() {
            return new PropertyName<String>(this, "password");
        }

        /**
         * authorizationのプロパティ名を返します。
         *
         * @return authorizationのプロパティ名
         */
        public PropertyName<String> authorization() {
            return new PropertyName<String>(this, "authorization");
        }

        /**
         * shortEmpNameのプロパティ名を返します。
         *
         * @return shortEmpNameのプロパティ名
         */
        public PropertyName<String> shortEmpName() {
            return new PropertyName<String>(this, "shortEmpName");
        }

        /**
         * empConditionCodeのプロパティ名を返します。
         *
         * @return empConditionCodeのプロパティ名
         */
        public PropertyName<Integer> empConditionCode() {
            return new PropertyName<Integer>(this, "empConditionCode");
        }

        /**
         * ankenRirekiListのプロパティ名を返します。
         * 
         * @return ankenRirekiListのプロパティ名
         */
        public _AnkenRirekiNames ankenRirekiList() {
            return new _AnkenRirekiNames(this, "ankenRirekiList");
        }

        /**
         * ankenRirekiList2のプロパティ名を返します。
         * 
         * @return ankenRirekiList2のプロパティ名
         */
        public _AnkenRirekiNames ankenRirekiList2() {
            return new _AnkenRirekiNames(this, "ankenRirekiList2");
        }

        /**
         * ankenRirekiList3のプロパティ名を返します。
         * 
         * @return ankenRirekiList3のプロパティ名
         */
        public _AnkenRirekiNames ankenRirekiList3() {
            return new _AnkenRirekiNames(this, "ankenRirekiList3");
        }

        /**
         * empAuthRelationListのプロパティ名を返します。
         * 
         * @return empAuthRelationListのプロパティ名
         */
        public _EmpAuthRelationNames empAuthRelationList() {
            return new _EmpAuthRelationNames(this, "empAuthRelationList");
        }

        /**
         * empConditionMasterのプロパティ名を返します。
         * 
         * @return empConditionMasterのプロパティ名
         */
        public _EmpConditionMasterNames empConditionMaster() {
            return new _EmpConditionMasterNames(this, "empConditionMaster");
        }

        /**
         * empMonthlyKousuListのプロパティ名を返します。
         * 
         * @return empMonthlyKousuListのプロパティ名
         */
        public _EmpMonthlyKousuNames empMonthlyKousuList() {
            return new _EmpMonthlyKousuNames(this, "empMonthlyKousuList");
        }

        /**
         * gaityuMonthlyCostListのプロパティ名を返します。
         * 
         * @return gaityuMonthlyCostListのプロパティ名
         */
        public _GaityuMonthlyCostNames gaityuMonthlyCostList() {
            return new _GaityuMonthlyCostNames(this, "gaityuMonthlyCostList");
        }

        /**
         * genkaKanriListのプロパティ名を返します。
         * 
         * @return genkaKanriListのプロパティ名
         */
        public _GenkaKanriNames genkaKanriList() {
            return new _GenkaKanriNames(this, "genkaKanriList");
        }

        /**
         * genkaKanriList2のプロパティ名を返します。
         * 
         * @return genkaKanriList2のプロパティ名
         */
        public _GenkaKanriNames genkaKanriList2() {
            return new _GenkaKanriNames(this, "genkaKanriList2");
        }

        /**
         * genkaKanriList3のプロパティ名を返します。
         * 
         * @return genkaKanriList3のプロパティ名
         */
        public _GenkaKanriNames genkaKanriList3() {
            return new _GenkaKanriNames(this, "genkaKanriList3");
        }

        /**
         * kaihatsutaiseiListのプロパティ名を返します。
         * 
         * @return kaihatsutaiseiListのプロパティ名
         */
        public _KaihatsutaiseiNames kaihatsutaiseiList() {
            return new _KaihatsutaiseiNames(this, "kaihatsutaiseiList");
        }
    }
}