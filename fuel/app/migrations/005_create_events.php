<?php

namespace Fuel\Migrations;

class Create_events
{
	public function up()
	{
		\DBUtil::create_table('events', array(
			'id' => array('constraint' => 11, 'type' => 'int', 'auto_increment' => true, 'unsigned' => true),
			'status' => array('type' => 'tinyint'),
			'name' => array('constraint' => 100, 'type' => 'varchar'),
			'open_date' => array('type' => 'date'),
			'detail' => array('constraint' => 2000, 'type' => 'varchar'),
			'website' => array('constraint' => 400, 'type' => 'varchar'),
			'invite_date_from' => array('type' => 'date'),
			'invite_date_to' => array('type' => 'date'),
			'delflag' => array('type' => 'tinyint'),
			'created_at' => array('constraint' => 11, 'type' => 'int', 'null' => true),
			'updated_at' => array('constraint' => 11, 'type' => 'int', 'null' => true),

		), array('id'));
	}

	public function down()
	{
		\DBUtil::drop_table('events');
	}
}