package ug.service;

import java.util.List;
import javax.annotation.Generated;
import ug.entity.EmpAuthRelation;

import static org.seasar.extension.jdbc.operation.Operations.*;
import static ug.entity.EmpAuthRelationNames.*;

/**
 * {@link EmpAuthRelation}のサービスクラスです。
 * 
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.ServiceModelFactoryImpl"}, date = "2017/03/07 15:54:16")
public class EmpAuthRelationService extends AbstractService<EmpAuthRelation> {

    /**
     * 識別子でエンティティを検索します。
     * 
     * @param empNo
     *            識別子
     * @param authId
     *            識別子
     * @param sysId
     *            識別子
     * @return エンティティ
     */
    public EmpAuthRelation findById(String empNo, Integer authId, String sysId) {
        return select().id(empNo, authId, sysId).getSingleResult();
    }

    /**
     * 識別子の昇順ですべてのエンティティを検索します。
     * 
     * @return エンティティのリスト
     */
    public List<EmpAuthRelation> findAllOrderById() {
        return select().orderBy(asc(empNo()), asc(authId()), asc(sysId())).getResultList();
    }
}