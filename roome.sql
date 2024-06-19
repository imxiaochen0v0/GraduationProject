/*
 Navicat Premium Data Transfer

 Source Server         : mydb
 Source Server Type    : MySQL
 Source Server Version : 80036
 Source Host           : localhost:3306
 Source Schema         : roome

 Target Server Type    : MySQL
 Target Server Version : 80036
 File Encoding         : 65001

 Date: 19/06/2024 11:45:42
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for city
-- ----------------------------
DROP TABLE IF EXISTS `city`;
CREATE TABLE `city`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `isHot` int NULL DEFAULT NULL,
  `recommend` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of city
-- ----------------------------
INSERT INTO `city` VALUES (1, '伦敦', 0, 1);
INSERT INTO `city` VALUES (2, '北京', 1, 0);
INSERT INTO `city` VALUES (3, '巴黎', 0, 0);
INSERT INTO `city` VALUES (4, '夏威夷', 0, 0);

-- ----------------------------
-- Table structure for hotel
-- ----------------------------
DROP TABLE IF EXISTS `hotel`;
CREATE TABLE `hotel`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `rate` int NULL DEFAULT NULL,
  `price` int NULL DEFAULT NULL,
  `distance` int NULL DEFAULT NULL,
  `isLike` int NULL DEFAULT NULL,
  `cheap` int NULL DEFAULT NULL,
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hotel
-- ----------------------------
INSERT INTO `hotel` VALUES (1, '香格里拉酒店', '北京', '朝阳区, 北京', 4, 1080, 2, 0, 0, '/uploads/hotel/hotel1.jpg');
INSERT INTO `hotel` VALUES (2, '帝豪国际酒店', '北京', '朝阳区, 北京', 5, 2560, 200, 1, 0, '/uploads/hotel/hotel2.jpg');
INSERT INTO `hotel` VALUES (3, '梦幻之星酒店', '北京', '朝阳区, 北京', 4, 3256, 158, 0, 0, '/uploads/hotel/hotel3.jpg');
INSERT INTO `hotel` VALUES (4, '吉野家民宿', '巴塞罗那', '巴塞罗那,西班牙', 4, 1241, 2, 0, 1, '/uploads/hotel/hotel4.jpg');
INSERT INTO `hotel` VALUES (5, '拉普拉岛哈扎库酒店', '巴塞罗那', '巴塞罗那,西班牙', 5, 2780, 500, 0, 1, '/uploads/hotel/hotel5.jpg');
INSERT INTO `hotel` VALUES (6, '拉布拉多酒店', '巴塞罗那', '巴塞罗那,西班牙', 4, 3520, 236, 1, 1, '/uploads/hotel/hotel6.jpg');
INSERT INTO `hotel` VALUES (7, '迪奥酒店', '巴黎', '巴黎,法国', 5, 5460, 1000, 0, 1, '/uploads/hotel/hotel7.jpg');
INSERT INTO `hotel` VALUES (8, '拉斐尔酒店', '巴黎', '巴黎,法国', 4, 3540, 1205, 0, 1, '/uploads/hotel/hotel8.jpg');
INSERT INTO `hotel` VALUES (9, '拿破仑酒店', '巴黎', '巴黎,法国', 5, 5640, 1326, 1, 1, '/uploads/hotel/hotel9.jpg');
INSERT INTO `hotel` VALUES (10, '山下酒店', '巴黎', '巴黎,法国', 4, 5310, 1063, 0, 1, '/uploads/hotel/hotel10.jpg');

-- ----------------------------
-- Table structure for hotelorder
-- ----------------------------
DROP TABLE IF EXISTS `hotelorder`;
CREATE TABLE `hotelorder`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `hotel_id` int NOT NULL,
  `price` int NULL DEFAULT NULL,
  `status` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hotelorder
-- ----------------------------
INSERT INTO `hotelorder` VALUES (1, 1, 1080, 1);
INSERT INTO `hotelorder` VALUES (2, 3, 3256, 1);
INSERT INTO `hotelorder` VALUES (3, 5, 2780, 1);
INSERT INTO `hotelorder` VALUES (4, 9, 5640, 1);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_pic` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `amount` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id` ASC) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', '$2a$10$UZCcJiFbpxj8/Hqhz4oh4Om10o0dhBDjsFxUqpoH2z8RqpEK1s57W', '彭于晏', '3332333@qq.com', '/uploads/avatar/84d8afcf3fc9bd85d0de9f6d13ae1d17', '13660092916', 994359);
INSERT INTO `users` VALUES (2, 'admin1', '$2a$10$kUAMLYOmm40wievYObxe0eMO85utTzR035gEw4aAHlqvnecTIVNKC', '', '', NULL, '', NULL);

SET FOREIGN_KEY_CHECKS = 1;
