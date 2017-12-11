<?php
/**
 * Created by PhpStorm.
 * User: jeyson
 * Date: 14/08/24
 * Time: 14:24
 */
require_once (APPPATH.'vendor'.DS.'excel'.DS.'PHPExcel.php');

class loadExcel {
	var $cell_cap = array(
		0 => 'A',
		1 => 'B',
		2 => 'C',
		3 => 'D',
		4 => 'E',
		5 => 'F',
		6 => 'G',
		7 => 'H',
		8 => 'I',
		9 => 'J',
		9 => 'K',
		10 => 'L',
		11 => 'M',
		12 => 'N',
		13 => 'O',
		14 => 'P',
		15 => 'Q',
		16 => 'R',
		17 => 'S',
		18 => 'T',
		19 => 'U',
		20 => 'V',
		21 => 'W',
		22 => 'X',
		23 => 'Y',
		24 => 'Z',
	);

	var $load_filename;

	function __construct () {

	}
	function loadCells (){
		$cells = $this->_readExcel($this->load_filename);
		return $cells;
	}

	// Excelファイル読み込み
	private function _readExcel($filepath){
		//Excel2007形式のファイルを読み込み
//		$reader = PHPExcel_IOFactory::createReader('Excel2007');
//		$xl = $reader->load($filepath);

		$xl = PHPExcel_IOFactory::load($filepath);
//		PHPExcel_IOFactory::load は テンプレートファイルの拡張子を元に Excel ファイルの種類を判断
//		拡張子	対応する Reader
//		xls	PHPExcel_Reader_Excel5
//		xlsx	PHPExcel_Reader_Excel2007
//		ods	PHPExcel_Reader_OOCalc
//		slk	PHPExcel_Reader_SYLK
//		xml	PHPExcel_Reader_Excel2003XML
//		gnumeric	PHPExcel_Reader_Gnumeric
//		csv	-
//		※ 上記の対応表で csv の Reader が入っていないが、Excel は全ての csv ファイルを含んでいるとの理由により csv ファイルに関しては直接 PHPExcel_Reader_CSV を使用する必要がある。


		//アクティブなシートを変数に格納
		$xl->setActiveSheetIndex(0);
		$worksheet = $xl->getActiveSheet();

		$list=array();
//列の最大値を取得
		for($i=1;$i<=$worksheet->getHighestRow();$i++)
		{
			$tmp=array();
			//行の最大値を取得
			//A、B、Cの文字列形式で帰ってくるので数字に変換する
			$max_column=PHPExcel_Cell::columnIndexFromString($worksheet->getHighestColumn());
			for($j=0;$j<$max_column;$j++)
			{
				//列のインデックスと、行のインデックスからセルの値を取得
				$tmp[]=$worksheet->getCellByColumnAndRow($j,$i)->getValue();
			}
			$list[]=$tmp;
		}




//		$list = array();
//		//行でループ
//		foreach ($worksheet->getRowIterator() as $row) {
//			$data = array();
//			$cnt = 0;
//			//列でループ
//			foreach ($row->getCellIterator() as $cell) {
//				if (!is_null($cell)) {
//					$data[$cnt] = (string)$cell->getValue();
//				} else {
//					$data[$cnt] = 'xx';
//				}
//				$cnt++;
//			}
//			$list[] = $data;
//		}

		return $list;

	}

}


