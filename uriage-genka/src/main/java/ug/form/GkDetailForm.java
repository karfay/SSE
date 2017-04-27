package ug.form;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class GkDetailForm extends CommonForm {
	public String pageName="原価管理表_詳細";
	public String gkId;

	/** 月別原価情報と開発体制を格納するフォーム */
	public List<List<Map<String, Object>>> mapItemsItems = new ArrayList<List<Map<String, Object>>>();
}
