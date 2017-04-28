package ug.service;

import static org.seasar.extension.jdbc.operation.Operations.*;
import static ug.entity.GenkaKanriNames.*;

import java.util.List;

import javax.annotation.Generated;

import ug.entity.GenkaKanri;

/**
 * {@link GenkaKanri}のサービスクラスです。
 *
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.ServiceModelFactoryImpl"}, date = "2017/03/07 15:54:16")
public class GenkaKanriService extends AbstractService<GenkaKanri> {

    /**
     * 識別子でエンティティを検索します。
     *
     * @param gkId
     *            識別子
     * @return エンティティ
     */
    public GenkaKanri findById(Integer gkId) {
        return select().id(gkId).getSingleResult();
    }

    /**
     * 識別子の昇順ですべてのエンティティを検索します。
     *
     * @return エンティティのリスト
     */
    public List<GenkaKanri> findAllOrderById() {
        return select().orderBy(asc(gkId())).getResultList();
    }

    public List<GenkaKanri> getGkList(String nendo) {
    	return select()
    			.innerJoin(themeMaster())
    			.where(
    			or(starts(tyakusyuMonth(), nendo), starts(nouki(), nendo)))
    			.getResultList();
    }

    /**
     * テーマ親番からGenkaKanriを一意に取得する。
     * @param themeGroup
     * @return
     */
	public GenkaKanri findByThemeGroup(String themeGroup) {
		return select().where(eq(themeGroup(), themeGroup)).getSingleResult();
	}

	public GenkaKanri getKaihatsuTaisei(int gkId) {
		// TODO 自動生成されたメソッド・スタブ
		return select()
				.where(eq(gkId(), gkId))
				.innerJoin(themeMaster())
				.innerJoin(themeMaster().empMonthlyKousuList())
				.innerJoin(themeMaster().gaityuMonthlyCostList())
				.getSingleResult();
	}
}