<?php

require_once 'ProgressBar/Manager.php';
require_once 'ProgressBar/Registry.php';

/*
 *
 * RUNNING ON A MACHINE THAT HAS UNLIMITED EXECUTION TIME IS HIGHLY ENCOURAGED
 *
 * If you have firewall installed on your webserver, whitelist your own IP or disable it
 * In case your firewall blacklists you.
 *
 */

//Website to query cache
$website = 'http://koken.kurvendiskussionen.at'; //no trailing slash

// Get Key from keyfile
$key = file_get_contents('/home/denocte/.koken_key');

//Variable defauls
$sizes = NULL;
/*$sizes = array(
		'tiny',
		'medium_large',
		'xlarge'
	);*/

$retina = NULL;
//$retina = false;

echo "Caching for website: ".$website."\n";

//Generate query
$query = http_build_query(array('key' => $key,'sizes' => $sizes ,'retina' => $retina));
$urls = file_get_contents($website.'/cache.url.php?' . $query);

//Decode the picture urls
$requests = json_decode($urls, true);

//Exit if no images need to be cached
if ($requests == NULL){
	echo "No requests\n";
	die;
}

echo 'Caching ' . count($requests) . " images\n";

//Initialize progress bar
$progressBar = new \ProgressBar\Manager(0, count($requests));
$progressBar->setFormat('Images: %current%/%max% [%bar%] %percent%%');

//Cache image by calling the the webgsite
foreach($requests as $i) {
	$ch = curl_init($website.$i);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HEADER, false);
    curl_exec($ch);
    curl_close($ch);
	$progressBar->advance();
}