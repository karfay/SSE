package management.dao;

import management.entity.MotikomiDaityo;

public class MotDaityoInputDao extends MotCommonDao {

    /**
     * 持込台帳（motikomi_daityoテーブル）にmotikomiDaityoDtoに格納されている<br />
     * テーブル情報をインサートするメソッド
     * @param motikomiDaityoDto
     */
    public void insertMotikomiDaityo(MotikomiDaityo motikomiDaityo) {
        jdbcManager.insert(motikomiDaityo).execute();
        
    }

}
