package management.logic;
import java.io.UnsupportedEncodingException;

import javax.annotation.Resource;

import org.seasar.framework.beans.util.Beans;

import management.constant.SyaConstant;
import management.dao.SyaCommonDao;
import management.dto.TakePcOutDto;
import management.entity.PersonnelMaster;
import management.entity.TakeDocumentsOut;
import management.entity.TakePcOut;
import management.form.SyaCommonForm;
import management.parameter.TakePcOutParams;
import management.util.ManagementStringUtil;

public class SyaCommonLogic {

    @Resource
    public SyaCommonDao syaCommonDao;

    /**
     * document_category_masterから紙媒体資料の区分情報を取ってくるメソッド<br />
     * Formのフィールドに格納してjspで利用する
     */
    public void getDocmentCategory(SyaCommonForm syaCommonForm) {

        // document_category_masterを全件取得してForm.documentCategoryに格納
        syaCommonForm.documentCategoy = syaCommonDao.getDocmentCategory();
    }

    /**
     * StringUtilクラスを使って、入力用の日付のformatを統一するメソッド<br />
     * DBではyyyy-mm-dd形式で表示される日付をyyyymmdd形式に変換する
     * 
     * @param syaCommonForm
     */
    public void convertDateFormatForInput(SyaCommonForm syaCommonForm) {
        syaCommonForm.appDate = ManagementStringUtil
            .convertDateFormatForInput(syaCommonForm.appDate);
        syaCommonForm.startDate = ManagementStringUtil
            .convertDateFormatForInput(syaCommonForm.startDate);
        syaCommonForm.endDate = ManagementStringUtil
            .convertDateFormatForInput(syaCommonForm.endDate);
        syaCommonForm.approvalDate = ManagementStringUtil
            .convertDateFormatForInput(syaCommonForm.approvalDate);
    }

    /**
     * condition_masterテーブルを全件検索して結果をFormの対応するフィールドに格納するメソッド
     * 
     * @param syaCommonForm
     */
    public void getConditionMaster(SyaCommonForm syaCommonForm) {

        syaCommonForm.conditionMaster = syaCommonDao.getConditionMaster();

    }

    /**
     * 台帳に登録・修正する値の中で、半角指定のものを全てチェックするメソッド<br />
     * もし全角で入力されていた場合は半角に変換する
     * 
     * @param takePcOut
     */
    public void convertFieldsForDaityo(TakePcOut takePcOut) {
        takePcOut.appDate = ManagementStringUtil
            .convertCharactor(takePcOut.appDate);
        takePcOut.appUser = ManagementStringUtil
            .convertCharactor(takePcOut.appUser);
        takePcOut.startDate = ManagementStringUtil
            .convertCharactor(takePcOut.startDate);
        takePcOut.endDate = ManagementStringUtil
            .convertCharactor(takePcOut.endDate);
        takePcOut.itLabel = ManagementStringUtil
            .convertCharactor(takePcOut.itLabel);
        takePcOut.wirelessLan = ManagementStringUtil
            .convertCharactor(takePcOut.wirelessLan);
        takePcOut.flashMemory = ManagementStringUtil
            .convertCharactor(takePcOut.flashMemory);
    }

    /**
     * 紙媒体資料を追加・登録・修正する値の中で、半角指定のものを全てチェックするメソッド<br />
     * もし全角で入力されていた場合は半角に変換する
     * 
     * @param takeDocumentsOut
     */
    public void convertFieldsForDocuments(TakeDocumentsOut takeDocumentsOut) {
        takeDocumentsOut.copies = ManagementStringUtil
            .convertCharactor(takeDocumentsOut.copies);
    }

    /**
     * 承認の際に更新する値の中で、半角指定のものを全てチェックするメソッド<br />
     * もし全角で入力されていた場合は半角に変換する
     * 
     * @param takePcOut
     */
    public void convertFieldsForApprove(TakePcOut takePcOut) {
        takePcOut.approvalDate = ManagementStringUtil
            .convertCharactor(takePcOut.approvalDate);
        takePcOut.approver = ManagementStringUtil
            .convertCharactor(takePcOut.approver);
    }

    /**
     * sYA010Form.timeに現在時刻を格納するメソッド
     * 
     * @param syaDaityoInputForm
     */
    public void getTime(SyaCommonForm syaCommonForm) {
        syaCommonForm.time = ManagementStringUtil.getTime();
    }

    /**
     * tableIdを用いてTakePcOutテーブルから1件を取り出すメソッド
     * 
     * @param syaCommonForm
     */
    public void setRecordFromTableId(SyaCommonForm syaCommonForm) {

        TakePcOutDto takePcOutDto;

        takePcOutDto = syaCommonDao.getRecordFromTableId(syaCommonForm.tableId);

        // jspで表示するためにFormのフィールドに検索結果を格納する
        Beans.copy(takePcOutDto, syaCommonForm).execute();
    }

    /**
     * テーブルの紙媒体資料の持出データをとってくるメソッド<br />
     * @param syaCommonForm
     */
    public void setDocumentRecords(SyaCommonForm syaCommonForm) {

        syaCommonForm.documents = syaCommonDao
            .getDocumentRecords(syaCommonForm.tableId);

    }

    /**
     * 承認者権限を持つユーザの社員情報をとってくるメソッド<br />
     * TakePcOutへの代入はあくまで社員番号
     * 
     * @param syaCommonForm
     */
    public void setApproversData(SyaCommonForm syaCommonForm) {
        // 重複して呼んでしまうことがあるので、既に処理していたら処理終了
        if (syaCommonForm.approvers != null) {
            return;
        }
        syaCommonForm.approvers = syaCommonDao.selectApprovers();
    }

    /**
     * {@link SyaCommonForm}.historyDto.approverの社員IDを社員名に変えるメソッド<br />
     * index2.jspが呼ばれたときのみ使用される<br />
     * index.jspで使用するとinput属性のapproverが変わってしまうため
     * 
     * @param syaSearchApproveForm
     */
    public void setApproverName(SyaCommonForm syaCommonForm) {
        // historyDtoにデータがなければ処理終了
        if (syaCommonForm.historyDto == null) {
            return;
        }
        for (TakePcOutDto takePcOutDto : syaCommonForm.historyDto) {
            // approverが登録されていなければcontinue、equalsでNullPointerExceptionになるため
            if (takePcOutDto.approver == null) {
                continue;
            }
            for (PersonnelMaster approvers : syaCommonForm.approvers) {
                if (takePcOutDto.approver.equals(approvers.personnelNumber)) {
                    takePcOutDto.approver = approvers.personnelName;
                }
            }
        }

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
        return (int) Math.ceil((double)pageCount / SyaConstant.pageIndex);
    }
    
    /**
     * 条件検索の結果をsyaSearchApproveForm.historyDtoに格納するメソッド<br />
     * 
     * @param syaCommonForm
     * @throws UnsupportedEncodingException 
     */
    public void setSearchResult(SyaCommonForm syaCommonForm) throws UnsupportedEncodingException {
        TakePcOutParams params = new TakePcOutParams();
        Beans.copy(syaCommonForm, params).excludesNull().execute();

        // 検索結果の行数を取得
        syaCommonForm.pageCount = syaCommonDao.getCountFromTakePcOut(params);

        // 総ページ数を計算
        syaCommonForm.totalPage = castTotalPage(syaCommonForm.pageCount);

        // 指定されたページ番号分だけ検索結果を取得
        syaCommonForm.historyDto = syaCommonDao
            .selectPagingSearch(syaCommonForm.pageNumber, params);

        // 全件検索のページングに用いるURLを格納
        //syaCommonForm.pagingUrl = ManagementStringUtil.createPagingUrlForConditionalSearch(params);
    }
    
    /**
     * wireless_lan_masterを全件検索してsyaDaityoInputForm.wirelessLanMasterに格納するメソッド
     * @param syaDaityoInputForm
     */
    public void getWirelessLanMaster(SyaCommonForm syaCommonForm) {
        
        syaCommonForm.wirelessLanMaster = syaCommonDao.getWirelessLanMaster();
        
    }
    
    /**
     * 無線子機のマスタテーブルの全件検索の結果を返すメソッド
     * @param syaCommonForm
     */
    public void getWirelessSlaveMaster(SyaCommonForm syaCommonForm) {
        syaCommonForm.wirelessSlaveMaster = syaCommonDao.getWirelessSlaveMaster();
        
    }
    
}
