package management.form;

import java.util.List;

import org.seasar.struts.annotation.Required;

import management.entity.PersonnelMaster;

public class KanPersonnelForm {
    
    public KanPersonnelForm() {
    }
    
    public List<PersonnelMaster> personnelMaster;
    
    /**
     * 社員の氏名を登録する際、姓と名の間に全角スペースを１つだけ入れたい
     * その場合、姓と名の入力フォームを分ける必要があるため変数を分けた
     */
    @Required
    public String familyName;
    
    @Required
    public String firstName;
    
    /**
     * 更新ページで更新前のテーブル情報を保持するエンティティ
     */
    public PersonnelMaster old;
    
    /**
     * 表示チェック用の権限情報を格納する
     * 入力フォームのauthorizationsと分けるため
     */
    public String condAuthorizations;
    
    /**
     * personnelNumber<br />
     * 社員番号
     */
    @Required
    public String personnelNumber;
    
    /**
     * personnelName<br />
     * 社員名
     */
    public String personnelName;
    
    /**
     * userId<br />
     * ユーザID　現状では社員番号と同じ
     */
    public String userId;
    
    /**
     * userPass<br />
     * パスワード　現状では社員番号と同じ
     */
    public String userPass;
    
    /**
     * authorizations<br />
     * 権限のフラグ<br />
     * 1ならば承認権限を持つ
     */
    public String authorizations;

}
