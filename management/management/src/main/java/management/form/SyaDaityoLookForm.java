package management.form;

import java.util.List;

import management.dto.SyaDaityoLookDto;

public class SyaDaityoLookForm extends SyaCommonForm{

    //----------------------------------------------------------------
    // 持出状況の検索条件に関するフィールド
    //----------------------------------------------------------------
    /*
     * PCを条件に含むためのフラグ
     */
    public String includePc;
    
    /*
     * ポケットWi-Fiを条件に含むためのフラグ
     */
    public String includeWirelesslan;
    
    /*
     * フラッシュメモリを条件に含むためのフラグ
     */
    public String includeWirelessSlave; 
    
    /*
     * 持出状況の検索結果を格納するDto
     * 持出管理台帳にあるITラベルごとに持出終了日が最大のデータを格納する
     */
    public List<SyaDaityoLookDto> syaDaityoLookDto1;
    
    /*
     * 持出状況の検索結果を格納するDto
     * ベースマスタのうち、持出データが全く無い（つまり社外に持ち出されたことがない）データを格納する
     */
    public List<SyaDaityoLookDto> syaDaityoLookDto2;
}
