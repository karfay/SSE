package ug.constant;

/**
 * 原価管理表に関連するメッセージを格納するクラス
 * list,create,detail共通
 * @author sse802563
 *
 */
public class GkConstant {

	public static final String duplicateGkId = "入力されたテーマNOに関連する原価管理表が既に存在します。";

	public static final String createGenkaKanri = "原価管理表を新規作成しました。<br />引き続きプロジェクトメンバの入力を行って下さい。";

	public static final String createGenkaUpdate = "原価管理表を修正しました。";

	public static final String addPjMember = "　さんをプロジェクトメンバに追加しました。";

	public static final String addGaityuMember = "　さんを外注（パートナー）に追加しました。";

	public static final String deleteMember = "　さんを開発体制から外しました。";

	public static final String deleteKousuCheckErr = "　さんは当プロジェクトで工数の入力があるため、開発体制から外せません。<br />"
			+ "詳細画面から工数を確認して下さい";

	public static final String deleteCostCheckErr = "　さんは当プロジェクトで外注費の入力があるため、開発体制から外せません。<br />"
			+ "詳細画面から外注費を確認して下さい";

	public static final String accessErr = "アクセスエラーです。意図しない方法でページにアクセスしています。<br />"
			+ "心当たりの無い場合は管理者に問い合わせて下さい。";
}
