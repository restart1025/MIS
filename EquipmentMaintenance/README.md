## 系统原型网址：
http://phbmhb.axshare.com
##ER图：
![ER图](https://github.com/restart1025/MIS/blob/master/EquipmentMaintenance/ERPicture.jpg)
##查询语句：
###根据设备名称查询保养记录：
SELECT 	et.type_name AS '设备类型',   
&emsp;&emsp;eq.name AS '设备名称',   
&emsp;&emsp;eq.maintenance_last_time AS '最近一次保养时间',   
&emsp;&emsp;mp.maintenance_content AS '保养内容',  
&emsp;&emsp;mr.type AS '保养类别',   
&emsp;&emsp;mr.main_time AS '保养时间',   
&emsp;&emsp;mc.material_name AS '消耗材料',  
&emsp;&emsp;mc.material_num AS '材料数量',  
&emsp;&emsp;mr.condition AS '完成情况',   
&emsp;&emsp;mr.comments AS '备注'     
FROM maintenance_record AS mr   
&emsp;	LEFT JOIN equipment AS eq ON mr.equipment_id = eq.id   
&emsp;	LEFT JOIN maintenance_project AS mp ON mr.project_id = mp.id   
&emsp;	LEFT JOIN consume_record AS cr ON mr.id = cr.record_id   
&emsp;	LEFT JOIN maintenance_consume AS mc ON cr.consume_id = mc.id   
&emsp;	LEFT JOIN equipment_type AS et ON eq.type = et.type_id   
WHERE eq.name='比重计01';  
###查询结果:  
![](https://github.com/restart1025/MIS/blob/master/EquipmentMaintenance/%E6%A0%B9%E6%8D%AE%E8%AE%BE%E5%A4%87%E7%BC%96%E5%8F%B7%E6%9F%A5%E8%AF%A2%E4%BF%9D%E5%85%BB%E8%AE%B0%E5%BD%95.JPG)

###预警
SELECT IF(  
(SELECT DATEDIFF(curdate(),  
&emsp;&emsp;		(SELECT mr.main_time  
&emsp;&emsp;		FROM maintenance_record AS mr   
&emsp;&emsp;&emsp;			LEFT JOIN check_type AS ct ON ct.check_type = mr.type  
&emsp;&emsp;		WHERE equipment_id = 1   
&emsp;&emsp;		ORDER BY mr.main_time DESC   
&emsp;&emsp;		limit 1)  
&emsp;	) AS DiffDate)   
<=   
&emsp;	(SELECT ct.waring_day   
&emsp;	FROM maintenance_record AS mr   
&emsp;&emsp;			LEFT JOIN check_type AS ct ON ct.check_type = mr.type  
&emsp;&emsp;			LEFT JOIN equipment e ON e.id = mr.equipment_id   
&emsp;	WHERE equipment_id = 1 ORDER BY mr.main_time DESC limit 1)  
, 'true' ,'false') AS '是否需要预警';  
###查询结果:
![](https://github.com/restart1025/MIS/blob/master/EquipmentMaintenance/%E9%A2%84%E8%AD%A6.JPG)

###数据库
SET FOREIGN_KEY_CHECKS=0;  

-- ----------------------------  
-- Table structure for `check_type`  
-- ----------------------------  
DROP TABLE IF EXISTS `check_type`;  
CREATE TABLE `check_type` (  
  `check_type` enum('年检','季检','周检','月检') DEFAULT NULL,  
  `waring_day` int(22) DEFAULT NULL  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;  
  
-- ----------------------------  
-- Records of check_type  
-- ----------------------------  
INSERT INTO `check_type` VALUES ('年检', '30');  
INSERT INTO `check_type` VALUES ('季检', '15');  
INSERT INTO `check_type` VALUES ('月检', '10');  
INSERT INTO `check_type` VALUES ('周检', '2');  
  
-- ----------------------------  
-- Table structure for `consume_record`  
-- ----------------------------  
DROP TABLE IF EXISTS `consume_record`;  
CREATE TABLE `consume_record` (  
  `consume_id` int(11) NOT NULL,  
  `record_id` int(11) NOT NULL,  
  PRIMARY KEY (`consume_id`,`record_id`),  
  KEY `fk_iuawfbsvd` (`record_id`),  
  CONSTRAINT `fk_iuawfbsvd` FOREIGN KEY (`record_id`) REFERENCES `maintenance_record` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,  
  CONSTRAINT `fk_jabelfia` FOREIGN KEY (`consume_id`) REFERENCES `maintenance_consume` (`id`) ON DELETE CASCADE ON UPDATE CASCADE  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;  
  
-- ----------------------------  
-- Records of consume_record  
-- ----------------------------  
INSERT INTO `consume_record` VALUES ('2', '1');  
INSERT INTO `consume_record` VALUES ('1', '2');  
INSERT INTO `consume_record` VALUES ('1', '3');  
  
-- ----------------------------  
-- Table structure for `equipment`  
-- ----------------------------  
DROP TABLE IF EXISTS `equipment`;  
CREATE TABLE `equipment` (  
  `id` int(11) NOT NULL,  
  `name` char(45) DEFAULT NULL,  
  `type` int(11) DEFAULT NULL,  
  `maintenance_last_time` date DEFAULT NULL,  
  `warning` varchar(45) NOT NULL DEFAULT 'false',  
  PRIMARY KEY (`id`),  
  KEY `fk_jnalbfnasvan` (`type`),    
  CONSTRAINT `fk_jnalbfnasvan` FOREIGN KEY (`type`) REFERENCES `equipment_type` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;  

-- ----------------------------  
-- Records of equipment  
-- ----------------------------  
INSERT INTO `equipment` VALUES ('1', '比重计01', '1', '2016-10-08', 'false');  
INSERT INTO `equipment` VALUES ('2', '比重计02', '1', '2016-10-01', 'false');  
INSERT INTO `equipment` VALUES ('3', '比重计03', '1', '2016-09-15', 'false');  
INSERT INTO `equipment` VALUES ('4', '比重计04', '1', '2016-09-20', 'false');  
INSERT INTO `equipment` VALUES ('5', '比重计05', '1', '2016-09-25', 'false');  
INSERT INTO `equipment` VALUES ('6', '比重计06', '1', '2016-09-30', 'false');  
  
-- ----------------------------  
-- Table structure for `equipment_type`  
-- ----------------------------  
DROP TABLE IF EXISTS `equipment_type`;  
CREATE TABLE `equipment_type` (  
  `type_id` int(11) NOT NULL,  
  `type_name` char(45) DEFAULT NULL,  
  `maintenance_time` date DEFAULT NULL,  
  PRIMARY KEY (`type_id`)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;  

-- ----------------------------  
-- Records of equipment_type  
-- ----------------------------  
INSERT INTO `equipment_type` VALUES ('1', '比重计', null);  
INSERT INTO `equipment_type` VALUES ('2', '液压仪', null);  
  
-- ----------------------------  
-- Table structure for `maintenance_consume`  
-- ----------------------------          
DROP TABLE IF EXISTS `maintenance_consume`;  
CREATE TABLE `maintenance_consume` (  
  `id` int(11) NOT NULL,  
  `material_name` char(45) DEFAULT NULL,  
  `material_num` float(45,0) DEFAULT NULL,  
  PRIMARY KEY (`id`)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;  

-- ----------------------------  
-- Records of maintenance_consume  
-- ----------------------------  
INSERT INTO `maintenance_consume` VALUES ('1', '仪器', '2');  
INSERT INTO `maintenance_consume` VALUES ('2', '机器', '3');  
INSERT INTO `maintenance_consume` VALUES ('3', '防护栏', '5');  
  
-- ----------------------------  
-- Table structure for `maintenance_person`  
-- ----------------------------  
DROP TABLE IF EXISTS `maintenance_person`;  
CREATE TABLE `maintenance_person` (  
  `id` int(11) NOT NULL,  
  `name` char(45) DEFAULT NULL,  
  PRIMARY KEY (`id`)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;  

-- ----------------------------  
-- Records of maintenance_person  
-- ----------------------------  
INSERT INTO `maintenance_person` VALUES ('1', '王凯');  
INSERT INTO `maintenance_person` VALUES ('2', '张三');  
INSERT INTO `maintenance_person` VALUES ('3', '李四');  
INSERT INTO `maintenance_person` VALUES ('4', '小明');  
INSERT INTO `maintenance_person` VALUES ('5', '小红');  

-- ----------------------------  
-- Table structure for `maintenance_project`  
-- ----------------------------  
DROP TABLE IF EXISTS `maintenance_project`;  
CREATE TABLE `maintenance_project` (  
  `id` int(11) NOT NULL AUTO_INCREMENT,  
  `maintenance_content` varchar(255) DEFAULT NULL,  
  `equipment_type_id` int(11) DEFAULT NULL,  
  PRIMARY KEY (`id`),  
  KEY `fk_kdfkkSV` (`equipment_type_id`),  
  CONSTRAINT `fk_kdfkkSV` FOREIGN KEY (`equipment_type_id`) REFERENCES `equipment_type` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;  
  
-- ----------------------------  
-- Records of maintenance_project  
-- ----------------------------  
INSERT INTO `maintenance_project` VALUES ('1', '测量γ源泄露情况', '1');  
INSERT INTO `maintenance_project` VALUES ('2', '检查接线紧固情况和电缆磨损情况；', '1');  
INSERT INTO `maintenance_project` VALUES ('3', '检查仪表、传感器的密封、固定情况', '1');  
INSERT INTO `maintenance_project` VALUES ('4', '校对比重计准确度', '1');  
  
-- ----------------------------  
-- Table structure for `maintenance_record`  
-- ----------------------------  
DROP TABLE IF EXISTS `maintenance_record`;  
CREATE TABLE `maintenance_record` (  
  `id` int(11) NOT NULL AUTO_INCREMENT,  
  `equipment_id` int(11) DEFAULT NULL,  
  `project_id` int(11) DEFAULT NULL,  
  `condition` enum('二分之一','完成','四分之三','四分之一','未完成') DEFAULT NULL,  
  `comments` varchar(255) DEFAULT NULL,  
  `main_time` date DEFAULT NULL,  
  `person_id` int(22) DEFAULT NULL,  
  `type` enum('周检','季检','月检','年检') DEFAULT NULL,  
  PRIMARY KEY (`id`),  
  KEY `fk_uafiuafnsvbakd` (`equipment_id`),  
  KEY `fk_uaeiuckjsddsa` (`project_id`),  
  KEY `fk_kaksbva` (`person_id`),  
  CONSTRAINT `fk_kaksbva` FOREIGN KEY (`person_id`) REFERENCES `maintenance_person` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,  
  CONSTRAINT `fk_uaeiuckjsddsa` FOREIGN KEY (`project_id`) REFERENCES `maintenance_project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,  
  CONSTRAINT `fk_uafiuafnsvbakd` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE  
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;  
  
-- ----------------------------  
-- Records of maintenance_record  
-- ----------------------------  
INSERT INTO `maintenance_record` VALUES ('1', '1', '1', '完成', '无', '2016-10-09', '1', '月检');  
INSERT INTO `maintenance_record` VALUES ('2', '1', '2', '未完成', '无', '2016-10-07', '2', '季检');  
INSERT INTO `maintenance_record` VALUES ('3', '1', '3', '二分之一', '无', '2016-10-05', '3', '年检');  
  
-- ----------------------------  
-- Table structure for `record_project`  
-- ----------------------------  
DROP TABLE IF EXISTS `record_project`;  
CREATE TABLE `record_project` (  
  `record_id` int(22) NOT NULL,  
  `project_id` int(22) NOT NULL,  
  PRIMARY KEY (`record_id`,`project_id`),  
  KEY `fk_uahifjnakjsd` (`project_id`),  
  CONSTRAINT `fk_aliufljans` FOREIGN KEY (`record_id`) REFERENCES `maintenance_record` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,  
  CONSTRAINT `fk_uahifjnakjsd` FOREIGN KEY (`project_id`) REFERENCES `maintenance_project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;  
  
-- ----------------------------  
-- Records of record_project  
-- ----------------------------  
INSERT INTO `record_project` VALUES ('1', '1');  
INSERT INTO `record_project` VALUES ('1', '2');  
INSERT INTO `record_project` VALUES ('1', '3');  
INSERT INTO `record_project` VALUES ('1', '4');  

