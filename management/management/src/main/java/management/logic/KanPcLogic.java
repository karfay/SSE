package management.logic;

import java.util.List;

import java.io.*;

import javassist.bytecode.LineNumberAttribute.Pc;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.seasar.framework.beans.util.Beans;
import org.seasar.struts.util.ResponseUtil;

import management.constant.KanConstant;
import management.dao.KanPcDao;
import management.dto.PcMasterDto;
import management.entity.PcMaster;
import management.entity.PersonnelMaster;
import management.form.KanPcForm;
import management.util.ManagementStringUtil;

public class KanPcLogic {
    
    @Resource
    public KanPcDao kanPcDao;
    
    //ダウンロード処理用
    @Resource
    protected HttpServletResponse response;
    
    //csvファイルの作成場所
    public final String csvFilePass = "C:/Users/SSE802563/Desktop/management/pc_master.csv";
    //public final String csvFilePass = "C:/Users/Administrator/Desktop/management/pc_master.csv";

    /**
     * base_masterを全検索した結果をformに格納するメソッド
     * @param kanPcForm
     */
    public void getPcMaster(KanPcForm kanPcForm) {
        
        kanPcForm.pcMasterDto = kanPcDao.getPcMaster();
        
        convartDateForPcMaster(kanPcForm.pcMasterDto);
        return;
        
    }

    /**
     * DBから受け取ったpcMasterのうち、DATE型だったものは(yyyy-MM-dd)となっているので
     * このフォーマットを（yyyyMMdd）に変更するメソッド
     * @param pcMasterDto
     */
    private void convartDateForPcMaster(List<PcMasterDto> pcMasterDto) {
        for(PcMasterDto dto: pcMasterDto){
            dto.itLabel = ManagementStringUtil.convertDateFormatForInput(dto.itLabel);
            dto.admin = ManagementStringUtil.convertDateFormatForInput(dto.admin);
            dto.user = ManagementStringUtil.convertDateFormatForInput(dto.user);
            dto.assetsMode = ManagementStringUtil.convertDateFormatForInput(dto.assetsMode);
            dto.startDate = ManagementStringUtil.convertDateFormatForInput(dto.startDate);
            dto.endDate = ManagementStringUtil.convertDateFormatForInput(dto.endDate);
            dto.scheduledDate = ManagementStringUtil.convertDateFormatForInput(dto.scheduledDate);
            dto.maker = ManagementStringUtil.convertDateFormatForInput(dto.maker);
            dto.modelNumber = ManagementStringUtil.convertDateFormatForInput(dto.modelNumber);
            dto.serialNumber = ManagementStringUtil.convertDateFormatForInput(dto.serialNumber);
            dto.os = ManagementStringUtil.convertDateFormatForInput(dto.os);
            dto.wirelessLan = ManagementStringUtil.convertDateFormatForInput(dto.wirelessLan);
            dto.encryption = ManagementStringUtil.convertDateFormatForInput(dto.encryption);
            dto.notes = ManagementStringUtil.convertDateFormatForInput(dto.notes);
        }
    }

    /**
     * Formで受け取った値をpcMasterエンティティにコピーしてインサート処理を行うDaoに投げるメソッド
     * @param kanPcForm
     */
    public void insertPcMaster(KanPcForm kanPcForm) {
        
        PcMaster pcMaster = new PcMaster();
        //DATE型のカラムに空白文字を渡さないようにexcludesWhitespace()を利用してコピー
        Beans.copy(kanPcForm, pcMaster).excludesWhitespace().execute();
        
        kanPcDao.insertPcMaster(pcMaster);
        
    }

    /**
     * Formで受け取った値をpcMasterエンティティにコピーしてデリート処理を行うDaoに投げるメソッド
     * @param kanPcForm
     */
    public void deletePcMaster(KanPcForm kanPcForm) {
        
        PcMaster pcMaster = new PcMaster();
        Beans.copy(kanPcForm, pcMaster).excludesNull().execute();
        
        kanPcDao.deletePcMaster(pcMaster);
    }

    public void copyOld(KanPcForm kanPcForm) {
        kanPcForm.old = new PcMaster(); 
        Beans.copy(kanPcForm, kanPcForm.old).excludesNull().execute();
    }

    public void updatePcMaster(KanPcForm kanPcForm) {
        
        PcMaster pcMaster = new PcMaster();
      //DATE型のカラムに空白文字を渡さないようにexcludesWhitespace()を利用してコピー
        Beans.copy(kanPcForm, pcMaster).excludesWhitespace().execute();
        
        kanPcDao.updatePcMaster(pcMaster);
    }
    
    public void importCsv(List<PcMaster> pcMaster){
 
    }

    /**
     * pcMasterのリストを受け取ってcsv出力を行うメソッド
     * @param list
     */
    public void createCsv(List<PcMasterDto> list){
        
        try {
            FileOutputStream fos = new FileOutputStream(csvFilePass);
            OutputStreamWriter osw = new OutputStreamWriter(fos, "Shift_JIS");
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
            fos.close();
            
            
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
     * DBからnullを受け取るとcsvに転記する際文字列nullとして転機されてしまうため
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
     * 入力された新規登録用ITラベルがDBで使われていないかチェックする
     * 使用されていた場合falseを返して、使用されていない場合trueを返す
     * @param kanPcForm
     * @return 
     */
    public boolean checkId(KanPcForm kanPcForm) {
        
        for(PcMasterDto dtos : kanPcForm.pcMasterDto){
            if(dtos.itLabel.equals(kanPcForm.itLabel)){
                return false;
            }
        }
        //for文を無事に抜けたらtrue
        return true;
        
    }
       
}
