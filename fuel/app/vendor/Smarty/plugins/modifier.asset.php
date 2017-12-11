<?php
/**
 * Smarty plugin
 *
 * @package Smarty
 * @subpackage PluginsModifier
 */

function smarty_modifier_asset($func, $string = array(), $attr = array(), $group = NULL, $raw = false)
{
	return Asset::$func($string, $attr, $group, $raw);

}
