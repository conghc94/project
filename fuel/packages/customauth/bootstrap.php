<?php

\Autoloader::add_core_namespace('CustomAuth');

\Autoloader::add_classes(array(
	'CustomAuth\\Auth_Login_Simpleauth'       => __DIR__.'/classes/customauth/login/simpleauth.php',
));
