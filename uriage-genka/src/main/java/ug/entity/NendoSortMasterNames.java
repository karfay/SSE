package ug.entity;

import javax.annotation.Generated;
import org.seasar.extension.jdbc.name.PropertyName;
import ug.entity.MonthlyGenkaNames._MonthlyGenkaNames;

/**
 * {@link NendoSortMaster}のプロパティ名の集合です。
 * 
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.NamesModelFactoryImpl"}, date = "2017/04/28 15:30:26")
public class NendoSortMasterNames {

    /**
     * monthのプロパティ名を返します。
     * 
     * @return monthのプロパティ名
     */
    public static PropertyName<Integer> month() {
        return new PropertyName<Integer>("month");
    }

    /**
     * sortのプロパティ名を返します。
     * 
     * @return sortのプロパティ名
     */
    public static PropertyName<Integer> sort() {
        return new PropertyName<Integer>("sort");
    }

    /**
     * monthlyGenkaListのプロパティ名を返します。
     * 
     * @return monthlyGenkaListのプロパティ名
     */
    public static _MonthlyGenkaNames monthlyGenkaList() {
        return new _MonthlyGenkaNames("monthlyGenkaList");
    }

    /**
     * @author S2JDBC-Gen
     */
    public static class _NendoSortMasterNames extends PropertyName<NendoSortMaster> {

        /**
         * インスタンスを構築します。
         */
        public _NendoSortMasterNames() {
        }

        /**
         * インスタンスを構築します。
         * 
         * @param name
         *            名前
         */
        public _NendoSortMasterNames(final String name) {
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
        public _NendoSortMasterNames(final PropertyName<?> parent, final String name) {
            super(parent, name);
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
         * sortのプロパティ名を返します。
         *
         * @return sortのプロパティ名
         */
        public PropertyName<Integer> sort() {
            return new PropertyName<Integer>(this, "sort");
        }

        /**
         * monthlyGenkaListのプロパティ名を返します。
         * 
         * @return monthlyGenkaListのプロパティ名
         */
        public _MonthlyGenkaNames monthlyGenkaList() {
            return new _MonthlyGenkaNames(this, "monthlyGenkaList");
        }
    }
}