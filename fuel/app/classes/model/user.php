<?php

class Model_User extends \Orm\Model_Soft
{
	protected static $_properties = array(
		'id',
		'username',
		'password',
		'group',
		'email',
		'last_login',
		'login_hash',
		'profile_fields',
		'created_at',
		'updated_at',
		'deleted_at',
	);

	protected static $_observers = array(
		'Orm\Observer_CreatedAt' => array(
			'events' => array('before_insert'),
			'mysql_timestamp' => false,
		),
		'Orm\Observer_UpdatedAt' => array(
			'events' => array('before_update'),
			'mysql_timestamp' => false,
		),
	);

	protected static $_soft_delete = array(
			'deleted_field' => 'deleted_at',
			'mysql_timestamp' => false,
	);

	protected static $_table_name = 'users';

	public static function validate($factory , $param = array())
	{
		$val = Validation::forge($factory);
		switch ($factory) {
			case 'MasterLogin': // 管理者ユーザーログイン
				// validateルール設定
				$val->add_field('username', 'ログインID', 'required');
				$val->add_field('password', 'パスワード', 'required');
				break;
			case 'MasterCreate': // 管理者ユーザー作成
				// validateルール設定
				$val->add_field('username', 'ログインID', 'required|max_length[50]');
				$val->add_field('password', 'パスワード', 'required|max_length[255]');
				$val->add_field('email', 'メールアドレス', 'required|valid_email|max_length[255]');
				break;
			case 'MasterModify': // 管理者ユーザー変更
				// 拡張バリデーションクラスを呼び出し
				$val->add_callable('Validate_user');
				// validateルール設定
				$val->add('old_password', '旧パスワード')
						->add_rule('required_with', 'password')
						->add_rule('oldpasscheck', $param['username'])
						->add_rule('max_length',255);
				$val->add('password', 'パスワード')
						->add_rule('required_with', 'old_password')
						->add_rule('valid_string',array('alpha','numeric'))
						->add_rule('match_value', \Input::post('password2'), true)
						->add_rule('max_length',255);
				$val->add('email', 'メールアドレス')
						->add_rule('match_value', \Input::post('email2'), true)
						->add_rule('valid_email')
						->add_rule('max_length',255);
				$val->set_message('oldpasscheck', \Constants::$error_message['bad_old_password']);
				break;
			case 'UserLogin': // ユーザーログイン
				// validateルール設定
				$val->add_field('username', 'ログインID', 'required');
				$val->add_field('password', 'パスワード', 'required');
				break;

			case 'UserModifyMail': // メール変更
				// validateルール設定
				$val->add('email', 'メールアドレス')
					->add_rule('match_value', \Input::post('email2'), true)
					->add_rule('valid_email')
					->add_rule('max_length',255);
				break;

			case 'UserModifyPass': // 管理者ユーザー変更
				// 拡張バリデーションクラスを呼び出し
				$val->add_callable('Validate_user');
				// validateルール設定
				$val->add('old_password', '旧パスワード')
					->add_rule('required_with', 'password')
					->add_rule('oldpasscheck', $param['username'])
					->add_rule('max_length',255);
				$val->add('password', 'パスワード')
					->add_rule('required_with', 'old_password')
					->add_rule('valid_string',array('alpha','numeric'))
					->add_rule('match_value', \Input::post('password2'), true)
					->add_rule('max_length',255);
				$val->set_message('oldpasscheck', \Constants::$error_message['bad_old_password']);
				break;

			default:
				break;
		}

		return $val;
	}

}
