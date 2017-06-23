package management.util;

import java.util.Comparator;

/**
 * いると思ったらいらなかった
 * 実装手順はこれで良いもよう
 * @author sse802563
 *
 */
public class WirelessLanConparator implements Comparator<String> {

    public int compare(String label1, String label2) {
        int intLabel1 = Integer.parseInt(label1);
        int intLabel2 = Integer.parseInt(label2);
        return intLabel1 - intLabel2;
    }

}
