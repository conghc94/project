<?php 

/**
* 
*/
class Model_Memberofcommittee extends \Orm\Model_Soft
{
	
	protected static $properties = array(
		'id',
        'committee_id',
        'member_id',
        'officer_in_commitee',
        'request_of_cost',
        'receipt_of_cost',
        'cumstom_input01',
        'cumstom_input02',
        'cumstom_input03',
        'cumstom_input04',
        'cumstom_input05',
        'cumstom_input06',
        'cumstom_input07',
        'cumstom_input08',
        'cumstom_input09',
        'cumstom_input10',
        'cumstom_input11',
        'cumstom_input12',
        'cumstom_input13',
        'cumstom_input14',
        'cumstom_input15',
        'cumstom_input16',
        'cumstom_input17',
        'cumstom_input18',
        'cumstom_input19',
        'cumstom_input20',
        'note',
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

    protected static $_table_name = 'members_of_committees';

    protected static $_soft_delete = array(
        'deleted_field' => 'deleted_at',
        'mysql_timestamp' => false,
    );

}