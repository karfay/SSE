package ug.entity;

import javax.annotation.Generated;
import org.seasar.extension.jdbc.name.PropertyName;
import ug.entity.EmpMasterNames._EmpMasterNames;
import ug.entity.UgAuthorizaitonMaserNames._UgAuthorizaitonMaserNames;

/**
 * {@link EmpAuthRelation}のプロパティ名の集合です。
 * 
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.NamesModelFactoryImpl"}, date = "2017/04/28 15:30:26")
public class EmpAuthRelationNames {

    /**
     * empNoのプロパティ名を返します。
     * 
     * @return empNoのプロパティ名
     */
    public static PropertyName<String> empNo() {
        return new PropertyName<String>("empNo");
    }

    /**
     * authIdのプロパティ名を返します。
     * 
     * @return authIdのプロパティ名
     */
    public static PropertyName<Integer> authId() {
        return new PropertyName<Integer>("authId");
    }

    /**
     * sysIdのプロパティ名を返します。
     * 
     * @return sysIdのプロパティ名
     */
    public static PropertyName<String> sysId() {
        return new PropertyName<String>("sysId");
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
     * ugAuthorizaitonMaserのプロパティ名を返します。
     * 
     * @return ugAuthorizaitonMaserのプロパティ名
     */
    public static _UgAuthorizaitonMaserNames ugAuthorizaitonMaser() {
        return new _UgAuthorizaitonMaserNames("ugAuthorizaitonMaser");
    }

    /**
     * @author S2JDBC-Gen
     */
    public static class _EmpAuthRelationNames extends PropertyName<EmpAuthRelation> {

        /**
         * インスタンスを構築します。
         */
        public _EmpAuthRelationNames() {
        }

        /**
         * インスタンスを構築します。
         * 
         * @param name
         *            名前
         */
        public _EmpAuthRelationNames(final String name) {
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
        public _EmpAuthRelationNames(final PropertyName<?> parent, final String name) {
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
         * authIdのプロパティ名を返します。
         *
         * @return authIdのプロパティ名
         */
        public PropertyName<Integer> authId() {
            return new PropertyName<Integer>(this, "authId");
        }

        /**
         * sysIdのプロパティ名を返します。
         *
         * @return sysIdのプロパティ名
         */
        public PropertyName<String> sysId() {
            return new PropertyName<String>(this, "sysId");
        }

        /**
         * empMasterのプロパティ名を返します。
         * 
         * @return empMasterのプロパティ名
         */
        public _EmpMasterNames empMaster() {
            return new _EmpMasterNames(this, "empMaster");
        }

        /**
         * ugAuthorizaitonMaserのプロパティ名を返します。
         * 
         * @return ugAuthorizaitonMaserのプロパティ名
         */
        public _UgAuthorizaitonMaserNames ugAuthorizaitonMaser() {
            return new _UgAuthorizaitonMaserNames(this, "ugAuthorizaitonMaser");
        }
    }
}