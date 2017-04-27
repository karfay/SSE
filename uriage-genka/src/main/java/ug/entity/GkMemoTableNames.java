package ug.entity;

import java.sql.Timestamp;
import javax.annotation.Generated;
import org.seasar.extension.jdbc.name.PropertyName;
import ug.entity.GenkaKanriNames._GenkaKanriNames;

/**
 * {@link GkMemoTable}のプロパティ名の集合です。
 * 
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.NamesModelFactoryImpl"}, date = "2017/04/26 17:27:54")
public class GkMemoTableNames {

    /**
     * memoIdのプロパティ名を返します。
     * 
     * @return memoIdのプロパティ名
     */
    public static PropertyName<Integer> memoId() {
        return new PropertyName<Integer>("memoId");
    }

    /**
     * gkIdのプロパティ名を返します。
     * 
     * @return gkIdのプロパティ名
     */
    public static PropertyName<Integer> gkId() {
        return new PropertyName<Integer>("gkId");
    }

    /**
     * writeDateのプロパティ名を返します。
     * 
     * @return writeDateのプロパティ名
     */
    public static PropertyName<Timestamp> writeDate() {
        return new PropertyName<Timestamp>("writeDate");
    }

    /**
     * bikouのプロパティ名を返します。
     * 
     * @return bikouのプロパティ名
     */
    public static PropertyName<String> bikou() {
        return new PropertyName<String>("bikou");
    }

    /**
     * jokyoのプロパティ名を返します。
     * 
     * @return jokyoのプロパティ名
     */
    public static PropertyName<String> jokyo() {
        return new PropertyName<String>("jokyo");
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
     * @author S2JDBC-Gen
     */
    public static class _GkMemoTableNames extends PropertyName<GkMemoTable> {

        /**
         * インスタンスを構築します。
         */
        public _GkMemoTableNames() {
        }

        /**
         * インスタンスを構築します。
         * 
         * @param name
         *            名前
         */
        public _GkMemoTableNames(final String name) {
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
        public _GkMemoTableNames(final PropertyName<?> parent, final String name) {
            super(parent, name);
        }

        /**
         * memoIdのプロパティ名を返します。
         *
         * @return memoIdのプロパティ名
         */
        public PropertyName<Integer> memoId() {
            return new PropertyName<Integer>(this, "memoId");
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
         * writeDateのプロパティ名を返します。
         *
         * @return writeDateのプロパティ名
         */
        public PropertyName<Timestamp> writeDate() {
            return new PropertyName<Timestamp>(this, "writeDate");
        }

        /**
         * bikouのプロパティ名を返します。
         *
         * @return bikouのプロパティ名
         */
        public PropertyName<String> bikou() {
            return new PropertyName<String>(this, "bikou");
        }

        /**
         * jokyoのプロパティ名を返します。
         *
         * @return jokyoのプロパティ名
         */
        public PropertyName<String> jokyo() {
            return new PropertyName<String>(this, "jokyo");
        }

        /**
         * genkaKanriのプロパティ名を返します。
         * 
         * @return genkaKanriのプロパティ名
         */
        public _GenkaKanriNames genkaKanri() {
            return new _GenkaKanriNames(this, "genkaKanri");
        }
    }
}