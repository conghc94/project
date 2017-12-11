<?php

abstract class ViewModel extends \Fuel\Core\ViewModel {
	protected function set_view() {
		$this->_view = \View_Smarty::forge($this->_view);
	}
}
