package ug.service;

import static org.seasar.extension.jdbc.operation.Operations.*;
import static ug.entity.EmpMasterNames.*;

import java.util.List;

import javax.annotation.Generated;

import ug.entity.EmpMaster;

/**
 * {@link EmpMaster}のサービスクラスです。
 *
 */
@Generated(value = {"S2JDBC-Gen 2.4.46", "org.seasar.extension.jdbc.gen.internal.model.ServiceModelFactoryImpl"}, date = "2017/03/07 15:54:16")
public class EmpMasterService extends AbstractService<EmpMaster> {

    /**
     * 識別子でエンティティを検索します。
     *
     * @param empNo
     *            識別子
     * @return エンティティ
     */
    public EmpMaster findById(String empNo) {
        return select().id(empNo).getSingleResult();
    }

    /**
     * 識別子の昇順ですべてのエンティティを検索します。
     *
     * @return エンティティのリスト
     */
    public List<EmpMaster> findAllOrderById() {
        return select().orderBy(asc(empNo())).getResultList();
    }

    /**
     * 営業権限を持つ社員のリストを返す。
     * @return
     */
    public List<EmpMaster> getEigyoList() {
    	return select()
    			.innerJoin(empAuthRelationList())
    			.where(
    					eq(empAuthRelationList().authId(), 1))
    			.getResultList();
    }

    /**
     * 所属長権限を持つ社員のリストを返す。
     * @return
     */
    public List<EmpMaster> getKaihatsuGroupList() {
    	return select()
    			.innerJoin(empAuthRelationList())
    			.where(
    					eq(empAuthRelationList().authId(), 5))
    			.getResultList();
    }

    /**
     * PJ管理者権限を持つ社員のリストを返す。
     * @return
     */
    public List<EmpMaster> getPjAdminList() {
    	return select()
    			.innerJoin(empAuthRelationList())
    			.where(
    					eq(empAuthRelationList().authId(), 4))
    			.getResultList();
    }

    /**
     * PJリーダ権限を持つ社員のリストを返す。
     * @return
     */
    public List<EmpMaster> getPjLederList() {
    	return select()
    			.innerJoin(empAuthRelationList())
    			.where(
    					eq(empAuthRelationList().authId(), 3))
    			.getResultList();
    }

    /**
     * 引数gkIdの原価管理表に参加できる公共社員の候補リストを返す。
     * @return
     */
    public List<EmpMaster> getPjMemberCandidate(Integer gkId) {
    	return select()
    			.leftOuterJoin(kaihatsutaiseiList())
    			.where(
    					or(ne(kaihatsutaiseiList().gkId(), gkId),isNull(kaihatsutaiseiList().gkId()))
    					,or(eq(empConditionCode(), 0),eq(empConditionCode(), 3)))
    			.getResultList();
    }

    /**
     * 引数gkIdの原価管理表に参加できる外注・パートナーの候補リストを返す。
     * @return
     */
    public List<EmpMaster> getGaityuMemberCandidate(Integer gkId) {
    	return select()
    			.leftOuterJoin(kaihatsutaiseiList())
    			.where(
    					or(ne(kaihatsutaiseiList().gkId(), gkId),isNull(kaihatsutaiseiList().gkId()))
    					,or(eq(empConditionCode(), 1),eq(empConditionCode(), 3)))
    			.getResultList();
    }

    /**
     * 引数gkIdの原価管理表に参加しているプロジェクトメンバのリストを返す
     * @param parseInt
     * @return
     */
	public List<EmpMaster> getPjMemberList(int gkId) {
		return select().innerJoin(kaihatsutaiseiList())
				.where(eq(kaihatsutaiseiList().gkId(), gkId)
						,eq(kaihatsutaiseiList().gaityuFlag(), 0))
				.getResultList();
	}

    /**
     * 引数gkIdの原価管理表に参加している外注・パートナーのリストを返す
     * @param parseInt
     * @return
     */
	public List<EmpMaster> getGaityuMemberList(int gkId) {
		return select().innerJoin(kaihatsutaiseiList())
				.where(eq(kaihatsutaiseiList().gkId(), gkId)
						,eq(kaihatsutaiseiList().gaityuFlag(), 1))
				.getResultList();
	}

}