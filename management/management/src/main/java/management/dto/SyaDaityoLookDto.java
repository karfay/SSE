package management.dto;

/*
 * 持出状況の検索結果を格納するDto
 */
public class SyaDaityoLookDto {
    
    /*
     * 社内の有無を格納する
     * java側の処理なのでsqlの結果を受け取らない変数
     */
    public String syanai;
    
    /*
     * it_label
     * 端末のITラベル：base_masterのitLabel
     */
    public String itLabel;
    
    /*
     * user
     * 端末の所持社員名
     */
    public String user;
    
    /*
     * bring_person_number
     * 持出申請を行った社員番号
     */
    public String bringPersonNumber;
    
    /*
     * bring_person_name
     * 持出申請を行った社員名 
     */
    public String bringPersonName;
    
    /*
     * dest
     * 持出先
     */
    public String dest;
    
    /*
     * start_date
     * 持出開始日
     */
    public String startDate;
    
    /*
     * max_end_date
     * 同じITラベルの端末の中で、もっとも新しい持出終了日
     */
    public String maxEndDate;
    
}
