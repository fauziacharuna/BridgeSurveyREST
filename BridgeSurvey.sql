/*
 Navicat Premium Data Transfer

 Source Server         : docker-mysql
 Source Server Type    : MySQL
 Source Server Version : 50724
 Source Host           : localhost:5700
 Source Schema         : BridgeSurvey

 Target Server Type    : MySQL
 Target Server Version : 50724
 File Encoding         : 65001

 Date: 19/05/2019 00:35:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for answer
-- ----------------------------
DROP TABLE IF EXISTS `answer`;
CREATE TABLE `answer` (
  `answer_id` int(11) NOT NULL AUTO_INCREMENT,
  `sistem_id` int(255) DEFAULT NULL,
  `komponen_id` int(255) DEFAULT NULL,
  `subKomponen_id` int(255) DEFAULT NULL,
  `surveyor_id` int(255) DEFAULT NULL,
  `bridge_id` int(11) DEFAULT NULL,
  `kerusakan` varchar(255) DEFAULT NULL,
  `interval_kerusakan` enum('1','2','3','4','5') DEFAULT NULL,
  PRIMARY KEY (`answer_id`),
  KEY `sistem_name` (`sistem_id`),
  KEY `komponen_name` (`komponen_id`),
  KEY `subKomponen_name` (`subKomponen_id`),
  KEY `surveyor_name` (`surveyor_id`),
  KEY `bridge_name` (`bridge_id`),
  CONSTRAINT `bridge_name` FOREIGN KEY (`bridge_id`) REFERENCES `bridge` (`bridge_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `komponen_name` FOREIGN KEY (`komponen_id`) REFERENCES `komponen` (`komponen_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sistem_name` FOREIGN KEY (`sistem_id`) REFERENCES `sistem` (`sistem_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `subKomponen_name` FOREIGN KEY (`subKomponen_id`) REFERENCES `subKomponen` (`subKomponen_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `surveyor_name` FOREIGN KEY (`surveyor_id`) REFERENCES `surveyor` (`surveyor_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of answer
-- ----------------------------
BEGIN;
INSERT INTO `answer` VALUES (1, 1, 3, 5, 2, 2, 'Berkarat, Lumut', '3');
COMMIT;

-- ----------------------------
-- Table structure for bridge
-- ----------------------------
DROP TABLE IF EXISTS `bridge`;
CREATE TABLE `bridge` (
  `bridge_id` int(11) NOT NULL AUTO_INCREMENT,
  `bridge_name` varchar(255) NOT NULL,
  `bridge_location` varchar(255) NOT NULL,
  PRIMARY KEY (`bridge_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of bridge
-- ----------------------------
BEGIN;
INSERT INTO `bridge` VALUES (1, 'Jembatan PascaSarjana UGM', 'Pascasarjana UGM');
INSERT INTO `bridge` VALUES (2, 'Jembatan Baru UGM', 'Jl. MOnjali');
COMMIT;

-- ----------------------------
-- Table structure for komponen
-- ----------------------------
DROP TABLE IF EXISTS `komponen`;
CREATE TABLE `komponen` (
  `komponen_id` int(11) NOT NULL AUTO_INCREMENT,
  `komponen_name` varchar(255) DEFAULT NULL,
  `sistem_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`komponen_id`),
  KEY `sistem_id` (`sistem_id`),
  CONSTRAINT `sistem_id` FOREIGN KEY (`sistem_id`) REFERENCES `sistem` (`sistem_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of komponen
-- ----------------------------
BEGIN;
INSERT INTO `komponen` VALUES (1, 'GelagarUtama', 1);
INSERT INTO `komponen` VALUES (2, 'GelagarSekunder', 1);
INSERT INTO `komponen` VALUES (3, 'IkatanAngin', 1);
INSERT INTO `komponen` VALUES (4, 'JembatanPlat', 1);
INSERT INTO `komponen` VALUES (5, 'Pelangkung', 1);
INSERT INTO `komponen` VALUES (6, 'BalokPelengkung', 1);
INSERT INTO `komponen` VALUES (7, 'Rangka', 1);
INSERT INTO `komponen` VALUES (8, 'DudukanJembatan', 1);
INSERT INTO `komponen` VALUES (9, 'Tumpuan', 1);
INSERT INTO `komponen` VALUES (10, 'DindingSayapJembatan', 1);
INSERT INTO `komponen` VALUES (11, 'JembatanGantung', 1);
INSERT INTO `komponen` VALUES (12, 'SistemLantai', 1);
INSERT INTO `komponen` VALUES (13, 'SiarMuai', 1);
INSERT INTO `komponen` VALUES (14, 'Landasan/Peletakan', 1);
INSERT INTO `komponen` VALUES (15, 'Pondasi', 2);
INSERT INTO `komponen` VALUES (16, 'KepalaJembatan', 2);
INSERT INTO `komponen` VALUES (17, 'Aliran/Sungai', 3);
INSERT INTO `komponen` VALUES (18, 'BangunanPengaman', 3);
INSERT INTO `komponen` VALUES (19, 'TanahTimbunan', 3);
INSERT INTO `komponen` VALUES (20, 'Pelengkap', 4);
COMMIT;

-- ----------------------------
-- Table structure for sistem
-- ----------------------------
DROP TABLE IF EXISTS `sistem`;
CREATE TABLE `sistem` (
  `sistem_id` int(10) NOT NULL AUTO_INCREMENT,
  `sistem_name` varchar(255) NOT NULL,
  PRIMARY KEY (`sistem_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of sistem
-- ----------------------------
BEGIN;
INSERT INTO `sistem` VALUES (1, 'BangunanAtas');
INSERT INTO `sistem` VALUES (2, 'BangunanBawah');
INSERT INTO `sistem` VALUES (3, 'Aliran');
INSERT INTO `sistem` VALUES (4, 'Pelengkap');
INSERT INTO `sistem` VALUES (7, 'tambahan');
COMMIT;

-- ----------------------------
-- Table structure for subKomponen
-- ----------------------------
DROP TABLE IF EXISTS `subKomponen`;
CREATE TABLE `subKomponen` (
  `subKomponen_id` int(11) NOT NULL AUTO_INCREMENT,
  `subKomponen_name` varchar(255) DEFAULT NULL,
  `komponen_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`subKomponen_id`),
  KEY `komponen_id` (`komponen_id`),
  KEY `subKomponen_name` (`subKomponen_name`),
  CONSTRAINT `komponen_id` FOREIGN KEY (`komponen_id`) REFERENCES `komponen` (`komponen_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of subKomponen
-- ----------------------------
BEGIN;
INSERT INTO `subKomponen` VALUES (1, 'LapisanPelindung', 1);
INSERT INTO `subKomponen` VALUES (2, 'GelagarInduk', 1);
INSERT INTO `subKomponen` VALUES (3, 'Sambungan', 1);
INSERT INTO `subKomponen` VALUES (4, 'LapisanPelindung', 2);
INSERT INTO `subKomponen` VALUES (5, 'GelagarMelintang', 2);
INSERT INTO `subKomponen` VALUES (6, 'Sambungan', 2);
INSERT INTO `subKomponen` VALUES (7, 'LapisanPelindung', 3);
INSERT INTO `subKomponen` VALUES (8, 'IkatanAnginPrimer', 3);
INSERT INTO `subKomponen` VALUES (9, 'Sambungan', 3);
INSERT INTO `subKomponen` VALUES (10, 'LapisPelindung', 3);
INSERT INTO `subKomponen` VALUES (11, 'IkatanAnginSekunder', 3);
INSERT INTO `subKomponen` VALUES (12, 'PlatBetonBertulang', 4);
INSERT INTO `subKomponen` VALUES (13, 'PlatBalokPracetak', 4);
INSERT INTO `subKomponen` VALUES (14, 'PlatBalokPrategang', 4);
INSERT INTO `subKomponen` VALUES (15, 'BagianPelengkung', 5);
INSERT INTO `subKomponen` VALUES (16, 'DindingTegakPelengkung', 5);
INSERT INTO `subKomponen` VALUES (17, 'GelagarBalokPelengkung', 6);
INSERT INTO `subKomponen` VALUES (18, 'BalokPelengkung', 6);
INSERT INTO `subKomponen` VALUES (19, 'BalokVertikal', 6);
INSERT INTO `subKomponen` VALUES (20, 'BalokMelintang', 6);
INSERT INTO `subKomponen` VALUES (21, 'BalokPengakuMendatar', 6);
INSERT INTO `subKomponen` VALUES (22, 'SambunganBalokPelengkung', 6);
INSERT INTO `subKomponen` VALUES (23, 'PanelRangka', 7);
INSERT INTO `subKomponen` VALUES (24, 'GelagarPenguat', 7);
INSERT INTO `subKomponen` VALUES (25, 'RangkaPengaku', 7);
INSERT INTO `subKomponen` VALUES (26, 'RakerPenyokong', 7);
INSERT INTO `subKomponen` VALUES (27, 'Pin Panel/sycrclip', 7);
INSERT INTO `subKomponen` VALUES (28, 'Clamp', 7);
INSERT INTO `subKomponen` VALUES (29, 'BatangTepiAtas', 8);
INSERT INTO `subKomponen` VALUES (30, 'BatangTepiBawah', 8);
INSERT INTO `subKomponen` VALUES (31, 'BatangDiagonal', 8);
INSERT INTO `subKomponen` VALUES (32, 'BatangVertikal', 8);
INSERT INTO `subKomponen` VALUES (33, 'IkatanAnginAtas', 8);
INSERT INTO `subKomponen` VALUES (34, 'IkatanAnginBawah', 9);
INSERT INTO `subKomponen` VALUES (35, 'Diafragma', 9);
INSERT INTO `subKomponen` VALUES (36, 'GelagarMelintang', 9);
INSERT INTO `subKomponen` VALUES (37, 'SambunganPlat/Bahul', 10);
INSERT INTO `subKomponen` VALUES (38, 'Baut', 10);
INSERT INTO `subKomponen` VALUES (39, 'BatangTengah', 10);
INSERT INTO `subKomponen` VALUES (40, 'BatangDiagonalKecil', 10);
INSERT INTO `subKomponen` VALUES (41, 'KabelPemikul', 11);
INSERT INTO `subKomponen` VALUES (42, 'KabelPenggantung', 11);
INSERT INTO `subKomponen` VALUES (43, 'KabelPenahanAyun', 11);
INSERT INTO `subKomponen` VALUES (44, 'KolomPylon', 11);
INSERT INTO `subKomponen` VALUES (45, 'PengakuPylon', 11);
INSERT INTO `subKomponen` VALUES (46, 'SadelPylon', 11);
INSERT INTO `subKomponen` VALUES (47, 'BalokMelintang (gantung)', 11);
INSERT INTO `subKomponen` VALUES (48, 'IkatanAnginBawah', 11);
INSERT INTO `subKomponen` VALUES (49, '(gantung)/Sambungan', 11);
INSERT INTO `subKomponen` VALUES (50, 'GelagarMemanjangLantai', 12);
INSERT INTO `subKomponen` VALUES (51, 'PlatLantai', 12);
INSERT INTO `subKomponen` VALUES (52, 'PlatBajaBergelombang', 12);
INSERT INTO `subKomponen` VALUES (53, 'BalokTepi', 12);
INSERT INTO `subKomponen` VALUES (54, 'JalurRodaKendaraan', 12);
INSERT INTO `subKomponen` VALUES (55, 'PipaCucuran', 12);
INSERT INTO `subKomponen` VALUES (56, 'DrainaseLantai', 12);
INSERT INTO `subKomponen` VALUES (57, 'LapisPermukaan', 12);
INSERT INTO `subKomponen` VALUES (58, 'SiarMuaiBaja', 13);
INSERT INTO `subKomponen` VALUES (59, 'SiarMuaiBajaProfil', 13);
INSERT INTO `subKomponen` VALUES (60, 'SiarMuaiKaret', 13);
INSERT INTO `subKomponen` VALUES (61, 'Sambungan', 13);
INSERT INTO `subKomponen` VALUES (62, 'PerletakanBaja', 14);
INSERT INTO `subKomponen` VALUES (63, 'PerletakanKaret', 14);
INSERT INTO `subKomponen` VALUES (64, 'PerletakanPot', 14);
INSERT INTO `subKomponen` VALUES (65, 'BantalanMortar/PlatDasar', 14);
INSERT INTO `subKomponen` VALUES (66, 'BatuPengikat', 14);
INSERT INTO `subKomponen` VALUES (67, 'TiangSandaran', 14);
INSERT INTO `subKomponen` VALUES (68, 'SandaranHorizontal', 14);
INSERT INTO `subKomponen` VALUES (69, 'PenunjangSandaran', 14);
INSERT INTO `subKomponen` VALUES (70, 'Perapet/TembokSedada', 14);
INSERT INTO `subKomponen` VALUES (71, 'TiangPancang', 15);
INSERT INTO `subKomponen` VALUES (72, 'PilarDinding/Kolom', 15);
INSERT INTO `subKomponen` VALUES (73, 'DindingPenahanTanahKepalaJembatanDinding/Tembok', 15);
INSERT INTO `subKomponen` VALUES (74, 'TembokSayap', 15);
INSERT INTO `subKomponen` VALUES (75, 'BalokKepala', 15);
INSERT INTO `subKomponen` VALUES (76, 'BalokPenahanGempa', 15);
INSERT INTO `subKomponen` VALUES (77, 'Penunjang/Pengaku', 15);
INSERT INTO `subKomponen` VALUES (78, 'PenunjangSementara', 15);
INSERT INTO `subKomponen` VALUES (79, 'DrainaseDinding', 15);
INSERT INTO `subKomponen` VALUES (80, 'TebingSungai', 16);
INSERT INTO `subKomponen` VALUES (81, 'AliranAirUtama', 16);
INSERT INTO `subKomponen` VALUES (82, 'DaerahGenanganBanjir', 16);
INSERT INTO `subKomponen` VALUES (83, 'KripPengarahArusSungai', 17);
INSERT INTO `subKomponen` VALUES (84, 'Bronjongdanmattresses	', 17);
INSERT INTO `subKomponen` VALUES (85, 'TaludBeton', 17);
INSERT INTO `subKomponen` VALUES (86, 'PasanganBatuKosong', 17);
INSERT INTO `subKomponen` VALUES (87, 'TurabBaja', 17);
INSERT INTO `subKomponen` VALUES (88, 'SistemFender', 17);
INSERT INTO `subKomponen` VALUES (89, 'DindingPenahanTanah', 17);
INSERT INTO `subKomponen` VALUES (90, 'PengamananDasarSungai', 17);
INSERT INTO `subKomponen` VALUES (91, 'TimbunanOprit', 18);
INSERT INTO `subKomponen` VALUES (92, 'DrainaseTimbunan', 18);
COMMIT;

-- ----------------------------
-- Table structure for survey
-- ----------------------------
DROP TABLE IF EXISTS `survey`;
CREATE TABLE `survey` (
  `survey_id` int(10) NOT NULL AUTO_INCREMENT,
  `engineer_name` varchar(255) DEFAULT NULL,
  `bridge_name` varchar(255) DEFAULT NULL,
  `bridge_location` varchar(255) DEFAULT NULL,
  `sub_komponen` varchar(255) DEFAULT NULL,
  `komponen` varchar(255) DEFAULT NULL,
  `sistem` varchar(255) DEFAULT NULL,
  `bahan` varchar(255) DEFAULT NULL,
  `kerusakan` varchar(255) DEFAULT NULL,
  `interval_kerusakan` varchar(255) DEFAULT NULL,
  `luasan` int(255) DEFAULT NULL,
  `nilai_pengurang` int(255) DEFAULT NULL,
  `faktor_koreksi` int(255) DEFAULT NULL,
  `faktor_nilai` int(255) DEFAULT NULL,
  `bobot_komponen` varchar(255) DEFAULT NULL,
  `IKSK` int(255) DEFAULT NULL,
  `IKUS` int(255) DEFAULT NULL,
  `IKKJ` int(255) DEFAULT NULL,
  `IKS` int(255) DEFAULT NULL,
  PRIMARY KEY (`survey_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for surveyor
-- ----------------------------
DROP TABLE IF EXISTS `surveyor`;
CREATE TABLE `surveyor` (
  `surveyor_id` int(255) NOT NULL AUTO_INCREMENT,
  `surveyor_name` varchar(255) DEFAULT NULL,
  `surveyor_work` enum('engineer','supervisor') DEFAULT NULL,
  PRIMARY KEY (`surveyor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of surveyor
-- ----------------------------
BEGIN;
INSERT INTO `surveyor` VALUES (1, 'Fauzi', 'engineer');
INSERT INTO `surveyor` VALUES (2, 'Hafidz', 'supervisor');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
