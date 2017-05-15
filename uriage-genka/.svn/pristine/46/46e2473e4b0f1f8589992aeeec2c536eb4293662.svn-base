package ug.service;

import java.util.List;
import javax.annotation.Generated;
import ug.entity.Kaihatsutaisei;

import static org.seasar.extension.jdbc.operation.Operations.*;
import static ug.entity.KaihatsutaiseiNames.*;

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
}