package management.dto;

import java.io.Serializable;

import org.seasar.framework.container.annotation.tiger.Component;
import org.seasar.framework.container.annotation.tiger.InstanceType;

/**
 * ログイン情報を管理するDto<br />
 * ログインユーザの情報を参照できる
 * @author sse802563
 */
@Component(instance = InstanceType.SESSION)
public class UserDataDto implements Serializable {
    
        private static final long serialVersionUID = 1L;
        
        /**
         * 社員ID
         */
        public String userId;
        
        /**
         * 社員名
         */
        public String personnelName;
        
        /**
         * アクセス権<br />
         * "0"であれば一般権限<br />
         * "1"であれば承認者権限<br />
         * "2"であれば管理者権限
         */
        public String authorizations = "0";
        
}
