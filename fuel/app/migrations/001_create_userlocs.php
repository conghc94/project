<?php

namespace Fuel\Migrations;

class Create_userlocs
{
	public function up()
	{
		\DBUtil::create_table('userlocs', array(
			'id' => array('constraint' => 11, 'type' => 'int', 'auto_increment' => true, 'unsigned' => true),
			'user_id' => array('constraint' => 255, 'type' => 'varchar'),
			'lat' => array('constraint' => 255, 'type' => 'varchar'),
			'lon' => array('constraint' => 255, 'type' => 'varchar'),
			'created_at' => array('constraint' => 11, 'type' => 'int', 'null' => true),
			'updated_at' => array('constraint' => 11, 'type' => 'int', 'null' => true),

		), array('id'));
	}

	public function down()
	{
		\DBUtil::drop_table('userlocs');
	}
}