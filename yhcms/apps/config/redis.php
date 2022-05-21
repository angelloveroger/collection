<?php
defined('BASEPATH') OR exit('No direct script access allowed');

$mysys = json_decode(_SYSJSON_,1);
$config = array(
	'socket_type' => 'tcp',
	'host' => $mysys['caches']['redis']['ip'],
	'password' => $mysys['caches']['redis']['pass'] === '' ? NULL : $mysys['caches']['redis']['pass'],
	'port' => $mysys['caches']['redis']['port'],
	'timeout' => 0
);