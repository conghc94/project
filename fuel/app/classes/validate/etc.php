<?php

// app/classes/myrules.php
class Validate_Etc
{
	// 静的メソッドであることに注意する
	public static function _validation_checkexistdate($val, $options = null)
	{

		$checkdate = 0;

		//空っぽの時はOKにする(そういうチェックは別の場所で行う)
		if ($val == '') {
			$checkdate = 1;
		}

		$check = explode('/',$val);
		$s_check = array();
		if ($check[0] != '') $s_check['year'] = intval($check[0]);
		if ($check[1] != '') $s_check['month'] = intval($check[1]);
		if ($check[2] != '') $s_check['day'] = intval($check[2]);

		if (($s_check['year'] != '') && ($s_check['month'] != '') && ($s_check['day'] != '')) {
			if (checkdate($s_check['month'], $s_check['day'], $s_check['year'])) $checkdate = 1;
		}

		if ($checkdate == 0)
		{
			return false;
		}

		return true;
	}
}