package management.logic;

import javax.annotation.Resource;

import management.dao.SyaSearchApproveDao;
import management.dto.TakePcOutDto;
import management.entity.PersonnelMaster;
import management.entity.TakePcOut;
import management.form.SyaSearchApproveForm;
import management.util.ManagementStringUtil;

public class SyaSearchApproveLogic extends SyaCommonLogic {

    @Resource
    public SyaSearchApproveDao syaSearchApproveDao;

    /**
     * 未承認のデータを検索するメソッド<br />
     * データがあればtrue、なければfalseを返す
     * 
     * @param syaSearchApproveForm
     * @return
     */
    public void setUnapprovedRecords(SyaSearchApproveForm syaSearchApproveForm) {
        // 検索結果の行数を取得
        syaSearchApproveForm.pageCount = syaSearchApproveDao
            .countUnapprovedRecords();

        // 総ページ数を計算
        syaSearchApproveForm.totalPage = castTotalPage(syaSearchApproveForm.pageCount);

        // 指定されたページ番号分だけ検索結果を取得
        syaSearchApproveForm.historyDto = syaSearchApproveDao
            .getUnapprovedRecords(syaSearchApproveForm.pageNumber);

        // 未承認一覧のページングに用いるURLを格納
        syaSearchApproveForm.pagingUrl = ManagementStringUtil
            .createPagingUrlForShowUnapprovedRecords();
    }

    /**
     * 申請の承認を行うメソッド<br />
     * 
     * @param syaSearchApproveForm
     */
    public void approveRecords(SyaSearchApproveForm syaSearchApproveForm) {
        
        TakePcOut takePcOut = new TakePcOut();

        // 更新者と更新日、主キーだけフォームからエンティティに格納
        takePcOut.approver = syaSearchApproveForm.approver;
        takePcOut.approvalDate = syaSearchApproveForm.approvalDate;
        takePcOut.tableId = syaSearchApproveForm.tableId;

        // conditioncode=1は"承認済み"
        takePcOut.conditionCode = "1";

        syaSearchApproveDao.updateTakePcOut(takePcOut);
    }

    /**
     * 全件検索の結果をsyaSearchApproveForm.historyDtoに格納するメソッド<br />
     * ページングに対応
     * 
     * @param syaSearchApproveForm
     */
    public void selectAllRecords(SyaSearchApproveForm syaSearchApproveForm) {
        // 検索結果の行数を取得
        syaSearchApproveForm.pageCount = syaSearchApproveDao.countSelectAll();

        // 総ページ数を計算
        syaSearchApproveForm.totalPage = castTotalPage(syaSearchApproveForm.pageCount);

        // 指定されたページ番号分だけ検索結果を取得
        syaSearchApproveForm.historyDto = syaSearchApproveDao
            .selectAllRecords(syaSearchApproveForm.pageNumber);

        // 全件検索のページングに用いるURLを格納
        syaSearchApproveForm.pagingUrl = ManagementStringUtil
            .createPagingUrlForShowAll();

    }


    /**
     * 登録情報の差し戻しを行うメソッド<br />
     * conditionCodeとnotesのみを更新する
     * 
     * @param syaSearchApproveForm
     */
    public void remandRecords(SyaSearchApproveForm syaSearchApproveForm) {

        TakePcOut takePcOut = new TakePcOut();

        // 更新者と更新日、主キーだけフォームからエンティティに格納
        takePcOut.approver = syaSearchApproveForm.approver;
        takePcOut.approvalDate = syaSearchApproveForm.approvalDate;
        takePcOut.notes = syaSearchApproveForm.notes;
        takePcOut.tableId = syaSearchApproveForm.tableId;

        // conditioncode=3は"差し戻し"
        takePcOut.conditionCode = "3";

        // NULL以外のデータを更新、つまり上で格納したデータのみを更新
        syaSearchApproveDao.updateTakePcOut(takePcOut);

    }

    /**
     * {@link SyaSearchApproveForm}.historyDto.approverの社員IDを社員名に変えるメソッド<br />
     * index2.jspが呼ばれたときのみ使用される<br />
     * index.jspで使用するとinput属性のapproverが変わってしまうため
     * 
     * @param syaSearchApproveForm
     */
    public void setApproverName(SyaSearchApproveForm syaSearchApproveForm) {
        // historyDtoにデータがなければ処理終了
        if (syaSearchApproveForm.historyDto == null) {
            return;
        }
        for (TakePcOutDto takePcOutDto : syaSearchApproveForm.historyDto) {
            // approverが登録されていなければcontinue、equalsでNullPointerExceptionになるため
            if (takePcOutDto.approver == null) {
                continue;
            }
            for (PersonnelMaster approvers : syaSearchApproveForm.approvers) {
                if (takePcOutDto.approver.equals(approvers.personnelNumber)) {
                    takePcOutDto.approver = approvers.personnelName;
                }
            }
        }

    }

    /*
     * SyaSearchApproveForm syaSearchApproveFormの検索条件にあたる変数全てにチェックを入れる関数
     */
    public void setAllConditions(SyaSearchApproveForm syaSearchApproveForm) {
        
        syaSearchApproveForm.includeApproved = "1";
        syaSearchApproveForm.includeCorrected = "1";
        syaSearchApproveForm.includeDeleted = "1";
        syaSearchApproveForm.includeRemanded = "1";
        syaSearchApproveForm.includeUnapproved = "1";
        
    }

    /*
     * SyaSearchApproveForm syaSearchApproveFormの検索条件にあたる変数の
     * 未承認データを取得する条件のみにチェックを入れる関数
     */
    public void setUnapproveCondition(SyaSearchApproveForm syaSearchApproveForm) {
        
        syaSearchApproveForm.includeApproved = "0";
        syaSearchApproveForm.includeCorrected = "1";
        syaSearchApproveForm.includeDeleted = "0";
        syaSearchApproveForm.includeRemanded = "0";
        syaSearchApproveForm.includeUnapproved = "1";
        
    }

    /**
     * 差し戻しデータを検索するためにフォームの条件を変更するメソッド
     * @param syaSearchApproveForm
     */
    public void setRemandConditon(SyaSearchApproveForm syaSearchApproveForm) {
        
        syaSearchApproveForm.includeApproved = "0";
        syaSearchApproveForm.includeCorrected = "0";
        syaSearchApproveForm.includeDeleted = "0";
        syaSearchApproveForm.includeRemanded = "1";
        syaSearchApproveForm.includeUnapproved = "0";
        
    }

}
