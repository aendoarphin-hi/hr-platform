<?php

require_once("../sys/ttprod.app.php"); //$db->debug=true;

// print all query params
echo 'query params:<br/>';
myprint_r($_REQUEST);

// print all body params
echo 'body params:<br/>';
myprint_r($_POST);