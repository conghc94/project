<?php

abstract class Presenter extends \Fuel\Core\Presenter
{
	public function before() {
		parent::before();
	}

	protected function set_view() {
		$this->_view = \View_Smarty::forge($this->_view . '.tpl');
	}

	/**
	 * コントローラー内に宣言してあるFiledsを取得
	 * @return mixed
	 */
	protected function get_fields() {
		return $this->request()->controller_instance->fields;
	}

	/**
	 * セッションに保存されている値をViewに配置
	 */
	protected function set_session_to_disp($fields) {
		//入力のときに保存したセッションデータを配列に保存
		foreach ($fields as $id => $field) {
			if (!empty($field['related'])) {
				if (!isset($this->$field['related'])) {
					$this->$field['related'] = (object)array ();
				}
				$this->$field['related']->$id = \Session::get_flash($id);
			} else {
				$this->$id = \Session::get_flash($id);
			}
			//セッション変数を次のリクエストを維持
			\Session::keep_flash($id);
		}
	}

	/**
	 * DBから取得してきた値を画面表示用の値に変換する
	 * @param $data
	 * @param $fields
	 */
	public function convert_db_to_disp($data, $related = '', $is_first = true) {
		$fields = $this->get_fields();
		foreach ($data as $key => $value) {
			if ($value instanceof \Orm\Model) {
				$value = $this->convert_db_to_disp($value, $key, false);
			}
			if (isset($fields[$key]['default']) && is_array($fields[$key]['default'])) {
				$value = explode(',', $value);
			}
			if (is_object($data)) {
				$data->$key = $value;
			} else {
				$data[$key] = $value;
			}
		}
		if ($is_first) {
			if ($related) {
				$this->$related = $data;
			} else {
				foreach ($data as $key => $value) {
					$this->$key = $value;
				}
			}
		} else {
			return $data;
		}
	}

	/**
	 * CSRF対策用パラメーター埋め込み
	 */
	public function set_csrf() {
		$this->token_key = \Config::get('security.csrf_token_key');
		$this->token = \Security::fetch_token();
	}

	/**
	 * エラー内容を設定
	 */
	public function set_error() {
		$error = '';
		if (!empty($this->errors)) {
			foreach ($this->errors as $key => $err) {
				$error .= '<span id="error-' . $key . '">' . $err . '</span><br />';
			}
			$this->set('error', $error, false);
		}
	}
}
