package ug.service;

import static org.seasar.extension.jdbc.operation.Operations.*;
import static ug.entity.MonthlyGenkaNames.*;

import java.util.List;

import javax.annotation.Generated;

import ug.entity.MonthlyGenka;

/**
 * {@link MonthlyGenka}のサービスクラスです。
 *
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.ServiceModelFactoryImpl"}, date = "2017/03/07 15:54:17")
public class MonthlyGenkaService extends AbstractService<MonthlyGenka> {

    /**
     * 識別子でエンティティを検索します。
     *
     * @param monthlyGenkaId
     *            識別子
     * @return エンティティ
     */
    public MonthlyGenka findById(Integer monthlyGenkaId) {
        return select().id(monthlyGenkaId).getSingleResult();
    }

    /**
     * 識別子の昇順ですべてのエンティティを検索します。
     *
     * @return エンティティのリスト
     */
    public List<MonthlyGenka> findAllOrderById() {
        return select().orderBy(asc(monthlyGenkaId())).getResultList();
    }

    /**
     * 引数gkIdの原価管理表で作成された月別原価詳細テーブルを取得する。
     * gkConditionCode=401は月別、404は削除対象
     * @param gkId
     * @return
     */
    public List<MonthlyGenka> findByGkIdIncludeDelete(Integer gkId){
    	return select()
    			.innerJoin(genkaKanri(), eq(genkaKanri().gkId(), gkId))
    			.innerJoin(nendoSortMaster())
    			.where(or(eq(gkConditionCode(), 401), eq(gkConditionCode(), 404)))
    			.orderBy(asc(nendo()), asc(nendoSortMaster().sort()), asc(gkConditionCode()))
    			.getResultList();
    }

    /**
     * 引数のthemeGroupを持つ原価仕掛り計テーブルと原価PJ合計テーブルを削除する
     * @param themeGroup
     * @return 削除した件数
     */
	public int[] deleteGenkaSum(String themeGroup) {
		List<MonthlyGenka> deleteList =
				select()
				.where(eq(themeGroup(), themeGroup)
						,in(gkConditionCode(), 402, 403))
				.getResultList();
		if(deleteList.size()==0)return null;
		return jdbcManager.deleteBatch(deleteList).execute();
	}

	/**
	 * 表示用に月別原価、仕掛り計、PJ合計をすべて取得する
	 * 表示順になるようにソートする。
	 * ソート順は年度、月、状態コード
	 * @param themeGroup
	 * @return
	 */
	public List<MonthlyGenka> getMonthlyGenlka(String themeGroup) {
		return select()
				.innerJoin(nendoSortMaster())
				.where(eq(themeGroup(), themeGroup))
				.orderBy(asc(nendo()), asc(nendoSortMaster().sort()), asc(gkConditionCode()))
				.getResultList();
	}

	/**
	 * 引数gkIdの原価管理表で作成された月別原価詳細テーブルを取得する。
	 * 仕掛り計、PJ計の再計算のために取得するため、401(月別)のみしか対象にしない。
	 * 計算の簡易化のためソート順をテーマNO、年度、年度ソートマスタの月で抽出。
	 * @param gkId
	 * @return
	 */
	public List<MonthlyGenka> getMgListForCalcShikakari(String themeGroup) {
		return select()
				.innerJoin(nendoSortMaster())
				.where(eq(themeGroup(),themeGroup)
						,eq(gkConditionCode(), 401)
						,isNotNull(themeNo()))
				.orderBy(asc(themeNo()), asc(nendo()), asc(nendoSortMaster().sort()))
				.getResultList();
	}

}