package ug.service;

import static org.seasar.extension.jdbc.operation.Operations.*;
import static ug.entity.AnkenRirekiNames.*;

import java.util.List;

import javax.annotation.Generated;

import ug.entity.AnkenRireki;

/**
 * {@link AnkenRireki}のサービスクラスです。
 *
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.ServiceModelFactoryImpl"}, date = "2017/03/07 15:54:16")
public class AnkenRirekiService extends AbstractService<AnkenRireki> {

    /**
     * 識別子でエンティティを検索します。
     *
     * @param ankenRirekiId
     *            識別子
     * @return エンティティ
     */
    public AnkenRireki findById(Integer ankenRirekiId) {
        return select().id(ankenRirekiId).getSingleResult();
    }

    /**
     * 識別子の昇順ですべてのエンティティを検索します。
     *
     * @return エンティティのリスト
     */
    public List<AnkenRireki> findAllOrderById() {
        return select().orderBy(asc(ankenRirekiId())).getResultList();
    }

}