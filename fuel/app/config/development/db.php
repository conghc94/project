<?php
	/**
	 * The development database settings. These get merged with the global settings.
	 */

	return array (
		'default' => array (
			'connection' => array (
				'dsn' => 'mysql:host=localhost;dbname=manage_members',
				'username' => 'salinger',
				'password' => 'bananafish',
			),
			'profiling' => true,
		),
	);
