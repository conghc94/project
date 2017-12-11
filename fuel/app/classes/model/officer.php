<?php 

/**
* 
*/
class Model_Officer extends \Orm\Model_Soft 
{
	
	protected static $properties = array(
		'id',
		'member_id',
		'officer_in_group',
		'note'
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

    public static function validate($factory) 
    {
        $val = Validation::forge($factory);
        $val->add_field('department', '所属・役職', 'required|max_length[256]');
        $val->add_field('name', '氏名', 'required|max_length[256]');
        return $val;
    }

    protected static $_soft_delete = array(
        'deleted_field' => 'deleted_at',
        'mysql_timestamp' => false,
    );
}