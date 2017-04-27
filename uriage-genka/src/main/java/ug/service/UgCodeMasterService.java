package ug.service;

import static org.seasar.extension.jdbc.operation.Operations.*;
import static ug.entity.UgCodeMasterNames.*;

import java.util.List;

import javax.annotation.Generated;

import ug.entity.UgCodeMaster;

/**
 * {@link UgCodeMaster}のサービスクラスです。
 *
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.ServiceModelFactoryImpl"}, date = "2017/03/07 15:54:17")
public class UgCodeMasterService extends AbstractService<UgCodeMaster> {

    /**
     * 識別子でエンティティを検索します。
     *
     * @param codeId
     *            識別子
     * @param codeType
     *            識別子
     * @return エンティティ
     */
    public UgCodeMaster findById(Integer codeId, String codeType) {
        return select().id(codeId, codeType).getSingleResult();
    }

    /**
     * 識別子の昇順ですべてのエンティティを検索します。
     *
     * @return エンティティのリスト
     */
    public List<UgCodeMaster> findAllOrderById() {
        return select().orderBy(asc(codeId()), asc(codeType())).getResultList();
    }

    /**
     * 発注タイプのコード情報を返す。
     * 表示用なのでcode_flag=0のみ返す。
     * @return
     */
    public List<UgCodeMaster> getHattyuTypeList() {
    	return select()
    			.where(
    					eq(codeType(), "hattyu_type")
    					,eq(codeFlag(), 0))
    			.orderBy(asc(codeId()))
    			.getResultList();
    }

    /**
     * 確度のコード情報を返す。
     * 表示用なのでcode_flag=0のみ返す。
     * @return
     */
    public List<UgCodeMaster> getKakudoList() {
    	return select()
    			.where(
    					eq(codeType(), "kakudo")
    					,eq(codeFlag(), 0))
    			.orderBy(asc(codeId()))
    			.getResultList();
    }

	public List<UgCodeMaster> getConditionCodeList() {
		return select()
    			.where(
    					eq(codeType(), "uk_condition")
    					,eq(codeFlag(), 0))
    			.orderBy(asc(codeId()))
    			.getResultList();
    }
}