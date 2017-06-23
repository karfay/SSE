package management.logic;

import javax.annotation.Resource;

import org.seasar.framework.beans.util.Beans;

import management.dao.MotSearchUpdateDao;
import management.form.MotSearchUpdateForm;
import management.parameter.MotSearchFilterParams;
import management.entity.MotikomiDaityo;

public class MotSearchUpdateLogic extends MotCommonLogic {

    @Resource
    public MotSearchUpdateDao motSearchUpdateDao;

    /**
     * 持込台帳の持込終了時対応の入力（更新）を行うメソッド
     * 
     * @param motSearchUpdateForm
     */
    public void updateProcess(MotSearchUpdateForm motSearchUpdateForm) {
        // 持込台帳のエンティティにjspからの入力情報を格納
        MotikomiDaityo motikomiDaityo = new MotikomiDaityo();
        Beans.copy(motSearchUpdateForm, motikomiDaityo).execute();

        // 対応登録のための情報を格納
        // 状態コード２０は'対応承認待ち'
        motikomiDaityo.conditionCode = "20";

        // 持込台帳を更新
        motSearchUpdateDao.updateMotimkomiDaityo(motikomiDaityo);

    }

    /**
     * 管理者権限を持つユーザを格納するメソッド
     * 
     * @param motSearchUpdateForm
     */
    public void setApprovers(MotSearchUpdateForm motSearchUpdateForm) {

        motSearchUpdateForm.approvers = motSearchUpdateDao.selectApprovers();
    }

    /**
     * 持込台帳の承認を行うメソッド
     * 
     * @param motSearchUpdateForm
     */
    public void updateApprove(MotSearchUpdateForm motSearchUpdateForm) {
        // 持込台帳のエンティティにjspからの入力情報を格納
        MotikomiDaityo motikomiDaityo = new MotikomiDaityo();
        Beans.copy(motSearchUpdateForm, motikomiDaityo).execute();

        // 承認のための情報を格納
        // 状態コード１０：持込承認待ち
        // 状態コード１１：持込承認済み
        // 状態コード１２：持込承認修正
        // 状態コード２０：対応承認待ち
        // 状態コード２１：対応承認済み
        // 状態コード２２：対応承認修正
        // 持込段階なら持込の承認を、終了時対応段階なら対応の承認を行う
        if (motikomiDaityo.conditionCode.equals("10")) {
            motikomiDaityo.conditionCode = "11";
        } else if (motikomiDaityo.conditionCode.equals("12")) {
            motikomiDaityo.conditionCode = "11";
        } else if (motikomiDaityo.conditionCode.equals("20")) {
            motikomiDaityo.conditionCode = "21";
        } else if (motikomiDaityo.conditionCode.equals("22")) {
            motikomiDaityo.conditionCode = "21";
        }

        // 持込台帳を更新
        motSearchUpdateDao.updateMotimkomiDaityo(motikomiDaityo);
    }

    /**
     * 持込台帳の差し戻しを行うメソッド
     * 
     * @param motSearchUpdateForm
     */
    public void updateRemand(MotSearchUpdateForm motSearchUpdateForm) {
        // 持込台帳のエンティティにjspからの入力情報を格納
        MotikomiDaityo motikomiDaityo = new MotikomiDaityo();
        Beans.copy(motSearchUpdateForm, motikomiDaityo).execute();

        // 承認のための情報を格納
        // 状態コード１０：持込承認待ち
        // 状態コード１２：持込承認修正
        // 状態コード１３：持込差し戻し
        // 状態コード２０：対応承認待ち
        // 状態コード２２：対応承認修正
        // 状態コード２３：対応差し戻し
        // 持込段階なら持込の承認を、終了時対応段階なら対応の承認を行う
        if (motikomiDaityo.conditionCode.equals("10")) {
            motikomiDaityo.conditionCode = "13";
        } else if (motikomiDaityo.conditionCode.equals("12")) {
            motikomiDaityo.conditionCode = "13";
        } else if (motikomiDaityo.conditionCode.equals("20")) {
            motikomiDaityo.conditionCode = "23";
        } else if (motikomiDaityo.conditionCode.equals("22")) {
            motikomiDaityo.conditionCode = "23";
        }

        // 持込台帳を更新
        motSearchUpdateDao.updateMotimkomiDaityo(motikomiDaityo);
    }

    /**
     * 全件検索を行うメソッド
     * 
     * @param motSearchUpdateForm
     */
    public void setAllSearchResult(MotSearchUpdateForm motSearchUpdateForm) {

        // 検索条件をMotSearchFilterDtoに格納する
        MotSearchFilterParams motSearchFilterDto = new MotSearchFilterParams();

        this.pagingSearch(motSearchUpdateForm, motSearchFilterDto);

        // 検索内容をFormに反映
        Beans.copy(motSearchFilterDto, motSearchUpdateForm).execute();

    }

    /**
     * 未承認データの検索を行うメソッド
     * 
     * @param motSearchUpdateForm
     */
    public void setSearchResultUnapprove(MotSearchUpdateForm motSearchUpdateForm) {

        // 検索条件をMotSearchFilterDtoに格納する
        MotSearchFilterParams motSearchFilterDto = new MotSearchFilterParams();
        // 未承認以外の状態コードを検索結果に含まないように変更
        motSearchFilterDto.includeDeleted = "0";

        motSearchFilterDto.includeBringApproved = "0";

        motSearchFilterDto.includeBringUpdate = "1";

        motSearchFilterDto.includeBringRemand = "1";

        motSearchFilterDto.includeProcessApproved = "0";

        motSearchFilterDto.includeProcessUpdate = "1";

        motSearchFilterDto.includeProcessRemand = "1";

        // パラメータを渡して条件検索
        this.pagingSearch(motSearchUpdateForm, motSearchFilterDto);

        // 検索条件をFormに反映
        Beans.copy(motSearchFilterDto, motSearchUpdateForm).execute();
    }

    /**
     * 期限切れデータの検索を行うメソッド
     * 
     * @param motSearchUpdateForm
     */
    public void setSearchResultExpired(MotSearchUpdateForm motSearchUpdateForm) {

        // 検索条件をMotSearchFilterDtoに格納する
        MotSearchFilterParams motSearchFilterDto = new MotSearchFilterParams();
        // 期限切れデータを含み、かつ終了対応承認済みでも削除データでもないもの
        motSearchFilterDto.includeExpired = "1";

        motSearchFilterDto.includeProcessApproved = "0";

        motSearchFilterDto.includeDeleted = "0";

        // パラメータを渡して条件検索
        this.pagingSearch(motSearchUpdateForm, motSearchFilterDto);

        // 検索条件をFormに反映
        Beans.copy(motSearchFilterDto, motSearchUpdateForm).execute();
    }

    /**
     * 条件検索を行うメソッド
     * 
     * @param motSearchUpdateForm
     */
    public void setSearchResult(MotSearchUpdateForm motSearchUpdateForm) {

        // 検索条件をMotSearchFilterDtoに格納する
        MotSearchFilterParams motSearchFilterDto = new MotSearchFilterParams();

        Beans.copy(motSearchUpdateForm, motSearchFilterDto).execute();

        this.pagingSearch(motSearchUpdateForm, motSearchFilterDto);

    }

    public void bringUpdate(MotSearchUpdateForm motSearchUpdateFrom) {

        // 持込台帳のエンティティにjspからの入力情報を格納
        MotikomiDaityo motikomiDaityo = new MotikomiDaityo();
        Beans.copy(motSearchUpdateFrom, motikomiDaityo).execute();

        // 持出差し戻し（状態コード１３）のときに、持出修正（状態コード１２）になる
        if (motikomiDaityo.conditionCode.equals("13")) {
            motikomiDaityo.conditionCode = "12";
        }
        
        motSearchUpdateDao.updateMotimkomiDaityo(motikomiDaityo);
    }

    public void setMotikomiDaityoFromTableId(MotSearchUpdateForm motSearchUpdateForm){
        super.setMotikomiDaityoFromTableId(motSearchUpdateForm);
        Beans.copy(motSearchUpdateForm.historyDto.get(0), motSearchUpdateForm).excludesNull().execute();
    }

    /**
     * フォームとパラメータを受け取って、ページング検索を行うメソッド
     * @param syaSearchApproveForm
     * @param motSearchFilterDto
     */
    public void pagingSearch(MotSearchUpdateForm motSearchUpdateForm, MotSearchFilterParams motSearchFilterDto){
        
        // ページング処理
        //検索結果のテーブル数を取得
        motSearchUpdateForm.totalTable = motSearchUpdateDao.getTotalTable(motSearchFilterDto);
        //取得したテーブル数からページ数を取得
        motSearchUpdateForm.totalPage = castTotalPage(motSearchUpdateForm.totalTable);
        
        // パラメータを渡して条件検索
        motSearchUpdateForm.historyDto = motSearchUpdateDao
            .selectMotikomiDaityo(motSearchFilterDto, motSearchUpdateForm.pageNumber);
        return;
    }
}
