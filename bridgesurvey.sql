-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 20 Bulan Mei 2019 pada 17.03
-- Versi server: 10.1.36-MariaDB
-- Versi PHP: 7.2.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bridgesurvey`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `answer`
--

CREATE TABLE `answer` (
  `answer_id` int(11) NOT NULL,
  `sistem_id` int(255) DEFAULT NULL,
  `komponen_id` int(255) DEFAULT NULL,
  `subKomponen_id` int(255) DEFAULT NULL,
  `surveyor_id` int(255) DEFAULT NULL,
  `bridge_id` int(11) DEFAULT NULL,
  `kerusakan` varchar(255) DEFAULT NULL,
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
  `IKS` double(255,3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `answer`
--

INSERT INTO `answer` (`answer_id`, `sistem_id`, `komponen_id`, `subKomponen_id`, `surveyor_id`, `bridge_id`, `kerusakan`, `interval_kerusakan`, `luasan`, `luasan2`, `nilai_pengurang`, `faktor_koreksi`, `faktor_nilai1`, `faktor_nilai2`, `bobot_komponen`, `IKSK`, `IKUS`, `IKKJ`, `IKS`) VALUES
(1, 1, 3, 5, 2, 2, 'Berkarat, Lumut', '3', 10.000, 5.000, '3', 0.700, 0.200, 0.500, 0.650, 2.100, 0.840, 1.680, 1.092),
(2, 2, 15, 71, 1, 7, 'Korosi, Berongga', '4', 9.000, 5.000, '4', 0.600, 0.400, 0.200, 0.700, 2.400, 4.800, 8.640, 6.048),
(3, 1, 3, 8, 1, 10, 'Retak, Pelapukan', '2', 4.000, 6.000, '2', 0.800, 0.400, 0.100, 1.000, 1.600, 6.400, 4.270, 4.270),
(4, 1, 5, 16, 2, 12, 'Perubahan Bentuk, Hilangnya Bahan', '3', 10.000, 15.000, '3', 0.750, 0.250, 0.400, 0.800, 2.250, 1.406, 0.938, 0.750);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `answer_views`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `answer_views` (
`answer_id` int(11)
,`sistem_id` int(255)
,`komponen_id` int(255)
,`subKomponen_id` int(255)
,`surveyor_id` int(255)
,`bridge_id` int(11)
,`kerusakan` varchar(255)
,`interval_kerusakan` enum('1','2','3','4','5')
,`luasan` double(255,3)
,`luasan2` double(255,3)
,`nilai_pengurang` enum('1','2','3','4','5')
,`faktor_koreksi` double(255,3)
,`faktor_nilai1` double(255,3)
,`faktor_nilai2` double(255,3)
,`bobot_komponen` double(255,3)
,`IKSK` double(255,3)
,`IKUS` double(255,3)
,`IKKJ` double(255,3)
,`IKS` double(255,3)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `bridge`
--

CREATE TABLE `bridge` (
  `bridge_id` int(11) NOT NULL,
  `bridge_name` varchar(255) NOT NULL,
  `bridge_location` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `bridge`
--

INSERT INTO `bridge` (`bridge_id`, `bridge_name`, `bridge_location`) VALUES
(1, 'Jembatan PascaSarjana UGM', 'Pascasarjana UGM'),
(2, 'Jembatan Baru UGM', 'Jl. MOnjali'),
(3, 'Jembatan Ampera', 'Sumatera Selatan'),
(4, 'Jembatan Barito', 'Banjarmasin, Kalimantan Selatan'),
(5, 'Jembatan Rantau Berangin', 'Kampar, Provinsi Riau'),
(6, 'Jembatan Tukad Bangkung', 'Badung, Bali'),
(7, 'Jembatan Pasar Ayam', 'DKI Jakarta'),
(8, 'Jembatan Javasche Bank', 'DKI Jakarta'),
(9, 'Jembatan Suramadu', 'Surabaya, Jawa Timur'),
(10, 'Jembatan Siti Nurbaya', 'Padang, Sumatra Barat'),
(11, 'Jembatan Barelang', 'Batam, Kepulauan Riau'),
(12, 'Jembatan Pasupati', 'Bandung, Jawa Barat');

-- --------------------------------------------------------

--
-- Struktur dari tabel `komponen`
--

CREATE TABLE `komponen` (
  `komponen_id` int(11) NOT NULL,
  `komponen_name` varchar(255) DEFAULT NULL,
  `sistem_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `komponen`
--

INSERT INTO `komponen` (`komponen_id`, `komponen_name`, `sistem_id`) VALUES
(1, 'GelagarUtama', 1),
(2, 'GelagarSekunder', 1),
(3, 'IkatanAngin', 1),
(4, 'JembatanPlat', 1),
(5, 'Pelangkung', 1),
(6, 'BalokPelengkung', 1),
(7, 'Rangka', 1),
(8, 'DudukanJembatan', 1),
(9, 'Tumpuan', 1),
(10, 'DindingSayapJembatan', 1),
(11, 'JembatanGantung', 1),
(12, 'SistemLantai', 1),
(13, 'SiarMuai', 1),
(14, 'Landasan/Peletakan', 1),
(15, 'Pondasi', 2),
(16, 'KepalaJembatan', 2),
(17, 'Aliran/Sungai', 3),
(18, 'BangunanPengaman', 3),
(19, 'TanahTimbunan', 3),
(20, 'Pelengkap', 4);

-- --------------------------------------------------------

--
-- Struktur dari tabel `sistem`
--

CREATE TABLE `sistem` (
  `sistem_id` int(10) NOT NULL,
  `sistem_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `sistem`
--

INSERT INTO `sistem` (`sistem_id`, `sistem_name`) VALUES
(1, 'BangunanAtas'),
(2, 'BangunanBawah'),
(3, 'Aliran'),
(4, 'Pelengkap'),
(7, 'tambahan');

-- --------------------------------------------------------

--
-- Struktur dari tabel `subkomponen`
--

CREATE TABLE `subkomponen` (
  `subKomponen_id` int(11) NOT NULL,
  `subKomponen_name` varchar(255) DEFAULT NULL,
  `komponen_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `subkomponen`
--

INSERT INTO `subkomponen` (`subKomponen_id`, `subKomponen_name`, `komponen_id`) VALUES
(1, 'LapisanPelindung', 1),
(2, 'GelagarInduk', 1),
(3, 'Sambungan', 1),
(4, 'LapisanPelindung', 2),
(5, 'GelagarMelintang', 2),
(6, 'Sambungan', 2),
(7, 'LapisanPelindung', 3),
(8, 'IkatanAnginPrimer', 3),
(9, 'Sambungan', 3),
(10, 'LapisPelindung', 3),
(11, 'IkatanAnginSekunder', 3),
(12, 'PlatBetonBertulang', 4),
(13, 'PlatBalokPracetak', 4),
(14, 'PlatBalokPrategang', 4),
(15, 'BagianPelengkung', 5),
(16, 'DindingTegakPelengkung', 5),
(17, 'GelagarBalokPelengkung', 6),
(18, 'BalokPelengkung', 6),
(19, 'BalokVertikal', 6),
(20, 'BalokMelintang', 6),
(21, 'BalokPengakuMendatar', 6),
(22, 'SambunganBalokPelengkung', 6),
(23, 'PanelRangka', 7),
(24, 'GelagarPenguat', 7),
(25, 'RangkaPengaku', 7),
(26, 'RakerPenyokong', 7),
(27, 'Pin Panel/sycrclip', 7),
(28, 'Clamp', 7),
(29, 'BatangTepiAtas', 8),
(30, 'BatangTepiBawah', 8),
(31, 'BatangDiagonal', 8),
(32, 'BatangVertikal', 8),
(33, 'IkatanAnginAtas', 8),
(34, 'IkatanAnginBawah', 9),
(35, 'Diafragma', 9),
(36, 'GelagarMelintang', 9),
(37, 'SambunganPlat/Bahul', 10),
(38, 'Baut', 10),
(39, 'BatangTengah', 10),
(40, 'BatangDiagonalKecil', 10),
(41, 'KabelPemikul', 11),
(42, 'KabelPenggantung', 11),
(43, 'KabelPenahanAyun', 11),
(44, 'KolomPylon', 11),
(45, 'PengakuPylon', 11),
(46, 'SadelPylon', 11),
(47, 'BalokMelintang (gantung)', 11),
(48, 'IkatanAnginBawah', 11),
(49, '(gantung)/Sambungan', 11),
(50, 'GelagarMemanjangLantai', 12),
(51, 'PlatLantai', 12),
(52, 'PlatBajaBergelombang', 12),
(53, 'BalokTepi', 12),
(54, 'JalurRodaKendaraan', 12),
(55, 'PipaCucuran', 12),
(56, 'DrainaseLantai', 12),
(57, 'LapisPermukaan', 12),
(58, 'SiarMuaiBaja', 13),
(59, 'SiarMuaiBajaProfil', 13),
(60, 'SiarMuaiKaret', 13),
(61, 'Sambungan', 13),
(62, 'PerletakanBaja', 14),
(63, 'PerletakanKaret', 14),
(64, 'PerletakanPot', 14),
(65, 'BantalanMortar/PlatDasar', 14),
(66, 'BatuPengikat', 14),
(67, 'TiangSandaran', 14),
(68, 'SandaranHorizontal', 14),
(69, 'PenunjangSandaran', 14),
(70, 'Perapet/TembokSedada', 14),
(71, 'TiangPancang', 15),
(72, 'PilarDinding/Kolom', 15),
(73, 'DindingPenahanTanahKepalaJembatanDinding/Tembok', 15),
(74, 'TembokSayap', 15),
(75, 'BalokKepala', 15),
(76, 'BalokPenahanGempa', 15),
(77, 'Penunjang/Pengaku', 15),
(78, 'PenunjangSementara', 15),
(79, 'DrainaseDinding', 15),
(80, 'TebingSungai', 16),
(81, 'AliranAirUtama', 16),
(82, 'DaerahGenanganBanjir', 16),
(83, 'KripPengarahArusSungai', 17),
(84, 'Bronjongdanmattresses	', 17),
(85, 'TaludBeton', 17),
(86, 'PasanganBatuKosong', 17),
(87, 'TurabBaja', 17),
(88, 'SistemFender', 17),
(89, 'DindingPenahanTanah', 17),
(90, 'PengamananDasarSungai', 17),
(91, 'TimbunanOprit', 18),
(92, 'DrainaseTimbunan', 18);

-- --------------------------------------------------------

--
-- Struktur dari tabel `surveyor`
--

CREATE TABLE `surveyor` (
  `surveyor_id` int(255) NOT NULL,
  `surveyor_name` varchar(255) DEFAULT NULL,
  `surveyor_work` enum('engineer','supervisor') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `surveyor`
--

INSERT INTO `surveyor` (`surveyor_id`, `surveyor_name`, `surveyor_work`) VALUES
(1, 'Fauzi', 'engineer'),
(2, 'Hafidz', 'supervisor');

-- --------------------------------------------------------

--
-- Struktur untuk view `answer_views`
--
DROP TABLE IF EXISTS `answer_views`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `answer_views`  AS  select `answer`.`answer_id` AS `answer_id`,`answer`.`sistem_id` AS `sistem_id`,`answer`.`komponen_id` AS `komponen_id`,`answer`.`subKomponen_id` AS `subKomponen_id`,`answer`.`surveyor_id` AS `surveyor_id`,`answer`.`bridge_id` AS `bridge_id`,`answer`.`kerusakan` AS `kerusakan`,`answer`.`interval_kerusakan` AS `interval_kerusakan`,`answer`.`luasan` AS `luasan`,`answer`.`luasan2` AS `luasan2`,`answer`.`nilai_pengurang` AS `nilai_pengurang`,`answer`.`faktor_koreksi` AS `faktor_koreksi`,`answer`.`faktor_nilai1` AS `faktor_nilai1`,`answer`.`faktor_nilai2` AS `faktor_nilai2`,`answer`.`bobot_komponen` AS `bobot_komponen`,`answer`.`IKSK` AS `IKSK`,`answer`.`IKUS` AS `IKUS`,`answer`.`IKKJ` AS `IKKJ`,`answer`.`IKS` AS `IKS` from `answer` ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `answer`
--
ALTER TABLE `answer`
  ADD PRIMARY KEY (`answer_id`),
  ADD KEY `sistem_name` (`sistem_id`),
  ADD KEY `komponen_name` (`komponen_id`),
  ADD KEY `subKomponen_name` (`subKomponen_id`),
  ADD KEY `surveyor_name` (`surveyor_id`),
  ADD KEY `bridge_name` (`bridge_id`);

--
-- Indeks untuk tabel `bridge`
--
ALTER TABLE `bridge`
  ADD PRIMARY KEY (`bridge_id`);

--
-- Indeks untuk tabel `komponen`
--
ALTER TABLE `komponen`
  ADD PRIMARY KEY (`komponen_id`),
  ADD KEY `sistem_id` (`sistem_id`);

--
-- Indeks untuk tabel `sistem`
--
ALTER TABLE `sistem`
  ADD PRIMARY KEY (`sistem_id`);

--
-- Indeks untuk tabel `subkomponen`
--
ALTER TABLE `subkomponen`
  ADD PRIMARY KEY (`subKomponen_id`),
  ADD KEY `komponen_id` (`komponen_id`),
  ADD KEY `subKomponen_name` (`subKomponen_name`);

--
-- Indeks untuk tabel `surveyor`
--
ALTER TABLE `surveyor`
  ADD PRIMARY KEY (`surveyor_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `answer`
--
ALTER TABLE `answer`
  MODIFY `answer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `bridge`
--
ALTER TABLE `bridge`
  MODIFY `bridge_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `komponen`
--
ALTER TABLE `komponen`
  MODIFY `komponen_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT untuk tabel `sistem`
--
ALTER TABLE `sistem`
  MODIFY `sistem_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `subkomponen`
--
ALTER TABLE `subkomponen`
  MODIFY `subKomponen_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT untuk tabel `surveyor`
--
ALTER TABLE `surveyor`
  MODIFY `surveyor_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `answer`
--
ALTER TABLE `answer`
  ADD CONSTRAINT `bridge_name` FOREIGN KEY (`bridge_id`) REFERENCES `bridge` (`bridge_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `komponen_name` FOREIGN KEY (`komponen_id`) REFERENCES `komponen` (`komponen_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sistem_name` FOREIGN KEY (`sistem_id`) REFERENCES `sistem` (`sistem_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `subKomponen_name` FOREIGN KEY (`subKomponen_id`) REFERENCES `subkomponen` (`subKomponen_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `surveyor_name` FOREIGN KEY (`surveyor_id`) REFERENCES `surveyor` (`surveyor_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `komponen`
--
ALTER TABLE `komponen`
  ADD CONSTRAINT `sistem_id` FOREIGN KEY (`sistem_id`) REFERENCES `sistem` (`sistem_id`);

--
-- Ketidakleluasaan untuk tabel `subkomponen`
--
ALTER TABLE `subkomponen`
  ADD CONSTRAINT `komponen_id` FOREIGN KEY (`komponen_id`) REFERENCES `komponen` (`komponen_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
