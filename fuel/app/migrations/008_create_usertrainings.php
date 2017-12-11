<?php

namespace Fuel\Migrations;

class Create_usertrainings
{
	public function up()
	{
		\DBUtil::create_table('usertrainings', array(
			'id' => array('constraint' => 11, 'type' => 'int', 'auto_increment' => true, 'unsigned' => true),
			'userid' => array('constraint' => 11, 'type' => 'int'),
			'trainingid' => array('constraint' => 11, 'type' => 'int'),
			'comment' => array('constraint' => 2000, 'type' => 'varchar'),
			'change_date_from' => array('type' => 'date'),
			'change_date_to' => array('type' => 'date'),
			'delflag' => array('type' => 'tinyint'),
			'created_at' => array('constraint' => 11, 'type' => 'int', 'null' => true),
			'updated_at' => array('constraint' => 11, 'type' => 'int', 'null' => true),

		), array('id'));
	}

	public function down()
	{
		\DBUtil::drop_table('usertrainings');
	}
}