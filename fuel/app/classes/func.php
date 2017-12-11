<?php

/**
 * Class Func
 * 共通関数クラス
 */
class Func
{
	/**
	 * 配列の一番最初に連想配列を追加する
	 * @param $target
	 * @param $add
	 * @return array
	 */
	public static function array_unshift($target, $add) {
		$target = array_reverse($target, true);
		$target += $add;
		return array_reverse($target, true);

	}

	public static function create_query_in_get_methd($data) {
		$count_max = count ( $data );
		if ($count_max == 0) return;
		reset ( $data );
		$output = '';

		for ( $count = 0 ; $count < $count_max ; $count ++ ) {
			if ($count == 0) {
				$output .= '?';
			} else {
				$output .= '&';
			}
			if (is_array($data[key($data)])) {
				$output .= key($data).'[]='.implode('&'.key($data).'[]=',$data[key($data)]);
			} else {
				$output .= key($data) .'='. $data[key($data)];
			}
			next($data);
		}
		return $output;

	}

	public static function send_mail($to_address,$from_address,$mail_subject,$mail_message) {
		if ($to_address == '') return;
		if (strpos($to_address,'.@') !== false) return; // 過去の不正なdocomoメールは不可

		$email = \Email::forge();
		$email->to($to_address);
		$email->from($from_address);
		$email->reply_to($from_address);
		$email->return_path($from_address);
		$email->subject($mail_subject);
		$mail_message = mb_convert_encoding( $mail_message, 'ISO-2022-JP' );
		$email->body($mail_message);
		return $email->send();
	}

	/**
	 * ドメイン部分を抜いたリファラーの取得
	 * @return mixed|string
	 */
	public static function get_referrer() {
		$referrer = \Input::referrer();
		$referrer = preg_replace('/https?:\/\/' . \Input::server('HTTP_HOST') . '/i', '', $referrer);
		return $referrer;
	}

	/**
	 * 数字のリストを生成
	 * @return array
	 */
	public static function create_number_list($min, $max) {
		$ret = array ();
		for ($i = $min; $i <= $max; $i++) {
			$ret[$i] = $i;
		}
		return $ret;
	}

	/**
	 * 西暦和暦変換
	 * @param $year
	 * @param int $month
	 * @param int $day
	 * @return string
	 */
	public static function convert_jp_year($year, $month = 1, $day = 1) {
		$year_jp = '';
		if ($year > 1989 || $year == 1989 && $month == 1 && $day >= 8) {
			$year_jp = '平成' . ($year - 1988);
		} elseif ($year > 1926 || $year == 1926 && $month > 12 || $year == 1926 && $month == 12 && $day >= 25) {
			$year_jp = '昭和' . ($year - 1925);
		} elseif ($year > 1912 || $year == 1912 && $month > 7 || $year == 1912 && $month == 7 && $day >= 30) {
			$year_jp = '大正' . ($year - 1911);
		} else {
			$year_jp = '明治' . ($year - 1867);
		}
		return $year_jp;
	}


	public static function is_bot() {
		$bot_list = array (
			'Googlebot',
			'Yahoo! Slurp',
			'Mediapartners-Google',
			'msnbot',
			'bingbot',
			'MJ12bot',
			'Ezooms',
			'pirst; MSIE 8.0;',
			'Google Web Preview',
			'ia_archiver',
			'Sogou web spider',
			'Googlebot-Mobile',
			'AhrefsBot',
			'YandexBot',
			'Purebot',
			'Baiduspider',
			'UnwindFetchor',
			'TweetmemeBot',
			'MetaURI',
			'PaperLiBot',
			'Showyoubot',
			'JS-Kit',
			'PostRank',
			'Crowsnest',
			'PycURL',
			'bitlybot',
			'Hatena',
			'facebookexternalhit',
			'NINJA bot',
			'YahooCacheSystem',
			'bot',
		);

		$is_bot = false;
		foreach ($bot_list as $bot) {
			if (stripos($_SERVER['HTTP_USER_AGENT'], $bot) !== false) {
				$is_bot = true;
				break;
			}
		}
		return $is_bot;
	}

	public static function weekTransSun($week) {
		$week = $week -1;
		if ($week == -1) {
			$week = 6;
		}
		return $week;
	}

	/*----------------------------------------------------------------------------------------------------
     曜日取得
    ----------------------------------------------------------------------------------------------------*/
	public static function get_weekday($item){
		$weekjp_array = array('日', '月', '火', '水', '木', '金', '土');
		//日付を指定
		$pyear = intval(substr($item,0,4));
		$pmonth = intval(substr($item,4,2));
		$pday = intval(substr($item,6,2));
		//タイムスタンプを取得
		$ptimestamp = mktime(0, 0, 0, $pmonth, $pday, $pyear);
		//曜日番号を取得
		$weekno = date('w', $ptimestamp);
		//日本語の曜日を出力
		$weekjp = $weekjp_array[$weekno];
		return $weekjp;
	}

}
