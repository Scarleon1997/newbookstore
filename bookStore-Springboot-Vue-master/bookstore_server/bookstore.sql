/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80039
 Source Host           : localhost:3306
 Source Schema         : bookstore

 Target Server Type    : MySQL
 Target Server Version : 80039
 File Encoding         : 65001

 Date: 18/06/2025 20:38:17
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
CREATE DATABASE bookstore;
USE bookstore;
-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '地址ID',
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账户',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货人姓名',
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `addr` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '详细地址',
  `label` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标签 (如 家, 公司)',
  `off` tinyint(1) NULL DEFAULT 0 COMMENT '是否弃用 (逻辑删除标记)',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_address_account`(`account`) USING BTREE,
  CONSTRAINT `fk_address_user_account` FOREIGN KEY (`account`) REFERENCES `user` (`account`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户地址表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (1, 'testuser', '张三', '13800138000', '北京市海淀区中关村南大街1号', '家', 0);
INSERT INTO `address` VALUES (2, 'testuser', '张先生', '13800138000', '上海市浦东新区世纪大道100号', '公司', 0);
INSERT INTO `address` VALUES (3, 'admin', '李四', '13900139000', '广东省深圳市南山区科技园', '家', 0);

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '图书ID',
  `bookName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '书名',
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '作者',
  `isbn` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'ISBN编号',
  `publishId` bigint NULL DEFAULT NULL COMMENT '出版社ID',
  `publish` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '出版社名称 (考虑是否规范化为publish.id)',
  `birthday` date NULL DEFAULT NULL COMMENT '出版日期',
  `marketPrice` decimal(10, 2) NULL DEFAULT NULL COMMENT '市场价',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '销售价',
  `stock` int NULL DEFAULT 0 COMMENT '库存数量',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '图书描述',
  `put` tinyint(1) NULL DEFAULT 1 COMMENT '是否上架',
  `newProduct` tinyint(1) NULL DEFAULT 0 COMMENT '是否新品',
  `recommend` tinyint(1) NULL DEFAULT 0 COMMENT '是否推荐',
  `rank` int NULL DEFAULT 0 COMMENT '排序字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `isbn_UNIQUE`(`isbn`) USING BTREE,
  INDEX `idx_book_publishId`(`publishId`) USING BTREE,
  CONSTRAINT `fk_book_publish` FOREIGN KEY (`publishId`) REFERENCES `publish` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '图书信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (1, '深入理解计算机系统', 'Randal E. Bryant', '9787111213606', 2, NULL, '2016-11-01', 139.00, 118.50, 50, '计算机领域的经典之作，被誉为“程序员的百科全书”。', 1, 0, 1, 0);
INSERT INTO `book` VALUES (2, '三体', '刘慈欣', '9787536692930', 1, NULL, '2008-01-01', 93.00, 75.00, 100, '中国科幻文学的里程碑之作。', 1, 0, 1, 0);
INSERT INTO `book` VALUES (3, 'Java核心技术 卷I', 'Cay S. Horstmann', '9787111547426', 2, NULL, '2020-05-01', 149.00, 129.00, 80, 'Java领域经典教材，内容翔实，深入浅出。', 1, 1, 0, 0);
INSERT INTO `book` VALUES (4, '百年孤独', '加西亚·马尔克斯', '9787544253994', 3, NULL, '2011-06-01', 69.00, 55.20, 120, '魔幻现实主义文学的代表作，描绘了布恩迪亚家族七代人的传奇故事。', 1, 0, 0, 0);
INSERT INTO `book` VALUES (5, 'MySQL是怎样运行的', '小孩子4919', '9787115531238', 2, NULL, '2020-06-01', 89.00, 71.20, 60, '从根儿上理解 MySQL。', 1, 1, 1, 0);

-- ----------------------------
-- Table structure for bookimg
-- ----------------------------
DROP TABLE IF EXISTS `bookimg`;
CREATE TABLE `bookimg`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '图片ID',
  `isbn` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '图书ISBN编号',
  `imgSrc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '图片路径',
  `cover` tinyint(1) NULL DEFAULT 0 COMMENT '是否为封面图片',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_bookimg_isbn`(`isbn`) USING BTREE,
  CONSTRAINT `fk_bookimg_book_isbn` FOREIGN KEY (`isbn`) REFERENCES `book` (`isbn`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '图书图片表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bookimg
-- ----------------------------
INSERT INTO `bookimg` VALUES (1, '9787111213606', '/images/book/csapp_cover.jpg', 1);
INSERT INTO `bookimg` VALUES (2, '9787111213606', '/images/book/csapp_detail1.jpg', 0);
INSERT INTO `bookimg` VALUES (3, '9787536692930', '/images/book/santi_cover.jpg', 1);
INSERT INTO `bookimg` VALUES (4, '9787111547426', '/images/book/javacore_cover.jpg', 1);

-- ----------------------------
-- Table structure for bookorder
-- ----------------------------
DROP TABLE IF EXISTS `bookorder`;
CREATE TABLE `bookorder`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '内部订单ID',
  `orderId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单编号 (业务ID)',
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账户',
  `addressId` bigint NOT NULL COMMENT '收货地址ID',
  `orderTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '下单时间',
  `shipTime` datetime NULL DEFAULT NULL COMMENT '发货时间',
  `getTime` datetime NULL DEFAULT NULL COMMENT '确认收货时间',
  `evaluateTime` datetime NULL DEFAULT NULL COMMENT '评价时间',
  `closeTime` datetime NULL DEFAULT NULL COMMENT '订单关闭时间',
  `orderStatus` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '订单状态',
  `logisticsNum` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物流单号',
  `logisticsCompany` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物流公司',
  `confirmTime` datetime NULL DEFAULT NULL COMMENT '付款确认时间',
  `beUserDelete` tinyint(1) NULL DEFAULT 0 COMMENT '用户是否删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `orderId_UNIQUE`(`orderId`) USING BTREE,
  INDEX `idx_bookorder_account`(`account`) USING BTREE,
  INDEX `idx_bookorder_addressId`(`addressId`) USING BTREE,
  CONSTRAINT `fk_bookorder_address_id` FOREIGN KEY (`addressId`) REFERENCES `address` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_bookorder_user_account` FOREIGN KEY (`account`) REFERENCES `user` (`account`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '图书订单主表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bookorder
-- ----------------------------
INSERT INTO `bookorder` VALUES (1, 'ORD202506060001', 'testuser', 1, '2025-06-06 00:04:24', NULL, NULL, NULL, NULL, 'SUBMIT', NULL, NULL, NULL, 0);

-- ----------------------------
-- Table structure for booksort
-- ----------------------------
DROP TABLE IF EXISTS `booksort`;
CREATE TABLE `booksort`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `parentId` bigint NULL DEFAULT NULL COMMENT '上级分类ID (NULL表示顶级)',
  `upperName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '上级分类名称 (无 表示顶级)',
  `sortName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `level` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分类级别 (如 级别一, 级别二)',
  `rank` int NULL DEFAULT 0 COMMENT '排序字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uidx_booksort_upper_sort`(`upperName`, `sortName`) USING BTREE,
  UNIQUE INDEX `uidx_booksort_parent_sort`(`parentId`, `sortName`) USING BTREE,
  CONSTRAINT `fk_booksort_self_parentId` FOREIGN KEY (`parentId`) REFERENCES `booksort` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 118 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '图书分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of booksort
-- ----------------------------
INSERT INTO `booksort` VALUES (1, NULL, '', '计算机科学', '级别一', 10);
INSERT INTO `booksort` VALUES (2, NULL, '', '文学', '级别一', 20);
INSERT INTO `booksort` VALUES (3, 1, '', '编程语言', '级别二', 11);
INSERT INTO `booksort` VALUES (4, 1, '', '数据库', '级别二', 12);
INSERT INTO `booksort` VALUES (5, 2, '', '科幻小说', '级别二', 21);
INSERT INTO `booksort` VALUES (6, 2, '', '经典名著', '级别二', 22);

-- ----------------------------
-- Table structure for booksortlist
-- ----------------------------
DROP TABLE IF EXISTS `booksortlist`;
CREATE TABLE `booksortlist`  (
  `bookSortId` bigint NOT NULL COMMENT '图书分类ID',
  `bookId` bigint NOT NULL COMMENT '图书ID',
  PRIMARY KEY (`bookSortId`, `bookId`) USING BTREE,
  INDEX `idx_booksortlist_bookId`(`bookId`) USING BTREE,
  CONSTRAINT `fk_booksortlist_book_id` FOREIGN KEY (`bookId`) REFERENCES `book` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_booksortlist_booksort_id` FOREIGN KEY (`bookSortId`) REFERENCES `booksort` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '图书与分类关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of booksortlist
-- ----------------------------
INSERT INTO `booksortlist` VALUES (1, 1);
INSERT INTO `booksortlist` VALUES (3, 1);
INSERT INTO `booksortlist` VALUES (2, 2);
INSERT INTO `booksortlist` VALUES (5, 2);
INSERT INTO `booksortlist` VALUES (1, 3);
INSERT INTO `booksortlist` VALUES (3, 3);
INSERT INTO `booksortlist` VALUES (2, 4);
INSERT INTO `booksortlist` VALUES (6, 4);
INSERT INTO `booksortlist` VALUES (1, 5);
INSERT INTO `booksortlist` VALUES (4, 5);

-- ----------------------------
-- Table structure for booktopic
-- ----------------------------
DROP TABLE IF EXISTS `booktopic`;
CREATE TABLE `booktopic`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '书单ID',
  `topicName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '书单名称',
  `subTitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '副标题',
  `cover` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '封面图片路径',
  `rank` int NULL DEFAULT 0 COMMENT '排序字段',
  `put` tinyint(1) NULL DEFAULT 0 COMMENT '是否发布',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '书单信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of booktopic
-- ----------------------------
INSERT INTO `booktopic` VALUES (1, '程序员进阶书单', '从入门到大师的必经之路', '/images/topic/programmer.jpg', 1, 1);
INSERT INTO `booktopic` VALUES (2, '永恒的科幻经典', '探索宇宙的奥秘与人性的光辉', '/images/topic/scifi.jpg', 2, 1);

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账户',
  `bookId` bigint NOT NULL COMMENT '图书ID (原XML中为id)',
  `num` int NULL DEFAULT 1 COMMENT '商品数量',
  `addTime` datetime NULL DEFAULT NULL COMMENT '添加时间 (由应用提供)',
  PRIMARY KEY (`account`, `bookId`) USING BTREE,
  INDEX `idx_cart_bookId`(`bookId`) USING BTREE,
  CONSTRAINT `fk_cart_book_id` FOREIGN KEY (`bookId`) REFERENCES `book` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_cart_user_account` FOREIGN KEY (`account`) REFERENCES `user` (`account`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '购物车表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES ('testuser', 3, 1, '2025-06-06 00:04:24');
INSERT INTO `cart` VALUES ('testuser', 5, 1, '2025-06-06 00:04:24');

-- ----------------------------
-- Table structure for expense
-- ----------------------------
DROP TABLE IF EXISTS `expense`;
CREATE TABLE `expense`  (
  `orderId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单编号 (关联bookorder.orderId)',
  `productTotalMoney` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '商品总价',
  `freight` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '运费',
  `coupon` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '优惠券金额',
  `activityDiscount` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '活动优惠',
  `allPrice` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '订单总金额 (优惠前)',
  `finallyPrice` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '最终实付总额',
  PRIMARY KEY (`orderId`) USING BTREE,
  CONSTRAINT `fk_expense_bookorder_orderId` FOREIGN KEY (`orderId`) REFERENCES `bookorder` (`orderId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单费用表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of expense
-- ----------------------------
INSERT INTO `expense` VALUES ('ORD202506060001', 193.50, 5.00, 0.00, 10.00, 198.50, 188.50);

-- ----------------------------
-- Table structure for newproduct
-- ----------------------------
DROP TABLE IF EXISTS `newproduct`;
CREATE TABLE `newproduct`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '新品记录ID',
  `bookId` bigint NOT NULL COMMENT '图书ID',
  `rank` int NULL DEFAULT 0 COMMENT '新品排序',
  `addTime` datetime NULL DEFAULT NULL COMMENT '添加时间 (由应用提供)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uidx_newproduct_bookId`(`bookId`) USING BTREE,
  CONSTRAINT `fk_newproduct_book_id` FOREIGN KEY (`bookId`) REFERENCES `book` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '新品推荐表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of newproduct
-- ----------------------------
INSERT INTO `newproduct` VALUES (1, 3, 1, NULL);
INSERT INTO `newproduct` VALUES (2, 5, 2, NULL);

-- ----------------------------
-- Table structure for orderdetail
-- ----------------------------
DROP TABLE IF EXISTS `orderdetail`;
CREATE TABLE `orderdetail`  (
  `orderId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单编号 (关联bookorder.orderId)',
  `bookId` bigint NOT NULL COMMENT '图书ID',
  `num` int NOT NULL COMMENT '购买数量',
  `price` decimal(10, 2) NOT NULL COMMENT '下单时价格',
  PRIMARY KEY (`orderId`, `bookId`) USING BTREE,
  INDEX `idx_orderdetail_bookId`(`bookId`) USING BTREE,
  CONSTRAINT `fk_orderdetail_book_id` FOREIGN KEY (`bookId`) REFERENCES `book` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_orderdetail_bookorder_orderId` FOREIGN KEY (`orderId`) REFERENCES `bookorder` (`orderId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单详情表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orderdetail
-- ----------------------------
INSERT INTO `orderdetail` VALUES ('ORD202506060001', 1, 1, 118.50);
INSERT INTO `orderdetail` VALUES ('ORD202506060001', 2, 1, 75.00);

-- ----------------------------
-- Table structure for publish
-- ----------------------------
DROP TABLE IF EXISTS `publish`;
CREATE TABLE `publish`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '出版社ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '出版社名称',
  `showPublish` tinyint(1) NULL DEFAULT 1 COMMENT '是否显示',
  `rank` int NULL DEFAULT 0 COMMENT '排序字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name_UNIQUE`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '出版社信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of publish
-- ----------------------------
INSERT INTO `publish` VALUES (1, '人民文学出版社', 1, 1);
INSERT INTO `publish` VALUES (2, '机械工业出版社', 1, 2);
INSERT INTO `publish` VALUES (3, '中信出版社', 1, 3);

-- ----------------------------
-- Table structure for recommend
-- ----------------------------
DROP TABLE IF EXISTS `recommend`;
CREATE TABLE `recommend`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '推荐记录ID',
  `bookId` bigint NOT NULL COMMENT '图书ID',
  `rank` int NULL DEFAULT 0 COMMENT '推荐排序',
  `addTime` datetime NULL DEFAULT NULL COMMENT '添加时间 (由应用提供)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uidx_recommend_bookId`(`bookId`) USING BTREE,
  CONSTRAINT `fk_recommend_book_id` FOREIGN KEY (`bookId`) REFERENCES `book` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '推荐图书表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recommend
-- ----------------------------
INSERT INTO `recommend` VALUES (1, 1, 1, NULL);
INSERT INTO `recommend` VALUES (2, 2, 2, NULL);
INSERT INTO `recommend` VALUES (3, 5, 3, NULL);

-- ----------------------------
-- Table structure for subbooktopic
-- ----------------------------
DROP TABLE IF EXISTS `subbooktopic`;
CREATE TABLE `subbooktopic`  (
  `topicId` bigint NOT NULL COMMENT '书单ID',
  `bookId` bigint NOT NULL COMMENT '图书ID',
  `recommendReason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '推荐理由',
  PRIMARY KEY (`topicId`, `bookId`) USING BTREE,
  INDEX `idx_subbooktopic_bookId`(`bookId`) USING BTREE,
  CONSTRAINT `fk_subbooktopic_book_id` FOREIGN KEY (`bookId`) REFERENCES `book` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_subbooktopic_booktopic_id` FOREIGN KEY (`topicId`) REFERENCES `booktopic` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '书单与图书关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of subbooktopic
-- ----------------------------
INSERT INTO `subbooktopic` VALUES (1, 1, '硬核基础，每一位工程师都应该阅读。');
INSERT INTO `subbooktopic` VALUES (1, 3, 'Java程序员的案头必备书籍。');
INSERT INTO `subbooktopic` VALUES (1, 5, '让你不再对数据库感到恐惧。');
INSERT INTO `subbooktopic` VALUES (2, 2, '开启你对宇宙社会学的思考。');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账户 (登录名)',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户密码',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称或姓名',
  `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '性别 (如 Male, Female, Other)',
  `imgUrl` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户头像URL',
  `info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '个人简介',
  `manage` tinyint(1) NULL DEFAULT 0 COMMENT '是否为管理员',
  `enable` tinyint(1) NULL DEFAULT 1 COMMENT '账户是否启用',
  `registerTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `account_UNIQUE`(`account`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'testuser', 'password123', '张三', 'Male', '/avatars/zhangsan.png', '一位热爱阅读的普通用户。', 0, 1, '2025-06-06 00:02:00');
INSERT INTO `user` VALUES (2, 'admin', 'admin123', '李四', 'Female', '/avatars/lisi.png', '书店管理员。', 1, 1, '2025-06-06 00:02:00');
INSERT INTO `user` VALUES (100, '1@1.com', '$2a$10$o2We/czhsCDhBizkyoRdIOWNypYtGddnEvo.4VZKr0rE2pC3VJfYG', NULL, NULL, NULL, NULL, 1, 1, NULL);
INSERT INTO `user` VALUES (101, '2@2.com', '$2a$10$RhzLxRoIbJvjzXL8PNiG/.aGvZH55xEwx/JEZ4DMpJ0yHK3f8mv8G', NULL, NULL, NULL, NULL, 0, 1, NULL);

SET FOREIGN_KEY_CHECKS = 1;
