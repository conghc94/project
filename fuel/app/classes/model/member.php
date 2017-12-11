<?php
class Model_Member extends \Orm\Model_Soft
{
	protected static $_table_name = 'members';

	protected static $_properties = array(
		'id',
		'member_id',
		'attendance_of_meeting',
		'proxy_of_meeting',
		'note',
		'created_at',
		'updated_at',
		'deleted_at',
	);
	
	public static function validate($factory)
	{
        $val = Validation::forge($factory);
		
		$val->add_field('attendance_of_meeting', '総会の出席', 'required|match_collection[0,1,2,9]');
		$val->add_field('proxy_of_meeting', '総会の委任状', 'required|match_collection[0,1,2]');
		$val->add_field('note', '備考', 'required|max_length[4000]');

        return $val;
    }

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
