<?php
// Script for automatically checking in newly uploaded PPD files
// (in upload/driver/<driver>/PPD) to the BZR repositories of
// foomatic-db and foomatic-db-nonfree. To be called via

// php /srv/www/openprinting/maint/scripts/commitppdstobzr.php

// This script should be run as a cron job once a minute

$BASE="/srv/www/openprinting";
$UPLOADPATH="/upload/driver";
$LOGFILE="log.txt";

$dir = $BASE . $UPLOADPATH;
if (is_dir($dir)) {
    if ($dh = opendir($dir)) {
	while (($driver = readdir($dh)) !== false) {
	    if ($driver == "." or $driver == "..") continue;
	    if (strlen($driver) > 0) {
		$f = file_get_contents("$dir/$driver/ppdcommit");
		if (strlen($f) > 0 and ($f == "free" or $f == "nonfree")) {
		    $lfh = fopen("$dir/$driver/$LOGFILE", "a");
		    if (!$lfh) {
			// Cannot write to log file
			exit(1);
		    }
		    fwrite($lfh,
			   "\nBZR check-in of the PPD files via cron job\n");
		    $result = array();
		    exec("$BASE/maint/scripts/updatebzrfrommysql --ppd-$f " .
			 "$dir/$driver/PPD $driver",
			 $result, $ret_value);
		    fwrite($lfh,
			   "Checking new PPD files for $driver into the BZR repository\n");
		    foreach ($result as $line) {
			fwrite($lfh,
			       "   $line\n");
		    }
		    if ($ret_value == 0) {
			fwrite($lfh,
			       "   --> SUCCESS\n");
			$result = array();
			exec("rm -rf $dir/$driver/PPD", $result, $ret_value);
			if ($ret_value != 0) {
			    fwrite($lfh,
				   "ERROR: Cannot remove \"PPD\" directory for driver \"$driver\"!\n");
			}
			$result = array();
			exec("rm $dir/$driver/ppdcommit", $result, $ret_value);
			if ($ret_value != 0) {
			    fwrite($lfh,
				   "ERROR: Cannot remove ppdcommit file for driver \"$driver\"!\n");
			}
		    } else {
			fwrite($lfh,
			       "   --> ERROR: $ret_value\n");
		    }
		    fclose($lfh);
		}
	    }
	}
	closedir($dh);
    }
}

?>