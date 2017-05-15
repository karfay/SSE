package ug.service;

import java.util.List;
import javax.annotation.Generated;
import ug.entity.EmpConditionMaster;

import static org.seasar.extension.jdbc.operation.Operations.*;
import static ug.entity.EmpConditionMasterNames.*;

/**
 * {@link EmpConditionMaster}のサービスクラスです。
 * 
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.ServiceModelFactoryImpl"}, date = "2017/03/07 15:54:16")
public class EmpConditionMasterService extends AbstractService<EmpConditionMaster> {

    /**
     * 識別子でエンティティを検索します。
     * 
     * @param empConditionCode
     *            識別子
     * @return エンティティ
     */
    public EmpConditionMaster findById(Integer empConditionCode) {
        return select().id(empConditionCode).getSingleResult();
    }

    /**
     * 識別子の昇順ですべてのエンティティを検索します。
     * 
     * @return エンティティのリスト
     */
    public List<EmpConditionMaster> findAllOrderById() {
        return select().orderBy(asc(empConditionCode())).getResultList();
    }
}