package ug.service;

import static org.seasar.extension.jdbc.operation.Operations.*;
import static ug.entity.UriageKeikakuNames.*;

import java.util.List;

import javax.annotation.Generated;

import ug.entity.UriageKeikaku;

/**
 * {@link UriageKeikaku}のサービスクラスです。
 *
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.ServiceModelFactoryImpl"}, date = "2017/03/07 15:54:17")
public class UriageKeikakuService extends AbstractService<UriageKeikaku> {

    /**
     * 識別子でエンティティを検索します。
     *
     * @param ankenRirekiId
     *            識別子
     * @param nendo
     *            識別子
     * @return エンティティ
     */
    public UriageKeikaku findById(Integer ankenRirekiId, Integer nendo) {
        return select().id(ankenRirekiId, nendo).getSingleResult();
    }

    /**
     * 識別子の昇順ですべてのエンティティを検索します。
     *
     * @return エンティティのリスト
     */
    public List<UriageKeikaku> findAllOrderById() {
        return select().orderBy(asc(ankenRirekiId()), asc(nendo())).getResultList();
    }

    /**
     * 引数gkIdの原価管理表に紐づく売上計画をすべて取得して返す。
     * @param parseInt
     * @return
     */
	public List<UriageKeikaku> findByGkId(int gkId) {
		select()
		.innerJoin(themeMaster())
		.innerJoin(themeMaster().genkaKanri(), eq(themeMaster().genkaKanri().gkId(), gkId))
		.orderBy(asc(nendo()))
		.getResultList();
		return null;
	}


}