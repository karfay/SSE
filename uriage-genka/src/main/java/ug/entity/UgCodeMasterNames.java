package ug.entity;

import javax.annotation.Generated;
import org.seasar.extension.jdbc.name.PropertyName;

/**
 * {@link UgCodeMaster}のプロパティ名の集合です。
 * 
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.NamesModelFactoryImpl"}, date = "2017/04/28 15:30:27")
public class UgCodeMasterNames {

    /**
     * codeIdのプロパティ名を返します。
     * 
     * @return codeIdのプロパティ名
     */
    public static PropertyName<Integer> codeId() {
        return new PropertyName<Integer>("codeId");
    }

    /**
     * codeTypeのプロパティ名を返します。
     * 
     * @return codeTypeのプロパティ名
     */
    public static PropertyName<String> codeType() {
        return new PropertyName<String>("codeType");
    }

    /**
     * codeNameのプロパティ名を返します。
     * 
     * @return codeNameのプロパティ名
     */
    public static PropertyName<String> codeName() {
        return new PropertyName<String>("codeName");
    }

    /**
     * codeFlagのプロパティ名を返します。
     * 
     * @return codeFlagのプロパティ名
     */
    public static PropertyName<Integer> codeFlag() {
        return new PropertyName<Integer>("codeFlag");
    }

    /**
     * @author S2JDBC-Gen
     */
    public static class _UgCodeMasterNames extends PropertyName<UgCodeMaster> {

        /**
         * インスタンスを構築します。
         */
        public _UgCodeMasterNames() {
        }

        /**
         * インスタンスを構築します。
         * 
         * @param name
         *            名前
         */
        public _UgCodeMasterNames(final String name) {
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
        public _UgCodeMasterNames(final PropertyName<?> parent, final String name) {
            super(parent, name);
        }

        /**
         * codeIdのプロパティ名を返します。
         *
         * @return codeIdのプロパティ名
         */
        public PropertyName<Integer> codeId() {
            return new PropertyName<Integer>(this, "codeId");
        }

        /**
         * codeTypeのプロパティ名を返します。
         *
         * @return codeTypeのプロパティ名
         */
        public PropertyName<String> codeType() {
            return new PropertyName<String>(this, "codeType");
        }

        /**
         * codeNameのプロパティ名を返します。
         *
         * @return codeNameのプロパティ名
         */
        public PropertyName<String> codeName() {
            return new PropertyName<String>(this, "codeName");
        }

        /**
         * codeFlagのプロパティ名を返します。
         *
         * @return codeFlagのプロパティ名
         */
        public PropertyName<Integer> codeFlag() {
            return new PropertyName<Integer>(this, "codeFlag");
        }
    }
}