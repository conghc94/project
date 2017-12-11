<?php 

/**
* 
*/
class Model_Committee extends \Orm\Model_Soft
{
	
	protected static $properties = array(
		'id',
        'parent_committee_id',
        'committee_name',
        'committee_name_kana',
        'committee_name_eng',
        'selectable_officer',
        'custom_input_name01',
        'custom_input_type01',
        'custom_input_selectable01',
        'custom_input_name02',
        'custom_input_type02',
        'custom_input_selectable02',
        'custom_input_name03',
        'custom_input_type03',
        'custom_input_selectable03',
        'custom_input_name04',
        'custom_input_type04',
        'custom_input_selectable04',
        'custom_input_name05',
        'custom_input_type05',
        'custom_input_selectable05',
        'custom_input_name06',
        'custom_input_type06',
        'custom_input_selectable06',
        'custom_input_name07',
        'custom_input_type07',
        'custom_input_selectable07',
        'custom_input_name08',
        'custom_input_type08',
        'custom_input_selectable08',
        'custom_input_name09',
        'custom_input_type09',
        'custom_input_selectable09',
        'custom_input_name10',
        'custom_input_type10',
        'custom_input_selectable10',
        'custom_input_name11',
        'custom_input_type11',
        'custom_input_selectable11',
        'custom_input_name12',
        'custom_input_type12',
        'custom_input_selectable12',
        'custom_input_name13',
        'custom_input_type13',
        'custom_input_selectable13',
        'custom_input_name14',
        'custom_input_type14',
        'custom_input_selectable14',
        'custom_input_name15',
        'custom_input_type15',
        'custom_input_selectable15',
        'custom_input_name16',
        'custom_input_type16',
        'custom_input_selectable16',
        'custom_input_name17',
        'custom_input_type17',
        'custom_input_selectable17',
        'custom_input_name18',
        'custom_input_type18',
        'custom_input_selectable18',
        'custom_input_name19',
        'custom_input_type19',
        'custom_input_selectable19',
        'custom_input_name20',
        'custom_input_type20',
        'custom_input_selectable20',
        'edited_history',
        'created_at',
        'updated_at',
        'deleted_at'
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

    protected static $_table_name = 'committees';

    protected static $_soft_delete = array(
        'deleted_field' => 'deleted_at',
        'mysql_timestamp' => false,
    );

    public static function validate($factory) 
    {
        $val = Validation::forge($factory);
        $val->add_field('committee_name', '委員会名称', 'required|max_length[255]');
        $val->add_field('committee_name_kana', '委員会名称(ふりがな)', 'required|max_length[256]');
        $val->add_field('committee_name_eng', '委員会名称(英語)','required|max_length[256]');
        return $val;
    }
}