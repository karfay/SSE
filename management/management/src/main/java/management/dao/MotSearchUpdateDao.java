package management.dao;

import java.util.List;

import management.entity.MotikomiDaityo;
import management.entity.PersonnelMaster;

public class MotSearchUpdateDao extends MotCommonDao {

    /**
     * 持込台帳（motikomi_daityoテーブル）の更新を行うメソッド<br />
     * エンティティに入力のある項目のみ更新を行う（nullは除外する）
     * @param motikomiDaityo　エンティティ
     */
    public void updateMotimkomiDaityo(MotikomiDaityo motikomiDaityo) {
        
        // null項目を除外して更新
        jdbcManager.update(motikomiDaityo).excludesNull().execute();
    }

    /**
     * 管理者権限を持つユーザをpersonnel_masterテーブルから検索し、<br />
     * その結果をリストで返すメソッド
     * @return
     */
    public List<PersonnelMaster> selectApprovers() {
        return jdbcManager
        .selectBySqlFile(PersonnelMaster.class, "META-INF/sql/SyaCommon/selectApprovers.sql")
        .getResultList();
    }


}
