package ug.entity;

import javax.annotation.Generated;
import org.seasar.extension.jdbc.name.PropertyName;
import ug.entity.EmpMasterNames._EmpMasterNames;

/**
 * {@link EmpConditionMaster}のプロパティ名の集合です。
 * 
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.NamesModelFactoryImpl"}, date = "2017/04/26 17:27:54")
public class EmpConditionMasterNames {

    /**
     * empConditionCodeのプロパティ名を返します。
     * 
     * @return empConditionCodeのプロパティ名
     */
    public static PropertyName<Integer> empConditionCode() {
        return new PropertyName<Integer>("empConditionCode");
    }

    /**
     * empConditionNameのプロパティ名を返します。
     * 
     * @return empConditionNameのプロパティ名
     */
    public static PropertyName<String> empConditionName() {
        return new PropertyName<String>("empConditionName");
    }

    /**
     * empMasterListのプロパティ名を返します。
     * 
     * @return empMasterListのプロパティ名
     */
    public static _EmpMasterNames empMasterList() {
        return new _EmpMasterNames("empMasterList");
    }

    /**
     * @author S2JDBC-Gen
     */
    public static class _EmpConditionMasterNames extends PropertyName<EmpConditionMaster> {

        /**
         * インスタンスを構築します。
         */
        public _EmpConditionMasterNames() {
        }

        /**
         * インスタンスを構築します。
         * 
         * @param name
         *            名前
         */
        public _EmpConditionMasterNames(final String name) {
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
        public _EmpConditionMasterNames(final PropertyName<?> parent, final String name) {
            super(parent, name);
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
         * empConditionNameのプロパティ名を返します。
         *
         * @return empConditionNameのプロパティ名
         */
        public PropertyName<String> empConditionName() {
            return new PropertyName<String>(this, "empConditionName");
        }

        /**
         * empMasterListのプロパティ名を返します。
         * 
         * @return empMasterListのプロパティ名
         */
        public _EmpMasterNames empMasterList() {
            return new _EmpMasterNames(this, "empMasterList");
        }
    }
}