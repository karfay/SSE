-- Project Name : Noname
-- Date/Time    : 2017/06/07 9:58:53
-- Author       : sse802563
-- RDBMS Type   : MySQL
-- Application  : A5:SQL Mk-2

-- リースマスタ
create table `リースマスタ` (
  `ITラベル` varchar(10) comment 'ITラベル'
  , `リース契約番号` varchar(20) comment 'リース契約番号'
  , `リース開始日` varchar(20) comment 'リース開始日'
  , `リース終了日` int(8) comment 'リース終了日'
  , `備考` varchar(50) comment '備考'
) comment 'リースマスタ' ;

create index ITラベル
  on `リースマスタ`(`ITラベル`);

-- base_master
create table base_master (
  it_label varchar(10) not null comment 'it_label'
  , admin varchar(20) comment 'admin'
  , user varchar(20) comment 'user'
  , lending_date date comment 'lending_date'
  , collection_date date comment 'collection_date'
  , disposal_date date comment 'disposal_date'
  , model_number varchar(20) comment 'model_number'
  , serial_number varchar(15) comment 'serial_number'
  , delivery date comment 'delivery'
  , os varchar(30) comment 'os'
  , wireless_lan varchar(10) comment 'wireless_lan'
  , hdd_space int(10) comment 'hdd_space'
  , data_volume varchar(1) comment 'data_volume'
  , ip_address varchar(15) comment 'ip_address'
  , encryption_soft varchar(50) comment 'encryption_soft'
  , notes varchar(100) comment 'notes'
  , constraint base_master_PKC primary key (it_label)
) comment 'base_master' ;

-- condition_master
create table condition_master (
  condition_code int(11) comment 'condition_code'
  , condition_name char(10) comment 'condition_name'
) comment 'condition_master' ;

-- document_category_master
create table document_category_master (
  category_id int(11) not null comment 'category_id'
  , category_name varchar(20) not null comment 'category_name'
  , constraint document_category_master_PKC primary key (category_id)
) comment 'document_category_master' ;

-- 持込物区分マスター
create table material_category_master (
  category_name varchar(10) comment '区分名'
  , category_code int(11) default 0 not null comment '区分コード'
  , constraint material_category_master_PKC primary key (category_code)
) comment '持込物区分マスター' ;

-- 持込台帳
create table motikomi_daityo (
  table_id varchar(20) not null comment 'テーブルID'
  , bring_person varchar(9) comment '持込者'
  , bring_date date comment '持込日'
  , client_name varchar(50) comment '預かり元'
  , project varchar(50) comment 'プロジェクト名'
  , material_name varchar(100) comment '持込物名称'
  , category_code int(11) comment '持込物区分コード'
  , depository varchar(1000) comment '保管場所'
  , copies int(11) comment '部数'
  , confidential int(11) comment '機密フラグ'
  , bring_notes varchar(300) comment '持込時備考'
  , scheduled_date date comment '保管終了予定日'
  , scheduled_code int(11) comment '終了時予定対応コード'
  , process_date date comment '終了時予定対応日'
  , process_code int(11) comment '終了時実施対応コード'
  , process_person varchar(9) comment '終了時実施対応者'
  , process_notes varchar(300) comment '終了時備考'
  , bring_approval_date date comment '持込確認日'
  , bring_approver varchar(10) comment '持込確認者'
  , bring_approve_notes varchar(300) comment '持込確認時備考'
  , process_approval_date date comment '終了対応確認日'
  , process_approver varchar(9) comment '終了対応確認者'
  , process_approve_notes varchar(300) comment '終了対応確認時備考'
  , condition_code int(11) comment '状態コード'
  , constraint motikomi_daityo_PKC primary key (table_id)
) comment '持込台帳' ;

-- PC端末マスタ
create table pc_master (
  it_label varchar(8) not null comment 'ITラベル'
  , admin varchar(20) comment '管理者'
  , user varchar(20) comment '利用者'
  , assets_mode varchar(10) comment '資産形態'
  , start_date date comment '利用開始日'
  , end_date date comment '利用終了日'
  , scheduled_date date comment '終了予定日'
  , maker varchar(10) comment 'メーカー'
  , model_number varchar(30) comment '型番'
  , serial_number varchar(30) comment '製造番号'
  , os varchar(30) comment 'OS'
  , wireless_lan varchar(5) comment '無線LAN'
  , hdd_valume varchar(10) comment 'HD容量'
  , ip_address varchar(20) comment 'IPアドレス'
  , encryption varchar(20) comment '暗号化ソフト'
  , notes varchar(1000) comment '備考'
  , constraint pc_master_PKC primary key (it_label)
) comment 'PC端末マスタ' ;

-- pc_software
create table pc_software (
  itLabel varchar(10) not null comment 'itLabel'
  , softwareId varchar(3) not null comment 'softwareId'
  , constraint pc_software_PKC primary key (itLabel,softwareId)
) comment 'pc_software' ;

-- personnel_master
create table personnel_master (
  personnelNumber varchar(20) not null comment 'personnelNumber'
  , personnelName varchar(20) comment 'personnelName'
  , userId varchar(10) comment 'userId'
  , userPass varchar(10) comment 'userPass'
  , authorizations varchar(2) comment 'authorizations'
  , constraint personnel_master_PKC primary key (personnelNumber)
) comment 'personnel_master' ;

-- 処理マスター
create table process_master (
  process_name varchar(10) comment '処理名称'
  , process_code int(11) comment '処理コード'
) comment '処理マスター' ;

-- software_master
create table software_master (
  softwareId varchar(3) not null comment 'softwareId'
  , softwareName varchar(30) comment 'softwareName'
  , softwareVer varchar(10) comment 'softwareVer'
  , constraint software_master_PKC primary key (softwareId)
) comment 'software_master' ;

-- take_documents_out
create table take_documents_out (
  table_id varchar(20) not null comment 'table_id'
  , doc_id int(11) not null comment 'doc_id'
  , doc_name varchar(500) comment 'doc_name'
  , copies int(11) comment 'copies'
  , category_id int(11) comment 'category_id'
  , condition_code int(11) comment 'condition_code'
  , constraint take_documents_out_PKC primary key (table_id,doc_id)
) comment 'take_documents_out' ;

-- take_pc_out
create table take_pc_out (
  table_id char(20) not null comment 'table_id'
  , app_date date comment 'app_date'
  , app_user char(20) comment 'app_user'
  , start_date date comment 'start_date'
  , end_date date comment 'end_date'
  , dest char(50) comment 'dest'
  , it_label int(11) comment 'it_label'
  , wireless_lan varchar(11) comment 'モバイルWi-Fi'
  , flash_memory char(10) comment 'flash_memory'
  , project char(50) comment 'project'
  , approval_date date comment 'approval_date'
  , approver char(20) comment 'approver'
  , condition_code int(11) comment 'condition_code'
  , notes varchar(100) comment 'notes'
  , other_media varchar(100) comment 'other_media'
  , wireless_slave varchar(10) comment '無線子機'
  , constraint take_pc_out_PKC primary key (table_id)
) comment 'take_pc_out' ;

-- モバイル端末マスタ
create table wireless_lan_master (
  phone_number varchar(13) not null comment '電話番号'
  , model varchar(10) comment '機種'
  , plan varchar(10) comment 'プラン'
  , pin_code varchar(10) comment '機器PIN'
  , serial_number varchar(20) comment '製造番号'
  , it_label varchar(8) not null comment 'ITラベル'
  , admin varchar(10) comment '管理者'
  , post varchar(20) comment '部署'
  , iccid varchar(19) comment 'ICCID'
  , pin_release_code varchar(8) comment 'PIN解除コード'
  , user varchar(10) comment '使用者'
  , constraint wireless_lan_master_PKC primary key (phone_number,it_label)
) comment 'モバイル端末マスタ' ;

-- 無線子機マスタ
create table wireless_slave_master (
  number varchar(10) not null comment '管理番号'
  , constraint wireless_slave_master_PKC primary key (number)
) comment '無線子機マスタ' ;

