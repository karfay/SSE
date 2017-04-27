package ug.service;

import java.util.List;
import javax.annotation.Generated;
import ug.entity.NendoSortMaster;

import static org.seasar.extension.jdbc.operation.Operations.*;
import static ug.entity.NendoSortMasterNames.*;

/**
 * {@link NendoSortMaster}のサービスクラスです。
 * 
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.ServiceModelFactoryImpl"}, date = "2017/03/07 15:54:17")
public class NendoSortMasterService extends AbstractService<NendoSortMaster> {

    /**
     * 識別子でエンティティを検索します。
     * 
     * @param month
     *            識別子
     * @return エンティティ
     */
    public NendoSortMaster findById(Integer month) {
        return select().id(month).getSingleResult();
    }

    /**
     * 識別子の昇順ですべてのエンティティを検索します。
     * 
     * @return エンティティのリスト
     */
    public List<NendoSortMaster> findAllOrderById() {
        return select().orderBy(asc(month())).getResultList();
    }
}