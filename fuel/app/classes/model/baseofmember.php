<?php
class Model_Baseofmember extends \Orm\Model_Soft
{
	protected static $_table_name = 'base_of_members';

	protected static $_properties = array(
		'id',
		'published',
		'type',
		'profile_flag',
		'name',
		'name_kana',
		'name_eng',
		'description',
		'created_at',
		'updated_at',
		'deleted_at',
	);
	
	public static function validate($factory)
	{
		$val = Validation::forge($factory);
		
		$val->add_field('published', '有効フラグpublished', 'match_collection[0,1]');
		$val->add_field('type', '会員属性', 'required|match_collection[0,1,2,3,4,5]');
		$val->add_field('profile_flag', '会員フラグ', 'required|match_collection[0,1]');
		$val->add_field('name', '会員名称', 'required|max_length[255]');
        $val->add_field('name_kana', '会員名称(ふりがな)', 'required|max_length[256]');
        $val->add_field('name_eng', '会員名称(英語)','required|max_length[256]');
        $val->add_field('description', '事業概要','max_length[4000]');

        return $val;
    }

    protected static $_soft_delete = array(
        'deleted_field' => 'deleted_at',
        'mysql_timestamp' => false,
    );

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
}