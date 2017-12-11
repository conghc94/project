<?php

// app/classes/myrules.php
class Validate_User
{
	// 静的メソッドであることに注意する
	public static function _validation_oldpasscheck($val, $options)
	{
		if ($val == '') return true;
		$check = \Auth::validate_user($options, $val);
		if (!isset($check['username']))
		{
			return false;
		}

		return true;
	}

	public static function _validation_alreadyexistuser($val, $options = null)
	{
		// クエリービルダー生成
		$query = \DB::select('*')->from('users');

		//一般ユーザーのみ取り出し
		$query->where('users.username', $val);
		if ($options != null) $query->where('users.id' , '!=' , $options);

		//【重要!!!!!!!】クエリービルダーでは論理削除が無視されるのでこちらに入れる
		$query->where('users.deleted_at', null);

		$check = $query->execute()->as_array();

		if (count($check) > 0)
		{
			return false;
		}

		return true;
	}
}