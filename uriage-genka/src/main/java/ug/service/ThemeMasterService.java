package ug.service;

import static org.seasar.extension.jdbc.operation.Operations.*;
import static ug.entity.ThemeMasterNames.*;

import java.util.List;

import javax.annotation.Generated;

import ug.entity.ThemeMaster;

/**
 * {@link ThemeMaster}のサービスクラスです。
 *
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.ServiceModelFactoryImpl"}, date = "2017/03/07 15:54:17")
public class ThemeMasterService extends AbstractService<ThemeMaster> {

    /**
     * 識別子でエンティティを検索します。
     *
     * @param themeNo
     *            識別子
     * @return エンティティ
     */
    public ThemeMaster findById(String themeNo) {
        return select().id(themeNo).getSingleResult();
    }

    /**
     * 識別子の昇順ですべてのエンティティを検索します。
     *
     * @return エンティティのリスト
     */
    public List<ThemeMaster> findAllOrderById() {
        return select().orderBy(asc(themeNo())).getResultList();
    }

    /**
     * 受付日の降順ですべてのエンティティを検索します。
     *
     * @return エンティティのリスト
     */
    public List<ThemeMaster> findAllOrderByUketsukeDate() {
        return select().orderBy(desc(uketsukeDate())).getResultList();
    }

    /**
     * テーママスタのテーマ親番のみを更新する。
     * エンティティにはテーマNOとテーマ親番を設定すること。
     * @param entity
     * @return 更新成功：true 失敗：false デバッグ用
     */
    public boolean updateThemeGroup(ThemeMaster entity){
    	int count = jdbcManager.update(entity).includes(themeGroup()).execute();

    	if(count==1)return true;
    	else return false;
    }

    /**
     * テーマ親番から関連するテーマをすべて取得する。
     * @param themeGroup
     * @return
     */
	public List<ThemeMaster> findByThemeGroup(String themeGroup) {

		return select().where(eq(themeGroup(), themeGroup)).getResultList();
	}
}