<?php
/**
 * Smarty plugin
 *
 * @package Smarty
 * @subpackage PluginsModifier
 */

function smarty_modifier_casset($func, $attr1 = '', $attr2 = '', $attr3 = '', $attr4 = '', $attr5 = '', $attr6 = '')
{

	switch ($func) {
		case 'js':
		case 'css':
		if ($attr1 == '') return;
		if ($attr2 == '') $attr2 = false;
		if ($attr3 == '') $attr3 = 'global';
			return Casset::$func($attr1, $attr2, $attr3);

		case 'render':
		case 'render_js':
		case 'render_css':
			if ($attr1 == '') $attr1 = false;
			if ($attr2 == '') $attr2 = null;
			if ($attr3 == '') $attr3 = array();
			return Casset::$func($attr1, $attr2, $attr3);

		case 'img':
			if ($attr1 == '') return;
			if ($attr3 == '') $attr3 = array();
			return Casset::$func($attr1, $attr2, $attr3);

		case 'js_inline':
		case 'css_inline':
			if ($attr1 == '') return;
			return Casset::$func($attr1);

		case 'add_Casset_inline':
			if ($attr1 == '') return;
			if ($attr2 == '') return;
			return Casset::$func($attr1, $attr2);

		case 'add_group':
			if ($attr1 == '') return;
			if ($attr2 == '') return;
			if ($attr3 == '') return;
			if ($attr4 == '') $attr4 = array();
			if ($attr5 == '') $attr5 = null;
			if ($attr6 == '') $attr6 = null;
			return Casset::$func($attr1, $attr2, $attr3, $attr4, $attr5, $attr6);

		case 'group_exists':
			if ($attr1 == '') return;
			if ($attr2 == '') return;
			return Casset::$func($attr1, $attr2);

		case 'set_js_option':
		case 'set_css_option':
			if ($attr1 == '') return;
			if ($attr2 == '') return;
			if ($attr3 == '') return;
			return Casset::$func($attr1, $attr2, $attr3);

		case 'set_group_option':
			if ($attr1 == '') return;
			if ($attr2 == '') return;
			if ($attr3 == '') return;
			if ($attr4 == '') return;
			return Casset::$func($attr1, $attr2, $attr3, $attr4);

		case 'enable':
		case 'disable':
		case 'enable_js':
		case 'disable_js':
		case 'enable_css':
		case 'disable_css':
			if ($attr1 == '') return;
			return Casset::$func($attr1);

		case 'clear_cache':
		case 'clear_js_cache':
			if ($attr1 == '') $attr1 = 'now';
			return Casset::$func($attr1);

	}



}

