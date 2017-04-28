package ug.entity;

import javax.annotation.Generated;
import org.seasar.extension.jdbc.name.PropertyName;
import ug.entity.EmpMasterNames._EmpMasterNames;
import ug.entity.GenkaKanriNames._GenkaKanriNames;

/**
 * {@link Kaihatsutaisei}のプロパティ名の集合です。
 * 
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.NamesModelFactoryImpl"}, date = "2017/04/28 15:30:26")
public class KaihatsutaiseiNames {

    /**
     * gkIdのプロパティ名を返します。
     * 
     * @return gkIdのプロパティ名
     */
    public static PropertyName<Integer> gkId() {
        return new PropertyName<Integer>("gkId");
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
     * gaityuFlagのプロパティ名を返します。
     * 
     * @return gaityuFlagのプロパティ名
     */
    public static PropertyName<Integer> gaityuFlag() {
        return new PropertyName<Integer>("gaityuFlag");
    }

    /**
     * genkaKanriのプロパティ名を返します。
     * 
     * @return genkaKanriのプロパティ名
     */
    public static _GenkaKanriNames genkaKanri() {
        return new _GenkaKanriNames("genkaKanri");
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
    public static class _KaihatsutaiseiNames extends PropertyName<Kaihatsutaisei> {

        /**
         * インスタンスを構築します。
         */
        public _KaihatsutaiseiNames() {
        }

        /**
         * インスタンスを構築します。
         * 
         * @param name
         *            名前
         */
        public _KaihatsutaiseiNames(final String name) {
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
        public _KaihatsutaiseiNames(final PropertyName<?> parent, final String name) {
            super(parent, name);
        }

        /**
         * gkIdのプロパティ名を返します。
         *
         * @return gkIdのプロパティ名
         */
        public PropertyName<Integer> gkId() {
            return new PropertyName<Integer>(this, "gkId");
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
         * gaityuFlagのプロパティ名を返します。
         *
         * @return gaityuFlagのプロパティ名
         */
        public PropertyName<Integer> gaityuFlag() {
            return new PropertyName<Integer>(this, "gaityuFlag");
        }

        /**
         * genkaKanriのプロパティ名を返します。
         * 
         * @return genkaKanriのプロパティ名
         */
        public _GenkaKanriNames genkaKanri() {
            return new _GenkaKanriNames(this, "genkaKanri");
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