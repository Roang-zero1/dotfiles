<?php


$website = 'http://koken.kurvendiskussionen.at'; //no trailing slash

$key = 'KHdiEhp21mDwPMhhA2ZNI8i4m1CnAG';

/*
 *
 * RUNNING ON A MACHINE THAT HAS UNLIMITED EXECUTION TIME IS HIGHLY ENCOURAGED
 *
 * If you have firewall installed on your webserver, whitelist your own IP or disable it
 * In case your firewall blacklists you.
 *
 */
echo "Caching for website: ".$website."\n";
$urls = file_get_contents($website.'/cache.url.php?key='.$key);

$requests = json_decode($urls, true);

if ($requests === NULL){
	echo "No requests\n";
	die;
}

foreach($requests as $i) {
    echo "Caching ".$website.$i."\n";
	$ch = curl_init($website.$i);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HEADER, false);
    curl_exec($ch);
    curl_close($ch);
}