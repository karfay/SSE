package ug.service;

import java.util.List;
import javax.annotation.Generated;
import ug.entity.UgAuthorizaitonMaser;

import static org.seasar.extension.jdbc.operation.Operations.*;
import static ug.entity.UgAuthorizaitonMaserNames.*;

/**
 * {@link UgAuthorizaitonMaser}のサービスクラスです。
 * 
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.ServiceModelFactoryImpl"}, date = "2017/03/07 15:54:17")
public class UgAuthorizaitonMaserService extends AbstractService<UgAuthorizaitonMaser> {

    /**
     * 識別子でエンティティを検索します。
     * 
     * @param authId
     *            識別子
     * @return エンティティ
     */
    public UgAuthorizaitonMaser findById(Integer authId) {
        return select().id(authId).getSingleResult();
    }

    /**
     * 識別子の昇順ですべてのエンティティを検索します。
     * 
     * @return エンティティのリスト
     */
    public List<UgAuthorizaitonMaser> findAllOrderById() {
        return select().orderBy(asc(authId())).getResultList();
    }
}