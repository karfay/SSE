package ug.service;

import static org.seasar.extension.jdbc.operation.Operations.*;
import static ug.entity.KaihatsutaiseiNames.*;

import java.util.List;

import javax.annotation.Generated;

import ug.entity.Kaihatsutaisei;

/**
 * {@link Kaihatsutaisei}のサービスクラスです。
 *
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.ServiceModelFactoryImpl"}, date = "2017/03/07 15:54:17")
public class KaihatsutaiseiService extends AbstractService<Kaihatsutaisei> {

    /**
     * 識別子でエンティティを検索します。
     *
     * @param gkId
     *            識別子
     * @param empNo
     *            識別子
     * @return エンティティ
     */
    public Kaihatsutaisei findById(Integer gkId, String empNo) {
        return select().id(gkId, empNo).getSingleResult();
    }

    /**
     * 識別子の昇順ですべてのエンティティを検索します。
     *
     * @return エンティティのリスト
     */
    public List<Kaihatsutaisei> findAllOrderById() {
        return select().orderBy(asc(gkId()), asc(empNo())).getResultList();
    }

    /**
     * 引数gkIdの原価管理表の開発体制メンバーをすべてとりだす。
     * 名前も欲しいのでempMasterと結合。
     * 表示順を役職順でソートしたいのでempAuthRelationListとも結合。
     * @param gkId
     * @return
     */
	public List<Kaihatsutaisei> getKaihatsuTaisei(int gkId) {
		return select()
				.where(eq(gkId(), gkId))
				.innerJoin(empMaster())
				.leftOuterJoin(empMaster().empAuthRelationList())
				.orderBy(asc(gaityuFlag()), asc(empMaster().empAuthRelationList().authId()))
				.getResultList();
	}
}