<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/*
| -------------------------------------------------------------------------
| Memcached settings
| -------------------------------------------------------------------------
| Your Memcached servers can be specified below.
|
|	See: https://codeigniter.com/user_guide/libraries/caching.html#memcached
|
*/
$mysys = json_decode(_SYSJSON_,1);
$config = array(
	'default' => array(
		'hostname' => $mysys['caches']['memcache']['ip'],
		'port'     => $mysys['caches']['memcache']['port'],
		'weight'   => '1',
	),
);