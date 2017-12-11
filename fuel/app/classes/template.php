<?php

abstract class Controller_Template extends \Fuel\Core\Controller_Template
{
	public function before() {
		if (!empty($this->template) and is_string($this->template)) {
			// Load the template
			$this->template = \View_Smarty::forge($this->template . '.tpl');
		}
		return parent::before();
	}
}
