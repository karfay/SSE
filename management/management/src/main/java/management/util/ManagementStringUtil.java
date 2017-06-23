package management.util;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import management.form.SyaCommonForm;
import management.form.SyaDaityoInputForm;
import management.parameter.TakePcOutParams;

/**
 * 文字列操作に関する汎用メソッドを置いておくクラス
 * 
 * @author sse802563
 * 
 */
public class ManagementStringUtil {

    /**
     * yyyyMMddHHmmss
     */
    static SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddHHmmss");

    /**
     * yyyyMMdd
     */
    static SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMdd");

    /**
     * yyyy/MM/dd
     */
    static SimpleDateFormat sdf3 = new SimpleDateFormat("yyyy-MM-dd");

    /**
     * 現在時刻を返すメソッド
     * 
     * @return 現在時刻(yyyyMMdd)
     */
    public static String getTime() {
        Date date = new Date();
        return sdf2.format(date);
    }

    /**
     * tableIdを生成する<br />
     * tableIdはログインユーザの社員番号と現在時刻を用いて一意に定めている
     * 
     * @param userId
     *            社員番号
     * @return tableId
     */
    public static String setTableId(String userId) {
        Date date = new Date();
        return userId.substring(3, 9) + sdf1.format(date);
    }

    //TODO 引数がsya限定になっているので、上の汎用メソッドに統合する
    /**
     * tableIdを生成する<br />
     * tableIdはログインユーザの社員番号と現在時刻を用いて一意に定めている
     * 
     * @param syaDaityoInputForm
     */
    public static void setTableId(SyaDaityoInputForm syaDaityoInputForm) {
        Date date = new Date();
        syaDaityoInputForm.tableId = syaDaityoInputForm.userId.substring(3, 9)
            + sdf1.format(date);
    }

    /**
     * 受け取った日付データの入っているString型のデータのフォーマットを変換するクラス<br />
     * valueの値がyyyy-MM-dd形式であればyyyyMMdd形式に変換する
     * 
     * @param value
     *            日付データの入ったString型文字列
     * @return yyyyMMdd
     */
    public static String convertDateFormatForInput(String value) {
 
        if (value == null || value.equals("")) {
            return "";
        } else if (checkPattern(value)) {
            return value;
        } else {
            return value.replaceAll("-", "");
        }
    }

    /**
     * 受け取った文字列が999999にマッチしたらtrue、しなければfalseを返すメソッド
     * 
     * @param str
     * @return
     */
    public static Boolean checkPattern(String str) {
        String regex = "\\d\\{5}";
        Pattern p = Pattern.compile(regex);
        Matcher m = p.matcher(str);

        if (m.find()) {
            return true;
        } else {
            return false;
        }

    }

    /**
     * 全角アルファベットと半角アルファベットとの文字コードの差
     */
    private static final int DIFFERENCE = 'Ａ' - 'A';

    /**
     * 文字列のアルファベット・数値を半角文字に変換する。
     * 
     * @param str
     * @return
     */
    public static String convertCharactor(String str) {
        if (str == null || str.equals("")) {
            return str;
        }
        char[] cc = str.toCharArray();
        StringBuilder sb = new StringBuilder();
        for (char c : cc) {
            char newChar = c;
            if ((('Ａ' <= c) && (c <= 'Ｚ')) || (('ａ' <= c) && (c <= 'ｚ'))
                || (('０' <= c) && (c <= '９'))) {
                // 変換対象のcharだった場合に全角文字と半角文字の差分を引く
                newChar = (char) (c - DIFFERENCE);
            }
            sb.append(newChar);
        }
        return sb.toString();
    }

    /**
     * {@link SyaCommonForm}.pagingUrlに格納するUrlを作成するメソッド<br />
     * 全件検索showAll用
     * 
     * @return
     */
    public static String createPagingUrlForShowAll() {
        return "showAll?pageNumber=";
    }

    /**
     * {@link SyaCommonForm}.pagingUrlに格納するUrlを作成するメソッド<br />
     * 全件検索showUnapprovedRecords用
     * 
     * @return
     */
    public static String createPagingUrlForShowUnapprovedRecords() {
        return "showUnapprovedRecords?pageNumber=";
    }

    /**
     * 「この条件で検索」conditionalSearchのページング用のURLを生成するメソッド
     * 
     * @param params
     * @return
     * @throws UnsupportedEncodingException 
     */
    public static String createPagingUrlForConditionalSearch(
            TakePcOutParams params) throws UnsupportedEncodingException {

        String url = "search?";

        // paramsに検索条件が格納されていたら値を渡す
        url += checkAddUrl(params.searchDateAfter, "searchDateAfter");
        url += checkAddUrl(params.searchDateBefore, "searchDateBefore");
        url += checkAddUrl(params.searchDest, "searchDest");
        url += checkAddUrl(params.searchName, "searchName");
        url += checkAddUrl(params.searchPastRecords, "searchPastRecords");
        url += checkAddUrl(params.includeApproved, "includeApproved");
        url += checkAddUrl(params.includeCorrected, "includeCorrected");
        url += checkAddUrl(params.includeDeleted, "includeDeleted");
        url += checkAddUrl(params.includeRemanded, "includeRemanded");
        url += checkAddUrl(params.includeUnapproved, "includeUnapproved");
        url += "&" + "pageNumber=";

        return url;

    }

    /**
     * パラメータの値によってurlに付け加える文字列を生成していくメソッド
     * 
     * @param url
     *            　createPagingUrlForConditionalSearchから受け取るurl
     * @param param
     *            　パラメータの値
     * @param paramName
     *            　パラメータの名前
     */
    private static String checkAddUrl(String param, String paramName) {
        if (param.equals("")) {
            return "";
        } else {
            return "&" + paramName + "=" + param;
        }
    }

    /**
     * {@link SyaCommonForm}.pagingUrlに格納するUrlを作成するメソッド<br />
     * 個人履歴検索showPersonalRecords用
     * 
     * @return
     */
    public static String createPagingUrlForShowPersonalRecords() {
        return "showPersonalRecords?pageNumber=";
    }

    /**
     * 日付データの格納されている文字列を受け取って、Date型に変換して返すメソッド
     * @param str
     *          日付データの格納されている文字列
     * @return Date
     */
    public static Date toDate(String str) throws ParseException{
        Date date = sdf3.parse(str);
        return date;
    }
}
