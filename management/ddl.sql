-- Project Name : Noname
-- Date/Time    : 2017/06/07 9:58:53
-- Author       : sse802563
-- RDBMS Type   : MySQL
-- Application  : A5:SQL Mk-2

-- ���[�X�}�X�^
create table `���[�X�}�X�^` (
  `IT���x��` varchar(10) comment 'IT���x��'
  , `���[�X�_��ԍ�` varchar(20) comment '���[�X�_��ԍ�'
  , `���[�X�J�n��` varchar(20) comment '���[�X�J�n��'
  , `���[�X�I����` int(8) comment '���[�X�I����'
  , `���l` varchar(50) comment '���l'
) comment '���[�X�}�X�^' ;

create index IT���x��
  on `���[�X�}�X�^`(`IT���x��`);

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

-- �������敪�}�X�^�[
create table material_category_master (
  category_name varchar(10) comment '�敪��'
  , category_code int(11) default 0 not null comment '�敪�R�[�h'
  , constraint material_category_master_PKC primary key (category_code)
) comment '�������敪�}�X�^�[' ;

-- �����䒠
create table motikomi_daityo (
  table_id varchar(20) not null comment '�e�[�u��ID'
  , bring_person varchar(9) comment '������'
  , bring_date date comment '������'
  , client_name varchar(50) comment '�a���茳'
  , project varchar(50) comment '�v���W�F�N�g��'
  , material_name varchar(100) comment '����������'
  , category_code int(11) comment '�������敪�R�[�h'
  , depository varchar(1000) comment '�ۊǏꏊ'
  , copies int(11) comment '����'
  , confidential int(11) comment '�@���t���O'
  , bring_notes varchar(300) comment '���������l'
  , scheduled_date date comment '�ۊǏI���\���'
  , scheduled_code int(11) comment '�I�����\��Ή��R�[�h'
  , process_date date comment '�I�����\��Ή���'
  , process_code int(11) comment '�I�������{�Ή��R�[�h'
  , process_person varchar(9) comment '�I�������{�Ή���'
  , process_notes varchar(300) comment '�I�������l'
  , bring_approval_date date comment '�����m�F��'
  , bring_approver varchar(10) comment '�����m�F��'
  , bring_approve_notes varchar(300) comment '�����m�F�����l'
  , process_approval_date date comment '�I���Ή��m�F��'
  , process_approver varchar(9) comment '�I���Ή��m�F��'
  , process_approve_notes varchar(300) comment '�I���Ή��m�F�����l'
  , condition_code int(11) comment '��ԃR�[�h'
  , constraint motikomi_daityo_PKC primary key (table_id)
) comment '�����䒠' ;

-- PC�[���}�X�^
create table pc_master (
  it_label varchar(8) not null comment 'IT���x��'
  , admin varchar(20) comment '�Ǘ���'
  , user varchar(20) comment '���p��'
  , assets_mode varchar(10) comment '���Y�`��'
  , start_date date comment '���p�J�n��'
  , end_date date comment '���p�I����'
  , scheduled_date date comment '�I���\���'
  , maker varchar(10) comment '���[�J�['
  , model_number varchar(30) comment '�^��'
  , serial_number varchar(30) comment '�����ԍ�'
  , os varchar(30) comment 'OS'
  , wireless_lan varchar(5) comment '����LAN'
  , hdd_valume varchar(10) comment 'HD�e��'
  , ip_address varchar(20) comment 'IP�A�h���X'
  , encryption varchar(20) comment '�Í����\�t�g'
  , notes varchar(1000) comment '���l'
  , constraint pc_master_PKC primary key (it_label)
) comment 'PC�[���}�X�^' ;

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

-- �����}�X�^�[
create table process_master (
  process_name varchar(10) comment '��������'
  , process_code int(11) comment '�����R�[�h'
) comment '�����}�X�^�[' ;

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
  , wireless_lan varchar(11) comment '���o�C��Wi-Fi'
  , flash_memory char(10) comment 'flash_memory'
  , project char(50) comment 'project'
  , approval_date date comment 'approval_date'
  , approver char(20) comment 'approver'
  , condition_code int(11) comment 'condition_code'
  , notes varchar(100) comment 'notes'
  , other_media varchar(100) comment 'other_media'
  , wireless_slave varchar(10) comment '�����q�@'
  , constraint take_pc_out_PKC primary key (table_id)
) comment 'take_pc_out' ;

-- ���o�C���[���}�X�^
create table wireless_lan_master (
  phone_number varchar(13) not null comment '�d�b�ԍ�'
  , model varchar(10) comment '�@��'
  , plan varchar(10) comment '�v����'
  , pin_code varchar(10) comment '�@��PIN'
  , serial_number varchar(20) comment '�����ԍ�'
  , it_label varchar(8) not null comment 'IT���x��'
  , admin varchar(10) comment '�Ǘ���'
  , post varchar(20) comment '����'
  , iccid varchar(19) comment 'ICCID'
  , pin_release_code varchar(8) comment 'PIN�����R�[�h'
  , user varchar(10) comment '�g�p��'
  , constraint wireless_lan_master_PKC primary key (phone_number,it_label)
) comment '���o�C���[���}�X�^' ;

-- �����q�@�}�X�^
create table wireless_slave_master (
  number varchar(10) not null comment '�Ǘ��ԍ�'
  , constraint wireless_slave_master_PKC primary key (number)
) comment '�����q�@�}�X�^' ;

