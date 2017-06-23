package ug.service;

import static org.seasar.extension.jdbc.operation.Operations.*;
import static ug.entity.GaityuMonthlyCostNames.*;

import java.util.List;

import javax.annotation.Generated;

import ug.entity.GaityuMonthlyCost;
import ug.entity.MonthlyGenka;

/**
 * {@link GaityuMonthlyCost}のサービスクラスです。
 *
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.ServiceModelFactoryImpl"}, date = "2017/03/07 15:54:16")
public class GaityuMonthlyCostService extends AbstractService<GaityuMonthlyCost> {

    /**
     * 識別子でエンティティを検索します。
     *
     * @param gmcId
     *            識別子
     * @return エンティティ
     */
    public GaityuMonthlyCost findById(Integer gmcId) {
        return select().id(gmcId).getSingleResult();
    }

    /**
     * 識別子の昇順ですべてのエンティティを検索します。
     *
     * @return エンティティのリスト
     */
    public List<GaityuMonthlyCost> findAllOrderById() {
        return select().orderBy(asc(gmcId())).getResultList();
    }

    /**
     * 引数gkIdの原価管理表に参加している、社員番号がdeleteMemberの外注（パートナー）の外注費を取得する。
     * @param gkId
     * @param deleteMember
     * @return
     */
	public List<GaityuMonthlyCost> getPjCost(int gkId, String deleteMember) {
		return select()
				.innerJoin(empMaster(), eq(empMaster().empNo(), deleteMember))
				.innerJoin(empMaster().kaihatsutaiseiList(), eq(empMaster().kaihatsutaiseiList().gkId(), gkId))
				.getResultList();

	}

	/**
	 * 引数のテーマ親番から、その原価管理表に参加しているメンバーの工数を抽出する
	 * 年度、年度ソートマスタの月順、社員番号順に昇順ソート
	 * @param themeGroup
	 * @return
	 */
	public List<GaityuMonthlyCost> getFromThemeGroup(String themeGroup) {

		return select()
				.innerJoin(themeMaster(), eq(themeMaster().themeGroup(), themeGroup))
				.innerJoin(nendoSortMaster())
				.innerJoin(empMaster())
				.leftOuterJoin(empMaster().empAuthRelationList())
				.orderBy(asc(nendo()), asc(nendoSortMaster().month()), asc(empMaster().empAuthRelationList().authId()),asc(empNo()))
				.getResultList();
	}

	/**
	 * 月別原価テーブルを受け取って、その月別原価テーブルに関連するテーブルを抽出する。
	 * @param mg
	 * @return
	 */
	public List<GaityuMonthlyCost> getListFromMonthlyGenka(MonthlyGenka mg){
		return select()
				.where(eq(themeNo(), mg.themeNo)
						,eq(nendo(), mg.nendo)
						,eq(month(), mg.month))
				.getResultList();
	}
}