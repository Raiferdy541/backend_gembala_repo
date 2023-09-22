-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 19 Sep 2023 pada 10.42
-- Versi server: 10.3.38-MariaDB-0ubuntu0.20.04.1
-- Versi PHP: 7.4.3-4ubuntu2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `breeding_db`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `auth_users`
--

CREATE TABLE `auth_users` (
  `id_user` int(11) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `nama_pengguna` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `nomor_telepon` varchar(255) DEFAULT NULL,
  `kata_sandi` varchar(255) NOT NULL,
  `role` enum('superadmin','admin','bod') NOT NULL DEFAULT 'admin',
  `status` enum('active','inactive') NOT NULL DEFAULT 'inactive',
  `id_peternakan` int(11) DEFAULT NULL,
  `lastAccess` datetime DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `auth_users`
--

INSERT INTO `auth_users` (`id_user`, `image`, `nama_pengguna`, `email`, `nomor_telepon`, `kata_sandi`, `role`, `status`, `id_peternakan`, `lastAccess`, `createdAt`, `updatedAt`) VALUES
(3, NULL, 'superadmin', 'superadmin@email.com', '081315372263', '$2b$10$qYZn6QMrFDuAN28hT5Fwh.1uDdhZlxNPaTVLvWKtCcrM3gyZeaHYe', 'superadmin', 'active', NULL, '2023-09-15 06:20:42', '2022-12-06 03:19:51', '2023-09-15 06:20:42'),
(4, NULL, 'sinergi', 'admin1@email.com', '081315372231', '$2b$10$EImUpBVoslRNeZ3S5e5As.vbCeBG2TKeZ3yVyGiwYngJqj8enHWpe', 'admin', 'active', 1, '2023-09-18 10:43:02', '2022-12-06 03:19:51', '2023-09-18 10:43:02'),
(5, 'avatar-3-1670810300918-820131057-Screenshot (379).png', 'admin2', 'admin2@email.com', '081315372232', '$2b$10$GCAo3HijIa5BNynNrIUDA.IQqqAViPqjNcByCJD.CiWjdbVIxF/n.', 'admin', 'active', 2, '2023-07-25 00:56:27', '2022-12-06 03:19:51', '2023-07-25 00:56:27');

-- --------------------------------------------------------

--
-- Struktur dari tabel `d_adaptasi`
--

CREATE TABLE `d_adaptasi` (
  `id_adaptasi` int(11) NOT NULL,
  `id_peternakan` int(11) NOT NULL,
  `id_ternak` int(11) NOT NULL,
  `id_treatment` int(11) NOT NULL,
  `id_kandang` int(11) DEFAULT NULL,
  `tanggal_adaptasi` datetime NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `d_bahan_pakan`
--

CREATE TABLE `d_bahan_pakan` (
  `id_bahan_pakan` int(11) NOT NULL,
  `id_peternakan` int(11) NOT NULL,
  `id_jenis_bahan_pakan` int(11) NOT NULL,
  `tanggal` datetime NOT NULL DEFAULT current_timestamp(),
  `jumlah` int(11) NOT NULL,
  `keterangan` enum('Masuk','Keluar') NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `d_bangsa`
--

CREATE TABLE `d_bangsa` (
  `id_bangsa` int(11) NOT NULL,
  `bangsa` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `d_bangsa`
--

INSERT INTO `d_bangsa` (`id_bangsa`, `bangsa`, `createdAt`, `updatedAt`) VALUES
(1, 'Garut', '2023-05-12 16:37:02', '2023-05-12 16:37:02'),
(2, 'Texel', '2023-05-12 16:37:02', '2023-05-12 16:37:02'),
(3, 'Texel Cross', '2023-05-12 16:37:02', '2023-05-12 16:37:02'),
(4, 'Dorper', '2023-05-12 16:37:02', '2023-05-12 16:37:02'),
(5, 'Merino', '2023-05-12 16:37:02', '2023-05-12 16:37:02'),
(6, 'Dombos', '2023-05-12 16:37:02', '2023-05-12 16:37:02'),
(7, 'Ekor Tipis', '2023-05-12 16:37:02', '2023-05-12 16:37:02'),
(8, 'Ekor Gemuk', '2023-05-12 16:37:02', '2023-05-12 16:37:02'),
(9, 'Batur', '2023-05-12 16:37:02', '2023-05-12 16:37:02'),
(10, 'St. Croix', '2023-05-12 16:37:02', '2023-05-12 16:37:02'),
(11, 'Suffolk', '2023-05-12 16:37:03', '2023-05-12 16:37:03'),
(12, 'Barbados Blackbelly', '2023-05-12 16:37:03', '2023-05-12 16:37:03'),
(13, 'Kisar', '2023-05-12 16:37:03', '2023-05-12 16:37:03'),
(14, 'Donggala', '2023-05-12 16:37:03', '2023-05-12 16:37:03'),
(15, 'Indramayu', '2023-05-12 16:37:03', '2023-05-12 16:37:03'),
(16, 'Jonggol', '2023-05-12 16:37:03', '2023-05-12 16:37:03'),
(17, 'Rote', '2023-05-12 16:37:03', '2023-05-12 16:37:03'),
(18, 'Dorset', '2023-05-12 16:37:03', '2023-05-12 16:37:03'),
(19, 'Sumbawa', '2023-05-12 16:37:03', '2023-05-12 16:37:03'),
(20, 'Waringin', '2023-05-12 16:37:03', '2023-05-12 16:37:03'),
(21, 'Merino', '2023-05-12 16:37:03', '2023-05-12 16:37:03'),
(22, 'Priangan', '2023-05-12 16:37:03', '2023-05-12 16:37:03'),
(23, 'Lainnya', '2023-05-12 16:37:03', '2023-05-12 16:37:03'),
(24, 'Saanen', '2023-05-12 16:37:03', '2023-05-12 16:37:03');

-- --------------------------------------------------------

--
-- Struktur dari tabel `d_fase`
--

CREATE TABLE `d_fase` (
  `id_fp` int(11) NOT NULL,
  `fase` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `d_fase`
--

INSERT INTO `d_fase` (`id_fp`, `fase`, `createdAt`, `updatedAt`) VALUES
(1, 'Pemasukan', '2023-05-12 16:34:20', '2023-05-12 16:34:20'),
(2, 'Adaptasi', '2023-05-12 16:34:20', '2023-09-06 15:05:04'),
(7, 'Waiting List Perkawinan', '2023-05-12 16:34:21', '2023-05-12 16:34:21'),
(8, 'Perkawinan', '2023-05-12 16:34:21', '2023-05-12 16:34:21'),
(9, 'Kebuntingan', '2023-05-12 16:34:21', '2023-05-12 16:34:21'),
(10, 'Laktasi', '2023-05-12 16:34:21', '2023-05-12 16:34:21'),
(11, 'Kelahiran', '2023-05-12 16:34:21', '2023-05-12 16:34:21'),
(12, 'Lepas Sapih', '2023-05-12 16:34:21', '2023-05-12 16:34:21');

-- --------------------------------------------------------

--
-- Struktur dari tabel `d_jenis_bahan_pakan`
--

CREATE TABLE `d_jenis_bahan_pakan` (
  `id_jenis_bahan_pakan` int(11) NOT NULL,
  `id_peternakan` int(11) NOT NULL,
  `jenis_bahan_pakan` varchar(255) NOT NULL,
  `satuan` varchar(255) NOT NULL,
  `stok` int(11) NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `d_jenis_kandang`
--

CREATE TABLE `d_jenis_kandang` (
  `id_jenis_kandang` int(11) NOT NULL,
  `jenis_kandang` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `d_jenis_kandang`
--

INSERT INTO `d_jenis_kandang` (`id_jenis_kandang`, `jenis_kandang`, `createdAt`, `updatedAt`) VALUES
(1, 'Kandang Kawin', '2022-12-06 03:19:51', '2022-12-06 03:19:51'),
(2, 'Kandang Laktasi', '2022-12-06 03:19:51', '2022-12-06 03:19:51'),
(3, 'Kandang Rekondisi', '2022-12-06 03:19:51', '2022-12-06 03:19:51'),
(4, 'Kandang Isolasi', '2022-12-06 03:19:51', '2022-12-06 03:19:51'),
(5, 'Kandang Kebuntingan', '2022-12-06 03:19:51', '2022-12-06 03:19:51'),
(6, 'Kandang Lepas Sapih', '2022-12-06 03:19:51', '2022-12-06 03:19:51');

-- --------------------------------------------------------

--
-- Struktur dari tabel `d_jenis_pakan`
--

CREATE TABLE `d_jenis_pakan` (
  `id_jenis_pakan` int(11) NOT NULL,
  `id_peternakan` int(11) NOT NULL,
  `jenis_pakan` varchar(255) NOT NULL,
  `interval_pakan` int(11) NOT NULL,
  `satuan` enum('Tong','Ball','Pcs','Kg') NOT NULL,
  `komposisi` varchar(255) NOT NULL,
  `nutrien` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `d_jenis_pakan`
--

INSERT INTO `d_jenis_pakan` (`id_jenis_pakan`, `id_peternakan`, `jenis_pakan`, `interval_pakan`, `satuan`, `komposisi`, `nutrien`, `createdAt`, `updatedAt`) VALUES
(1, 1, 'Complete Feed', 14, 'Tong', 'Jagung 100%', 'BK 100%', '2023-05-12 09:28:57', '2023-05-12 09:28:57'),
(2, 1, 'Silase', 7, 'Ball', 'Test', 'Test', '2023-05-12 09:29:24', '2023-05-12 09:29:24');

-- --------------------------------------------------------

--
-- Struktur dari tabel `d_kandang`
--

CREATE TABLE `d_kandang` (
  `id_kandang` int(11) NOT NULL,
  `id_peternakan` int(11) NOT NULL,
  `kode_kandang` varchar(255) NOT NULL,
  `id_jenis_kandang` int(11) DEFAULT NULL,
  `id_jenis_pakan` int(11) DEFAULT NULL,
  `persentase_kebutuhan_pakan` int(11) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `d_kandang`
--

INSERT INTO `d_kandang` (`id_kandang`, `id_peternakan`, `kode_kandang`, `id_jenis_kandang`, `id_jenis_pakan`, `persentase_kebutuhan_pakan`, `createdAt`, `updatedAt`) VALUES
(10, 1, 'L1', 4, 2, 7, '2023-09-06 06:36:16', '2023-09-07 09:47:40'),
(11, 1, 'K1', 4, 1, 4, '2023-09-06 06:36:53', '2023-09-06 06:36:53'),
(12, 1, 'L2', 6, 1, 4, '2023-09-06 06:37:09', '2023-09-06 06:37:09'),
(13, 1, 'K2', 6, 2, 7, '2023-09-06 06:37:22', '2023-09-06 06:37:22'),
(14, 1, 'L3', 6, 2, 7, '2023-09-06 06:37:59', '2023-09-06 06:37:59'),
(15, 1, 'K3', 2, 1, 4, '2023-09-06 06:38:14', '2023-09-06 06:38:14'),
(16, 1, 'L4', 5, 2, 7, '2023-09-06 06:38:28', '2023-09-06 06:38:28'),
(17, 1, 'K4', 6, 2, 7, '2023-09-06 06:38:48', '2023-09-06 06:38:48'),
(18, 1, 'L5', 1, 2, 7, '2023-09-06 06:39:05', '2023-09-06 06:39:05'),
(19, 1, 'K5', 1, 2, 7, '2023-09-06 06:39:19', '2023-09-06 06:39:19'),
(20, 1, 'L6', 3, 1, 4, '2023-09-06 06:39:35', '2023-09-06 06:39:35'),
(21, 1, 'K6', 3, 1, 4, '2023-09-06 06:39:49', '2023-09-06 06:39:49');

-- --------------------------------------------------------

--
-- Struktur dari tabel `d_kesehatan`
--

CREATE TABLE `d_kesehatan` (
  `id_kesehatan` int(11) NOT NULL,
  `id_peternakan` int(11) NOT NULL,
  `id_ternak` int(11) NOT NULL,
  `id_penyakit` int(11) NOT NULL,
  `tanggal_sakit` datetime NOT NULL,
  `gejala` varchar(255) NOT NULL,
  `penanganan` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `d_lk_pemasukan`
--

CREATE TABLE `d_lk_pemasukan` (
  `id_lk_pemasukan` int(11) NOT NULL,
  `id_peternakan` int(11) NOT NULL,
  `id_ternak` int(11) NOT NULL,
  `rf_id` varchar(255) NOT NULL,
  `id_bangsa` int(11) DEFAULT NULL,
  `jenis_kelamin` enum('Jantan','Betina') NOT NULL,
  `cek_poel` int(11) NOT NULL,
  `cek_mulut` varchar(255) NOT NULL,
  `cek_telinga` varchar(255) NOT NULL,
  `cek_kuku_kaki` varchar(255) NOT NULL,
  `cek_kondisi_fisik_lain` varchar(255) NOT NULL,
  `cek_bcs` int(11) NOT NULL,
  `id_status_ternak` int(11) DEFAULT NULL,
  `status_kesehatan` enum('Sehat','Sakit') NOT NULL,
  `id_kandang` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `d_pakan`
--

CREATE TABLE `d_pakan` (
  `id_pakan` int(11) NOT NULL,
  `id_peternakan` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `id_jenis_pakan` int(11) NOT NULL,
  `tanggal_pembuatan` datetime DEFAULT NULL,
  `tanggal_konsumsi` datetime DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `d_pemeliharaan`
--

CREATE TABLE `d_pemeliharaan` (
  `id_pemeliharaan` int(11) NOT NULL,
  `id_peternakan` int(11) NOT NULL,
  `id_kandang` int(11) NOT NULL,
  `tanggal_pemeliharaan` datetime NOT NULL,
  `jenis_pakan` varchar(255) NOT NULL,
  `jumlah_pakan` int(11) NOT NULL,
  `pembersihan_kandang` tinyint(1) NOT NULL DEFAULT 0,
  `pembersihan_ternak` tinyint(1) NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `d_penyakit`
--

CREATE TABLE `d_penyakit` (
  `id_penyakit` int(11) NOT NULL,
  `nama_penyakit` varchar(255) NOT NULL,
  `gejala` varchar(255) NOT NULL,
  `penanganan` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `d_penyakit`
--

INSERT INTO `d_penyakit` (`id_penyakit`, `nama_penyakit`, `gejala`, `penanganan`, `createdAt`, `updatedAt`) VALUES
(1, 'Diare', 'Feses domba diare biasanya juga disertai darah, lendir dan bau yang tidak sedap', 'pemberian obat diare, pemberian obat herbal', '2023-05-12 09:18:29', '2023-05-12 09:18:29'),
(2, 'Kembung', 'Perut yang membesar dan menonjol keluar dan berisi gas', 'Trocar (coblos perut domba), pemberian obat', '2023-05-12 09:19:12', '2023-05-12 09:19:12'),
(3, 'ORF', 'Iritasi berwarna kemerahan pada bagian mulut dan hidung, domba tidak nafsu makan', 'Pemberian obat spray, pengobatan salep dan sanitasi bagian tubuh yang terinfeksi', '2023-05-12 09:19:26', '2023-05-12 09:19:26'),
(4, 'Pink Eye', 'mata merah berair hingga kornea mata dapat berubah warna menjadi putih', 'Pemberian obat salep dan rutin membersihkan area mata', '2023-05-12 09:19:40', '2023-05-12 09:19:40'),
(5, 'Scabies', 'terdapat eksim pada kulit ternak dan ternak merasa tidak nyaman', 'Obat semprot dan suntik', '2023-05-12 09:19:54', '2023-05-12 09:19:54'),
(6, 'Mastitis', 'gejala pembengkakan, pengerasan ambing, rasa sakit, panas, serta kemerahan bahkan sampai terjadi penurunan fungsi ambing', 'Obat suntik mastitis', '2023-05-12 09:20:08', '2023-05-12 09:20:08'),
(7, 'Asidosis', 'Lesu, tidak mampu berdiri, suhu tubuh kurang normal, menurunnya nafsu makan, feses berair, denyut jantung terasa lemah dan lebih cepat.', 'Pemberian cairan ber pH 8+', '2023-05-12 09:20:28', '2023-05-12 09:20:28'),
(8, 'Cacingan', 'kurus seperti berat badan tidak sesuai umur, bulu agak berdiri dan kusam, sembelit atau kotoran lembek sampai mencret sehingga kandang cepat kotor, terlihat lesu dan pucat serta nafsu makan berkurang,', 'Pemberian obat cacing', '2023-05-12 09:20:43', '2023-05-12 09:20:43'),
(9, 'Antraks', 'Suhu tubuh tinggi, keluar cairan dari lubang hidung dan dubur, tubuh gemetar dan nafsu makan hilang', 'Obat suntik antraks', '2023-05-12 09:20:57', '2023-05-12 09:20:57'),
(10, 'Ngorok', 'Gangguan pernapasan, sesak napas, suara ngorok dengan gigi gemeretak', 'Suntik antibiotik', '2023-05-12 09:21:11', '2023-05-12 09:21:11'),
(11, 'Radang Pusar', 'Pembengkakan disekitar pusar', 'Penggunaan antibiotik', '2023-05-12 09:21:24', '2023-05-12 09:21:24'),
(12, 'Prolapsus', 'Keluarnya sebagian organ uterus yang terjadi waktu kelahiran', 'Pengembalian organ ke posisi semula', '2023-05-12 09:21:38', '2023-05-12 09:21:38'),
(13, 'Distokia', 'ambing (penghasil susu) membengkak meneteskan kolostrum, kelamin betina bengkak mengeluarkan lendir, merejan dan posisi badan membungkuk, sulit mengeluarkan anak.', 'Pengobatan distokia harus dikonsultasikan dan ditangani oleh dokter hewan atau tenaga medis veteriner. Mengembalikan posisi anak pada posisi normal dengan cara didorong, diputar dan ditarik.', '2023-05-12 09:21:56', '2023-05-12 09:21:56'),
(14, 'Artritis', 'pembengkakan pada persendian, pincang yang menyebabkan tidak bisa berdiri', 'pemberian obat anti inflamasi nonsteroid', '2023-05-12 09:22:13', '2023-05-12 09:22:13'),
(15, 'Miasis', 'Terdapat luka yang mengeluarkan lendir dan nanah, suhu tubuh meningkat', 'Membersihkan luka hingga bersih dari larva serangga, pemberian antibiotik', '2023-05-12 09:22:26', '2023-05-12 09:22:26'),
(16, 'Busuk Kuku', 'Kuku bengkak dan busuk', 'Pemotongan kuku kemudian diberi antiseptik ex: formaldehid 10-20%. Kemudian diberi salep sulfatizol dan perban bagian kuku yang busuk', '2023-05-12 09:22:39', '2023-05-12 09:22:39'),
(17, 'Radang paha', 'kematian mendadak, kaki pincang, lesu, demam singkat, nafsu makan menurun, ngorok beberapa jam sebelum mati.', 'Pemberian antibiotik', '2023-05-12 09:25:24', '2023-05-12 09:25:24'),
(18, 'Tuberkulosis', 'pembentukan granuloma (tuberkel) di beberapa organ terutama paru-paru, hati dan ginjal', ' ', '2023-05-12 09:25:58', '2023-05-12 09:25:58'),
(19, 'Leptospirosis', 'ternak lesu, demam, anemia, kencing darah, penyakit kuning, ternak betina akan keguguran, penurunan produksi susu, susu berwarna kekuningan, terjadi meningitis.', 'pemberian antibiotik streptomisin atau oksitetrasiklin', '2023-05-12 09:26:12', '2023-05-12 09:26:12'),
(20, 'Tetanus', 'malas, kaku, sukar berjalan dan menelan, kepala sering digerakkan ke belakang dan ke samping, kejang-kejang', 'pemberian antibiotik penisilin dan othrisin dengan cara injeksi', '2023-05-12 09:26:24', '2023-05-12 09:26:24'),
(21, 'Piroplasmosis', 'demam tinggi, nafsu makan berkurang, selaput lendir mulut dan mata pucat kekuningan, pernapasan cepat, kencing darah, diare, kurus', 'acaprin, acriflavin, trypaflavin, imidocarb', '2023-05-12 09:26:37', '2023-05-12 09:26:37'),
(22, 'Anaplasmosis', 'gejala timbul 30-40 hari setelah terinfeksi; demam, selaput lendir mulut dan mata pucat, produksi susu menurun, dehidrasi, konstipasi, kematian dalam waktu 2-3 hari', 'aricyl, paludrine, sodiym cacodilate, mercurochrome, penyuntikan antibiotik terramisin atau chlortetrasiklin', '2023-05-12 09:26:51', '2023-05-12 09:26:51'),
(23, 'Coccidiosis', 'diare, dengan mucus atau darah, dehidrasi, lemah, dehidrasi dan mati', 'Pemberian antibiotik', '2023-05-12 09:27:04', '2023-05-12 09:27:04'),
(24, 'Aktinomikosis/rahang bengkak', 'Ternak lesu, demam, sukar makan', 'Pemberian natrium iodida untuk hewan terinfeksi secara oral.', '2023-05-12 09:27:17', '2023-05-12 09:27:17'),
(25, 'Cacing Hati', 'nafsu makan turun, ternak malas, kurus', 'per oral albendazole, dosis pemberian 10-20 mg/kg berat badan namun obat ini dilarang digunakna pada 1/3 pertama kebuntingan karena menyebabkan abortus.', '2023-05-12 09:27:35', '2023-05-12 09:27:35'),
(26, 'Sakit Perut', 'Mules', 'Minum obat', '2023-05-12 09:27:48', '2023-05-12 09:27:48');

-- --------------------------------------------------------

--
-- Struktur dari tabel `d_perkawinan`
--

CREATE TABLE `d_perkawinan` (
  `id_perkawinan` int(11) NOT NULL,
  `id_peternakan` int(11) NOT NULL,
  `id_indukan` int(11) NOT NULL,
  `id_pejantan` int(11) NOT NULL,
  `id_kandang` int(11) NOT NULL,
  `tanggal_perkawinan` datetime NOT NULL,
  `status` enum('Bunting','Tidak Bunting','Abortus') DEFAULT NULL,
  `usg_1` tinyint(1) NOT NULL DEFAULT 0,
  `usg_2` tinyint(1) NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `d_perkawinan`
--

INSERT INTO `d_perkawinan` (`id_perkawinan`, `id_peternakan`, `id_indukan`, `id_pejantan`, `id_kandang`, `tanggal_perkawinan`, `status`, `usg_1`, `usg_2`, `createdAt`, `updatedAt`) VALUES
(1, 1, 162, 169, 18, '2023-08-01 13:02:12', 'Bunting', 1, 1, '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(2, 1, 163, 169, 18, '2023-08-01 13:02:12', 'Bunting', 0, 0, '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(3, 1, 165, 169, 18, '2023-08-01 13:02:12', 'Tidak Bunting', 0, 0, '2023-09-06 13:02:12', '2023-09-07 14:25:39'),
(4, 1, 164, 169, 18, '2023-08-01 13:02:12', 'Tidak Bunting', 0, 0, '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(5, 1, 166, 169, 18, '2023-08-01 13:02:12', 'Tidak Bunting', 0, 0, '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(6, 1, 167, 169, 18, '2023-08-01 13:02:12', 'Tidak Bunting', 0, 0, '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(7, 1, 168, 169, 18, '2023-08-01 13:02:12', 'Tidak Bunting', 0, 0, '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(8, 1, 182, 195, 19, '2023-08-01 13:02:12', 'Tidak Bunting', 0, 0, '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(9, 1, 183, 195, 19, '2023-08-01 13:02:12', 'Tidak Bunting', 0, 0, '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(10, 1, 184, 195, 19, '2023-08-01 13:02:12', 'Tidak Bunting', 0, 0, '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(11, 1, 185, 195, 19, '2023-08-01 13:02:12', 'Tidak Bunting', 0, 0, '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(12, 1, 186, 195, 19, '2023-08-01 13:02:12', 'Tidak Bunting', 0, 0, '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(13, 1, 187, 195, 19, '2023-08-01 13:02:12', 'Tidak Bunting', 0, 0, '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(14, 1, 188, 195, 19, '2023-08-01 13:02:12', 'Tidak Bunting', 0, 0, '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(15, 1, 189, 195, 19, '2023-08-01 13:02:12', 'Tidak Bunting', 0, 0, '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(16, 1, 190, 195, 19, '2023-08-01 13:02:12', 'Tidak Bunting', 0, 0, '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(17, 1, 191, 195, 19, '2023-08-01 13:02:12', 'Tidak Bunting', 0, 0, '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(18, 1, 192, 195, 19, '2023-08-01 13:02:12', 'Tidak Bunting', 0, 0, '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(19, 1, 193, 195, 19, '2023-08-01 13:02:12', 'Tidak Bunting', 0, 0, '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(20, 1, 142, 140, 16, '2023-08-01 13:02:12', 'Bunting', 1, 1, '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(21, 1, 143, 116, 16, '2023-08-01 13:02:12', 'Bunting', 1, 1, '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(22, 1, 144, 140, 16, '2023-08-01 13:02:12', 'Bunting', 1, 1, '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(23, 1, 145, 116, 16, '2023-08-01 13:02:12', 'Bunting', 1, 1, '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(24, 1, 146, 140, 16, '2023-08-01 13:02:12', 'Bunting', 1, 1, '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(25, 1, 147, 116, 16, '2023-08-01 13:02:12', 'Bunting', 1, 1, '2023-09-06 13:02:12', '2023-09-06 13:02:12');

-- --------------------------------------------------------

--
-- Struktur dari tabel `d_peternakan`
--

CREATE TABLE `d_peternakan` (
  `id_peternakan` int(11) NOT NULL,
  `nama_peternakan` varchar(255) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `subscribe` datetime DEFAULT NULL,
  `longitude` varchar(255) DEFAULT NULL,
  `latitude` varchar(255) DEFAULT NULL,
  `postcode` varchar(255) DEFAULT NULL,
  `alamat_postcode` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `d_peternakan`
--

INSERT INTO `d_peternakan` (`id_peternakan`, `nama_peternakan`, `alamat`, `subscribe`, `longitude`, `latitude`, `postcode`, `alamat_postcode`, `token`, `createdAt`, `updatedAt`) VALUES
(1, 'sinergi farm', 'Selomartani, Kalasan, Sleman, Yogyakarta', NULL, '110.393', '-7.782', '55581', 'Jl. Selomartani, Kalasan, Sleman, Yogyakarta, 55581', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF9wZXRlcm5ha2FuIjoxLCJpYXQiOjE2NzAyOTY3OTF9.j5o0BQOrheYtw05LZOK8Mhg6YWXWutfWCAC_rOhSoDk', '2022-12-06 03:19:51', '2023-08-01 07:53:38'),
(2, 'Gembala Farm', 'Selomartani, Kalasan, Sleman, Yogyakarta', NULL, '110.393', '-7.782', '55581', 'Jl. Selomartani, Kalasan, Sleman, Yogyakarta, 55581', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF9wZXRlcm5ha2FuIjoyLCJpYXQiOjE2NzAyOTY3OTF9.XJ06F4oK9d9LKWn_4NnGbcPHRGy2I-wQtDM1gf_Stb8', '2022-12-06 03:19:51', '2022-12-12 02:01:32');

-- --------------------------------------------------------

--
-- Struktur dari tabel `d_populasi`
--

CREATE TABLE `d_populasi` (
  `id_populasi` int(11) NOT NULL,
  `id_peternakan` int(11) NOT NULL,
  `tanggal` datetime NOT NULL,
  `populasi` int(11) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `d_riwayat_fase`
--

CREATE TABLE `d_riwayat_fase` (
  `id_riwayat_fase` int(11) NOT NULL,
  `id_peternakan` int(11) NOT NULL,
  `id_fp` int(11) NOT NULL,
  `id_ternak` int(11) NOT NULL,
  `tanggal` datetime NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `d_riwayat_fase`
--

INSERT INTO `d_riwayat_fase` (`id_riwayat_fase`, `id_peternakan`, `id_fp`, `id_ternak`, `tanggal`, `createdAt`, `updatedAt`) VALUES
(106, 1, 2, 116, '2023-09-06 06:48:55', '2023-09-06 06:48:55', '2023-09-06 06:48:55'),
(107, 1, 2, 117, '2023-09-06 06:51:01', '2023-09-06 06:51:01', '2023-09-06 06:51:01'),
(108, 1, 2, 118, '2023-09-06 06:52:14', '2023-09-06 06:52:14', '2023-09-06 06:52:14'),
(115, 1, 2, 125, '2023-09-06 07:02:36', '2023-09-06 07:02:36', '2023-09-06 07:02:36'),
(116, 1, 2, 126, '2023-09-06 07:03:27', '2023-09-06 07:03:27', '2023-09-06 07:03:27'),
(117, 1, 2, 127, '2023-09-06 07:04:56', '2023-09-06 07:04:56', '2023-09-06 07:04:56'),
(118, 1, 2, 128, '2023-09-06 07:05:36', '2023-09-06 07:05:36', '2023-09-06 07:05:36'),
(119, 1, 2, 129, '2023-09-06 07:06:20', '2023-09-06 07:06:20', '2023-09-06 07:06:20'),
(120, 1, 2, 130, '2023-09-06 07:06:59', '2023-09-06 07:06:59', '2023-09-06 07:06:59'),
(121, 1, 7, 131, '2023-09-06 07:10:04', '2023-09-06 07:10:04', '2023-09-06 07:10:04'),
(122, 1, 7, 132, '2023-09-06 07:12:03', '2023-09-06 07:12:03', '2023-09-06 07:12:03'),
(123, 1, 7, 133, '2023-09-06 07:13:07', '2023-09-06 07:13:07', '2023-09-06 07:13:07'),
(124, 1, 7, 134, '2023-09-06 07:13:57', '2023-09-06 07:13:57', '2023-09-06 07:13:57'),
(125, 1, 7, 135, '2023-09-06 07:18:31', '2023-09-06 07:18:31', '2023-09-06 07:18:31'),
(126, 1, 7, 136, '2023-09-06 07:40:40', '2023-09-06 07:40:40', '2023-09-06 07:40:40'),
(127, 1, 7, 137, '2023-09-06 07:42:10', '2023-09-06 07:42:10', '2023-09-06 07:42:10'),
(128, 1, 7, 138, '2023-09-06 07:43:58', '2023-09-06 07:43:58', '2023-09-06 07:43:58'),
(129, 1, 7, 139, '2023-09-06 07:44:44', '2023-09-06 07:44:44', '2023-09-06 07:44:44'),
(130, 1, 2, 140, '2023-09-06 08:56:29', '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(131, 1, 12, 170, '2023-09-06 12:28:36', '2023-09-06 12:28:36', '2023-09-06 12:28:36'),
(132, 1, 12, 171, '2023-09-06 12:29:38', '2023-09-06 12:29:38', '2023-09-06 12:29:38'),
(133, 1, 12, 172, '2023-09-06 12:31:41', '2023-09-06 12:31:41', '2023-09-06 12:31:41'),
(134, 1, 12, 173, '2023-09-06 12:32:34', '2023-09-06 12:32:34', '2023-09-06 12:32:34'),
(135, 1, 12, 174, '2023-09-06 12:33:33', '2023-09-06 12:33:33', '2023-09-06 12:33:33'),
(136, 1, 12, 175, '2023-09-06 12:35:47', '2023-09-06 12:35:47', '2023-09-06 12:35:47'),
(137, 1, 12, 176, '2023-09-06 12:36:39', '2023-09-06 12:36:39', '2023-09-06 12:36:39'),
(138, 1, 12, 177, '2023-09-06 12:39:19', '2023-09-06 12:39:19', '2023-09-06 12:39:19'),
(139, 1, 12, 178, '2023-09-06 12:40:49', '2023-09-06 12:40:49', '2023-09-06 12:40:49'),
(140, 1, 12, 179, '2023-09-06 12:42:03', '2023-09-06 12:42:03', '2023-09-06 12:42:03'),
(141, 1, 12, 180, '2023-09-06 12:43:54', '2023-09-06 12:43:54', '2023-09-06 12:43:54'),
(142, 1, 12, 181, '2023-09-06 12:44:57', '2023-09-06 12:44:57', '2023-09-06 12:44:57'),
(143, 1, 12, 194, '2023-09-06 12:48:04', '2023-09-06 12:48:04', '2023-09-06 12:48:04'),
(144, 1, 12, 196, '2023-09-06 12:52:43', '2023-09-06 12:52:43', '2023-09-06 12:52:43'),
(145, 1, 12, 197, '2023-09-06 12:53:53', '2023-09-06 12:53:53', '2023-09-06 12:53:53'),
(146, 1, 12, 198, '2023-09-06 12:55:10', '2023-09-06 12:55:10', '2023-09-06 12:55:10'),
(147, 1, 12, 199, '2023-09-06 12:56:17', '2023-09-06 12:56:17', '2023-09-06 12:56:17'),
(148, 1, 12, 220, '2023-09-06 13:03:28', '2023-09-06 13:03:28', '2023-09-06 13:03:28'),
(149, 1, 12, 221, '2023-09-06 13:05:04', '2023-09-06 13:05:04', '2023-09-06 13:05:04'),
(150, 1, 12, 222, '2023-09-06 13:08:30', '2023-09-06 13:08:30', '2023-09-06 13:08:30'),
(151, 1, 12, 223, '2023-09-06 13:09:28', '2023-09-06 13:09:28', '2023-09-06 13:09:28'),
(152, 1, 12, 224, '2023-09-06 13:10:57', '2023-09-06 13:10:57', '2023-09-06 13:10:57'),
(153, 1, 12, 245, '2023-09-06 13:22:37', '2023-09-06 13:22:37', '2023-09-06 13:22:37'),
(154, 1, 12, 246, '2023-09-06 13:24:17', '2023-09-06 13:24:17', '2023-09-06 13:24:17'),
(155, 1, 12, 247, '2023-09-06 13:25:27', '2023-09-06 13:25:27', '2023-09-06 13:25:27'),
(156, 1, 12, 248, '2023-09-06 13:26:26', '2023-09-06 13:26:26', '2023-09-06 13:26:26'),
(157, 1, 12, 249, '2023-09-06 13:27:33', '2023-09-06 13:27:33', '2023-09-06 13:27:33'),
(158, 1, 12, 250, '2023-09-06 13:28:54', '2023-09-06 13:28:54', '2023-09-06 13:28:54'),
(159, 1, 12, 251, '2023-09-06 13:30:45', '2023-09-06 13:30:45', '2023-09-06 13:30:45'),
(160, 1, 12, 252, '2023-09-06 13:31:50', '2023-09-06 13:31:50', '2023-09-06 13:31:50'),
(161, 1, 7, 253, '2023-09-06 14:43:08', '2023-09-06 14:43:08', '2023-09-06 14:43:08'),
(162, 1, 7, 254, '2023-09-06 14:44:51', '2023-09-06 14:44:51', '2023-09-06 14:44:51'),
(163, 1, 7, 255, '2023-09-06 14:45:46', '2023-09-06 14:45:46', '2023-09-06 14:45:46'),
(164, 1, 7, 256, '2023-09-06 14:46:48', '2023-09-06 14:46:48', '2023-09-06 14:46:48'),
(165, 1, 9, 257, '2023-09-06 14:51:08', '2023-09-06 14:51:08', '2023-09-06 14:51:08'),
(166, 1, 9, 258, '2023-09-06 14:52:00', '2023-09-06 14:52:00', '2023-09-06 14:52:00'),
(167, 1, 9, 259, '2023-09-06 14:52:46', '2023-09-06 14:52:46', '2023-09-06 14:52:46'),
(168, 1, 9, 260, '2023-09-06 14:53:41', '2023-09-06 14:53:41', '2023-09-06 14:53:41'),
(169, 1, 12, 261, '2023-09-06 14:56:58', '2023-09-06 14:56:58', '2023-09-06 14:56:58'),
(170, 1, 12, 262, '2023-09-06 14:58:11', '2023-09-06 14:58:11', '2023-09-06 14:58:11'),
(171, 1, 12, 263, '2023-09-06 15:00:06', '2023-09-06 15:00:06', '2023-09-06 15:00:06'),
(172, 1, 10, 264, '2023-09-06 15:03:35', '2023-09-06 15:03:35', '2023-09-06 15:03:35'),
(173, 1, 10, 265, '2023-09-06 15:04:50', '2023-09-06 15:04:50', '2023-09-06 15:04:50'),
(174, 1, 10, 266, '2023-09-06 15:06:06', '2023-09-06 15:06:06', '2023-09-06 15:06:06'),
(175, 1, 10, 267, '2023-09-06 15:07:14', '2023-09-06 15:07:14', '2023-09-06 15:07:14'),
(176, 1, 10, 268, '2023-09-06 15:08:03', '2023-09-06 15:08:03', '2023-09-06 15:08:03'),
(177, 1, 10, 269, '2023-09-06 15:10:48', '2023-09-06 15:10:48', '2023-09-06 15:10:48'),
(178, 1, 10, 270, '2023-09-06 15:11:24', '2023-09-06 15:11:24', '2023-09-06 15:11:24'),
(179, 1, 10, 271, '2023-09-06 15:12:07', '2023-09-06 15:12:07', '2023-09-06 15:12:07'),
(180, 1, 10, 272, '2023-09-06 15:12:57', '2023-09-06 15:12:57', '2023-09-06 15:12:57'),
(181, 1, 10, 273, '2023-09-06 15:13:35', '2023-09-06 15:13:35', '2023-09-06 15:13:35'),
(182, 1, 10, 274, '2023-09-06 23:08:03', '2023-09-06 23:08:03', '2023-09-06 23:08:03'),
(183, 1, 10, 275, '2023-09-06 23:09:14', '2023-09-06 23:09:14', '2023-09-06 23:09:14'),
(184, 1, 10, 276, '2023-09-06 23:10:09', '2023-09-06 23:10:09', '2023-09-06 23:10:09'),
(185, 1, 10, 277, '2023-09-06 23:11:02', '2023-09-06 23:11:02', '2023-09-06 23:11:02'),
(186, 1, 10, 278, '2023-09-06 23:11:59', '2023-09-06 23:11:59', '2023-09-06 23:11:59'),
(187, 1, 10, 279, '2023-09-06 23:13:13', '2023-09-06 23:13:13', '2023-09-06 23:13:13');

-- --------------------------------------------------------

--
-- Struktur dari tabel `d_riwayat_kebuntingan`
--

CREATE TABLE `d_riwayat_kebuntingan` (
  `id_riwayat_kebuntingan` int(11) NOT NULL,
  `id_peternakan` int(11) NOT NULL,
  `id_riwayat_perkawinan` int(11) DEFAULT NULL,
  `id_indukan` int(11) NOT NULL,
  `id_pejantan` int(11) DEFAULT NULL,
  `tanggal_perkawinan` datetime NOT NULL,
  `tanggal_kebuntingan` datetime NOT NULL,
  `status` enum('Abortus','Partus') NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `d_riwayat_kelahiran`
--

CREATE TABLE `d_riwayat_kelahiran` (
  `id_kelahiran` int(11) NOT NULL,
  `id_peternakan` int(11) NOT NULL,
  `id_ternak` int(11) NOT NULL,
  `tanggal_masuk` datetime NOT NULL,
  `tanggal_lahir` datetime NOT NULL,
  `id_sire` int(11) DEFAULT NULL,
  `id_dam` int(11) DEFAULT NULL,
  `jenis_kelamin` enum('Jantan','Betina') NOT NULL,
  `bangsa` varchar(255) NOT NULL,
  `kode_kandang` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `d_riwayat_kesehatan`
--

CREATE TABLE `d_riwayat_kesehatan` (
  `id_riwayat_kesehatan` int(11) NOT NULL,
  `id_peternakan` int(11) NOT NULL,
  `id_ternak` int(11) NOT NULL,
  `penyakit` varchar(255) NOT NULL,
  `tanggal_sakit` datetime NOT NULL,
  `tanggal_sembuh` datetime DEFAULT NULL,
  `gejala` varchar(255) NOT NULL,
  `penanganan` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `d_riwayat_lepas_sapih`
--

CREATE TABLE `d_riwayat_lepas_sapih` (
  `id_riwayat_lepas_sapih` int(11) NOT NULL,
  `id_peternakan` int(11) NOT NULL,
  `id_ternak` int(11) NOT NULL,
  `tanggal_lepas_sapih` datetime NOT NULL,
  `kode_kandang` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `d_riwayat_perkawinan`
--

CREATE TABLE `d_riwayat_perkawinan` (
  `id_riwayat_perkawinan` int(11) NOT NULL,
  `id_peternakan` int(11) NOT NULL,
  `id_kandang` int(11) DEFAULT NULL,
  `id_indukan` int(11) NOT NULL,
  `id_pejantan` int(11) DEFAULT NULL,
  `tanggal_perkawinan` datetime NOT NULL,
  `status` enum('Bunting','Tidak Bunting') NOT NULL DEFAULT 'Tidak Bunting',
  `usg` int(11) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `d_status_ternak`
--

CREATE TABLE `d_status_ternak` (
  `id_status_ternak` int(11) NOT NULL,
  `status_ternak` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `d_status_ternak`
--

INSERT INTO `d_status_ternak` (`id_status_ternak`, `status_ternak`, `createdAt`, `updatedAt`) VALUES
(1, 'Indukan', '2023-05-12 16:32:48', '2023-05-12 16:32:48'),
(2, 'Pejantan', '2023-05-12 16:32:48', '2023-05-12 16:32:48'),
(3, 'Cempe', '2023-05-12 16:32:48', '2023-05-12 16:32:48'),
(4, 'Afkir', '2023-05-12 16:32:48', '2023-05-12 16:32:48'),
(5, 'Bakalan', '2023-05-12 16:32:48', '2023-05-12 16:32:48'),
(6, 'Jemoko', '2023-05-12 16:32:48', '2023-05-12 16:32:48'),
(7, 'Dara', '2023-05-12 16:32:48', '2023-05-12 16:32:48');

-- --------------------------------------------------------

--
-- Struktur dari tabel `d_timbangan`
--

CREATE TABLE `d_timbangan` (
  `id_timbangan` int(11) NOT NULL,
  `id_ternak` int(11) NOT NULL,
  `rf_id` varchar(255) NOT NULL,
  `berat` float NOT NULL,
  `suhu` float NOT NULL,
  `tanggal_timbang` datetime NOT NULL DEFAULT current_timestamp(),
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `d_timbangan`
--

INSERT INTO `d_timbangan` (`id_timbangan`, `id_ternak`, `rf_id`, `berat`, `suhu`, `tanggal_timbang`, `createdAt`, `updatedAt`) VALUES
(265, 126, 'KB001', 38, 38, '2023-09-06 07:03:51', '2023-09-06 07:03:51', '2023-09-06 07:03:51'),
(274, 131, 'DB001', 34, 38, '2023-09-06 07:16:20', '2023-09-06 07:16:20', '2023-09-06 07:16:20'),
(275, 132, 'DB002', 34, 38, '2023-09-06 07:16:46', '2023-09-06 07:16:46', '2023-09-06 07:16:46'),
(276, 133, 'DB003', 33, 38, '2023-09-06 07:17:14', '2023-09-06 07:17:14', '2023-09-06 07:17:14'),
(277, 134, 'DB004', 34, 38, '2023-09-06 07:17:35', '2023-09-06 07:17:35', '2023-09-06 07:17:35'),
(279, 132, 'DB002', 34, 38, '2023-09-06 07:27:50', '2023-09-06 07:27:50', '2023-09-06 07:27:50'),
(280, 131, 'DB001', 34, 38, '2023-09-06 07:28:19', '2023-09-06 07:28:19', '2023-09-06 07:28:19'),
(281, 131, 'DB001', 34, 38, '2023-09-06 07:33:21', '2023-09-06 07:33:21', '2023-09-06 07:33:21'),
(282, 134, 'DB004', 34, 38, '2023-09-06 07:34:00', '2023-09-06 07:34:00', '2023-09-06 07:34:00'),
(283, 133, 'DB003', 33, 38, '2023-09-06 07:34:31', '2023-09-06 07:34:31', '2023-09-06 07:34:31'),
(284, 132, 'DB002', 34, 38, '2023-09-06 07:35:32', '2023-09-06 07:35:32', '2023-09-06 07:35:32'),
(289, 116, 'DJ002', 75, 38, '2023-09-06 08:50:53', '2023-09-06 08:50:53', '2023-09-06 08:50:53'),
(291, 140, 'DJ001', 72, 38, '2023-09-06 11:55:39', '2023-09-06 11:55:39', '2023-09-06 11:55:39'),
(292, 140, 'DJ001', 72, 38, '2023-09-06 11:56:48', '2023-09-06 11:56:48', '2023-09-06 11:56:48'),
(293, 117, 'DJ003', 78, 38, '2023-09-06 12:01:24', '2023-09-06 12:01:24', '2023-09-06 12:01:24'),
(294, 118, 'KJ001', 45, 38, '2023-09-06 12:02:59', '2023-09-06 12:02:59', '2023-09-06 12:02:59'),
(295, 118, 'KJ001', 45, 38, '2023-09-06 12:03:30', '2023-09-06 12:03:30', '2023-09-06 12:03:30'),
(296, 126, 'KB001', 37, 38, '2023-09-06 12:05:34', '2023-09-06 12:05:34', '2023-09-06 12:05:34'),
(297, 127, 'KB002', 33, 38, '2023-09-06 12:07:11', '2023-09-06 12:07:11', '2023-09-06 12:07:11'),
(298, 128, 'KB003', 35, 38, '2023-09-06 12:07:40', '2023-09-06 12:07:40', '2023-09-06 12:07:40'),
(299, 129, 'KB004', 36, 38, '2023-09-06 12:08:51', '2023-09-06 12:08:51', '2023-09-06 12:08:51'),
(300, 130, 'KB005', 35, 38, '2023-09-06 12:09:52', '2023-09-06 12:09:52', '2023-09-06 12:09:52'),
(301, 131, 'DB001', 33, 38, '2023-09-06 12:11:08', '2023-09-06 12:11:08', '2023-09-06 12:11:08'),
(302, 132, 'DB002', 32, 38, '2023-09-06 12:12:05', '2023-09-06 12:12:05', '2023-09-06 12:12:05'),
(303, 133, 'DB003', 39, 38, '2023-09-06 12:13:10', '2023-09-06 12:13:10', '2023-09-06 12:13:10'),
(304, 134, 'DB004', 37, 38, '2023-09-06 12:13:41', '2023-09-06 12:13:41', '2023-09-06 12:13:41'),
(305, 135, 'DB005', 31, 38, '2023-09-06 12:14:35', '2023-09-06 12:14:35', '2023-09-06 12:14:35'),
(306, 136, 'DB006', 34, 38, '2023-09-06 12:15:08', '2023-09-06 12:15:08', '2023-09-06 12:15:08'),
(307, 137, 'DB007', 35, 38, '2023-09-06 12:15:50', '2023-09-06 12:15:50', '2023-09-06 12:15:50'),
(308, 138, 'DB008', 35, 38, '2023-09-06 12:16:47', '2023-09-06 12:16:47', '2023-09-06 12:16:47'),
(309, 139, 'DB009', 36, 38, '2023-09-06 12:17:18', '2023-09-06 12:17:18', '2023-09-06 12:17:18'),
(310, 139, 'DB009', 36, 38, '2023-09-06 12:17:55', '2023-09-06 12:17:55', '2023-09-06 12:17:55'),
(311, 141, 'DJ004', 15, 38, '2023-09-06 12:25:03', '2023-09-06 12:25:03', '2023-09-06 12:25:03'),
(317, 174, 'DJ009', 15, 38, '2023-09-06 12:34:00', '2023-09-06 12:34:00', '2023-09-06 12:34:00'),
(320, 176, 'DB011', 13, 38, '2023-09-06 12:37:59', '2023-09-06 12:37:59', '2023-09-06 12:37:59'),
(331, 157, 'DJ021', 28, 38, '2023-09-06 12:58:25', '2023-09-06 12:58:25', '2023-09-06 12:58:25'),
(332, 143, 'DB061', 32, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(338, 224, 'DB026', 28, 38, '2023-09-06 13:12:51', '2023-09-06 13:12:51', '2023-09-06 13:12:51'),
(339, 223, 'DB025', 31, 38, '2023-09-06 13:15:53', '2023-09-06 13:15:53', '2023-09-06 13:15:53'),
(340, 222, 'DB024', 35, 38, '2023-09-06 13:16:15', '2023-09-06 13:16:15', '2023-09-06 13:16:15'),
(341, 222, 'DB024', 35, 38, '2023-09-06 13:16:36', '2023-09-06 13:16:36', '2023-09-06 13:16:36'),
(342, 222, 'DB024', 35, 38, '2023-09-06 13:17:06', '2023-09-06 13:17:06', '2023-09-06 13:17:06'),
(343, 221, 'DB023', 33, 38, '2023-09-06 13:18:04', '2023-09-06 13:18:04', '2023-09-06 13:18:04'),
(344, 220, 'DB022', 30, 38, '2023-09-06 13:18:25', '2023-09-06 13:18:25', '2023-09-06 13:18:25'),
(345, 199, 'DB021', 28, 38, '2023-09-06 13:18:42', '2023-09-06 13:18:42', '2023-09-06 13:18:42'),
(346, 198, 'DB020', 32, 38, '2023-09-06 13:19:00', '2023-09-06 13:19:00', '2023-09-06 13:19:00'),
(347, 197, 'DB019', 33, 38, '2023-09-06 13:19:23', '2023-09-06 13:19:23', '2023-09-06 13:19:23'),
(348, 196, 'DB018', 35, 38, '2023-09-06 13:19:34', '2023-09-06 13:19:34', '2023-09-06 13:19:34'),
(349, 194, 'DB017', 30, 38, '2023-09-06 13:19:44', '2023-09-06 13:19:44', '2023-09-06 13:19:44'),
(350, 198, 'DB020', 32, 38, '2023-09-06 13:20:15', '2023-09-06 13:20:15', '2023-09-06 13:20:15'),
(351, 221, 'DB023', 33, 38, '2023-09-06 13:20:51', '2023-09-06 13:20:51', '2023-09-06 13:20:51'),
(352, 223, 'DB025', 31, 38, '2023-09-06 13:21:12', '2023-09-06 13:21:12', '2023-09-06 13:21:12'),
(353, 223, 'DB025', 31, 38, '2023-09-06 13:21:36', '2023-09-06 13:21:36', '2023-09-06 13:21:36'),
(355, 245, 'DB027', 27, 38, '2023-09-06 13:23:23', '2023-09-06 13:23:23', '2023-09-06 13:23:23'),
(357, 246, 'DB028', 28, 38, '2023-09-06 13:24:41', '2023-09-06 13:24:41', '2023-09-06 13:24:41'),
(359, 247, 'DB029', 29, 38, '2023-09-06 13:25:43', '2023-09-06 13:25:43', '2023-09-06 13:25:43'),
(361, 248, 'DB030', 30, 38, '2023-09-06 13:26:56', '2023-09-06 13:26:56', '2023-09-06 13:26:56'),
(363, 249, 'DB031', 31, 38, '2023-09-06 13:27:53', '2023-09-06 13:27:53', '2023-09-06 13:27:53'),
(365, 250, 'DB032', 32, 38, '2023-09-06 13:29:15', '2023-09-06 13:29:15', '2023-09-06 13:29:15'),
(367, 251, 'DJ010', 33, 38, '2023-09-06 13:31:07', '2023-09-06 13:31:07', '2023-09-06 13:31:07'),
(368, 252, 'DJ011', 36, 38, '2023-09-06 13:32:19', '2023-09-06 13:32:19', '2023-09-06 13:32:19'),
(369, 175, 'DB010', 12, 38, '2023-09-06 14:35:34', '2023-09-06 14:35:34', '2023-09-06 14:35:34'),
(370, 176, 'DB011', 13, 38, '2023-09-06 14:35:52', '2023-09-06 14:35:52', '2023-09-06 14:35:52'),
(371, 177, 'DB012', 15, 38, '2023-09-06 14:36:05', '2023-09-06 14:36:05', '2023-09-06 14:36:05'),
(372, 178, 'DB013', 14, 38, '2023-09-06 14:36:25', '2023-09-06 14:36:25', '2023-09-06 14:36:25'),
(373, 179, 'DB014', 12, 38, '2023-09-06 14:36:36', '2023-09-06 14:36:36', '2023-09-06 14:36:36'),
(374, 180, 'DB015', 11, 38, '2023-09-06 14:36:51', '2023-09-06 14:36:51', '2023-09-06 14:36:51'),
(375, 181, 'DB016', 13, 38, '2023-09-06 14:37:07', '2023-09-06 14:37:07', '2023-09-06 14:37:07'),
(376, 246, 'DB028', 28, 38, '2023-09-06 14:38:02', '2023-09-06 14:38:02', '2023-09-06 14:38:02'),
(377, 246, 'DB028', 28, 38, '2023-09-06 14:38:30', '2023-09-06 14:38:30', '2023-09-06 14:38:30'),
(378, 247, 'DB029', 29, 38, '2023-09-06 14:39:07', '2023-09-06 14:39:07', '2023-09-06 14:39:07'),
(379, 249, 'DB031', 31, 38, '2023-09-06 14:39:34', '2023-09-06 14:39:34', '2023-09-06 14:39:34'),
(381, 253, 'DB033', 35, 38, '2023-09-06 14:43:27', '2023-09-06 14:43:27', '2023-09-06 14:43:27'),
(382, 253, 'DB033', 35, 38, '2023-09-06 14:43:48', '2023-09-06 14:43:48', '2023-09-06 14:43:48'),
(384, 254, 'DB034', 33, 38, '2023-09-06 14:48:36', '2023-09-06 14:48:36', '2023-09-06 14:48:36'),
(385, 255, 'DB035', 34, 38, '2023-09-06 14:49:00', '2023-09-06 14:49:00', '2023-09-06 14:49:00'),
(386, 256, 'DB036', 35, 38, '2023-09-06 14:49:42', '2023-09-06 14:49:42', '2023-09-06 14:49:42'),
(387, 257, 'DB037', 36, 38, '2023-09-06 14:54:12', '2023-09-06 14:54:12', '2023-09-06 14:54:12'),
(388, 258, 'DB038', 33, 38, '2023-09-06 14:54:33', '2023-09-06 14:54:33', '2023-09-06 14:54:33'),
(389, 259, 'DB039', 32, 38, '2023-09-06 14:54:50', '2023-09-06 14:54:50', '2023-09-06 14:54:50'),
(390, 260, 'DB040', 34, 38, '2023-09-06 14:55:12', '2023-09-06 14:55:12', '2023-09-06 14:55:12'),
(391, 261, 'DB041', 15, 38, '2023-09-06 14:57:16', '2023-09-06 14:57:16', '2023-09-06 14:57:16'),
(394, 263, 'DJ012', 20, 38, '2023-09-06 15:00:27', '2023-09-06 15:00:27', '2023-09-06 15:00:27'),
(395, 262, 'DB042', 16, 38, '2023-09-06 15:18:30', '2023-09-06 15:18:30', '2023-09-06 15:18:30'),
(396, 264, 'DB043', 16, 38, '2023-09-06 15:19:08', '2023-09-06 15:19:08', '2023-09-06 15:19:08'),
(397, 264, 'DB043', 33, 38, '2023-09-06 15:20:16', '2023-09-06 15:20:16', '2023-09-06 15:20:16'),
(398, 264, 'DB043', 33, 38, '2023-09-06 15:20:54', '2023-09-06 15:20:54', '2023-09-06 15:20:54'),
(399, 265, 'DB044', 32, 38, '2023-09-06 15:21:22', '2023-09-06 15:21:22', '2023-09-06 15:21:22'),
(400, 266, 'DB045', 39, 38, '2023-09-06 15:21:37', '2023-09-06 15:21:37', '2023-09-06 15:21:37'),
(401, 267, 'DB046', 37, 38, '2023-09-06 15:21:52', '2023-09-06 15:21:52', '2023-09-06 15:21:52'),
(402, 268, 'DB047', 31, 38, '2023-09-06 15:22:10', '2023-09-06 15:22:10', '2023-09-06 15:22:10'),
(403, 269, 'DB048', 34, 38, '2023-09-06 15:22:36', '2023-09-06 15:22:36', '2023-09-06 15:22:36'),
(404, 264, 'DB043', 33, 38, '2023-09-06 15:23:54', '2023-09-06 15:23:54', '2023-09-06 15:23:54'),
(405, 270, 'DB049', 35, 38, '2023-09-06 15:24:45', '2023-09-06 15:24:45', '2023-09-06 15:24:45'),
(406, 271, 'DB050', 35, 38, '2023-09-06 15:25:15', '2023-09-06 15:25:15', '2023-09-06 15:25:15'),
(407, 272, 'DB051', 36, 38, '2023-09-06 15:25:41', '2023-09-06 15:25:41', '2023-09-06 15:25:41'),
(408, 273, 'DB052', 33, 38, '2023-09-06 15:26:04', '2023-09-06 15:26:04', '2023-09-06 15:26:04'),
(410, 274, 'DB053', 10, 38, '2023-09-06 23:08:34', '2023-09-06 23:08:34', '2023-09-06 23:08:34'),
(411, 275, 'DB054', 9, 38, '2023-09-06 23:09:25', '2023-09-06 23:09:25', '2023-09-06 23:09:25'),
(412, 276, 'DB055', 8, 38, '2023-09-06 23:10:22', '2023-09-06 23:10:22', '2023-09-06 23:10:22'),
(413, 277, 'DB056', 10, 38, '2023-09-06 23:11:25', '2023-09-06 23:11:25', '2023-09-06 23:11:25'),
(414, 278, 'DB057', 11, 38, '2023-09-06 23:12:14', '2023-09-06 23:12:14', '2023-09-06 23:12:14'),
(415, 279, 'DB058', 12, 38, '2023-09-06 23:13:29', '2023-09-06 23:13:29', '2023-09-06 23:13:29'),
(416, 142, 'DB060', 33, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(417, 200, 'DB093', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(418, 201, 'DB094', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(419, 202, 'DB095', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(420, 203, 'DB096', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(421, 204, 'DB097', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(422, 205, 'DB098', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(423, 206, 'DB099', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(424, 207, 'DB100', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(425, 208, 'DB101', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(426, 209, 'DB102', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(427, 210, 'DB103', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(428, 211, 'DB104', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(429, 212, 'DB105', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(430, 213, 'DB106', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(431, 214, 'DB107', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(432, 215, 'DB108', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(433, 216, 'DB109', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(434, 217, 'DB110', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(435, 218, 'DB111', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(436, 219, 'DB112', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(437, 225, 'DB113', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(438, 226, 'DB114', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(439, 227, 'DB115', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(440, 228, 'DB116', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(441, 229, 'DB117', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(442, 230, 'DB118', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(443, 231, 'DB119', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(444, 232, 'DB120', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(445, 233, 'DB121', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(446, 234, 'DB122', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(447, 235, 'DB123', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(448, 236, 'DB124', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(449, 237, 'DB125', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(450, 238, 'DB126', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(451, 239, 'DB127', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(452, 240, 'DB128', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(453, 241, 'DB129', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(454, 242, 'DB130', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(455, 243, 'DB131', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(456, 244, 'DB132', 16.5, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(457, 182, 'DB081', 32, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-07 09:56:10'),
(458, 183, 'DB082', 39, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-07 09:56:10'),
(459, 184, 'DB083', 37, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-07 09:56:10'),
(460, 185, 'DB084', 31, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-07 09:56:10'),
(461, 186, 'DB085', 34, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-07 09:56:10'),
(462, 187, 'DB086', 35, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-07 09:56:10'),
(463, 188, 'DB087', 37, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-07 09:56:10'),
(464, 189, 'DB088', 31, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-07 09:56:10'),
(465, 190, 'DB089', 34, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-07 09:56:10'),
(466, 191, 'DB090', 35, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-07 09:56:10'),
(467, 192, 'DB091', 35, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-07 09:56:10'),
(468, 193, 'DB092', 36, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-07 09:56:10'),
(469, 195, 'DJ027', 80, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-07 09:56:10'),
(470, 162, 'DB074', 32, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(471, 163, 'DB075', 39, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(472, 164, 'DB076', 37, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(473, 165, 'DB077', 31, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(474, 166, 'DB078', 34, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(475, 167, 'DB079', 35, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(476, 168, 'DB080', 35, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(477, 169, 'DJ026', 72, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(478, 148, 'DB066', 27, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(479, 149, 'DB067', 28, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(480, 150, 'DB068', 29, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(481, 151, 'DB069', 30, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(482, 152, 'DB070', 31, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(483, 153, 'DB071', 32, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(484, 154, 'DB072', 29, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(485, 155, 'DB073', 30, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(486, 156, 'DJ020', 35, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(487, 157, 'DJ021', 37, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(488, 158, 'DJ022', 45, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(489, 159, 'DJ023', 37, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(490, 160, 'DJ024', 25, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(491, 161, 'DJ025', 23, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(492, 142, 'DB060', 33, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(493, 143, 'DB061', 32, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(494, 144, 'DB062', 28, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(495, 145, 'DB063', 30, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(496, 146, 'DB064', 33, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(497, 147, 'DB065', 35, 38, '2023-09-06 13:02:12', '2023-09-06 13:02:12', '2023-09-06 13:02:12'),
(498, 198, 'DB020', 32, 38, '2023-09-07 06:05:34', '2023-09-07 06:05:34', '2023-09-07 06:05:34'),
(499, 173, 'DJ008', 14, 38, '2023-09-07 06:15:20', '2023-09-07 06:15:20', '2023-09-07 06:15:20'),
(500, 116, 'DJ002', 75, 38, '2023-09-07 06:16:52', '2023-09-07 06:16:52', '2023-09-07 06:16:52'),
(501, 170, 'DJ005', 12, 38, '2023-09-07 06:18:48', '2023-09-07 06:18:48', '2023-09-07 06:18:48'),
(502, 171, 'DJ006', 14, 38, '2023-09-07 06:18:48', '2023-09-07 06:18:48', '2023-09-07 06:18:48'),
(503, 172, 'DJ007', 16, 38, '2023-09-07 06:18:48', '2023-09-07 06:18:48', '2023-09-07 06:18:48'),
(504, 280, 'DJ013', 11, 38, '2023-09-07 13:36:34', '2023-09-07 13:36:34', '2023-09-07 13:36:34'),
(505, 280, 'DJ013', 11, 38, '2023-09-07 13:36:47', '2023-09-07 13:36:47', '2023-09-07 13:36:47'),
(506, 281, 'DJ014', 13, 38, '2023-09-07 13:41:28', '2023-09-07 13:41:28', '2023-09-07 13:41:28'),
(507, 282, 'DJ015', 12, 38, '2023-09-07 13:41:28', '2023-09-07 13:41:28', '2023-09-07 13:41:28'),
(508, 283, 'DJ016', 12, 38, '2023-09-07 13:41:28', '2023-09-07 13:41:28', '2023-09-07 13:41:28'),
(509, 284, 'DJ017', 10, 38, '2023-09-07 13:41:28', '2023-09-07 13:41:28', '2023-09-07 13:41:28'),
(510, 285, 'DJ018', 11, 38, '2023-09-07 13:41:28', '2023-09-07 13:41:28', '2023-09-07 13:41:28'),
(511, 286, 'DJ019', 13, 38, '2023-09-07 13:41:28', '2023-09-07 13:41:28', '2023-09-07 13:41:28'),
(512, 287, 'DB059', 12, 38, '2023-09-06 23:13:29', '2023-09-06 23:13:29', '2023-09-06 23:13:29'),
(513, 125, 'KJ002', 43, 38, '2023-09-06 12:03:30', '2023-09-06 12:03:30', '2023-09-06 12:03:30'),
(514, 134, 'DB004', 34, 38, '2023-09-07 07:41:06', '2023-09-07 07:41:06', '2023-09-07 07:41:06'),
(515, 135, 'DB005', 31, 38, '2023-09-07 07:41:42', '2023-09-07 07:41:42', '2023-09-07 07:41:42'),
(516, 136, 'DB006', 34, 38, '2023-09-07 07:41:59', '2023-09-07 07:41:59', '2023-09-07 07:41:59'),
(517, 137, 'DB007', 35, 38, '2023-09-07 07:42:26', '2023-09-07 07:42:26', '2023-09-07 07:42:26'),
(518, 138, 'DB008', 35, 38, '2023-09-07 07:42:46', '2023-09-07 07:42:46', '2023-09-07 07:42:46'),
(519, 139, 'DB009', 36, 38, '2023-09-07 07:43:11', '2023-09-07 07:43:11', '2023-09-07 07:43:11');

-- --------------------------------------------------------

--
-- Struktur dari tabel `d_treatment`
--

CREATE TABLE `d_treatment` (
  `id_treatment` int(11) NOT NULL,
  `step` int(11) NOT NULL,
  `treatment` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `SequelizeMeta`
--

CREATE TABLE `SequelizeMeta` (
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data untuk tabel `SequelizeMeta`
--

INSERT INTO `SequelizeMeta` (`name`) VALUES
('20221004000000-create-d_peternakan-table.js'),
('20221004000001-create-auth_users-table.js'),
('20221004000002-create-d_fase_pemeliharaan-table.js'),
('20221004000003-create-d_bangsa-table.js'),
('20221004000004-create-d_penyakit-table.js'),
('20221004000005-create-d_jenis_bahan_pakan-table.js'),
('20221004000006-create-d_bahan_pakan-table.js'),
('20221004000007-create-d_jenis_pakan-table.js'),
('20221004000008-create-d_pakan-table.js'),
('20221004000009-create-d_jenis_kandang-table.js'),
('20221004000010-create-d_kandang-table.js'),
('20221004055922-create-d_status_ternak-table.js'),
('20221004055923-create-s_ternak-table.js'),
('20221004061516-create-d_kesehatan-table.js'),
('20221004061517-create-d_riwayat_kesehatan-table.js'),
('20221004065445-create-d_timbangan-table.js'),
('20221013023637-create-d_populasi-table.js'),
('20221024055952-create-d_lk_pemasukan-table.js'),
('20221029045838-create-d_pemeliharaan-table.js'),
('20221031042506-create-d_treatment-table.js'),
('20221031042516-create-d_adaptasi-table.js'),
('20221102071207-create-d_riwayat_fase-table.js'),
('20221108044906-create-d_perkawinan-table.js'),
('20221109051756-create-d_riwayat_perkawinan-table.js'),
('20221116055511-create-d_riwayat_kebuntingan-table.js'),
('20221120084809-create-d_riwayat_kelahiran-table.js'),
('20221122064323-create-d_riwayat_lepas_sapih-table.js');

-- --------------------------------------------------------

--
-- Struktur dari tabel `s_ternak`
--

CREATE TABLE `s_ternak` (
  `id_ternak` int(11) NOT NULL,
  `rf_id` varchar(255) DEFAULT NULL,
  `id_peternakan` int(11) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `jenis_kelamin` enum('Jantan','Betina') DEFAULT NULL,
  `id_bangsa` int(11) DEFAULT NULL,
  `id_kandang` int(11) DEFAULT NULL,
  `id_status_ternak` int(11) DEFAULT NULL,
  `id_fp` int(11) DEFAULT NULL,
  `id_dam` int(11) DEFAULT NULL,
  `id_sire` int(11) DEFAULT NULL,
  `tanggal_lahir` datetime DEFAULT NULL,
  `tanggal_masuk` datetime DEFAULT NULL,
  `tanggal_keluar` datetime DEFAULT NULL,
  `status_keluar` enum('Jual','Mati','Sembelih') DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `s_ternak`
--

INSERT INTO `s_ternak` (`id_ternak`, `rf_id`, `id_peternakan`, `image`, `jenis_kelamin`, `id_bangsa`, `id_kandang`, `id_status_ternak`, `id_fp`, `id_dam`, `id_sire`, `tanggal_lahir`, `tanggal_masuk`, `tanggal_keluar`, `status_keluar`, `createdAt`, `updatedAt`) VALUES
(116, 'DJ002', 1, NULL, 'Jantan', 2, 10, 2, 2, NULL, NULL, '2021-08-18 17:00:00', '2021-10-11 17:00:00', NULL, NULL, '2023-09-06 06:48:55', '2023-09-07 06:16:52'),
(117, 'DJ003', 1, NULL, 'Jantan', 2, 10, 2, 2, NULL, NULL, '2021-07-21 17:00:00', '2021-10-11 17:00:00', NULL, NULL, '2023-09-06 06:51:01', '2023-09-06 12:01:24'),
(118, 'KJ001', 1, NULL, 'Jantan', 24, 11, 2, 2, NULL, NULL, '2022-11-08 17:00:00', '2023-08-27 17:00:00', NULL, NULL, '2023-09-06 06:52:14', '2023-09-06 12:03:30'),
(125, 'KJ002', 1, NULL, 'Jantan', 24, 11, 2, 2, NULL, NULL, '2022-11-20 17:00:00', '2023-08-27 17:00:00', NULL, NULL, '2023-09-06 07:02:36', '2023-09-06 19:20:45'),
(126, 'KB001', 1, NULL, 'Betina', 24, 11, 7, 2, NULL, NULL, '2022-10-11 17:00:00', '2023-08-27 17:00:00', NULL, NULL, '2023-09-06 07:03:27', '2023-09-06 12:05:34'),
(127, 'KB002', 1, NULL, 'Betina', 24, 11, 7, 2, NULL, NULL, '2022-09-12 17:00:00', '2023-08-27 17:00:00', NULL, NULL, '2023-09-06 07:04:56', '2023-09-06 12:07:11'),
(128, 'KB003', 1, NULL, 'Betina', 24, 11, 7, 2, NULL, NULL, '2022-09-22 17:00:00', '2023-08-27 17:00:00', NULL, NULL, '2023-09-06 07:05:36', '2023-09-06 12:07:40'),
(129, 'KB004', 1, NULL, 'Betina', 24, 11, 7, 2, NULL, NULL, '2022-09-30 17:00:00', '2023-08-27 17:00:00', NULL, NULL, '2023-09-06 07:06:20', '2023-09-06 12:08:51'),
(130, 'KB005', 1, NULL, 'Betina', 24, 11, 7, 2, NULL, NULL, '2022-08-29 17:00:00', '2023-08-27 17:00:00', NULL, NULL, '2023-09-06 07:06:59', '2023-09-06 12:09:52'),
(131, 'DB001', 1, NULL, 'Betina', 1, 12, 1, 7, NULL, NULL, '2021-12-13 17:00:00', '2022-02-07 17:00:00', NULL, NULL, '2023-09-06 07:10:04', '2023-09-06 12:11:08'),
(132, 'DB002', 1, NULL, 'Betina', 1, 12, 1, 7, NULL, NULL, '2021-12-19 17:00:00', '2022-02-07 17:00:00', NULL, NULL, '2023-09-06 07:12:03', '2023-09-06 12:12:05'),
(133, 'DB003', 1, NULL, 'Betina', 1, 12, 1, 7, NULL, NULL, '2021-11-21 17:00:00', '2022-02-07 17:00:00', NULL, NULL, '2023-09-06 07:13:07', '2023-09-06 12:13:10'),
(134, 'DB004', 1, NULL, 'Betina', 1, 12, 1, 7, 131, 140, '2021-12-09 17:00:00', '2022-02-07 17:00:00', NULL, NULL, '2023-09-06 07:13:57', '2023-09-07 07:41:06'),
(135, 'DB005', 1, NULL, 'Betina', 1, 12, 1, 7, 132, 116, '2021-11-04 17:00:00', '2022-02-07 17:00:00', NULL, NULL, '2023-09-06 07:18:31', '2023-09-07 07:41:42'),
(136, 'DB006', 1, NULL, 'Betina', 1, 12, 1, 7, 133, 117, '2021-12-29 17:00:00', '2022-02-07 17:00:00', NULL, NULL, '2023-09-06 07:40:40', '2023-09-07 07:41:59'),
(137, 'DB007', 1, NULL, 'Betina', 1, 12, 1, 7, 134, 140, '2021-10-29 17:00:00', '2022-02-07 17:00:00', NULL, NULL, '2023-09-06 07:42:10', '2023-09-07 07:42:26'),
(138, 'DB008', 1, NULL, 'Betina', 1, 12, 1, 7, 135, 116, '2021-11-04 17:00:00', '2022-02-07 17:00:00', NULL, NULL, '2023-09-06 07:43:58', '2023-09-07 07:42:46'),
(139, 'DB009', 1, NULL, 'Betina', 1, 12, 1, 7, 136, 117, '2021-11-03 17:00:00', '2022-02-07 17:00:00', NULL, NULL, '2023-09-06 07:44:44', '2023-09-07 07:43:11'),
(140, 'DJ001', 1, NULL, 'Jantan', 2, 10, 2, 2, NULL, NULL, '2021-08-07 17:00:00', '2021-10-11 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 11:56:48'),
(141, 'DJ004', 1, NULL, 'Jantan', 3, 12, 3, 12, 140, 131, '2023-06-10 17:00:00', '2023-06-10 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-07 09:37:27'),
(142, 'DB060', 1, NULL, 'Betina', 1, 16, 1, 9, NULL, NULL, '2021-11-22 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(143, 'DB061', 1, NULL, 'Betina', 1, 16, 1, 9, NULL, NULL, '2021-12-10 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 13:02:12'),
(144, 'DB062', 1, NULL, 'Betina', 1, 16, 1, 9, NULL, NULL, '2021-11-05 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(145, 'DB063', 1, NULL, 'Betina', 1, 16, 1, 9, NULL, NULL, '2021-12-30 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(146, 'DB064', 1, NULL, 'Betina', 1, 16, 1, 9, NULL, NULL, '2021-10-30 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(147, 'DB065', 1, NULL, 'Betina', 1, 16, 1, 9, NULL, NULL, '2021-11-05 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(148, 'DB066', 1, NULL, 'Betina', 1, 17, 4, 2, NULL, NULL, '2021-11-22 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 18:57:22'),
(149, 'DB067', 1, NULL, 'Betina', 1, 17, 4, 2, NULL, NULL, '2021-12-10 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 18:57:22'),
(150, 'DB068', 1, NULL, 'Betina', 1, 17, 4, 2, NULL, NULL, '2021-11-05 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 18:57:22'),
(151, 'DB069', 1, NULL, 'Betina', 1, 17, 4, 2, NULL, NULL, '2021-12-30 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 18:57:22'),
(152, 'DB070', 1, NULL, 'Betina', 1, 17, 4, 2, NULL, NULL, '2021-10-30 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 18:57:22'),
(153, 'DB071', 1, NULL, 'Betina', 1, 17, 4, 2, NULL, NULL, '2021-11-05 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 18:57:22'),
(154, 'DB072', 1, NULL, 'Betina', 1, 17, 4, 2, NULL, NULL, '2021-12-06 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 18:57:22'),
(155, 'DB073', 1, NULL, 'Betina', 1, 17, 4, 2, NULL, NULL, '2021-10-07 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 18:57:22'),
(156, 'DJ020', 1, NULL, 'Jantan', 5, 17, 3, 12, NULL, NULL, '2023-08-14 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(157, 'DJ021', 1, NULL, 'Jantan', 5, 17, 3, 12, NULL, NULL, '2023-08-15 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 12:58:25'),
(158, 'DJ022', 1, NULL, 'Jantan', 5, 17, 3, 12, NULL, NULL, '2023-08-16 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(159, 'DJ023', 1, NULL, 'Jantan', 3, 17, 6, 12, NULL, NULL, '2023-02-27 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(160, 'DJ024', 1, NULL, 'Jantan', 3, 17, 3, 12, NULL, NULL, '2023-08-18 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(161, 'DJ025', 1, NULL, 'Jantan', 3, 17, 3, 12, NULL, NULL, '2023-08-19 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(162, 'DB074', 1, NULL, 'Betina', 1, 18, 1, 8, NULL, NULL, '2021-11-05 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(163, 'DB075', 1, NULL, 'Betina', 1, 18, 1, 8, NULL, NULL, '2021-12-30 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(164, 'DB076', 1, NULL, 'Betina', 1, 18, 1, 8, NULL, NULL, '2021-10-30 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(165, 'DB077', 1, NULL, 'Betina', 1, 18, 1, 8, NULL, NULL, '2021-11-05 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(166, 'DB078', 1, NULL, 'Betina', 1, 18, 1, 8, NULL, NULL, '2021-11-04 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(167, 'DB079', 1, NULL, 'Betina', 1, 18, 1, 8, NULL, NULL, '2021-11-05 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(168, 'DB080', 1, NULL, 'Betina', 1, 18, 1, 8, NULL, NULL, '2021-11-06 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(169, 'DJ026', 1, NULL, 'Jantan', 2, 18, 2, 8, NULL, NULL, '2021-12-10 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 19:49:44'),
(170, 'DJ005', 1, NULL, 'Jantan', 3, 12, 3, 12, 116, 132, '2023-06-11 17:00:00', '2023-06-11 17:00:00', NULL, NULL, '2023-09-06 12:28:36', '2023-09-07 06:18:48'),
(171, 'DJ006', 1, NULL, 'Jantan', 3, 12, 3, 12, 117, 133, '2023-06-12 17:00:00', '2023-06-12 17:00:00', NULL, NULL, '2023-09-06 12:29:38', '2023-09-07 09:39:50'),
(172, 'DJ007', 1, NULL, 'Jantan', 3, 12, 3, 12, 140, 134, '2023-06-13 17:00:00', '2023-06-13 17:00:00', NULL, NULL, '2023-09-06 12:31:41', '2023-09-07 09:40:27'),
(173, 'DJ008', 1, NULL, 'Jantan', 3, 12, 3, 12, 116, 135, '2023-06-14 17:00:00', '2023-06-14 17:00:00', NULL, NULL, '2023-09-06 12:32:34', '2023-09-07 06:15:20'),
(174, 'DJ009', 1, NULL, 'Jantan', 3, 12, 3, 12, 117, 136, '2023-06-15 17:00:00', '2023-06-15 17:00:00', NULL, NULL, '2023-09-06 12:33:33', '2023-09-07 09:42:53'),
(175, 'DB010', 1, NULL, 'Betina', 3, 12, 3, 12, 140, 137, '2023-06-16 17:00:00', '2023-06-16 17:00:00', NULL, NULL, '2023-09-06 12:35:47', '2023-09-07 09:43:46'),
(176, 'DB011', 1, NULL, 'Betina', 3, 12, 3, 12, 116, 138, '2023-06-17 17:00:00', '2023-06-17 17:00:00', NULL, NULL, '2023-09-06 12:36:39', '2023-09-07 09:44:16'),
(177, 'DB012', 1, NULL, 'Betina', 3, 12, 3, 12, 117, 139, '2023-06-18 17:00:00', '2023-06-18 17:00:00', NULL, NULL, '2023-09-06 12:39:19', '2023-09-07 09:45:38'),
(178, 'DB013', 1, NULL, 'Betina', 3, 12, 3, 12, 140, 131, '2023-06-10 17:00:00', '2023-06-10 17:00:00', NULL, NULL, '2023-09-06 12:40:49', '2023-09-07 09:46:13'),
(179, 'DB014', 1, NULL, 'Betina', 3, 12, 3, 12, 116, 132, '2023-06-11 17:00:00', '2023-06-11 17:00:00', NULL, NULL, '2023-09-06 12:42:03', '2023-09-07 09:46:37'),
(180, 'DB015', 1, NULL, 'Betina', 3, 12, 3, 12, 117, 133, '2023-06-12 17:00:00', '2023-06-12 17:00:00', NULL, NULL, '2023-09-06 12:43:54', '2023-09-07 09:47:10'),
(181, 'DB016', 1, NULL, 'Betina', 3, 12, 3, 12, NULL, NULL, '2023-06-13 17:00:00', '2023-06-13 17:00:00', NULL, NULL, '2023-09-06 12:44:57', '2023-09-06 14:37:07'),
(182, 'DB081', 1, NULL, 'Betina', 1, 19, 1, 8, NULL, NULL, '2021-11-05 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(183, 'DB082', 1, NULL, 'Betina', 1, 19, 1, 8, NULL, NULL, '2021-12-30 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(184, 'DB083', 1, NULL, 'Betina', 1, 19, 1, 8, NULL, NULL, '2021-10-30 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(185, 'DB084', 1, NULL, 'Betina', 1, 19, 1, 8, NULL, NULL, '2021-11-05 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(186, 'DB085', 1, NULL, 'Betina', 1, 19, 1, 8, NULL, NULL, '2021-11-04 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(187, 'DB086', 1, NULL, 'Betina', 1, 19, 1, 8, NULL, NULL, '2021-11-05 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(188, 'DB087', 1, NULL, 'Betina', 2, 19, 1, 8, NULL, NULL, '2023-01-30 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(189, 'DB088', 1, NULL, 'Betina', 2, 19, 1, 8, NULL, NULL, '2023-01-31 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(190, 'DB089', 1, NULL, 'Betina', 2, 19, 1, 8, NULL, NULL, '2023-02-01 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(191, 'DB090', 1, NULL, 'Betina', 2, 19, 1, 8, NULL, NULL, '2023-02-02 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(192, 'DB091', 1, NULL, 'Betina', 2, 19, 1, 8, NULL, NULL, '2023-02-03 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(193, 'DB092', 1, NULL, 'Betina', 2, 19, 1, 8, NULL, NULL, '2023-02-04 17:00:00', '2022-08-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(194, 'DB017', 1, NULL, 'Betina', 5, 13, 3, 12, NULL, NULL, '2023-04-27 17:00:00', '2023-04-27 17:00:00', NULL, NULL, '2023-09-06 12:48:04', '2023-09-06 13:19:44'),
(195, 'DJ027', 1, NULL, 'Jantan', 5, 18, 2, 8, NULL, NULL, '2021-08-17 17:00:00', '2021-12-10 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(196, 'DB018', 1, NULL, 'Betina', 5, 13, 3, 12, NULL, NULL, '2023-04-28 17:00:00', '2023-04-28 17:00:00', NULL, NULL, '2023-09-06 12:52:43', '2023-09-06 13:19:34'),
(197, 'DB019', 1, NULL, 'Betina', 5, 13, 3, 12, NULL, NULL, '2023-04-29 17:00:00', '2023-04-29 17:00:00', NULL, NULL, '2023-09-06 12:53:53', '2023-09-06 13:19:23'),
(198, 'DB020', 1, NULL, 'Betina', 5, 13, 3, 12, NULL, NULL, '2023-04-30 17:00:00', '2023-04-30 17:00:00', NULL, NULL, '2023-09-06 12:55:10', '2023-09-07 06:05:34'),
(199, 'DB021', 1, NULL, 'Betina', 5, 13, 3, 12, NULL, NULL, '2023-05-01 17:00:00', '2023-05-01 17:00:00', NULL, NULL, '2023-09-06 12:56:17', '2023-09-06 13:18:42'),
(200, 'DB093', 1, NULL, 'Betina', 7, 20, 5, 2, NULL, NULL, '2023-02-20 17:00:00', '2023-08-30 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(201, 'DB094', 1, NULL, 'Betina', 7, 20, 5, 2, NULL, NULL, '2023-02-21 17:00:00', '2023-08-31 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(202, 'DB095', 1, NULL, 'Betina', 7, 20, 5, 2, NULL, NULL, '2023-02-22 17:00:00', '2023-09-01 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(203, 'DB096', 1, NULL, 'Betina', 7, 20, 5, 2, NULL, NULL, '2023-02-23 17:00:00', '2023-09-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(204, 'DB097', 1, NULL, 'Betina', 7, 20, 5, 2, NULL, NULL, '2023-02-24 17:00:00', '2023-09-03 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(205, 'DB098', 1, NULL, 'Betina', 7, 20, 5, 2, NULL, NULL, '2023-02-25 17:00:00', '2023-09-04 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(206, 'DB099', 1, NULL, 'Betina', 7, 20, 5, 2, NULL, NULL, '2023-02-26 17:00:00', '2023-09-05 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(207, 'DB100', 1, NULL, 'Betina', 7, 20, 5, 2, NULL, NULL, '2023-02-27 17:00:00', '2023-09-06 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(208, 'DB101', 1, NULL, 'Betina', 7, 20, 5, 2, NULL, NULL, '2023-02-28 17:00:00', '2023-09-07 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(209, 'DB102', 1, NULL, 'Betina', 7, 20, 5, 2, NULL, NULL, '2023-03-01 17:00:00', '2023-09-08 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(210, 'DB103', 1, NULL, 'Betina', 7, 20, 5, 2, NULL, NULL, '2023-03-02 17:00:00', '2023-09-09 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(211, 'DB104', 1, NULL, 'Betina', 7, 20, 5, 2, NULL, NULL, '2023-03-03 17:00:00', '2023-09-10 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(212, 'DB105', 1, NULL, 'Betina', 7, 20, 5, 2, NULL, NULL, '2023-03-04 17:00:00', '2023-09-11 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(213, 'DB106', 1, NULL, 'Betina', 7, 20, 5, 2, NULL, NULL, '2023-03-05 17:00:00', '2023-09-12 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(214, 'DB107', 1, NULL, 'Betina', 7, 20, 5, 2, NULL, NULL, '2023-03-06 17:00:00', '2023-09-13 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(215, 'DB108', 1, NULL, 'Betina', 7, 20, 5, 2, NULL, NULL, '2023-03-07 17:00:00', '2023-09-14 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(216, 'DB109', 1, NULL, 'Betina', 7, 20, 5, 2, NULL, NULL, '2023-03-08 17:00:00', '2023-09-15 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(217, 'DB110', 1, NULL, 'Betina', 7, 20, 5, 2, NULL, NULL, '2023-03-09 17:00:00', '2023-09-16 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(218, 'DB111', 1, NULL, 'Betina', 7, 20, 5, 2, NULL, NULL, '2023-03-10 17:00:00', '2023-09-17 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(219, 'DB112', 1, NULL, 'Betina', 7, 20, 5, 2, NULL, NULL, '2023-03-11 17:00:00', '2023-09-18 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(220, 'DB022', 1, NULL, 'Betina', 5, 13, 3, 12, NULL, NULL, '2023-05-02 17:00:00', '2023-05-02 17:00:00', NULL, NULL, '2023-09-06 13:03:28', '2023-09-06 13:18:25'),
(221, 'DB023', 1, NULL, 'Betina', 5, 13, 3, 12, NULL, NULL, '2023-05-03 17:00:00', '2023-05-03 17:00:00', NULL, NULL, '2023-09-06 13:05:04', '2023-09-06 13:20:51'),
(222, 'DB024', 1, NULL, 'Betina', 5, 13, 3, 12, NULL, NULL, '2023-05-04 17:00:00', '2023-05-04 17:00:00', NULL, NULL, '2023-09-06 13:08:30', '2023-09-06 13:17:06'),
(223, 'DB025', 1, NULL, 'Betina', 5, 13, 3, 12, NULL, NULL, '2023-05-05 17:00:00', '2023-05-05 17:00:00', NULL, NULL, '2023-09-06 13:09:28', '2023-09-06 13:21:36'),
(224, 'DB026', 1, NULL, 'Betina', 3, 13, 3, 12, NULL, NULL, '2023-05-06 17:00:00', '2023-05-06 17:00:00', NULL, NULL, '2023-09-06 13:10:57', '2023-09-06 13:12:51'),
(225, 'DB113', 1, NULL, 'Betina', 7, 21, 5, 2, NULL, NULL, '2023-03-12 17:00:00', '2023-08-30 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(226, 'DB114', 1, NULL, 'Betina', 7, 21, 5, 2, NULL, NULL, '2023-03-13 17:00:00', '2023-08-31 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(227, 'DB115', 1, NULL, 'Betina', 7, 21, 5, 2, NULL, NULL, '2023-03-14 17:00:00', '2023-09-01 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(228, 'DB116', 1, NULL, 'Betina', 7, 21, 5, 2, NULL, NULL, '2023-03-15 17:00:00', '2023-09-02 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(229, 'DB117', 1, NULL, 'Betina', 7, 21, 5, 2, NULL, NULL, '2023-03-16 17:00:00', '2023-09-03 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(230, 'DB118', 1, NULL, 'Betina', 7, 21, 5, 2, NULL, NULL, '2023-03-17 17:00:00', '2023-09-04 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(231, 'DB119', 1, NULL, 'Betina', 7, 21, 5, 2, NULL, NULL, '2023-03-18 17:00:00', '2023-09-05 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(232, 'DB120', 1, NULL, 'Betina', 7, 21, 5, 2, NULL, NULL, '2023-03-19 17:00:00', '2023-09-06 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(233, 'DB121', 1, NULL, 'Betina', 7, 21, 5, 2, NULL, NULL, '2023-03-20 17:00:00', '2023-09-07 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(234, 'DB122', 1, NULL, 'Betina', 7, 21, 5, 2, NULL, NULL, '2023-03-21 17:00:00', '2023-09-08 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(235, 'DB123', 1, NULL, 'Betina', 7, 21, 5, 2, NULL, NULL, '2023-03-22 17:00:00', '2023-09-09 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(236, 'DB124', 1, NULL, 'Betina', 7, 21, 5, 2, NULL, NULL, '2023-03-23 17:00:00', '2023-09-10 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(237, 'DB125', 1, NULL, 'Betina', 7, 21, 5, 2, NULL, NULL, '2023-03-24 17:00:00', '2023-09-11 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(238, 'DB126', 1, NULL, 'Betina', 7, 21, 5, 2, NULL, NULL, '2023-03-25 17:00:00', '2023-09-12 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(239, 'DB127', 1, NULL, 'Betina', 7, 21, 5, 2, NULL, NULL, '2023-03-26 17:00:00', '2023-09-13 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(240, 'DB128', 1, NULL, 'Betina', 7, 21, 5, 2, NULL, NULL, '2023-03-27 17:00:00', '2023-09-14 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(241, 'DB129', 1, NULL, 'Betina', 7, 21, 5, 2, NULL, NULL, '2023-03-28 17:00:00', '2023-09-15 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(242, 'DB130', 1, NULL, 'Betina', 7, 21, 5, 2, NULL, NULL, '2023-03-29 17:00:00', '2023-09-16 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(243, 'DB131', 1, NULL, 'Betina', 7, 21, 5, 2, NULL, NULL, '2023-03-30 17:00:00', '2023-09-17 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(244, 'DB132', 1, NULL, 'Betina', 7, 21, 5, 2, NULL, NULL, '2023-03-31 17:00:00', '2023-09-18 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(245, 'DB027', 1, NULL, 'Betina', 3, 13, 3, 12, NULL, NULL, '2023-05-07 17:00:00', '2023-05-07 17:00:00', NULL, NULL, '2023-09-06 13:22:37', '2023-09-06 13:23:23'),
(246, 'DB028', 1, NULL, 'Betina', 3, 13, 3, 12, NULL, NULL, '2023-05-08 17:00:00', '2023-05-08 17:00:00', NULL, NULL, '2023-09-06 13:24:17', '2023-09-06 14:38:30'),
(247, 'DB029', 1, NULL, 'Betina', 3, 13, 3, 12, NULL, NULL, '2023-05-09 17:00:00', '2023-05-09 17:00:00', NULL, NULL, '2023-09-06 13:25:27', '2023-09-06 14:39:07'),
(248, 'DB030', 1, NULL, 'Betina', 3, 13, 3, 12, NULL, NULL, '2023-05-10 17:00:00', '2023-05-10 17:00:00', NULL, NULL, '2023-09-06 13:26:26', '2023-09-06 13:26:56'),
(249, 'DB031', 1, NULL, 'Betina', 3, 13, 3, 12, NULL, NULL, '2023-05-11 17:00:00', '2023-05-11 17:00:00', NULL, NULL, '2023-09-06 13:27:33', '2023-09-06 14:39:34'),
(250, 'DB032', 1, NULL, 'Betina', 3, 13, 3, 12, NULL, NULL, '2023-05-12 17:00:00', '2023-05-12 17:00:00', NULL, NULL, '2023-09-06 13:28:54', '2023-09-06 13:29:15'),
(251, 'DJ010', 1, NULL, 'Jantan', 3, 13, 6, 12, NULL, NULL, '2023-04-28 17:00:00', '2023-04-28 17:00:00', NULL, NULL, '2023-09-06 13:30:45', '2023-09-06 13:31:07'),
(252, 'DJ011', 1, NULL, 'Jantan', 3, 13, 6, 12, NULL, NULL, '2023-02-26 17:00:00', '2023-02-26 17:00:00', NULL, NULL, '2023-09-06 13:31:50', '2023-09-06 13:32:19'),
(253, 'DB033', 1, NULL, 'Betina', 2, 14, 1, 7, NULL, NULL, '2022-08-09 17:00:00', '2023-02-28 17:00:00', NULL, NULL, '2023-09-06 14:43:08', '2023-09-06 14:43:48'),
(254, 'DB034', 1, NULL, 'Betina', 2, 14, 1, 7, NULL, NULL, '2022-08-10 17:00:00', '2023-02-28 17:00:00', NULL, NULL, '2023-09-06 14:44:51', '2023-09-06 14:48:36'),
(255, 'DB035', 1, NULL, 'Betina', 2, 14, 1, 7, NULL, NULL, '2022-08-11 17:00:00', '2023-02-28 17:00:00', NULL, NULL, '2023-09-06 14:45:46', '2023-09-06 14:49:00'),
(256, 'DB036', 1, NULL, 'Betina', 2, 14, 7, 7, NULL, NULL, '2022-02-10 17:00:00', '2023-03-14 17:00:00', NULL, NULL, '2023-09-06 14:46:48', '2023-09-06 14:49:42'),
(257, 'DB037', 1, NULL, 'Betina', 2, 14, 1, 9, NULL, NULL, '2022-08-13 17:00:00', '2023-02-28 17:00:00', NULL, NULL, '2023-09-06 14:51:08', '2023-09-06 14:54:12'),
(258, 'DB038', 1, NULL, 'Betina', 2, 14, 1, 9, NULL, NULL, '2022-08-14 17:00:00', '2023-02-28 17:00:00', NULL, NULL, '2023-09-06 14:52:00', '2023-09-06 14:54:33'),
(259, 'DB039', 1, NULL, 'Betina', 2, 14, 1, 9, NULL, NULL, '2022-08-15 17:00:00', '2023-02-28 17:00:00', NULL, NULL, '2023-09-06 14:52:46', '2023-09-06 14:54:50'),
(260, 'DB040', 1, NULL, 'Betina', 2, 14, 1, 9, NULL, NULL, '2022-08-16 17:00:00', '2023-02-28 17:00:00', NULL, NULL, '2023-09-06 14:53:41', '2023-09-06 14:55:12'),
(261, 'DB041', 1, NULL, 'Betina', 2, 14, 3, 12, 140, 254, '2023-05-31 17:00:00', '2023-05-31 17:00:00', NULL, NULL, '2023-09-06 14:56:58', '2023-09-07 09:34:10'),
(262, 'DB042', 1, NULL, 'Betina', 2, 14, 3, 12, 116, 255, '2023-06-01 17:00:00', '2023-06-01 17:00:00', NULL, NULL, '2023-09-06 14:58:11', '2023-09-07 09:34:48'),
(263, 'DJ012', 1, NULL, 'Jantan', 2, 14, 3, 12, 140, 256, '2023-06-02 17:00:00', '2023-06-05 17:00:00', NULL, NULL, '2023-09-06 15:00:06', '2023-09-07 09:35:27'),
(264, 'DB043', 1, NULL, 'Betina', 1, 15, 1, 10, NULL, NULL, '2021-12-13 17:00:00', '2022-02-07 17:00:00', NULL, NULL, '2023-09-06 15:03:35', '2023-09-06 15:23:54'),
(265, 'DB044', 1, NULL, 'Betina', 1, NULL, 1, 10, NULL, NULL, '2021-12-19 17:00:00', '2022-02-07 17:00:00', NULL, NULL, '2023-09-06 15:04:50', '2023-09-06 15:21:22'),
(266, 'DB045', 1, NULL, 'Betina', 1, 15, 1, 10, NULL, NULL, '2021-11-21 17:00:00', '2022-02-07 17:00:00', NULL, NULL, '2023-09-06 15:06:06', '2023-09-06 15:21:37'),
(267, 'DB046', 1, NULL, 'Betina', 1, 15, 1, 10, NULL, NULL, '2021-12-09 17:00:00', '2022-02-07 17:00:00', NULL, NULL, '2023-09-06 15:07:14', '2023-09-06 15:21:52'),
(268, 'DB047', 1, NULL, 'Betina', 1, 15, 1, 10, NULL, NULL, '2021-11-04 17:00:00', '2022-02-07 17:00:00', NULL, NULL, '2023-09-06 15:08:03', '2023-09-06 15:22:10'),
(269, 'DB048', 1, NULL, 'Betina', 1, 15, 1, 10, NULL, NULL, '2020-12-29 17:00:00', '2022-02-07 17:00:00', NULL, NULL, '2023-09-06 15:10:48', '2023-09-06 15:22:36'),
(270, 'DB049', 1, NULL, 'Betina', 1, 15, 1, 10, NULL, NULL, '2021-10-29 17:00:00', '2022-02-07 17:00:00', NULL, NULL, '2023-09-06 15:11:24', '2023-09-06 15:24:45'),
(271, 'DB050', 1, NULL, 'Betina', 1, 15, 1, 10, NULL, NULL, '2021-11-04 17:00:00', '2022-02-07 17:00:00', NULL, NULL, '2023-09-06 15:12:07', '2023-09-06 15:25:15'),
(272, 'DB051', 1, NULL, 'Betina', 1, 15, 1, 10, NULL, NULL, '2021-11-03 17:00:00', '2022-02-07 17:00:00', NULL, NULL, '2023-09-06 15:12:57', '2023-09-06 15:25:41'),
(273, 'DB052', 1, NULL, 'Betina', 1, 15, 1, 10, NULL, NULL, '2021-11-04 17:00:00', '2022-02-07 17:00:00', NULL, NULL, '2023-09-06 15:13:35', '2023-09-06 15:26:04'),
(274, 'DB053', 1, NULL, 'Betina', 3, 15, 3, 10, NULL, NULL, '2023-08-12 17:00:00', '2023-08-12 17:00:00', NULL, NULL, '2023-09-06 23:08:03', '2023-09-06 23:08:34'),
(275, 'DB054', 1, NULL, 'Betina', 3, 15, 3, 10, 140, 265, '2023-08-13 17:00:00', '2023-08-06 17:00:00', NULL, NULL, '2023-09-06 23:09:14', '2023-09-07 09:25:52'),
(276, 'DB055', 1, NULL, 'Betina', 3, 15, 3, 10, 116, 266, '2023-08-14 17:00:00', '2023-08-14 17:00:00', NULL, NULL, '2023-09-06 23:10:09', '2023-09-07 09:26:33'),
(277, 'DB056', 1, NULL, 'Betina', 3, 15, 3, 10, 117, 267, '2023-08-15 17:00:00', '2023-08-15 17:00:00', NULL, NULL, '2023-09-06 23:11:02', '2023-09-07 09:27:26'),
(278, 'DB057', 1, NULL, 'Betina', 3, 15, 3, 10, 140, 268, '2023-08-16 17:00:00', '2023-08-16 17:00:00', NULL, NULL, '2023-09-06 23:11:59', '2023-09-07 09:28:01'),
(279, 'DB058', 1, NULL, 'Betina', 3, 15, 3, 10, 116, 267, '2023-08-17 17:00:00', '2023-08-17 17:00:00', NULL, NULL, '2023-09-06 23:13:13', '2023-09-07 09:30:32'),
(280, 'DJ013', 1, NULL, 'Jantan', 3, 15, 3, 10, 271, 140, '2023-08-19 17:00:00', '2023-08-19 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(281, 'DJ014', 1, NULL, 'Jantan', 3, 15, 3, 10, 116, 272, '2023-08-20 17:00:00', '2023-08-20 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(282, 'DJ015', 1, NULL, 'Jantan', 3, 15, 3, 10, 117, 273, '2023-08-21 17:00:00', '2023-08-21 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(283, 'DJ016', 1, NULL, 'Jantan', 3, 15, 3, 10, 140, 274, '2023-08-22 17:00:00', '2023-08-22 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-07 09:13:39'),
(284, 'DJ017', 1, NULL, 'Jantan', 3, 15, 3, 10, 140, 265, '2023-08-13 17:00:00', '2023-08-13 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-07 09:14:51'),
(285, 'DJ018', 1, NULL, 'Jantan', 3, 15, 3, 10, 116, 266, '2023-08-14 17:00:00', '2023-08-14 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(286, 'DJ019', 1, NULL, 'Jantan', 3, 15, 3, 10, 117, 267, '2023-08-15 17:00:00', '2023-08-15 17:00:00', NULL, NULL, '2023-09-06 08:56:29', '2023-09-06 08:56:29'),
(287, 'DB059', 1, NULL, 'Betina', 3, 15, 3, 10, NULL, NULL, '2023-08-12 17:00:00', '2023-08-12 17:00:00', NULL, NULL, '2023-09-06 23:08:03', '2023-09-06 23:08:34');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `auth_users`
--
ALTER TABLE `auth_users`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `nama_pengguna` (`nama_pengguna`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `nomor_telepon` (`nomor_telepon`),
  ADD KEY `id_peternakan` (`id_peternakan`);

--
-- Indeks untuk tabel `d_adaptasi`
--
ALTER TABLE `d_adaptasi`
  ADD PRIMARY KEY (`id_adaptasi`),
  ADD KEY `id_peternakan` (`id_peternakan`),
  ADD KEY `id_ternak` (`id_ternak`),
  ADD KEY `id_treatment` (`id_treatment`),
  ADD KEY `id_kandang` (`id_kandang`);

--
-- Indeks untuk tabel `d_bahan_pakan`
--
ALTER TABLE `d_bahan_pakan`
  ADD PRIMARY KEY (`id_bahan_pakan`),
  ADD KEY `id_peternakan` (`id_peternakan`),
  ADD KEY `id_jenis_bahan_pakan` (`id_jenis_bahan_pakan`);

--
-- Indeks untuk tabel `d_bangsa`
--
ALTER TABLE `d_bangsa`
  ADD PRIMARY KEY (`id_bangsa`);

--
-- Indeks untuk tabel `d_fase`
--
ALTER TABLE `d_fase`
  ADD PRIMARY KEY (`id_fp`);

--
-- Indeks untuk tabel `d_jenis_bahan_pakan`
--
ALTER TABLE `d_jenis_bahan_pakan`
  ADD PRIMARY KEY (`id_jenis_bahan_pakan`),
  ADD KEY `id_peternakan` (`id_peternakan`);

--
-- Indeks untuk tabel `d_jenis_kandang`
--
ALTER TABLE `d_jenis_kandang`
  ADD PRIMARY KEY (`id_jenis_kandang`);

--
-- Indeks untuk tabel `d_jenis_pakan`
--
ALTER TABLE `d_jenis_pakan`
  ADD PRIMARY KEY (`id_jenis_pakan`),
  ADD KEY `id_peternakan` (`id_peternakan`);

--
-- Indeks untuk tabel `d_kandang`
--
ALTER TABLE `d_kandang`
  ADD PRIMARY KEY (`id_kandang`),
  ADD KEY `id_peternakan` (`id_peternakan`),
  ADD KEY `id_jenis_kandang` (`id_jenis_kandang`),
  ADD KEY `id_jenis_pakan` (`id_jenis_pakan`);

--
-- Indeks untuk tabel `d_kesehatan`
--
ALTER TABLE `d_kesehatan`
  ADD PRIMARY KEY (`id_kesehatan`),
  ADD KEY `id_peternakan` (`id_peternakan`),
  ADD KEY `id_ternak` (`id_ternak`),
  ADD KEY `id_penyakit` (`id_penyakit`);

--
-- Indeks untuk tabel `d_lk_pemasukan`
--
ALTER TABLE `d_lk_pemasukan`
  ADD PRIMARY KEY (`id_lk_pemasukan`),
  ADD KEY `id_peternakan` (`id_peternakan`),
  ADD KEY `id_ternak` (`id_ternak`),
  ADD KEY `id_bangsa` (`id_bangsa`),
  ADD KEY `id_status_ternak` (`id_status_ternak`),
  ADD KEY `id_kandang` (`id_kandang`);

--
-- Indeks untuk tabel `d_pakan`
--
ALTER TABLE `d_pakan`
  ADD PRIMARY KEY (`id_pakan`),
  ADD KEY `id_peternakan` (`id_peternakan`),
  ADD KEY `id_jenis_pakan` (`id_jenis_pakan`);

--
-- Indeks untuk tabel `d_pemeliharaan`
--
ALTER TABLE `d_pemeliharaan`
  ADD PRIMARY KEY (`id_pemeliharaan`),
  ADD KEY `id_peternakan` (`id_peternakan`),
  ADD KEY `id_kandang` (`id_kandang`);

--
-- Indeks untuk tabel `d_penyakit`
--
ALTER TABLE `d_penyakit`
  ADD PRIMARY KEY (`id_penyakit`);

--
-- Indeks untuk tabel `d_perkawinan`
--
ALTER TABLE `d_perkawinan`
  ADD PRIMARY KEY (`id_perkawinan`),
  ADD KEY `id_peternakan` (`id_peternakan`),
  ADD KEY `id_indukan` (`id_indukan`),
  ADD KEY `id_pejantan` (`id_pejantan`),
  ADD KEY `id_kandang` (`id_kandang`);

--
-- Indeks untuk tabel `d_peternakan`
--
ALTER TABLE `d_peternakan`
  ADD PRIMARY KEY (`id_peternakan`);

--
-- Indeks untuk tabel `d_populasi`
--
ALTER TABLE `d_populasi`
  ADD PRIMARY KEY (`id_populasi`),
  ADD KEY `id_peternakan` (`id_peternakan`);

--
-- Indeks untuk tabel `d_riwayat_fase`
--
ALTER TABLE `d_riwayat_fase`
  ADD PRIMARY KEY (`id_riwayat_fase`),
  ADD KEY `id_peternakan` (`id_peternakan`),
  ADD KEY `id_fp` (`id_fp`),
  ADD KEY `id_ternak` (`id_ternak`);

--
-- Indeks untuk tabel `d_riwayat_kebuntingan`
--
ALTER TABLE `d_riwayat_kebuntingan`
  ADD PRIMARY KEY (`id_riwayat_kebuntingan`),
  ADD KEY `id_peternakan` (`id_peternakan`),
  ADD KEY `id_riwayat_perkawinan` (`id_riwayat_perkawinan`),
  ADD KEY `id_indukan` (`id_indukan`),
  ADD KEY `id_pejantan` (`id_pejantan`);

--
-- Indeks untuk tabel `d_riwayat_kelahiran`
--
ALTER TABLE `d_riwayat_kelahiran`
  ADD PRIMARY KEY (`id_kelahiran`),
  ADD KEY `id_peternakan` (`id_peternakan`),
  ADD KEY `id_ternak` (`id_ternak`),
  ADD KEY `id_sire` (`id_sire`),
  ADD KEY `id_dam` (`id_dam`);

--
-- Indeks untuk tabel `d_riwayat_kesehatan`
--
ALTER TABLE `d_riwayat_kesehatan`
  ADD PRIMARY KEY (`id_riwayat_kesehatan`),
  ADD KEY `id_peternakan` (`id_peternakan`),
  ADD KEY `id_ternak` (`id_ternak`);

--
-- Indeks untuk tabel `d_riwayat_lepas_sapih`
--
ALTER TABLE `d_riwayat_lepas_sapih`
  ADD PRIMARY KEY (`id_riwayat_lepas_sapih`),
  ADD KEY `id_peternakan` (`id_peternakan`),
  ADD KEY `id_ternak` (`id_ternak`);

--
-- Indeks untuk tabel `d_riwayat_perkawinan`
--
ALTER TABLE `d_riwayat_perkawinan`
  ADD PRIMARY KEY (`id_riwayat_perkawinan`),
  ADD KEY `id_peternakan` (`id_peternakan`),
  ADD KEY `id_kandang` (`id_kandang`),
  ADD KEY `id_indukan` (`id_indukan`),
  ADD KEY `id_pejantan` (`id_pejantan`);

--
-- Indeks untuk tabel `d_status_ternak`
--
ALTER TABLE `d_status_ternak`
  ADD PRIMARY KEY (`id_status_ternak`);

--
-- Indeks untuk tabel `d_timbangan`
--
ALTER TABLE `d_timbangan`
  ADD PRIMARY KEY (`id_timbangan`),
  ADD KEY `id_ternak` (`id_ternak`);

--
-- Indeks untuk tabel `d_treatment`
--
ALTER TABLE `d_treatment`
  ADD PRIMARY KEY (`id_treatment`);

--
-- Indeks untuk tabel `SequelizeMeta`
--
ALTER TABLE `SequelizeMeta`
  ADD PRIMARY KEY (`name`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indeks untuk tabel `s_ternak`
--
ALTER TABLE `s_ternak`
  ADD PRIMARY KEY (`id_ternak`),
  ADD KEY `id_peternakan` (`id_peternakan`),
  ADD KEY `id_bangsa` (`id_bangsa`),
  ADD KEY `id_kandang` (`id_kandang`),
  ADD KEY `id_status_ternak` (`id_status_ternak`),
  ADD KEY `id_fp` (`id_fp`),
  ADD KEY `fk_s_ternak_id_pejantan` (`id_sire`),
  ADD KEY `fk_s_ternak_id_induk` (`id_dam`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `auth_users`
--
ALTER TABLE `auth_users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `d_adaptasi`
--
ALTER TABLE `d_adaptasi`
  MODIFY `id_adaptasi` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `d_bahan_pakan`
--
ALTER TABLE `d_bahan_pakan`
  MODIFY `id_bahan_pakan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `d_bangsa`
--
ALTER TABLE `d_bangsa`
  MODIFY `id_bangsa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT untuk tabel `d_fase`
--
ALTER TABLE `d_fase`
  MODIFY `id_fp` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `d_jenis_bahan_pakan`
--
ALTER TABLE `d_jenis_bahan_pakan`
  MODIFY `id_jenis_bahan_pakan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `d_jenis_kandang`
--
ALTER TABLE `d_jenis_kandang`
  MODIFY `id_jenis_kandang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `d_jenis_pakan`
--
ALTER TABLE `d_jenis_pakan`
  MODIFY `id_jenis_pakan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `d_kandang`
--
ALTER TABLE `d_kandang`
  MODIFY `id_kandang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT untuk tabel `d_kesehatan`
--
ALTER TABLE `d_kesehatan`
  MODIFY `id_kesehatan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `d_lk_pemasukan`
--
ALTER TABLE `d_lk_pemasukan`
  MODIFY `id_lk_pemasukan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `d_pakan`
--
ALTER TABLE `d_pakan`
  MODIFY `id_pakan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `d_pemeliharaan`
--
ALTER TABLE `d_pemeliharaan`
  MODIFY `id_pemeliharaan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `d_penyakit`
--
ALTER TABLE `d_penyakit`
  MODIFY `id_penyakit` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT untuk tabel `d_perkawinan`
--
ALTER TABLE `d_perkawinan`
  MODIFY `id_perkawinan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT untuk tabel `d_peternakan`
--
ALTER TABLE `d_peternakan`
  MODIFY `id_peternakan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `d_populasi`
--
ALTER TABLE `d_populasi`
  MODIFY `id_populasi` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `d_riwayat_fase`
--
ALTER TABLE `d_riwayat_fase`
  MODIFY `id_riwayat_fase` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=188;

--
-- AUTO_INCREMENT untuk tabel `d_riwayat_kebuntingan`
--
ALTER TABLE `d_riwayat_kebuntingan`
  MODIFY `id_riwayat_kebuntingan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT untuk tabel `d_riwayat_kelahiran`
--
ALTER TABLE `d_riwayat_kelahiran`
  MODIFY `id_kelahiran` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `d_riwayat_kesehatan`
--
ALTER TABLE `d_riwayat_kesehatan`
  MODIFY `id_riwayat_kesehatan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `d_riwayat_lepas_sapih`
--
ALTER TABLE `d_riwayat_lepas_sapih`
  MODIFY `id_riwayat_lepas_sapih` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `d_riwayat_perkawinan`
--
ALTER TABLE `d_riwayat_perkawinan`
  MODIFY `id_riwayat_perkawinan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `d_status_ternak`
--
ALTER TABLE `d_status_ternak`
  MODIFY `id_status_ternak` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `d_timbangan`
--
ALTER TABLE `d_timbangan`
  MODIFY `id_timbangan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=520;

--
-- AUTO_INCREMENT untuk tabel `d_treatment`
--
ALTER TABLE `d_treatment`
  MODIFY `id_treatment` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `s_ternak`
--
ALTER TABLE `s_ternak`
  MODIFY `id_ternak` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=288;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `auth_users`
--
ALTER TABLE `auth_users`
  ADD CONSTRAINT `auth_users_ibfk_1` FOREIGN KEY (`id_peternakan`) REFERENCES `d_peternakan` (`id_peternakan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `d_adaptasi`
--
ALTER TABLE `d_adaptasi`
  ADD CONSTRAINT `d_adaptasi_ibfk_1` FOREIGN KEY (`id_peternakan`) REFERENCES `d_peternakan` (`id_peternakan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `d_adaptasi_ibfk_2` FOREIGN KEY (`id_ternak`) REFERENCES `s_ternak` (`id_ternak`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `d_adaptasi_ibfk_3` FOREIGN KEY (`id_treatment`) REFERENCES `d_treatment` (`id_treatment`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `d_adaptasi_ibfk_4` FOREIGN KEY (`id_kandang`) REFERENCES `d_kandang` (`id_kandang`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `d_bahan_pakan`
--
ALTER TABLE `d_bahan_pakan`
  ADD CONSTRAINT `d_bahan_pakan_ibfk_1` FOREIGN KEY (`id_peternakan`) REFERENCES `d_peternakan` (`id_peternakan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `d_bahan_pakan_ibfk_2` FOREIGN KEY (`id_jenis_bahan_pakan`) REFERENCES `d_jenis_bahan_pakan` (`id_jenis_bahan_pakan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `d_jenis_bahan_pakan`
--
ALTER TABLE `d_jenis_bahan_pakan`
  ADD CONSTRAINT `d_jenis_bahan_pakan_ibfk_1` FOREIGN KEY (`id_peternakan`) REFERENCES `d_peternakan` (`id_peternakan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `d_jenis_pakan`
--
ALTER TABLE `d_jenis_pakan`
  ADD CONSTRAINT `d_jenis_pakan_ibfk_1` FOREIGN KEY (`id_peternakan`) REFERENCES `d_peternakan` (`id_peternakan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `d_kandang`
--
ALTER TABLE `d_kandang`
  ADD CONSTRAINT `d_kandang_ibfk_1` FOREIGN KEY (`id_peternakan`) REFERENCES `d_peternakan` (`id_peternakan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `d_kandang_ibfk_2` FOREIGN KEY (`id_jenis_kandang`) REFERENCES `d_jenis_kandang` (`id_jenis_kandang`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `d_kandang_ibfk_3` FOREIGN KEY (`id_jenis_pakan`) REFERENCES `d_jenis_pakan` (`id_jenis_pakan`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `d_kesehatan`
--
ALTER TABLE `d_kesehatan`
  ADD CONSTRAINT `d_kesehatan_ibfk_1` FOREIGN KEY (`id_peternakan`) REFERENCES `d_peternakan` (`id_peternakan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `d_kesehatan_ibfk_2` FOREIGN KEY (`id_ternak`) REFERENCES `s_ternak` (`id_ternak`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `d_kesehatan_ibfk_3` FOREIGN KEY (`id_penyakit`) REFERENCES `d_penyakit` (`id_penyakit`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `d_lk_pemasukan`
--
ALTER TABLE `d_lk_pemasukan`
  ADD CONSTRAINT `d_lk_pemasukan_ibfk_1` FOREIGN KEY (`id_peternakan`) REFERENCES `d_peternakan` (`id_peternakan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `d_lk_pemasukan_ibfk_2` FOREIGN KEY (`id_ternak`) REFERENCES `s_ternak` (`id_ternak`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `d_lk_pemasukan_ibfk_3` FOREIGN KEY (`id_bangsa`) REFERENCES `d_bangsa` (`id_bangsa`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `d_lk_pemasukan_ibfk_4` FOREIGN KEY (`id_status_ternak`) REFERENCES `d_status_ternak` (`id_status_ternak`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `d_lk_pemasukan_ibfk_5` FOREIGN KEY (`id_kandang`) REFERENCES `d_kandang` (`id_kandang`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `d_pakan`
--
ALTER TABLE `d_pakan`
  ADD CONSTRAINT `d_pakan_ibfk_1` FOREIGN KEY (`id_peternakan`) REFERENCES `d_peternakan` (`id_peternakan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `d_pakan_ibfk_2` FOREIGN KEY (`id_jenis_pakan`) REFERENCES `d_jenis_pakan` (`id_jenis_pakan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `d_pemeliharaan`
--
ALTER TABLE `d_pemeliharaan`
  ADD CONSTRAINT `d_pemeliharaan_ibfk_1` FOREIGN KEY (`id_peternakan`) REFERENCES `d_peternakan` (`id_peternakan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `d_pemeliharaan_ibfk_2` FOREIGN KEY (`id_kandang`) REFERENCES `d_kandang` (`id_kandang`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `d_perkawinan`
--
ALTER TABLE `d_perkawinan`
  ADD CONSTRAINT `d_perkawinan_ibfk_1` FOREIGN KEY (`id_peternakan`) REFERENCES `d_peternakan` (`id_peternakan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `d_perkawinan_ibfk_2` FOREIGN KEY (`id_indukan`) REFERENCES `s_ternak` (`id_ternak`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `d_perkawinan_ibfk_3` FOREIGN KEY (`id_pejantan`) REFERENCES `s_ternak` (`id_ternak`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `d_perkawinan_ibfk_4` FOREIGN KEY (`id_kandang`) REFERENCES `d_kandang` (`id_kandang`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `d_populasi`
--
ALTER TABLE `d_populasi`
  ADD CONSTRAINT `d_populasi_ibfk_1` FOREIGN KEY (`id_peternakan`) REFERENCES `d_peternakan` (`id_peternakan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `d_riwayat_fase`
--
ALTER TABLE `d_riwayat_fase`
  ADD CONSTRAINT `d_riwayat_fase_ibfk_1` FOREIGN KEY (`id_peternakan`) REFERENCES `d_peternakan` (`id_peternakan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `d_riwayat_fase_ibfk_2` FOREIGN KEY (`id_fp`) REFERENCES `d_fase` (`id_fp`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `d_riwayat_fase_ibfk_3` FOREIGN KEY (`id_ternak`) REFERENCES `s_ternak` (`id_ternak`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `d_riwayat_kebuntingan`
--
ALTER TABLE `d_riwayat_kebuntingan`
  ADD CONSTRAINT `d_riwayat_kebuntingan_ibfk_1` FOREIGN KEY (`id_peternakan`) REFERENCES `d_peternakan` (`id_peternakan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `d_riwayat_kebuntingan_ibfk_2` FOREIGN KEY (`id_riwayat_perkawinan`) REFERENCES `d_riwayat_perkawinan` (`id_riwayat_perkawinan`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `d_riwayat_kebuntingan_ibfk_3` FOREIGN KEY (`id_indukan`) REFERENCES `s_ternak` (`id_ternak`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `d_riwayat_kebuntingan_ibfk_4` FOREIGN KEY (`id_pejantan`) REFERENCES `s_ternak` (`id_ternak`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `d_riwayat_kelahiran`
--
ALTER TABLE `d_riwayat_kelahiran`
  ADD CONSTRAINT `d_riwayat_kelahiran_ibfk_1` FOREIGN KEY (`id_peternakan`) REFERENCES `d_peternakan` (`id_peternakan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `d_riwayat_kelahiran_ibfk_2` FOREIGN KEY (`id_ternak`) REFERENCES `s_ternak` (`id_ternak`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `d_riwayat_kelahiran_ibfk_3` FOREIGN KEY (`id_sire`) REFERENCES `s_ternak` (`id_ternak`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `d_riwayat_kelahiran_ibfk_4` FOREIGN KEY (`id_dam`) REFERENCES `s_ternak` (`id_ternak`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `d_riwayat_kesehatan`
--
ALTER TABLE `d_riwayat_kesehatan`
  ADD CONSTRAINT `d_riwayat_kesehatan_ibfk_1` FOREIGN KEY (`id_peternakan`) REFERENCES `d_peternakan` (`id_peternakan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `d_riwayat_kesehatan_ibfk_2` FOREIGN KEY (`id_ternak`) REFERENCES `s_ternak` (`id_ternak`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `d_riwayat_lepas_sapih`
--
ALTER TABLE `d_riwayat_lepas_sapih`
  ADD CONSTRAINT `d_riwayat_lepas_sapih_ibfk_1` FOREIGN KEY (`id_peternakan`) REFERENCES `d_peternakan` (`id_peternakan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `d_riwayat_lepas_sapih_ibfk_2` FOREIGN KEY (`id_ternak`) REFERENCES `s_ternak` (`id_ternak`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `d_riwayat_perkawinan`
--
ALTER TABLE `d_riwayat_perkawinan`
  ADD CONSTRAINT `d_riwayat_perkawinan_ibfk_1` FOREIGN KEY (`id_peternakan`) REFERENCES `d_peternakan` (`id_peternakan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `d_riwayat_perkawinan_ibfk_2` FOREIGN KEY (`id_kandang`) REFERENCES `d_kandang` (`id_kandang`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `d_riwayat_perkawinan_ibfk_3` FOREIGN KEY (`id_indukan`) REFERENCES `s_ternak` (`id_ternak`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `d_riwayat_perkawinan_ibfk_4` FOREIGN KEY (`id_pejantan`) REFERENCES `s_ternak` (`id_ternak`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `d_timbangan`
--
ALTER TABLE `d_timbangan`
  ADD CONSTRAINT `d_timbangan_ibfk_1` FOREIGN KEY (`id_ternak`) REFERENCES `s_ternak` (`id_ternak`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `s_ternak`
--
ALTER TABLE `s_ternak`
  ADD CONSTRAINT `fk_s_ternak_id_induk` FOREIGN KEY (`id_dam`) REFERENCES `s_ternak` (`id_ternak`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_s_ternak_id_pejantan` FOREIGN KEY (`id_sire`) REFERENCES `s_ternak` (`id_ternak`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `s_ternak_ibfk_1` FOREIGN KEY (`id_peternakan`) REFERENCES `d_peternakan` (`id_peternakan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `s_ternak_ibfk_2` FOREIGN KEY (`id_bangsa`) REFERENCES `d_bangsa` (`id_bangsa`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `s_ternak_ibfk_3` FOREIGN KEY (`id_kandang`) REFERENCES `d_kandang` (`id_kandang`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `s_ternak_ibfk_4` FOREIGN KEY (`id_status_ternak`) REFERENCES `d_status_ternak` (`id_status_ternak`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `s_ternak_ibfk_5` FOREIGN KEY (`id_fp`) REFERENCES `d_fase` (`id_fp`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
