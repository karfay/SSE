package ug.entity;

import java.sql.Timestamp;
import javax.annotation.Generated;
import org.seasar.extension.jdbc.name.PropertyName;

/**
 * {@link LoginLog}のプロパティ名の集合です。
 * 
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.NamesModelFactoryImpl"}, date = "2017/04/28 15:30:26")
public class LoginLogNames {

    /**
     * sessionNumberのプロパティ名を返します。
     * 
     * @return sessionNumberのプロパティ名
     */
    public static PropertyName<Integer> sessionNumber() {
        return new PropertyName<Integer>("sessionNumber");
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
     * loginTimestampのプロパティ名を返します。
     * 
     * @return loginTimestampのプロパティ名
     */
    public static PropertyName<Timestamp> loginTimestamp() {
        return new PropertyName<Timestamp>("loginTimestamp");
    }

    /**
     * logoutTimestampのプロパティ名を返します。
     * 
     * @return logoutTimestampのプロパティ名
     */
    public static PropertyName<Timestamp> logoutTimestamp() {
        return new PropertyName<Timestamp>("logoutTimestamp");
    }

    /**
     * @author S2JDBC-Gen
     */
    public static class _LoginLogNames extends PropertyName<LoginLog> {

        /**
         * インスタンスを構築します。
         */
        public _LoginLogNames() {
        }

        /**
         * インスタンスを構築します。
         * 
         * @param name
         *            名前
         */
        public _LoginLogNames(final String name) {
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
        public _LoginLogNames(final PropertyName<?> parent, final String name) {
            super(parent, name);
        }

        /**
         * sessionNumberのプロパティ名を返します。
         *
         * @return sessionNumberのプロパティ名
         */
        public PropertyName<Integer> sessionNumber() {
            return new PropertyName<Integer>(this, "sessionNumber");
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
         * loginTimestampのプロパティ名を返します。
         *
         * @return loginTimestampのプロパティ名
         */
        public PropertyName<Timestamp> loginTimestamp() {
            return new PropertyName<Timestamp>(this, "loginTimestamp");
        }

        /**
         * logoutTimestampのプロパティ名を返します。
         *
         * @return logoutTimestampのプロパティ名
         */
        public PropertyName<Timestamp> logoutTimestamp() {
            return new PropertyName<Timestamp>(this, "logoutTimestamp");
        }
    }
}