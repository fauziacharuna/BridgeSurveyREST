/*
 Navicat Premium Data Transfer

 Source Server         : docker-mysql
 Source Server Type    : MySQL
 Source Server Version : 50724
 Source Host           : localhost:5700
 Source Schema         : bridgesurvey

 Target Server Type    : MySQL
 Target Server Version : 50724
 File Encoding         : 65001

 Date: 23/05/2019 19:05:53
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
  `bahan` enum('Besi','Kayu','Beton','Pasangan Batu','Pasangan Bata') DEFAULT NULL,
  `interval_kerusakan` enum('1','2','3','4','5') DEFAULT NULL,
  `luasan` double(255,3) DEFAULT NULL,
  `luasan2` double(255,3) DEFAULT NULL,
  `nilai_pengurang` enum('1','2','3','4','5') DEFAULT NULL,
  `faktor_koreksi` double(255,3) DEFAULT NULL,
  `faktor_nilai1` double(255,3) DEFAULT NULL,
  `faktor_nilai2` double(255,3) DEFAULT NULL,
  `bobot_komponen` double(255,3) DEFAULT NULL,
  `IKSK` double(255,3) DEFAULT NULL,
  `IKUS` double(255,3) DEFAULT NULL,
  `IKKJ` double(255,3) DEFAULT NULL,
  `IKS` double(255,3) DEFAULT NULL,
  PRIMARY KEY (`answer_id`),
  KEY `sistem_name` (`sistem_id`),
  KEY `komponen_name` (`komponen_id`),
  KEY `subKomponen_name` (`subKomponen_id`),
  KEY `surveyor_name` (`surveyor_id`),
  KEY `bridge_name` (`bridge_id`),
  CONSTRAINT `bridge_name` FOREIGN KEY (`bridge_id`) REFERENCES `bridge` (`bridge_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `komponen_name` FOREIGN KEY (`komponen_id`) REFERENCES `komponen` (`komponen_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sistem_name` FOREIGN KEY (`sistem_id`) REFERENCES `sistem` (`sistem_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `subKomponen_name` FOREIGN KEY (`subKomponen_id`) REFERENCES `subkomponen` (`subKomponen_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `surveyor_name` FOREIGN KEY (`surveyor_id`) REFERENCES `surveyor` (`surveyor_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of answer
-- ----------------------------
BEGIN;
INSERT INTO `answer` VALUES (2, 2, 15, 71, 1, 7, 'Korosi, Berongga', NULL, '4', 9.000, 5.000, '4', 0.600, 0.400, 0.200, 0.700, 2.400, 4.800, 8.640, 6.048);
INSERT INTO `answer` VALUES (3, 1, 3, 8, 1, 10, 'Retak, Pelapukan', NULL, '2', 4.000, 6.000, '2', 0.800, 0.400, 0.100, 1.000, 1.600, 6.400, 4.270, 4.270);
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of bridge
-- ----------------------------
BEGIN;
INSERT INTO `bridge` VALUES (1, 'Jembatan PascaSarjana UGM', 'Pascasarjana UGM');
INSERT INTO `bridge` VALUES (2, 'Jembatan Baru UGM', 'Jl. MOnjali');
INSERT INTO `bridge` VALUES (3, 'Jembatan Ampera', 'Sumatera Selatan');
INSERT INTO `bridge` VALUES (4, 'Jembatan Barito', 'Banjarmasin, Kalimantan Selatan');
INSERT INTO `bridge` VALUES (5, 'Jembatan Rantau Berangin', 'Kampar, Provinsi Riau');
INSERT INTO `bridge` VALUES (6, 'Jembatan Tukad Bangkung', 'Badung, Bali');
INSERT INTO `bridge` VALUES (7, 'Jembatan Pasar Ayam', 'DKI Jakarta');
INSERT INTO `bridge` VALUES (8, 'Jembatan Javasche Bank', 'DKI Jakarta');
INSERT INTO `bridge` VALUES (9, 'Jembatan Suramadu', 'Surabaya, Jawa Timur');
INSERT INTO `bridge` VALUES (10, 'Jembatan Siti Nurbaya', 'Padang, Sumatra Barat');
INSERT INTO `bridge` VALUES (11, 'Jembatan Barelang', 'Batam, Kepulauan Riau');
INSERT INTO `bridge` VALUES (12, 'Jembatan Pasupati', 'Bandung, Jawa Barat');
INSERT INTO `bridge` VALUES (13, 'test', 'test');
INSERT INTO `bridge` VALUES (14, 'test', 'test');
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
-- Table structure for subkomponen
-- ----------------------------
DROP TABLE IF EXISTS `subkomponen`;
CREATE TABLE `subkomponen` (
  `subKomponen_id` int(11) NOT NULL AUTO_INCREMENT,
  `subKomponen_name` varchar(255) DEFAULT NULL,
  `komponen_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`subKomponen_id`),
  KEY `komponen_id` (`komponen_id`),
  KEY `subKomponen_name` (`subKomponen_name`),
  CONSTRAINT `komponen_id` FOREIGN KEY (`komponen_id`) REFERENCES `komponen` (`komponen_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of subkomponen
-- ----------------------------
BEGIN;
INSERT INTO `subkomponen` VALUES (1, 'LapisanPelindung', 1);
INSERT INTO `subkomponen` VALUES (2, 'GelagarInduk', 1);
INSERT INTO `subkomponen` VALUES (3, 'Sambungan', 1);
INSERT INTO `subkomponen` VALUES (4, 'LapisanPelindung', 2);
INSERT INTO `subkomponen` VALUES (5, 'GelagarMelintang', 2);
INSERT INTO `subkomponen` VALUES (6, 'Sambungan', 2);
INSERT INTO `subkomponen` VALUES (7, 'LapisanPelindung', 3);
INSERT INTO `subkomponen` VALUES (8, 'IkatanAnginPrimer', 3);
INSERT INTO `subkomponen` VALUES (9, 'Sambungan', 3);
INSERT INTO `subkomponen` VALUES (10, 'LapisPelindung', 3);
INSERT INTO `subkomponen` VALUES (11, 'IkatanAnginSekunder', 3);
INSERT INTO `subkomponen` VALUES (12, 'PlatBetonBertulang', 4);
INSERT INTO `subkomponen` VALUES (13, 'PlatBalokPracetak', 4);
INSERT INTO `subkomponen` VALUES (14, 'PlatBalokPrategang', 4);
INSERT INTO `subkomponen` VALUES (15, 'BagianPelengkung', 5);
INSERT INTO `subkomponen` VALUES (16, 'DindingTegakPelengkung', 5);
INSERT INTO `subkomponen` VALUES (17, 'GelagarBalokPelengkung', 6);
INSERT INTO `subkomponen` VALUES (18, 'BalokPelengkung', 6);
INSERT INTO `subkomponen` VALUES (19, 'BalokVertikal', 6);
INSERT INTO `subkomponen` VALUES (20, 'BalokMelintang', 6);
INSERT INTO `subkomponen` VALUES (21, 'BalokPengakuMendatar', 6);
INSERT INTO `subkomponen` VALUES (22, 'SambunganBalokPelengkung', 6);
INSERT INTO `subkomponen` VALUES (23, 'PanelRangka', 7);
INSERT INTO `subkomponen` VALUES (24, 'GelagarPenguat', 7);
INSERT INTO `subkomponen` VALUES (25, 'RangkaPengaku', 7);
INSERT INTO `subkomponen` VALUES (26, 'RakerPenyokong', 7);
INSERT INTO `subkomponen` VALUES (27, 'Pin Panel/sycrclip', 7);
INSERT INTO `subkomponen` VALUES (28, 'Clamp', 7);
INSERT INTO `subkomponen` VALUES (29, 'BatangTepiAtas', 8);
INSERT INTO `subkomponen` VALUES (30, 'BatangTepiBawah', 8);
INSERT INTO `subkomponen` VALUES (31, 'BatangDiagonal', 8);
INSERT INTO `subkomponen` VALUES (32, 'BatangVertikal', 8);
INSERT INTO `subkomponen` VALUES (33, 'IkatanAnginAtas', 8);
INSERT INTO `subkomponen` VALUES (34, 'IkatanAnginBawah', 9);
INSERT INTO `subkomponen` VALUES (35, 'Diafragma', 9);
INSERT INTO `subkomponen` VALUES (36, 'GelagarMelintang', 9);
INSERT INTO `subkomponen` VALUES (37, 'SambunganPlat/Bahul', 10);
INSERT INTO `subkomponen` VALUES (38, 'Baut', 10);
INSERT INTO `subkomponen` VALUES (39, 'BatangTengah', 10);
INSERT INTO `subkomponen` VALUES (40, 'BatangDiagonalKecil', 10);
INSERT INTO `subkomponen` VALUES (41, 'KabelPemikul', 11);
INSERT INTO `subkomponen` VALUES (42, 'KabelPenggantung', 11);
INSERT INTO `subkomponen` VALUES (43, 'KabelPenahanAyun', 11);
INSERT INTO `subkomponen` VALUES (44, 'KolomPylon', 11);
INSERT INTO `subkomponen` VALUES (45, 'PengakuPylon', 11);
INSERT INTO `subkomponen` VALUES (46, 'SadelPylon', 11);
INSERT INTO `subkomponen` VALUES (47, 'BalokMelintang (gantung)', 11);
INSERT INTO `subkomponen` VALUES (48, 'IkatanAnginBawah', 11);
INSERT INTO `subkomponen` VALUES (49, '(gantung)/Sambungan', 11);
INSERT INTO `subkomponen` VALUES (50, 'GelagarMemanjangLantai', 12);
INSERT INTO `subkomponen` VALUES (51, 'PlatLantai', 12);
INSERT INTO `subkomponen` VALUES (52, 'PlatBajaBergelombang', 12);
INSERT INTO `subkomponen` VALUES (53, 'BalokTepi', 12);
INSERT INTO `subkomponen` VALUES (54, 'JalurRodaKendaraan', 12);
INSERT INTO `subkomponen` VALUES (55, 'PipaCucuran', 12);
INSERT INTO `subkomponen` VALUES (56, 'DrainaseLantai', 12);
INSERT INTO `subkomponen` VALUES (57, 'LapisPermukaan', 12);
INSERT INTO `subkomponen` VALUES (58, 'SiarMuaiBaja', 13);
INSERT INTO `subkomponen` VALUES (59, 'SiarMuaiBajaProfil', 13);
INSERT INTO `subkomponen` VALUES (60, 'SiarMuaiKaret', 13);
INSERT INTO `subkomponen` VALUES (61, 'Sambungan', 13);
INSERT INTO `subkomponen` VALUES (62, 'PerletakanBaja', 14);
INSERT INTO `subkomponen` VALUES (63, 'PerletakanKaret', 14);
INSERT INTO `subkomponen` VALUES (64, 'PerletakanPot', 14);
INSERT INTO `subkomponen` VALUES (65, 'BantalanMortar/PlatDasar', 14);
INSERT INTO `subkomponen` VALUES (66, 'BatuPengikat', 14);
INSERT INTO `subkomponen` VALUES (67, 'TiangSandaran', 14);
INSERT INTO `subkomponen` VALUES (68, 'SandaranHorizontal', 14);
INSERT INTO `subkomponen` VALUES (69, 'PenunjangSandaran', 14);
INSERT INTO `subkomponen` VALUES (70, 'Perapet/TembokSedada', 14);
INSERT INTO `subkomponen` VALUES (71, 'TiangPancang', 15);
INSERT INTO `subkomponen` VALUES (72, 'PilarDinding/Kolom', 15);
INSERT INTO `subkomponen` VALUES (73, 'DindingPenahanTanahKepalaJembatanDinding/Tembok', 15);
INSERT INTO `subkomponen` VALUES (74, 'TembokSayap', 15);
INSERT INTO `subkomponen` VALUES (75, 'BalokKepala', 15);
INSERT INTO `subkomponen` VALUES (76, 'BalokPenahanGempa', 15);
INSERT INTO `subkomponen` VALUES (77, 'Penunjang/Pengaku', 15);
INSERT INTO `subkomponen` VALUES (78, 'PenunjangSementara', 15);
INSERT INTO `subkomponen` VALUES (79, 'DrainaseDinding', 15);
INSERT INTO `subkomponen` VALUES (80, 'TebingSungai', 16);
INSERT INTO `subkomponen` VALUES (81, 'AliranAirUtama', 16);
INSERT INTO `subkomponen` VALUES (82, 'DaerahGenanganBanjir', 16);
INSERT INTO `subkomponen` VALUES (83, 'KripPengarahArusSungai', 17);
INSERT INTO `subkomponen` VALUES (84, 'Bronjongdanmattresses	', 17);
INSERT INTO `subkomponen` VALUES (85, 'TaludBeton', 17);
INSERT INTO `subkomponen` VALUES (86, 'PasanganBatuKosong', 17);
INSERT INTO `subkomponen` VALUES (87, 'TurabBaja', 17);
INSERT INTO `subkomponen` VALUES (88, 'SistemFender', 17);
INSERT INTO `subkomponen` VALUES (89, 'DindingPenahanTanah', 17);
INSERT INTO `subkomponen` VALUES (90, 'PengamananDasarSungai', 17);
INSERT INTO `subkomponen` VALUES (91, 'TimbunanOprit', 18);
INSERT INTO `subkomponen` VALUES (92, 'DrainaseTimbunan', 18);
COMMIT;

-- ----------------------------
-- Table structure for surveyor
-- ----------------------------
DROP TABLE IF EXISTS `surveyor`;
CREATE TABLE `surveyor` (
  `surveyor_id` int(255) NOT NULL AUTO_INCREMENT,
  `surveyor_name` varchar(255) DEFAULT NULL,
  `surveyor_work` enum('engineer','supervisor') DEFAULT NULL,
  PRIMARY KEY (`surveyor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of surveyor
-- ----------------------------
BEGIN;
INSERT INTO `surveyor` VALUES (1, 'fauzi', 'engineer');
INSERT INTO `surveyor` VALUES (3, 'test', 'supervisor');
INSERT INTO `surveyor` VALUES (4, 'fauzi', 'supervisor');
COMMIT;

-- ----------------------------
-- View structure for answer_views
-- ----------------------------
DROP VIEW IF EXISTS `answer_views`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `answer_views` AS select `answer`.`answer_id` AS `answer_id`,`answer`.`sistem_id` AS `sistem_id`,`answer`.`komponen_id` AS `komponen_id`,`answer`.`subKomponen_id` AS `subKomponen_id`,`answer`.`surveyor_id` AS `surveyor_id`,`answer`.`bridge_id` AS `bridge_id`,`answer`.`kerusakan` AS `kerusakan`,`answer`.`interval_kerusakan` AS `interval_kerusakan`,`answer`.`luasan` AS `luasan`,`answer`.`luasan2` AS `luasan2`,`answer`.`nilai_pengurang` AS `nilai_pengurang`,`answer`.`faktor_koreksi` AS `faktor_koreksi`,`answer`.`faktor_nilai1` AS `faktor_nilai1`,`answer`.`faktor_nilai2` AS `faktor_nilai2`,`answer`.`bobot_komponen` AS `bobot_komponen`,`answer`.`IKSK` AS `IKSK`,`answer`.`IKUS` AS `IKUS`,`answer`.`IKKJ` AS `IKKJ`,`answer`.`IKS` AS `IKS` from `answer`;

SET FOREIGN_KEY_CHECKS = 1;
