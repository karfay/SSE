package ug.service;

import java.util.List;
import javax.annotation.Generated;
import ug.entity.LoginLog;

import static org.seasar.extension.jdbc.operation.Operations.*;
import static ug.entity.LoginLogNames.*;

/**
 * {@link LoginLog}のサービスクラスです。
 * 
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.ServiceModelFactoryImpl"}, date = "2017/03/09 15:29:27")
public class LoginLogService extends AbstractService<LoginLog> {

    /**
     * 識別子でエンティティを検索します。
     * 
     * @param sessionNumber
     *            識別子
     * @return エンティティ
     */
    public LoginLog findById(Integer sessionNumber) {
        return select().id(sessionNumber).getSingleResult();
    }

    /**
     * 識別子の昇順ですべてのエンティティを検索します。
     * 
     * @return エンティティのリスト
     */
    public List<LoginLog> findAllOrderById() {
        return select().orderBy(asc(sessionNumber())).getResultList();
    }
}