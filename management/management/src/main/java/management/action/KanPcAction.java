package management.action;

import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import management.form.KanPcForm;
import management.logic.KanPcLogic;
import management.util.ManagementStringUtil;

import org.apache.commons.io.output.ByteArrayOutputStream;
import org.seasar.extension.jdbc.dialect.FirebirdDialect;
import org.seasar.framework.util.InputStreamUtil;
import org.seasar.struts.annotation.Execute;

import management.constant.KanConstant;
import management.dao.KanPcDao;
import management.dto.PcMasterDto;
import management.dto.UserDataDto;

import org.seasar.struts.annotation.ActionForm;
import org.seasar.struts.util.ResponseUtil;

public class KanPcAction {

    @Resource
    public UserDataDto userDataDto;
    
    @ActionForm
    @Resource
    protected KanPcForm kanPcForm;
    
    @Resource
    public KanPcLogic kanPcLogic;
    
    @Resource
    public KanPcDao kanPcDao;
    
    //ダウンロード処理用
    @Resource
    protected HttpServletResponse response;
    
    /**
     * 初期表示
     * @return index.jsp
     */
    @Execute(validator=false)
    public String index(){
        
        //base_masterを全検索する
        kanPcLogic.getPcMaster(kanPcForm);
        
        //personnel_masterを全検索する
        kanPcForm.personnelMaster = kanPcDao.getPersonnelMaster();
        
        return "index.jsp";
    }
    
    /**
     * 新規登録ボタンを押した時のアクション
     * @return
     */
    @Execute(validator=true, input="indexErr")
    public String insert(){
        
        //入力されたITラベルチェック用にbase_masterを全検索する
        kanPcLogic.getPcMaster(kanPcForm);
        
        //ITラベルのチェックを行う
        //DBのユニーク条件に反している場合は判定式がfalseとなり、エラーページに遷移する。
        if(kanPcLogic.checkId(kanPcForm)){
        
        //ログインユーザIDを更新者に、現在日付を更新日に
        kanPcForm.updateUser = userDataDto.userId;
        kanPcForm.updateDate = ManagementStringUtil.getTime();
        
        kanPcLogic.insertPcMaster(kanPcForm);
        
        //入力結果の表示用にbase_masterを再度全検索する
        kanPcLogic.getPcMaster(kanPcForm);
        
        //表示用にpersonnel_masterを全検索する
        kanPcForm.personnelMaster = kanPcDao.getPersonnelMaster();
        
        kanPcForm.message = KanConstant.pcInsert;
        return "index.jsp";
        }
        kanPcForm.message = KanConstant.checkIdErr;
        return "indexErr.jsp";
    }
    
    @Execute(validator=false)
    public String indexErr(){
        
        index();
        kanPcForm.message = KanConstant.insertErr;
        
        return "indexErr.jsp";
    }
    
    /**
     * 修正ボタンを押した時の処理
     * @return
     */
    @Execute(validator=false)
    public String jumpUpdate(){
        
        //personnel_masterを全検索する
        kanPcForm.personnelMaster = kanPcDao.getPersonnelMaster();
        
        kanPcLogic.copyOld(kanPcForm);
        return "update.jsp";
    }
    
    /**
     * 修正ページ（update.jsp）で修正ボタンを押した時の処理
     * @return
     */
    @Execute(validator=true, input="update.jsp")
    public String update(){
        
        //入力されたITラベルチェック用にbase_masterを全検索する
        kanPcLogic.getPcMaster(kanPcForm);
        
        //ログインユーザIDを更新者に、現在日付を更新日に
        kanPcForm.updateUser = userDataDto.userId;
        kanPcForm.updateDate = ManagementStringUtil.getTime();
        
        kanPcLogic.updatePcMaster(kanPcForm);
        
        return "index";
    }
    
    /**
     * 引用ボタンを推した時の処理
     * @return
     */
    @Execute(validator=false)
    public String quote(){
        
        //javascriptで対応
        //javascript未対応ブラウザ用に一応残す
        return null;
    }
    
    /**
     * クリアボタンを推した時の処理
     * @return
     */
    @Execute(validator=false)
    public String clear(){
        
        //javascriptで対応
        //javascript未対応ブラウザ用に一応残す
        return null;
    }
    
    /**
     * csvファイルを出力ボタンを押した時のメソッド
     */
    @Execute(validator=false)
    public String importCsv(){
        
        kanPcLogic.getPcMaster(kanPcForm);
        
        //FileOutputStreamを利用して、対象のフォルダにcsvファイルを保存するメソッド
        //サーバ側の保存先をうまく指定できなかったので破綻
        //localではうまくいくけど、コンパイルしてサーバに配備するとうまくいかないのがミソ
        //kanPcLogic.createCsv(kanPcForm.pcMasterDto);
        
        //this.download();
        
        this.download(kanPcForm.pcMasterDto);
        
        return null;
    }
    
    /**
     * デバッグでオーバーロードしたため利用していない（20170112）
     * ローカル用のダウンロードメソッド
     * 既にあるファイルを指定してダウンロードさせることができそうだけど、
     * サーバ側のフォルダ指定がうまく出来ていない
     */
    public void download(){
        
        try {
            InputStream is = new FileInputStream(kanPcLogic.csvFilePass);
            

            ResponseUtil.download(new String("pc_master.csv".getBytes("Shift-JIS"),"ISO-8859-1"), is);
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
    
    /**
     * とりあえずByteArrayなるものを利用して記述してみただけ
     * できたので昔の記述を残してオーバーロード
     * @param list
     */
    public void download(List<PcMasterDto> list){
        try {
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            OutputStreamWriter osw = new OutputStreamWriter(baos, "Shift_JIS");
            BufferedWriter bfw = new BufferedWriter(osw);
            
            String tmp = "";
            
            //見出し行を書き込む
            tmp += "\"ITラベル\",";
            tmp += "\"管理者\",";
            tmp += "\"利用者\",";
            tmp += "\"資産形態\",";
            tmp += "\"利用開始日\",";
            tmp += "\"利用終了日\",";
            tmp += "\"終了予定日\",";
            tmp += "\"メーカー\",";
            tmp += "\"型番\",";
            tmp += "\"製造番号\",";
            tmp += "\"OS\",";
            tmp += "\"無線LAN\",";
            tmp += "\"暗号化ソフト\",";
            tmp += "\"備考\"";
            
            //1行分を書き込む
            bfw.write(tmp);
            //改行をセット
            bfw.newLine();
            
            tmp = "";
            
            
            for(PcMasterDto pm : list){
                //1行分を作成
                tmp += convertNull(pm.itLabel) + ",";
                tmp += convertNull(pm.admin) + ",";
                tmp += convertNull(pm.user) + ",";
                tmp += convertNull(pm.assetsMode) + ",";
                tmp += convertNull(pm.startDate) + ",";
                tmp += convertNull(pm.endDate) + ",";
                tmp += convertNull(pm.scheduledDate) + ",";
                tmp += convertNull(pm.maker) + ",";
                tmp += convertNull(pm.modelNumber) + ",";
                tmp += convertNull(pm.serialNumber) + ",";
                tmp += convertNull(pm.os) + ",";
                tmp += convertNull(pm.wirelessLan) + ",";
                tmp += convertNull(pm.encryption) + ",";
                tmp += convertNull(pm.notes);
                //DB上のnullのカラムを文字列nullでcsvに出力したい場合は下の記述に変更する
//                tmp += "\"" + pm.itLabel + "\",";
//                tmp += "\"" + pm.admin + "\",";
//                tmp += "\"" + pm.user + "\",";
//                tmp += "\"" + pm.assetsMode + "\",";
//                tmp += "\"" + pm.startDate + "\",";
//                tmp += "\"" + pm.endDate + "\",";
//                tmp += "\"" + pm.scheduledDate + "\",";
//                tmp += "\"" + pm.maker + "\",";
//                tmp += "\"" + pm.modelNumber + "\",";
//                tmp += "\"" + pm.serialNumber + "\",";
//                tmp += "\"" + pm.os + "\",";
//                tmp += "\"" + pm.wirelessLan + "\",";
//                tmp += "\"" + pm.encryption + "\",";
//                tmp += "\"" + pm.notes + "\"";
                //1行分を書き込む
                bfw.write(tmp);
                //改行をセット
                bfw.newLine();
                
                tmp = "";

            }
            
          
            bfw.close();
            osw.close();
            
            
            ByteArrayInputStream bais = new ByteArrayInputStream(baos.toByteArray());
            
            ResponseUtil.download(new String("pc_master.csv".getBytes("Shift-JIS"),"ISO-8859-1"), bais);
            
            baos.close();
            bais.close();
            
            
        } catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
    }
    
    /**
     * 受け取ったStringがnullなら空白を返し、nullでないならStringを""で囲んで返すメソッド
     * DBからnullを受け取るとcsvに転記する際文字列nullとして転記されてしまうため
     * @param str
     * @return
     */
    private String convertNull(String str){
        if(str == null){
            return "";
        }
        else{
            return "\"" + str + "\"";
        }
    }
    
    
    /**
     * 削除ボタンを押した時の処理
     * @return
     */
    @Execute(validator=false)
    public String delete(){
        kanPcLogic.deletePcMaster(kanPcForm);
        
        kanPcForm.message = KanConstant.pcDelete;
        return "index";
    }
    
    /**
     * ログアウトボタンを押した際のメソッド
     * 
     * @return
     */
    @Execute(validator = false)
    public String logout() {

        userDataDto.userId = null;

        return "/login/?redirect=true";
    }

    /**
     * メニュー画面へボタンを押した際のメソッド
     * 
     * @return
     */
    @Execute(validator = false)
    public String menu() {

        return "/menu/?redirect=true";
    }
    
}
