package management.logic;

import javax.annotation.Resource;

import org.seasar.framework.beans.util.Beans;

import management.dao.MotDaityoInputDao;
import management.entity.MotikomiDaityo;
import management.form.MotDaityoInputForm;
import management.util.ManagementStringUtil;

/**
 * Mot:社内持ち込み管理システム<br />
 * 持込資料の登録を行うロジック
 * 
 * @author sse802563
 * 
 */
public class MotDaityoInputLogic extends MotCommonLogic {

    @Resource
    public MotDaityoInputDao motDaityoInputDao;

    public void insertDaityo(MotDaityoInputForm motDaityoInputForm) {

        // 持込台帳のテーブルID（tableId）を自動生成
        motDaityoInputForm.tableId = ManagementStringUtil.setTableId(motDaityoInputForm.userId);
        
       // エンティティに値を格納
        MotikomiDaityo motikomiDaityo = new MotikomiDaityo();
        Beans.copy(motDaityoInputForm, motikomiDaityo).excludesNull().execute();

        // 初期登録時に設定される値を格納
        // 状態コード１０は持込承認待ち
        motikomiDaityo.conditionCode = "10";

        // 実施処理コード０は未処理
        motikomiDaityo.processCode = "0";

        //台帳に登録・修正する値の中で、半角指定のものを全てチェックする
        //もし全角で入力されていた場合は半角に変換する
        motikomiDaityo.bringDate = ManagementStringUtil
        .convertCharactor(motikomiDaityo.bringDate);
        motikomiDaityo.scheduledDate = ManagementStringUtil
        .convertCharactor(motikomiDaityo.scheduledDate);
        motikomiDaityo.copies = ManagementStringUtil
        .convertCharactor(motikomiDaityo.copies);
        
        
        motDaityoInputDao.insertMotikomiDaityo(motikomiDaityo);

    }

}
