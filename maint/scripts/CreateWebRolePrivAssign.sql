CREATE TABLE `web_roles_privassign` (
  `assignID` int(11) NOT NULL AUTO_INCREMENT,
  `roleID` int(11) NOT NULL,
  `privName` varchar(45) NOT NULL,
  `value` int(1) NOT NULL,
  PRIMARY KEY (`assignID`),
  KEY `roleID` (`roleID`,`privName`),
  KEY `privName` (`privName`),
  CONSTRAINT `web_roles_privassign_ibfk_1` FOREIGN KEY (`roleID`) REFERENCES `web_roles` (`roleID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `web_roles_privassign_ibfk_2` FOREIGN KEY (`privName`) REFERENCES `web_permissions` (`privName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;


INSERT INTO `web_roles_privassign` VALUES
  (1,3,'roleadmin',1),
  (2,3,'show_admin',1),
  (3,3,'driver_noqueue',1),
  (4,3,'driver_queue_adm',1),
  (5,3,'driver_upload',1),
  (6,2,'driver_noqueue',1),
  (7,2,'driver_queue_adm',0),
  (8,2,'driver_upload',1),
  (9,2,'roleadmin',0),
  (10,2,'show_admin',0),
  (11,1,'driver_noqueue',0),
  (12,1,'driver_queue_adm',0),
  (13,1,'driver_upload',1),
  (14,1,'roleadmin',0),
  (15,1,'show_admin',0),
  (16,3,'printer_noqueue',1),
  (17,3,'printer_upload',1),
  (18,1,'printer_noqueue',0),
  (19,1,'printer_upload',1),
  (20,4,'driver_noqueue',0),
  (21,4,'driver_queue_adm',0),
  (22,4,'driver_upload',0),
  (23,4,'printer_noqueue',0),
  (24,4,'printer_upload',1),
  (25,4,'roleadmin',0),
  (26,4,'show_admin',0),
  (27,3,'notifications',1),
  (28,3,'driver_edit',1),
  (29,3,'printer_edit',1),
  (30,3,'driver_delete',1),
  (31,3,'printer_delete',1);
  
