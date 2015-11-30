<?php
require_once 'ProgressBar/Manager.php';
require_once 'ProgressBar/Registry.php';

//Variable defauls
$sizes       = NULL;
$sizes_avail = array(
    'xlarge',
    'medium_large',
    'tiny',
    'small',
    'medium',
    'large',
    'huge'
);

// Script example.php
$shortopts = "";
$shortopts .= "s:"; // Size
$shortopts .= "ahlrv"; // These options do not accept values

$longopts = array(
    "size:", // Request specific size
    "help", // Display help
    "list", // Only list image urls
    "retina", // Request retina image urls
    "all", // Request all images
    "summary" // Print summary
);
$options  = getopt($shortopts, $longopts);

if (array_key_exists('h', $options) || array_key_exists('help', $options)) {
    echo "Print help";
    //TO-DO: Write Help
    var_dump(array(
        'tiny',
        'small',
        'medium',
        'medium_large',
        'large',
        'xlarge',
        'huge'
    ));
}

$verbose = array_key_exists('v', $options);
// Generate list of missing images
$list    = array_key_exists('l', $options) || array_key_exists('list', $options);
$summary = array_key_exists('summary', $options);

//Website to query cache
$website = 'http://koken.kurvendiskussionen.at'; //no trailing slash

// Get Key from keyfile
$key = file_get_contents('/home/denocte/.koken_key');

$queryopts = array(
    'key' => $key
);

// Generate retina pictures
$queryopts['retina'] = array_key_exists('r', $options) || array_key_exists('retina', $options);
// Query all images from server
$queryopts['all']    = array_key_exists('a', $options) || array_key_exists('all', $options);
$sizes               = array();
if (array_key_exists('s', $options)) {
    option_to_array($sizes, $options['s']);
}
if (array_key_exists('size', $options)) {
    option_to_array($sizes, $options['size']);
}
if (count($sizes) > 0) {
    $sizes              = array_unique($sizes);
    $sizes              = array_intersect($sizes, $sizes_avail);
    $queryopts['sizes'] = $sizes;
}

echo "Caching for website: " . $website . "\n";
if ($verbose) {
    echo "Settings: \n";
    echo ' All: ' . ($queryopts['all'] ? 'true' : 'false') . "\n";
    echo ' List: ' . ($queryopts['retina'] ? 'true' : 'false') . "\n";
    echo ' Retina: ' . ($queryopts['retina'] ? 'true' : 'false') . "\n";
    if (count($sizes) == 0) {
        echo "  Sizes: default\n";
    } else {
        echo '  Sizes: ';
        foreach ($sizes as $s) {
            echo $s . ", ";
        }

        echo "\n";
    }

}

//Generate query
$query = http_build_query($queryopts);
$urls  = file_get_contents($website . '/cache.url.php?' . $query);

//Decode the picture urls
$requests = json_decode($urls, true);

//Exit if no images need to be cached
if ($requests == NULL) {
    echo "No requests\n";
    die;
}

if ($list || $summary) {
    if($list){
		foreach($requests as $size => $images){
		echo $size . ":\n";
			foreach ($images as $i) {
				echo $website . $i . "\n";
			}
		}
	}
	
	echo "Summary:\n";
	foreach($requests as $size => $images){
		echo "  " . $size . ": " . count($images) . " images\n";
	}

} else {
	// Sort requests by size
	$requests = array_merge(array_flip($sizes_avail),$requests);
	$requests =array_filter($requests,function($k) {
		return is_array($k);
	});
	
	//Work all sizes
	foreach($requests as $size => $images){
		echo 'Caching ' . count($images) . ' ' . $size . " sized images\n";
		
		//Initialize progress bar
    	$progressBar = new \ProgressBar\Manager(0, count($images));
    	$progressBar->setFormat('Images: %current%/%max% [%bar%] %percent%%');
		
		//Cache image by calling the the webgsite
    	foreach ($images as $i) {
			$ch = curl_init($website . $i);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
			curl_setopt($ch, CURLOPT_HEADER, false);
			curl_exec($ch);
			curl_close($ch);
			$progressBar->advance();
		}
	}
}



// Turn an option into an array, even if only one value is given
function option_to_array(&$array, $option)
{
    if (count($option) === 1) {
        array_push($array, $option);
    } else {
        $array = array_merge($array, $option);
    }

}