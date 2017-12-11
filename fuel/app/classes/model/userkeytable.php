<?php
class Model_Userkeytable extends \Orm\Model_Soft
{
	protected static $_properties = array(
		'id',
		'connect_type',
		'person_id',
		'officer_id',
		'committee_id',
		'member_id',
		'sort_number',
		'created_at',
		'updated_at',
		'deleted_at',
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

	protected static $_soft_delete = array(
        'deleted_field' => 'deleted_at',
        'mysql_timestamp' => false,
    );
	
	protected static $_table_name = 'user_key_tables';
	
}
