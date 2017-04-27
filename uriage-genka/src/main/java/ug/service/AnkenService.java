package ug.service;

import static org.seasar.extension.jdbc.operation.Operations.*;
import static ug.entity.AnkenNames.*;

import java.util.List;

import javax.annotation.Generated;

import ug.entity.Anken;

/**
 * {@link Anken}のサービスクラスです。
 *
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.ServiceModelFactoryImpl"}, date = "2017/03/07 15:54:16")
public class AnkenService extends AbstractService<Anken> {

    /**
     * 識別子でエンティティを検索します。
     *
     * @param ankenId
     *            識別子
     * @return エンティティ
     */
    public Anken findById(Integer ankenId) {
        return select().id(ankenId).getSingleResult();
    }

    /**
     * 識別子の昇順ですべてのエンティティを検索します。
     *
     * @return エンティティのリスト
     */
    public List<Anken> findAllOrderById() {
        return select().orderBy(asc(ankenId())).getResultList();
    }


}