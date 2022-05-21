<?php
class My_Controller extends CI_Controller {
	function __construct() {
		parent::__construct();
		header('X-Company: '.base64decode('WUhjbXMgKGh0dHA6Ly93d3cueWhjbXMuY2Mp'));
		header('X-Team: '.base64decode('VGVsZWdyYW0obXluYW1lNTIwKQ'));
	}
}