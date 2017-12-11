<?php

namespace Fuel\Migrations;

class Create_usercalendars
{
	public function up()
	{
		\DBUtil::create_table('usercalendars', array(
			'id' => array('constraint' => 11, 'type' => 'int', 'auto_increment' => true, 'unsigned' => true),
			'userid' => array('constraint' => 11, 'type' => 'int'),
			'year_month' => array('type' => 'date'),
			'type' => array('type' => 'tinyint'),
			'commitment' => array('type' => 'tinyint'),
			'accept_day01' => array('type' => 'tinyint'),
			'accept_day02' => array('type' => 'tinyint'),
			'accept_day03' => array('type' => 'tinyint'),
			'accept_day04' => array('type' => 'tinyint'),
			'accept_day05' => array('type' => 'tinyint'),
			'accept_day06' => array('type' => 'tinyint'),
			'accept_day07' => array('type' => 'tinyint'),
			'accept_day08' => array('type' => 'tinyint'),
			'accept_day09' => array('type' => 'tinyint'),
			'accept_day10' => array('type' => 'tinyint'),
			'accept_day11' => array('type' => 'tinyint'),
			'accept_day12' => array('type' => 'tinyint'),
			'accept_day13' => array('type' => 'tinyint'),
			'accept_day14' => array('type' => 'tinyint'),
			'accept_day15' => array('type' => 'tinyint'),
			'accept_day16' => array('type' => 'tinyint'),
			'accept_day17' => array('type' => 'tinyint'),
			'accept_day18' => array('type' => 'tinyint'),
			'accept_day19' => array('type' => 'tinyint'),
			'accept_day20' => array('type' => 'tinyint'),
			'accept_day21' => array('type' => 'tinyint'),
			'accept_day22' => array('type' => 'tinyint'),
			'accept_day23' => array('type' => 'tinyint'),
			'accept_day24' => array('type' => 'tinyint'),
			'accept_day25' => array('type' => 'tinyint'),
			'accept_day26' => array('type' => 'tinyint'),
			'accept_day27' => array('type' => 'tinyint'),
			'accept_day28' => array('type' => 'tinyint'),
			'accept_day29' => array('type' => 'tinyint'),
			'accept_day30' => array('type' => 'tinyint'),
			'accept_day31' => array('type' => 'tinyint'),
			'comment' => array('constraint' => 2000, 'type' => 'varchar'),
			'delflag' => array('type' => 'tinyint'),
			'created_at' => array('constraint' => 11, 'type' => 'int', 'null' => true),
			'updated_at' => array('constraint' => 11, 'type' => 'int', 'null' => true),

		), array('id'));
	}

	public function down()
	{
		\DBUtil::drop_table('usercalendars');
	}
}