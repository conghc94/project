<?php
class Model_Person extends \Orm\Model_Soft
{
	protected static $_properties = array(
		'id',
		'published',
		'department',
		'name',
		'name_kana',
		'email',
		'tel',
		'fax',
		'zip',
		'address01',
		'address02',
		'published_site_id',
		'type_of_ml',
		'created_at',
		'updated_at',
		'deleted_at',
	);

	public static function validate($factory)
	{
        $val = Validation::forge($factory);
		
		$val->add_field('published', '有効フラグ', 'match_collection[0,1]');
		$val->add_field('department', '所属・役職', 'required|max_length[256]');
        $val->add_field('name', '氏名', 'required|max_length[256]');
        $val->add_field('name_kana', '氏名(ふりがな)', 'max_length[256]');
        $val->add_field('email', 'メール', 'valid_email');
        $val->add_field('tel', '電話', 'max_length[256]|min_length[12]');
        $val->add_field('fax', 'FAX', 'max_length[256]|min_length[12]');
        $val->add_field('zip', '郵便番号', 'max_length[256]|min_length[8]');
        $val->add_field('address01', '住所1','max_length[256]');
        $val->add_field('address02', '住所2(ビル名・階数)','max_length[256]');
        $val->add_field('published_site_id', '会員サイトID発行','match_collection[0,1]');
        $val->add_field('type_of_ml', '登録MLの種別','max_length[256]');
        
        return $val;
    }	

	protected static $_table_name = 'persons';
	
	protected static $_observers = array(
		'Orm\Observer_CreatedAt' => array(
			'events' => array('before_insert'),
			'mysql_timestamp' => false,
		),
		'Orm\Observer_UpdatedAt' => array(
			'events' => array('before_save'),
			'mysql_timestamp' => false,
		),
	);

	protected static $_soft_delete = array(
        'deleted_field' => 'deleted_at',
        'mysql_timestamp' => false,
    );
}
