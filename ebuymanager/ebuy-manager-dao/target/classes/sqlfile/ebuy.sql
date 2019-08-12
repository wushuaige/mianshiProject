/*
 Navicat MySQL Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 100315
 Source Host           : localhost:3306
 Source Schema         : ebuy

 Target Server Type    : MySQL
 Target Server Version : 100315
 File Encoding         : 65001

 Date: 11/08/2019 13:49:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_content
-- ----------------------------
DROP TABLE IF EXISTS `tb_content`;
CREATE TABLE `tb_content`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) NOT NULL COMMENT '内容类目ID',
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内容标题',
  `sub_title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '子标题',
  `title_desc` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT ' 标题描述',
  `url` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '链接',
  `pic` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片绝对路径',
  `pic2` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片2',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `created` datetime(0) NULL DEFAULT NULL,
  `updated` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_content_category
-- ----------------------------
DROP TABLE IF EXISTS `tb_content_category`;
CREATE TABLE `tb_content_category`  (
  `id` bigint(20) NOT NULL COMMENT '类目id',
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '父类木Id=0时，代表的是一级类目',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '分类名称',
  `status` int(1) NULL DEFAULT 1 COMMENT '状态：可选1-正常2-删除',
  `sort_order` int(4) NULL DEFAULT NULL COMMENT '排列序号表示同级类目的展现次序，如数值相等则按名称次序排列。取值范围：大于零的整数',
  `is_parent` tinyint(1) NULL DEFAULT 1 COMMENT '该类目是否为父类目，1为true，2为false',
  `created` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_item
-- ----------------------------
DROP TABLE IF EXISTS `tb_item`;
CREATE TABLE `tb_item`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '商品id，同时也是商品编号',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品标题',
  `sell_point` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品卖点',
  `price` bigint(20) NOT NULL COMMENT '商品价格，单位：分',
  `num` int(10) NOT NULL COMMENT '库存数量',
  `barcode` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品条形码',
  `image` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `cid` bigint(10) NOT NULL COMMENT '所属类目，叶子类目',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '商品状态，1-正常，2-下架，3-删除',
  `created` datetime(0) NOT NULL COMMENT '创建时间',
  `updated` datetime(0) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '商品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_item_cat
-- ----------------------------
DROP TABLE IF EXISTS `tb_item_cat`;
CREATE TABLE `tb_item_cat`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '类目ID',
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '父类目ID=0时，代表的是一级的类目',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类目名称',
  `status` int(1) NULL DEFAULT 1 COMMENT '状态。可选值：1-正常，2-删除',
  `sort_order` int(4) NULL DEFAULT NULL COMMENT '排列序号，表示统计类目的展现次序，如数值相等则按名称次序排列。取值范围：大于零的整数',
  `is_parent` tinyint(1) NULL DEFAULT 1 COMMENT '该类目是否为父类目，1为true，0为false',
  `created` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '商品类目' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_item_desc
-- ----------------------------
DROP TABLE IF EXISTS `tb_item_desc`;
CREATE TABLE `tb_item_desc`  (
  `item_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '商品Id',
  `item_desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '商品描述',
  `created` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`item_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '商品描述表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_item_param
-- ----------------------------
DROP TABLE IF EXISTS `tb_item_param`;
CREATE TABLE `tb_item_param`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `item_cat_id` bigint(20) NULL DEFAULT NULL COMMENT '商品类目Id',
  `param_data` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '参数数据，格式为json格式',
  `created` datetime(0) NULL DEFAULT NULL,
  `updated` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '商品规则参数' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_item_param_item
-- ----------------------------
DROP TABLE IF EXISTS `tb_item_param_item`;
CREATE TABLE `tb_item_param_item`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `item_id` bigint(20) NULL DEFAULT NULL COMMENT '商品Id',
  `param_data` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '参数数据，格式为json格式',
  `created` datetime(0) NULL DEFAULT NULL,
  `updated` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '商品规格和商品的关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_order
-- ----------------------------
DROP TABLE IF EXISTS `tb_order`;
CREATE TABLE `tb_order`  (
  `order_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '订单id',
  `payment` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '实付金额，精确到2位小数；单位：元；如：200.07，表示200元7分',
  `payment_type` int(2) NULL DEFAULT NULL COMMENT '支付类型：1-在线支付，2-货到付款',
  `post_fee` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '邮费。精确到2位小数，单位：元；如：200.07，表示200元7分',
  `status` int(10) NULL DEFAULT NULL COMMENT '状态：1-未付款2-已付款3-未发货4-已发货5-交易成功6-交易关闭',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '订单创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '订单更新时间',
  `payment_time` datetime(0) NULL DEFAULT NULL COMMENT '付款时间',
  `consign_time` datetime(0) NULL DEFAULT NULL COMMENT '发货时间',
  `end_time` datetime(0) NULL DEFAULT NULL COMMENT '交易完成时间',
  `close_time` datetime(0) NULL DEFAULT NULL COMMENT '交易关闭时间',
  `shipping_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '物流名称',
  `shipping_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '物流单号',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `buyer_message` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '买家留言',
  `buyer_nick` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '买家昵称',
  `buyer_rete` int(2) NULL DEFAULT NULL COMMENT '买家是否已经评价',
  PRIMARY KEY (`order_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_order_item
-- ----------------------------
DROP TABLE IF EXISTS `tb_order_item`;
CREATE TABLE `tb_order_item`  (
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `item_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '商品id',
  `order_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '订单id',
  `num` int(10) NULL DEFAULT NULL COMMENT '商品购买数量',
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '商品标题',
  `price` bigint(50) NULL DEFAULT NULL COMMENT '商品单价',
  `total_fee` bigint(50) NULL DEFAULT NULL COMMENT '商品总金额',
  `pic_path` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '商品图片地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_order_shipping
-- ----------------------------
DROP TABLE IF EXISTS `tb_order_shipping`;
CREATE TABLE `tb_order_shipping`  (
  `order_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '订单id',
  `receiver_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '收货人全名',
  `receiver_phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '固定电话',
  `receiver_mobile` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '移动电话',
  `receiver_state` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '省份',
  `receiver_city` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '城市',
  `receiver_district` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '区/县',
  `receiver_address` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '收货地址。如：xx鲁xx号',
  `receiver_zip` varchar(6) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '邮政编号，如：310001',
  `created` datetime(0) NULL DEFAULT NULL,
  `updated` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`order_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码，加密存储',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '注册手机号',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '注册邮箱',
  `created` datetime(0) NOT NULL,
  `updated` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '用户表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
