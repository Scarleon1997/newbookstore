
-- Create Database
CREATE DATABASE IF NOT EXISTS bookstore DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE bookstore;

-- Table: book
CREATE TABLE IF NOT EXISTS `book` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bookName` varchar(255) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `isbn` varchar(255) DEFAULT NULL,
  `publish` varchar(255) DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  `marketPrice` double DEFAULT NULL,
  `price` double DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `description` longtext,
  `put` tinyint(1) DEFAULT '0',
  `coverImg` varchar(255) DEFAULT NULL,
  `rank` int(11) DEFAULT '0',
  `newProduct` tinyint(1) DEFAULT '0',
  `recommend` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `isbn` (`isbn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table: bookimg
CREATE TABLE IF NOT EXISTS `bookimg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `isbn` varchar(255) DEFAULT NULL,
  `imgSrc` varchar(255) DEFAULT NULL,
  `cover` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table: booksort
CREATE TABLE IF NOT EXISTS `booksort` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sortName` varchar(255) DEFAULT NULL,
  `upperName` varchar(255) DEFAULT NULL,
  `level` varchar(255) DEFAULT NULL,
  `rank` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table: booksortlist
CREATE TABLE IF NOT EXISTS `booksortlist` (
  `bookSortId` int(11) NOT NULL,
  `bookId` int(11) NOT NULL,
  PRIMARY KEY (`bookSortId`,`bookId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table: booktopic
CREATE TABLE IF NOT EXISTS `booktopic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `topicName` varchar(255) DEFAULT NULL,
  `subTitle` varchar(255) DEFAULT NULL,
  `cover` varchar(255) DEFAULT NULL,
  `rank` int(11) DEFAULT '0',
  `put` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table: publish
CREATE TABLE IF NOT EXISTS `publish` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `showPublish` tinyint(1) DEFAULT '1',
  `rank` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table: recommend
CREATE TABLE IF NOT EXISTS `recommend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bookId` int(11) DEFAULT NULL,
  `rank` int(11) DEFAULT '0',
  `addTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table: newproduct
CREATE TABLE IF NOT EXISTS `newproduct` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bookId` int(11) DEFAULT NULL,
  `rank` int(11) DEFAULT '0',
  `addTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table: subbooktopic
CREATE TABLE IF NOT EXISTS `subbooktopic` (
  `topicId` int(11) NOT NULL,
  `bookId` int(11) NOT NULL,
  `recommendReason` text,
  PRIMARY KEY (`topicId`,`bookId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table: address
CREATE TABLE IF NOT EXISTS `address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `addr` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `off` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table: cart
CREATE TABLE IF NOT EXISTS `cart` (
  `account` varchar(255) NOT NULL,
  `id` int(11) NOT NULL,
  `num` int(11) DEFAULT '1',
  `addTime` datetime DEFAULT NULL,
  PRIMARY KEY (`account`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table: user
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `imgUrl` varchar(255) DEFAULT NULL,
  `info` text,
  `manage` tinyint(1) DEFAULT '0',
  `enable` tinyint(1) DEFAULT '1',
  `registerTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account` (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table: bookorder (mapped to Order entity, assuming table name is bookorder based on convention or XML check needed)
-- Checked OrderMapper.xml (not read yet, but assuming standard name or 'orders' or 'bookorder')
-- Let's check OrderMapper.xml if possible, otherwise guess. 
-- In the user provided grep output earlier: "insert into bookorder(orderId..."
-- So table name is `bookorder`.
CREATE TABLE IF NOT EXISTS `bookorder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderId` varchar(255) NOT NULL,
  `account` varchar(255) DEFAULT NULL,
  `addressId` int(11) DEFAULT NULL,
  `orderTime` datetime DEFAULT NULL,
  `shipTime` datetime DEFAULT NULL,
  `getTime` datetime DEFAULT NULL,
  `evaluateTime` datetime DEFAULT NULL,
  `closeTime` datetime DEFAULT NULL,
  `confirmTime` datetime DEFAULT NULL,
  `orderStatus` varchar(50) DEFAULT NULL,
  `logisticsCompany` int(11) DEFAULT NULL,
  `logisticsNum` varchar(255) DEFAULT NULL,
  `beUserDelete` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `orderId` (`orderId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table: orderdetail
CREATE TABLE IF NOT EXISTS `orderdetail` (
  `orderId` varchar(255) NOT NULL,
  `bookId` int(11) NOT NULL,
  `num` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL,
  PRIMARY KEY (`orderId`,`bookId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table: coupon
CREATE TABLE IF NOT EXISTS `coupon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `issuesNum` int(11) DEFAULT NULL,
  `issuesTime` datetime DEFAULT NULL,
  `money` double DEFAULT NULL,
  `limitNum` int(11) DEFAULT NULL,
  `thresholdMoney` int(11) DEFAULT NULL,
  `startTime` datetime DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `range` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table: usercoupon
CREATE TABLE IF NOT EXISTS `usercoupon` (
  `account` varchar(255) NOT NULL,
  `couponId` int(11) NOT NULL,
  PRIMARY KEY (`account`,`couponId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table: expense
CREATE TABLE IF NOT EXISTS `expense` (
  `orderId` varchar(255) NOT NULL,
  `productTotalMoney` double DEFAULT NULL,
  `freight` double DEFAULT NULL,
  `coupon` int(11) DEFAULT '0',
  `activityDiscount` double DEFAULT '0',
  `allPrice` double DEFAULT NULL,
  `finallyPrice` double DEFAULT NULL,
  PRIMARY KEY (`orderId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Insert default admin user
-- Password should be encrypted, but for now insert clear text or placeholder.
-- Assuming Spring Security uses BCrypt. 
-- For testing, we can insert a user with known password if we knew the encryption.
-- '123456' encoded with BCrypt is usually $2a$10$....
-- Let's just create the table structure.

