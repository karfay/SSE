package ug.form;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
/**
 * 各テーブルのIDカラムをjsp内で保持するのが大変なのでセッション化
 * @author sse802563
 *
 */
public class GkDetailForm extends CommonForm implements Serializable{

	private static final long serialVersionUID = 1L;

	public String pageName="原価管理表_詳細";
	public String gkId;

	/** 月別原価情報と開発体制を格納するフォーム */
	public List<List<Map<String, Object>>> mapItemsItems = new ArrayList<List<Map<String, Object>>>();
}
