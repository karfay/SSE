package management.logic;

import java.text.ParseException;
import java.util.Date;

import javax.annotation.Resource;

import management.dao.SyaDaityoLookDao;
import management.dto.SyaDaityoLookDto;
import management.form.SyaDaityoLookForm;
import management.util.*;

public class SyaDaityoLookLogic{

    @Resource
    public SyaDaityoLookDao syaDaityoLookDao;
    
    public void listUp(SyaDaityoLookForm syaDaityoLookForm) throws ParseException {
        
        //条件に合ったsqlを呼び出して検索結果をFormに格納する
        if(syaDaityoLookForm.includePc.equals("1")){
            syaDaityoLookForm.syaDaityoLookDto1 = syaDaityoLookDao.listUpPc1();
            syaDaityoLookForm.syaDaityoLookDto2 = syaDaityoLookDao.listUpPc2();
        } else if(syaDaityoLookForm.includeWirelesslan.equals("1")){
            syaDaityoLookForm.syaDaityoLookDto1 = syaDaityoLookDao.listUpWirelessLan1();
            syaDaityoLookForm.syaDaityoLookDto2 = syaDaityoLookDao.listUpWirelessLan2();
        } else if(syaDaityoLookForm.includeWirelessSlave.equals("1")){
            syaDaityoLookForm.syaDaityoLookDto1 = syaDaityoLookDao.listUpWirelessSlave1();
            syaDaityoLookForm.syaDaityoLookDto2 = syaDaityoLookDao.listUpWirelessSlave2();
        }
        
        //現在日時を取得する
        Date now = new Date();
        
        //社内にあるかないかを判断し、検索結果に有無情報を格納する
        for(SyaDaityoLookDto t : syaDaityoLookForm.syaDaityoLookDto1){
            
            //Date tmp = ManagementStringUtil.toDate(t.maxEndDate);
            
            //ありえないはずだけど、max_end_dateがnullなら持ちだされていないから社内
            if(t.maxEndDate == null)t.syanai = "有";
            //現在日付がmax_end_dateより新しければ社内
            else if(now.compareTo(ManagementStringUtil.toDate(t.maxEndDate)) > 0)
                t.syanai = "有";
            //そうでなければ社外
            else t.syanai = "無";
            
        }
    }

}
