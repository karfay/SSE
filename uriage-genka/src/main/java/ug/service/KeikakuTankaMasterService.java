package ug.service;

import java.util.List;
import javax.annotation.Generated;
import ug.entity.KeikakuTankaMaster;

import static org.seasar.extension.jdbc.operation.Operations.*;
import static ug.entity.KeikakuTankaMasterNames.*;

/**
 * {@link KeikakuTankaMaster}のサービスクラスです。
 * 
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.ServiceModelFactoryImpl"}, date = "2017/03/07 15:54:17")
public class KeikakuTankaMasterService extends AbstractService<KeikakuTankaMaster> {

    /**
     * 識別子でエンティティを検索します。
     * 
     * @param nendo
     *            識別子
     * @return エンティティ
     */
    public KeikakuTankaMaster findById(Integer nendo) {
        return select().id(nendo).getSingleResult();
    }

    /**
     * 識別子の昇順ですべてのエンティティを検索します。
     * 
     * @return エンティティのリスト
     */
    public List<KeikakuTankaMaster> findAllOrderById() {
        return select().orderBy(asc(nendo())).getResultList();
    }
}