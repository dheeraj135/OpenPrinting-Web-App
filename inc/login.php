<?php

	if ($SESSION->isloggedIn()) {
		$SMARTY->assign('isLoggedIn', $SESSION->isloggedIn());
		$auth = $USER->fetchUserRoles();
		
		$adminPerms = $USER->getPerms();
		$SMARTY->assign('isAdmin', $adminPerms['roleadmin']);

		$SMARTY->assign('isUploader', $USER->isUploader($auth) );
		$SMARTY->assign('isTrustedUploader', $USER->isTrustedUploader($auth));
	}

?>