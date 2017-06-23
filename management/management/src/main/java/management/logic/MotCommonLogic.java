package management.logic;

import javax.annotation.Resource;

import management.constant.MotConstant;
import management.dao.MotCommonDao;
import management.dto.MotikomiDaityoDto;
import management.form.MotCommonForm;
import management.parameter.MotSearchFilterParams;

public class MotCommonLogic {

    @Resource
    public MotCommonDao motCommonDao;

    public MotikomiDaityoDto motikomiDaityoDto;

    /**
     * {@link MotCommonForm}.processMasterリストにprocess_masterテーブルの<br />
     * 要素をすべて格納するメソッド
     * 
     * @param motCommonForm
     */
    public void setProcessMaster(MotCommonForm motCommonForm) {

        motCommonForm.processMaster = motCommonDao.selectProcessMaster();
    }

    /**
     * {@link MotCommonForm}.materialCategoryMasterリストにmaterial_category_master<br />
     * テーブルの要素を全て格納するメソッド
     * 
     * @param motCommonForm
     */
    public void setMaterialCategoryMaster(MotCommonForm motCommonForm) {

        motCommonForm.materialCategoryMaster = motCommonDao
            .selectMaterialCategoryMaster();

    }

    /**
     * 持込台帳（motikomi_daityoテーブル）のID検索を行うメソッド
     * @param motCommonForm
     */
    public void setMotikomiDaityoFromTableId(MotCommonForm motCommonForm) {
        //検索条件のtableIdのみmotSearchFilterDtoに格納
        MotSearchFilterParams motSearchFilterDto = new MotSearchFilterParams();
        motSearchFilterDto.tableId = motCommonForm.tableId;

        motCommonForm.historyDto =
            motCommonDao.selectMotikomiDaityo(motSearchFilterDto);

    }

    /**
     * ページング検索の際に、総ページ数を求めて返すメソッド
     * 
     * @param pageCount
     *            ページング検索の際に、検索結果の全件数を受け取る
     * @return
     */
    public int castTotalPage(long pageCount) {
        // 総ページ数を計算　端数は切り上げ
        return (int) Math.ceil((double)pageCount / MotConstant.pageIndex);
    }
    
}
