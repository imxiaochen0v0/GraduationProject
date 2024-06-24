/*
 Navicat Premium Data Transfer

 Source Server         : Roome
 Source Server Type    : MySQL
 Source Server Version : 80036
 Source Host           : localhost:3306
 Source Schema         : roome

 Target Server Type    : MySQL
 Target Server Version : 80036
 File Encoding         : 65001

 Date: 24/06/2024 20:51:19
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
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of city
-- ----------------------------
INSERT INTO `city` VALUES (1, '伦敦', 1, 0, '/uploads/city/London.jpg');
INSERT INTO `city` VALUES (2, '北京', 1, 0, '/uploads/city/Beijing.jpg');
INSERT INTO `city` VALUES (3, '巴黎', 0, 0, '/uploads/city/Paris.jpg');
INSERT INTO `city` VALUES (4, '夏威夷', 0, 0, '/uploads/city/Hawaii.jpg');
INSERT INTO `city` VALUES (5, '巴塞罗那', 0, 0, '/uploads/city/Barcelona.jpg');
INSERT INTO `city` VALUES (6, '上海', 1, 1, '/uploads/city/Shanghai.jpg');

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
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hotel
-- ----------------------------
INSERT INTO `hotel` VALUES (1, '香格里拉酒店', '北京', '朝阳区, 北京', 4, 1080, 2, 1, 0, '/uploads/hotel/hotel1.jpg');
INSERT INTO `hotel` VALUES (2, '帝豪国际酒店', '北京', '朝阳区, 北京', 5, 2560, 200, 0, 1, '/uploads/hotel/hotel2.jpg');
INSERT INTO `hotel` VALUES (3, '梦幻之星酒店', '北京', '朝阳区, 北京', 4, 3256, 158, 0, 1, '/uploads/hotel/hotel3.jpg');
INSERT INTO `hotel` VALUES (4, '吉野家民宿', '巴塞罗那', '巴塞罗那，西班牙', 4, 1241, 2, 0, 1, '/uploads/hotel/hotel4.jpg');
INSERT INTO `hotel` VALUES (5, '拉普拉岛哈扎库酒店', '巴塞罗那', '巴塞罗那，西班牙', 5, 2780, 500, 0, 1, '/uploads/hotel/hotel5.jpg');
INSERT INTO `hotel` VALUES (6, '拉布拉多酒店', '巴塞罗那', '巴塞罗那，西班牙', 4, 3520, 236, 0, 1, '/uploads/hotel/hotel6.jpg');
INSERT INTO `hotel` VALUES (7, '迪奥酒店', '巴黎', '巴黎，法国', 5, 5460, 1000, 0, 1, '/uploads/hotel/hotel7.jpg');
INSERT INTO `hotel` VALUES (8, '拉斐尔酒店', '巴黎', '巴黎，法国', 4, 3540, 1205, 0, 1, '/uploads/hotel/hotel8.jpg');
INSERT INTO `hotel` VALUES (9, '拿破仑酒店', '巴黎', '巴黎，法国', 5, 5640, 1326, 0, 1, '/uploads/hotel/hotel9.jpg');
INSERT INTO `hotel` VALUES (10, '山下酒店', '巴黎', '巴黎，法国', 4, 5310, 1063, 0, 1, '/uploads/hotel/hotel10.jpg');
INSERT INTO `hotel` VALUES (11, 'Wailea Beach Resort Marriott', '夏威夷', '夏威夷，美国', 4, 3135, 2374, 0, 1, '/uploads/hotel/hotel11.jpg');
INSERT INTO `hotel` VALUES (12, 'Aston Waikiki Beach Tower', '夏威夷', '夏威夷，美国', 5, 4390, 3943, 0, 0, '/uploads/hotel/hotel12.jpg');
INSERT INTO `hotel` VALUES (13, 'Kingsland Locke', '伦敦', '伦敦，英国', 5, 5460, 5004, 0, 0, '/uploads/hotel/hotel13.jpg');
INSERT INTO `hotel` VALUES (14, '英迪格酒店', '上海', '浦东区，上海', 5, 4365, 564, 0, 0, '/uploads/hotel/hotel14.jpg');

-- ----------------------------
-- Table structure for hotelorder
-- ----------------------------
DROP TABLE IF EXISTS `hotelorder`;
CREATE TABLE `hotelorder`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `hotel_id` int NOT NULL,
  `price` int NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` int NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hotelorder
-- ----------------------------
INSERT INTO `hotelorder` VALUES (1, 1, 1080, '普通套房', 1);
INSERT INTO `hotelorder` VALUES (2, 3, 3256, '普通套房', 0);
INSERT INTO `hotelorder` VALUES (3, 5, 2780, '普通套房', 0);
INSERT INTO `hotelorder` VALUES (4, 9, 5640, '普通套房', 1);
INSERT INTO `hotelorder` VALUES (5, 12, 4390, '普通套房', 0);
INSERT INTO `hotelorder` VALUES (6, 11, 3135, '普通套房', 1);
INSERT INTO `hotelorder` VALUES (7, 1, 1080, '普通套房', 1);
INSERT INTO `hotelorder` VALUES (8, 13, 16380, '总统套房', 0);
INSERT INTO `hotelorder` VALUES (9, 3, 6512, '普通套房', 1);
INSERT INTO `hotelorder` VALUES (10, 7, 5460, '普通套房', 1);
INSERT INTO `hotelorder` VALUES (11, 11, 9405, '豪华套房', 0);
INSERT INTO `hotelorder` VALUES (12, 7, 10920, '豪华套房', 0);
INSERT INTO `hotelorder` VALUES (13, 7, 16380, '总统套房', 1);
INSERT INTO `hotelorder` VALUES (14, 1, 1080, '普通套房', 1);
INSERT INTO `hotelorder` VALUES (15, 7, 10920, '豪华套房', 1);
INSERT INTO `hotelorder` VALUES (16, 1, 3240, '总统套房', 1);
INSERT INTO `hotelorder` VALUES (17, 1, 2160, '豪华套房', 1);
INSERT INTO `hotelorder` VALUES (18, 12, 8780, '豪华套房', 1);
INSERT INTO `hotelorder` VALUES (19, 7, 16380, '总统套房', 0);

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
  `user_pic` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '/uploads/avatar/user.png',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `amount` int NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id` ASC) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', '$2a$10$E8tUogv.60lz9c4hIFU3XuBW0jyyvZmfdQtJKPWGe/AGNwqbwTZe.', '吴彦祖', 'im-xiaochen@outlook.com', '/uploads/avatar/84d8afcf3fc9bd85d0de9f6d13ae1d17', '15976631111', 480);
INSERT INTO `users` VALUES (2, 'imxiaochen', '$2a$10$OZx5fZhrU5ZKAnmXpPBn.e7cdY1zT2J4ciUXgWY75k5Ffk4tg/oIK', '吴彦祖11', '11223344@qq.com', '/uploads/avatar/5a8f24174b348ec13f4f12da92a1f3e8', '13337845812', 5355);

SET FOREIGN_KEY_CHECKS = 1;
