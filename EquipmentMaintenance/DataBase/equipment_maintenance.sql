/*
Navicat MySQL Data Transfer

Source Server         : RESTART1025
Source Server Version : 50712
Source Host           : localhost:3306
Source Database       : equipment_maintenance

Target Server Type    : MYSQL
Target Server Version : 50712
File Encoding         : 65001

Date: 2016-10-17 00:07:38
*/

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
