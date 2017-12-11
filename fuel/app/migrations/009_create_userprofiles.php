<?php

namespace Fuel\Migrations;

class Create_userprofiles
{
	public function up()
	{
		\DBUtil::create_table('userprofiles', array(
			'id' => array('constraint' => 11, 'type' => 'int', 'auto_increment' => true, 'unsigned' => true),
			'userid' => array('constraint' => 11, 'type' => 'int'),
			'name' => array('constraint' => 50, 'type' => 'varchar'),
			'email' => array('constraint' => 255, 'type' => 'varchar'),
			'speakable_language' => array('constraint' => 50, 'type' => 'varchar'),
			'enable_serviceguide' => array('type' => 'tinyint'),
			'enable_tochoguide' => array('type' => 'tinyint'),
			'enable_townguide' => array('type' => 'tinyint'),
			'delflag' => array('type' => 'tinyint'),
			'created_at' => array('constraint' => 11, 'type' => 'int', 'null' => true),
			'updated_at' => array('constraint' => 11, 'type' => 'int', 'null' => true),

		), array('id'));
	}

	public function down()
	{
		\DBUtil::drop_table('userprofiles');
	}
}