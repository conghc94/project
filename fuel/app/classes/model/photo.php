<?php

class Model_Photo extends \Orm\Model_Soft
{
	protected static $_properties = array(
		'id',
		'published',
		'shotdate',
		'type',
		'title',
		'latitude_longitude',
		'shotplace',
		'image',
		'keywords',
		'note',
		'geohash',
		'geom',
		'created_at',
		'updated_at',
		'deleted_at',
	);

	protected static $get_feilds_by_query_builder = array(
		'photos.id',
		'photos.published',
		'photos.shotdate',
		'photos.type',
		'photos.title',
		'photos.latitude_longitude',
		'photos.shotplace',
		'photos.image',
		'photos.keywords',
		'photos.note',
		'photos.geohash',
	);

	protected static $_observers = array(
		'Orm\\Observer_Self' => array(
			'events' => array('before_save'),
			),
		'Orm\Observer_CreatedAt' => array(
			'events' => array('before_insert'),
			'mysql_timestamp' => false,
		),
		'Orm\Observer_UpdatedAt' => array(
			'events' => array('before_update'),
			'mysql_timestamp' => false,
		),
	);

	public function _event_before_save()
	{
		$location = explode(',',$this->latitude_longitude);
		$this->set('geom', \DB::expr('GeomFromText("POINT('.$location[1].' '.$location[0].')")'));
	}



	protected static $_soft_delete = array(
			'deleted_field' => 'deleted_at',
			'mysql_timestamp' => false,
	);

	protected static $_table_name = 'photos';

	public static function validate($factory , $param = array())
	{
		$val = Validation::forge($factory);
		switch ($factory) {
			case 'CreatePhoto': // データ作成
				// 拡張バリデーションクラスを呼び出し
				$val->add_callable('Validate_etc');
				// validateルール設定
				$val->add_field('published', '表示ステータス', 'required|valid_string[numeric]');
				$val->add('shotdate', '撮影日')
					->add_rule('required')
					->add_rule('checkexistdate');
				$val->add_field('type', '種別', 'max_length[100]');
				$val->add_field('title', 'タイトル', 'required|max_length[100]');
				$val->add_field('latitude_longitude', '緯度経度', 'max_length[200]');
				$val->add_field('image', '写真', 'required|max_length[256]');
				$val->add_field('keywords', 'キーワード', 'max_length[1000]');
				$val->add_field('note', '備考', 'max_length[2000]');

				$val->set_message('checkexistdate', \Constants::$error_message['not_exist_date']);
				break;
			case 'ModifyPhoto': // データ変更
				// 拡張バリデーションクラスを呼び出し
				$val->add_callable('Validate_etc');
				// validateルール設定
				$val->add_field('id', 'ID', 'required|valid_string[numeric]');
				$val->add_field('published', '表示ステータス', 'required|valid_string[numeric]');
				$val->add('shotdate', '撮影日')
					->add_rule('required')
					->add_rule('checkexistdate');
				$val->add_field('type', '種別', 'max_length[100]');
				$val->add_field('title', 'タイトル', 'required|max_length[100]');
				$val->add_field('latitude_longitude', '緯度経度', 'max_length[200]');
				$val->add_field('image', '写真', 'required|max_length[256]');
				$val->add_field('keywords', 'キーワード', 'max_length[1000]');
				$val->add_field('note', '備考', 'max_length[2000]');

				$val->set_message('checkexistdate', \Constants::$error_message['not_exist_date']);

				break;
			default:
				break;
		}

		return $val;
	}

	// ページネートの設定をセット
	public static function set_config_pagenation ($searchkey = array()) {
		$pagenate_config = \Constants::$pagenate_config;
		$pagenate_config['pagination_url'] = \Uri::string() . \Func::create_query_in_get_methd($searchkey);
		$pagenate_config['total_items'] = self::get_photo_lists($searchkey)->count();

		$pagination = \Pagination::forge('paginate', $pagenate_config);

		return $pagination;
	}

	/**
	 * リストを取得
	 *
	 */
	public static function get_photo_lists ($searchkey = array(), $offset = null, $limit = null, $order = array()) {

		// クエリービルダー生成
		$query = \DB::select_array(self::$get_feilds_by_query_builder)->from('photos');

		//【重要!!!!!!!】クエリービルダーでは論理削除が無視されるのでこちらに入れる
		$query->where('photos.deleted_at', null);

		// 検索条件追加
		if (isset($searchkey['published']) && $searchkey['published'] !== '') $query->where('photos.published', $searchkey['published']);
//		if ($searchkey['shotdate'] != '') $query->where('photos.shotdate', '<=', $searchkey['shotdate']);
		if ($searchkey['shotdate'] != '') $query->where('photos.shotdate', $searchkey['shotdate']);
		if (isset($searchkey['type']) && $searchkey['type'] != '') $query->where('photos.type', 'like', '%'.$searchkey['type'].'%');
		if (isset($searchkey['title']) && $searchkey['title'] != '') $query->where('photos.title', 'like', '%'.$searchkey['title'].'%');
		if (isset($searchkey['shotplace']) && $searchkey['shotplace'] != '') $query->where('photos.shotplace', 'like', '%'.$searchkey['shotplace'].'%');
		if (isset($searchkey['keywords']) && $searchkey['keywords'] != '') $query->where('photos.keywords', 'like', '%'.$searchkey['keywords'].'%');
		if (isset($searchkey['note']) && $searchkey['note'] != '') $query->where('photos.note', 'like', '%'.$searchkey['note'].'%');

		// GeoHash
		if (isset($searchkey['latlng']) && $searchkey['latlng'] != '') {
			$lat_lng = explode(',',$searchkey['latlng']);
			if (count($lat_lng) == 2) {
				// geohashは役に立たないので封印
//				$geohash = \Geohash::encode(trim($lat_lng[0]),trim($lat_lng[1]));
//
//				if (isset($searchkey['range']) && $searchkey['range'] != '') {
//					$substrlen = inval($searchkey['range']);
//				} else {
//					$substrlen = \Constants::$range;
//				}
//				$geohash = mb_substr($geohash,0,$substrlen);
//
//				$query->where_open()
//					->where('photos.geohash', 'like', $geohash.'%')
//					->or_where('photos.geohash', 'like', \Geohash::adjacent($geohash,'top').'%')
//					->or_where('photos.geohash', 'like', \Geohash::adjacent(\Geohash::adjacent($geohash,'top'),'right').'%')
//					->or_where('photos.geohash', 'like', \Geohash::adjacent(\Geohash::adjacent($geohash,'top'),'left').'%')
//					->or_where('photos.geohash', 'like', \Geohash::adjacent($geohash,'right').'%')
//					->or_where('photos.geohash', 'like', \Geohash::adjacent($geohash,'bottom').'%')
//					->or_where('photos.geohash', 'like', \Geohash::adjacent($geohash,'left').'%')
//					->or_where('photos.geohash', 'like', \Geohash::adjacent(\Geohash::adjacent($geohash,'bottom'),'right').'%')
//					->or_where('photos.geohash', 'like', \Geohash::adjacent(\Geohash::adjacent($geohash,'bottom'),'left').'%')
//					->where_close();

				if (isset($searchkey['range']) && $searchkey['range'] != '') {
					$range = inval($searchkey['range']);
				} else {
					$range = \Constants::$range;
				}

				//やはりジオメトリ演算だね
				if ($range < 6) $range = 6;
				if ($range > 17) $range = 17;

				//20m==1||100m==2||500m==3||2km==4||5km==5
				$meter = \Constants::$search_meter;

				$lat_d = 0.0089877628 * $meter[$range];
				$lng_d = 0.0109699122 * $meter[$range];

				$geo_lat = $lat_lng[0];
				$geo_lng = $lat_lng[1];

				$l_lat = $geo_lat - $lat_d;
				$l_lng = $geo_lng - $lng_d;

				$r_lat = $geo_lat + $lat_d;
				$r_lng = $geo_lng + $lng_d;

				$geoquery = "MBRCONTAINS( GEOMFROMTEXT( 'LineString(".$l_lng." ".$l_lat.",".$r_lng." ".$r_lat.")' ) , photos.geom ) ";
				$query->where(\DB::expr($geoquery), '=', true);
			}

		}

		// ページネートセット
		if ($offset != null) $query->offset($offset);
		if ($limit != null) $query->limit($limit);

		// ORDERセット
		if (isset($searchkey['latlng']) && $searchkey['latlng'] != '') {
			$baseorder = 'GLength( ';
			$baseorder .= ' GeomFromText( ';
			$baseorder .= '  CONCAT(';
			$baseorder .= "   'LineString(" . $geo_lng . " " . $geo_lat . ",', ";
			$baseorder .= "   X( `geom` ) , ' ', ";
			$baseorder .= "   Y( `geom` ) , ')' ";
			$baseorder .= '  )';
			$baseorder .= ' )';
			$baseorder .= ')';


			$query->order_by(\DB::expr($baseorder), '');
		}

		if (count($order)>0) {
			reset($order);
			for ( $count = 0 ; $count < count($order) ; $count ++ ) {
				$query->order_by(key($order),$order[key($order)]);
				next($order);
			}
		}

		return $query->execute();
	}

}
