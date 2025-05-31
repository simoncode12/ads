-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 31 Bulan Mei 2025 pada 13.33
-- Versi server: 11.4.5-MariaDB-deb11
-- Versi PHP: 8.3.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `user_db`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `banner_sizes`
--

CREATE TABLE `banner_sizes` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL COMMENT 'e.g., Leaderboard, Medium Rectangle',
  `width` int(10) UNSIGNED NOT NULL COMMENT 'Width in pixels',
  `height` int(10) UNSIGNED NOT NULL COMMENT 'Height in pixels',
  `status` enum('active','inactive') DEFAULT 'active',
  `is_common` tinyint(1) DEFAULT 0 COMMENT 'Flag for commonly used sizes',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data untuk tabel `banner_sizes`
--

INSERT INTO `banner_sizes` (`id`, `name`, `width`, `height`, `status`, `is_common`, `created_at`, `updated_at`) VALUES
(1, '300x250', 300, 250, 'active', 1, '2025-05-29 16:24:52', '2025-05-29 16:27:35'),
(2, '300x100', 300, 100, 'active', 1, '2025-05-31 00:46:08', '2025-05-31 00:46:08'),
(3, '300x50', 300, 50, 'active', 1, '2025-05-31 00:46:32', '2025-05-31 00:46:32'),
(4, '300x500', 300, 500, 'active', 1, '2025-05-31 00:46:58', '2025-05-31 00:47:07'),
(5, '728x90', 728, 90, 'active', 1, '2025-05-31 00:47:29', '2025-05-31 00:47:29'),
(6, '900x250', 900, 250, 'active', 1, '2025-05-31 00:47:52', '2025-05-31 00:47:52'),
(7, '160x600', 160, 600, 'active', 1, '2025-05-31 00:48:14', '2025-05-31 00:48:14');

-- --------------------------------------------------------

--
-- Struktur dari tabel `campaigns`
--

CREATE TABLE `campaigns` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL COMMENT 'FK to users.id - Advertiser/Owner',
  `campaign_type` enum('rtb','direct','house_ad') NOT NULL DEFAULT 'rtb',
  `dsp_endpoint_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'FK to dsp_endpoints.id - Required if campaign_type = rtb',
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `status` enum('draft','pending_approval','active','paused','inactive','completed','rejected') NOT NULL DEFAULT 'draft',
  `total_budget` decimal(15,2) DEFAULT NULL,
  `daily_budget` decimal(15,2) DEFAULT NULL,
  `priority` tinyint(3) UNSIGNED DEFAULT 10 COMMENT 'For ordering/competition, lower is higher priority, e.g. 1-20',
  `bid_strategy` enum('cpm','cpc') DEFAULT NULL COMMENT 'Bidding strategy: Cost Per Mille (Impression) or Cost Per Click',
  `bid_amount` decimal(10,4) DEFAULT NULL COMMENT 'The bid amount corresponding to the bid_strategy (e.g., $0.50 CPM or $0.10 CPC)',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `campaigns`
--

INSERT INTO `campaigns` (`id`, `name`, `user_id`, `campaign_type`, `dsp_endpoint_id`, `start_date`, `end_date`, `status`, `total_budget`, `daily_budget`, `priority`, `bid_strategy`, `bid_amount`, `created_at`, `updated_at`) VALUES
(2, 'Exo PopUnder1', 1, 'rtb', 2, '2025-05-30 07:28:00', '2050-01-30 07:28:00', 'active', NULL, NULL, 10, 'cpm', 0.1000, '2025-05-30 00:28:41', '2025-05-30 00:53:11'),
(5, 'Banner 1', 1, 'rtb', 3, '2025-05-31 08:53:00', '2040-01-31 08:53:00', 'active', NULL, NULL, 10, 'cpm', 0.0001, '2025-05-31 01:53:58', '2025-05-31 01:53:58'),
(6, 'Banner 2', 1, 'rtb', 4, '2025-05-31 08:54:00', '2040-01-31 08:54:00', 'active', NULL, NULL, 10, 'cpm', 0.0001, '2025-05-31 01:54:51', '2025-05-31 01:54:51');

-- --------------------------------------------------------

--
-- Struktur dari tabel `campaign_ad_formats`
--

CREATE TABLE `campaign_ad_formats` (
  `id` int(10) UNSIGNED NOT NULL,
  `campaign_id` int(10) UNSIGNED NOT NULL,
  `ad_format_key` varchar(50) NOT NULL COMMENT 'e.g., banner, video, native, popunder. Matches keys from available formats'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `campaign_ad_formats`
--

INSERT INTO `campaign_ad_formats` (`id`, `campaign_id`, `ad_format_key`) VALUES
(5, 2, 'popunder'),
(6, 5, 'banner'),
(7, 6, 'banner');

-- --------------------------------------------------------

--
-- Struktur dari tabel `campaign_categories`
--

CREATE TABLE `campaign_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `campaign_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `campaign_categories`
--

INSERT INTO `campaign_categories` (`id`, `campaign_id`, `category_id`) VALUES
(3, 2, 1),
(4, 5, 1),
(5, 6, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `campaign_creatives`
--

CREATE TABLE `campaign_creatives` (
  `id` int(11) NOT NULL,
  `campaign_id` int(10) UNSIGNED NOT NULL,
  `creative_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data untuk tabel `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Adult', '', 'active', '2025-05-29 15:42:50', '2025-05-29 15:42:50'),
(2, 'Mainstreams', '', 'active', '2025-05-29 15:43:01', '2025-05-29 15:43:01');

-- --------------------------------------------------------

--
-- Struktur dari tabel `click_logs`
--

CREATE TABLE `click_logs` (
  `id` bigint(20) NOT NULL,
  `click_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `zone_id` varchar(255) DEFAULT NULL,
  `campaign_id` int(11) DEFAULT NULL,
  `creative_id` int(11) DEFAULT NULL,
  `destination_url` text DEFAULT NULL,
  `client_ip_address` varchar(45) DEFAULT NULL,
  `client_user_agent` text DEFAULT NULL,
  `page_url` text DEFAULT NULL,
  `country_code` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data untuk tabel `click_logs`
--

INSERT INTO `click_logs` (`id`, `click_time`, `zone_id`, `campaign_id`, `creative_id`, `destination_url`, `client_ip_address`, `client_user_agent`, `page_url`, `country_code`) VALUES
(1, '2025-05-31 02:03:42', '5', 5, 501, 'http://example-advertiser.com/productB-zone5', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(2, '2025-05-31 02:15:37', '5', 5, 501, 'http://example-advertiser.com/productB-zone5', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(3, '2025-05-31 02:17:29', '5', 5, 501, 'http://example-advertiser.com/productB-zone5', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(4, '2025-05-31 02:21:31', '5', 5, 501, 'http://example-advertiser.com/productB-zone5', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(5, '2025-05-31 02:21:52', '5', 5, 501, 'http://example-advertiser.com/productB-zone5', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(6, '2025-05-31 02:40:21', '5', 5, 501, 'http://example-advertiser.com/productB-zone5', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(7, '2025-05-31 02:40:21', '5', 5, 501, 'http://example-advertiser.com/productB-zone5', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(8, '2025-05-31 02:40:22', '5', 5, 501, 'http://example-advertiser.com/productB-zone5', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(9, '2025-05-31 02:42:04', '5', 5, 501, 'http://example-advertiser.com/productB-zone5', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(10, '2025-05-31 03:57:52', '5', 5, 501, 'http://example-advertiser.com/productB-zone5', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/test_panel_ads.html', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `creatives`
--

CREATE TABLE `creatives` (
  `id` int(11) NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `creative_type` enum('image','video','html','vast_url','popunder') NOT NULL,
  `asset_url` text DEFAULT NULL,
  `landing_page_url` text DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `html_content` text DEFAULT NULL,
  `vast_xml_content` text DEFAULT NULL,
  `status` enum('pending_review','active','inactive','rejected') NOT NULL DEFAULT 'pending_review',
  `rejection_reason` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `creatives`
--

INSERT INTO `creatives` (`id`, `user_id`, `name`, `creative_type`, `asset_url`, `landing_page_url`, `width`, `height`, `duration`, `html_content`, `vast_xml_content`, `status`, `rejection_reason`, `created_at`, `updated_at`) VALUES
(1, 1, 'Banner', 'html', NULL, NULL, 300, 250, NULL, '<script async type=\"application/javascript\" src=\"https://a.magsrv.com/ad-provider.js\"></script> \r\n <ins class=\"eas6a97888e2\" data-zoneid=\"5548370\"></ins> \r\n <script>(AdProvider = window.AdProvider || []).push({\"serve\": {}});</script>', '...</VAST>\">...</VAST>\">...</VAST>\">...</VAST>\">', 'active', NULL, '2025-05-30 02:00:02', '2025-05-30 02:00:02'),
(2, 1, 'Vast', 'vast_url', 'https://s.magsrv.com/v1/vast.php?idzone=5548380', NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-05-30 02:19:14', '2025-05-30 02:19:14');

-- --------------------------------------------------------

--
-- Struktur dari tabel `dsp_endpoints`
--

CREATE TABLE `dsp_endpoints` (
  `id` int(10) UNSIGNED NOT NULL,
  `endpoint_name` varchar(100) NOT NULL,
  `endpoint_url` varchar(255) NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data untuk tabel `dsp_endpoints`
--

INSERT INTO `dsp_endpoints` (`id`, `endpoint_name`, `endpoint_url`, `status`, `category_id`, `created_at`, `updated_at`) VALUES
(2, 'Exo Popunder 1', 'http://rtb.exoclick.com/rtb.php?idzone=5088174&fid=46fe16d158de6704ca67c123e99128c4bdc41362', 'active', 1, '2025-05-29 23:44:36', '2025-05-29 23:48:58'),
(3, 'Banner1', 'http://rtb.exoclick.com/rtb.php?idzone=5123466&fid=b5677dfe2f4a21c7548abc927fac110aaa4b157b', 'active', 1, '2025-05-31 00:49:06', '2025-05-31 00:49:06'),
(4, 'Banner2', 'http://rtb.exoclick.com/rtb.php?idzone=5128252&fid=e573a1c2a656509b0112f7213359757be76929c7', 'active', 1, '2025-05-31 00:49:48', '2025-05-31 00:49:48'),
(5, 'Banner3', 'http://rtb.exoclick.com/rtb.php?idzone=5123472&fid=6e4bb66dceebaae013c1bdfcde873a0e6457cb81', 'active', 1, '2025-05-31 00:50:30', '2025-05-31 00:50:30'),
(6, 'Banner4', 'http://rtb.exoclick.com/rtb.php?idzone=5123470&fid=2e05dd2082bc5cebcc121e9645ab1bdd81ca2148', 'active', 1, '2025-05-31 00:51:18', '2025-05-31 00:51:18');

-- --------------------------------------------------------

--
-- Struktur dari tabel `dsp_endpoint_banner_sizes`
--

CREATE TABLE `dsp_endpoint_banner_sizes` (
  `id` int(10) UNSIGNED NOT NULL,
  `dsp_endpoint_id` int(10) UNSIGNED NOT NULL,
  `banner_size_id` int(10) UNSIGNED NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data untuk tabel `dsp_endpoint_banner_sizes`
--

INSERT INTO `dsp_endpoint_banner_sizes` (`id`, `dsp_endpoint_id`, `banner_size_id`, `created_at`) VALUES
(1, 3, 7, '2025-05-31 00:49:06'),
(2, 3, 2, '2025-05-31 00:49:06'),
(3, 3, 1, '2025-05-31 00:49:06'),
(4, 3, 3, '2025-05-31 00:49:06'),
(5, 3, 4, '2025-05-31 00:49:06'),
(6, 3, 5, '2025-05-31 00:49:06'),
(7, 3, 6, '2025-05-31 00:49:06'),
(8, 4, 7, '2025-05-31 00:49:48'),
(9, 4, 2, '2025-05-31 00:49:48'),
(10, 4, 1, '2025-05-31 00:49:48'),
(11, 4, 3, '2025-05-31 00:49:48'),
(12, 4, 4, '2025-05-31 00:49:48'),
(13, 4, 5, '2025-05-31 00:49:48'),
(14, 4, 6, '2025-05-31 00:49:48'),
(15, 5, 7, '2025-05-31 00:50:30'),
(16, 5, 2, '2025-05-31 00:50:30'),
(17, 5, 1, '2025-05-31 00:50:30'),
(18, 5, 3, '2025-05-31 00:50:30'),
(19, 5, 4, '2025-05-31 00:50:30'),
(20, 5, 5, '2025-05-31 00:50:30'),
(21, 5, 6, '2025-05-31 00:50:30'),
(22, 6, 7, '2025-05-31 00:51:18'),
(23, 6, 2, '2025-05-31 00:51:18'),
(24, 6, 1, '2025-05-31 00:51:18'),
(25, 6, 3, '2025-05-31 00:51:18'),
(26, 6, 4, '2025-05-31 00:51:18'),
(27, 6, 5, '2025-05-31 00:51:18'),
(28, 6, 6, '2025-05-31 00:51:18');

-- --------------------------------------------------------

--
-- Struktur dari tabel `dsp_endpoint_formats`
--

CREATE TABLE `dsp_endpoint_formats` (
  `id` int(10) UNSIGNED NOT NULL,
  `dsp_endpoint_id` int(10) UNSIGNED NOT NULL,
  `ad_format` enum('banner','video','native','audio','popunder') NOT NULL COMMENT 'Format iklan yang didukung',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data untuk tabel `dsp_endpoint_formats`
--

INSERT INTO `dsp_endpoint_formats` (`id`, `dsp_endpoint_id`, `ad_format`, `created_at`) VALUES
(1, 2, 'popunder', '2025-05-29 23:44:36'),
(2, 3, 'banner', '2025-05-31 00:49:06'),
(3, 4, 'banner', '2025-05-31 00:49:48'),
(4, 5, 'banner', '2025-05-31 00:50:30'),
(5, 6, 'banner', '2025-05-31 00:51:18');

-- --------------------------------------------------------

--
-- Struktur dari tabel `impression_logs`
--

CREATE TABLE `impression_logs` (
  `id` bigint(20) NOT NULL,
  `impression_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `zone_id` varchar(255) DEFAULT NULL,
  `campaign_id` int(11) DEFAULT NULL,
  `creative_id` int(11) DEFAULT NULL,
  `ads_request_url` text DEFAULT NULL,
  `client_ip_address` varchar(45) DEFAULT NULL,
  `client_user_agent` text DEFAULT NULL,
  `page_url` text DEFAULT NULL,
  `country_code` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data untuk tabel `impression_logs`
--

INSERT INTO `impression_logs` (`id`, `impression_time`, `zone_id`, `campaign_id`, `creative_id`, `ads_request_url`, `client_ip_address`, `client_user_agent`, `page_url`, `country_code`) VALUES
(149, '2025-05-31 01:43:01', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778682', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(150, '2025-05-31 01:43:01', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778683', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(151, '2025-05-31 01:43:01', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778683', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(152, '2025-05-31 01:43:01', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778676', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(153, '2025-05-31 01:43:01', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778682', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(154, '2025-05-31 01:43:01', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778682', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(155, '2025-05-31 01:43:01', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778683', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(156, '2025-05-31 01:43:01', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778684', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(157, '2025-05-31 01:43:01', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778678', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(158, '2025-05-31 01:43:01', '5', NULL, NULL, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778678', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(159, '2025-05-31 01:43:01', '5', NULL, NULL, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778683', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(160, '2025-05-31 01:43:01', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778680', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(161, '2025-05-31 01:43:01', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778682', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(162, '2025-05-31 01:43:01', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778679', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(163, '2025-05-31 01:43:01', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778683', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(164, '2025-05-31 01:43:01', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778682', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(165, '2025-05-31 01:43:01', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778676', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(166, '2025-05-31 01:43:01', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778683', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(167, '2025-05-31 01:43:01', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778681', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(168, '2025-05-31 01:43:01', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778682', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(169, '2025-05-31 01:43:01', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778681', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(170, '2025-05-31 01:43:01', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778677', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(171, '2025-05-31 01:43:01', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778683', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(172, '2025-05-31 01:43:01', '5', NULL, NULL, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778676', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(173, '2025-05-31 01:43:01', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778684', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(174, '2025-05-31 01:43:01', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778678', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(175, '2025-05-31 01:43:01', '5', NULL, NULL, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778682', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(176, '2025-05-31 01:43:01', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778676', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(177, '2025-05-31 01:43:01', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778679', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(178, '2025-05-31 01:43:01', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778681', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(179, '2025-05-31 01:43:01', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778681', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(180, '2025-05-31 01:43:01', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778677', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(181, '2025-05-31 01:43:01', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778681', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(182, '2025-05-31 01:43:01', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778677', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(183, '2025-05-31 01:43:01', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778678', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(184, '2025-05-31 01:43:01', '5', NULL, NULL, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778681', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(185, '2025-05-31 01:43:01', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748655778676', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(186, '2025-05-31 01:55:03', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501274', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(187, '2025-05-31 01:55:03', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501272', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(188, '2025-05-31 01:55:03', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501269', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(189, '2025-05-31 01:55:03', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501268', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(190, '2025-05-31 01:55:03', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501269', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(191, '2025-05-31 01:55:03', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501274', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(192, '2025-05-31 01:55:03', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501274', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(193, '2025-05-31 01:55:03', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501272', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(194, '2025-05-31 01:55:03', '5', NULL, NULL, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501272', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(195, '2025-05-31 01:55:03', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501272', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(196, '2025-05-31 01:55:03', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501272', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(197, '2025-05-31 01:55:03', '5', NULL, NULL, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501274', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(198, '2025-05-31 01:55:03', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501268', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(199, '2025-05-31 01:55:03', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501274', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(200, '2025-05-31 01:55:03', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501268', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(201, '2025-05-31 01:55:03', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501272', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(202, '2025-05-31 01:55:03', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501274', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(203, '2025-05-31 01:55:03', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501273', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(204, '2025-05-31 01:55:03', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501268', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(205, '2025-05-31 01:55:03', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501269', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(206, '2025-05-31 01:55:03', '5', NULL, NULL, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501268', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(207, '2025-05-31 01:55:03', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501269', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(208, '2025-05-31 01:55:03', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501269', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(209, '2025-05-31 01:55:03', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501267', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(210, '2025-05-31 01:55:03', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501270', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(211, '2025-05-31 01:55:03', '5', NULL, NULL, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501269', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(212, '2025-05-31 01:55:03', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501270', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(213, '2025-05-31 01:55:03', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501270', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(214, '2025-05-31 01:55:03', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501268', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(215, '2025-05-31 01:55:03', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501270', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(216, '2025-05-31 01:55:03', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501270', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(217, '2025-05-31 01:55:03', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501271', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(218, '2025-05-31 01:55:03', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501269', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(219, '2025-05-31 01:55:03', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501270', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(220, '2025-05-31 01:55:03', '5', NULL, NULL, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501270', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(221, '2025-05-31 01:55:03', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501271', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(222, '2025-05-31 01:55:03', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501271', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(223, '2025-05-31 01:55:03', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501272', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(224, '2025-05-31 01:55:03', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501268', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(225, '2025-05-31 01:55:03', '5', NULL, NULL, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501271', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(226, '2025-05-31 01:55:03', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501271', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(227, '2025-05-31 01:55:03', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501271', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(228, '2025-05-31 01:55:03', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656501271', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(229, '2025-05-31 01:56:05', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562932', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(230, '2025-05-31 01:56:05', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562929', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(231, '2025-05-31 01:56:05', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562932', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(232, '2025-05-31 01:56:05', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562932', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(233, '2025-05-31 01:56:05', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562929', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(234, '2025-05-31 01:56:05', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562928', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(235, '2025-05-31 01:56:05', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562932', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(236, '2025-05-31 01:56:05', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562929', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(237, '2025-05-31 01:56:05', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562932', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(238, '2025-05-31 01:56:05', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562927', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(239, '2025-05-31 01:56:05', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562929', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(240, '2025-05-31 01:56:05', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562933', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(241, '2025-05-31 01:56:05', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562929', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(242, '2025-05-31 01:56:05', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562932', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(243, '2025-05-31 01:56:05', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562929', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(244, '2025-05-31 01:56:05', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562929', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(245, '2025-05-31 01:56:05', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562930', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(246, '2025-05-31 01:56:05', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562930', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(247, '2025-05-31 01:56:05', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562928', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(248, '2025-05-31 01:56:05', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562928', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(249, '2025-05-31 01:56:05', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562930', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(250, '2025-05-31 01:56:05', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562928', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(251, '2025-05-31 01:56:05', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562928', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(252, '2025-05-31 01:56:05', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562930', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(253, '2025-05-31 01:56:05', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562930', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(254, '2025-05-31 01:56:05', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562931', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(255, '2025-05-31 01:56:05', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562931', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(256, '2025-05-31 01:56:05', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562930', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(257, '2025-05-31 01:56:05', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562928', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(258, '2025-05-31 01:56:05', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562931', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(259, '2025-05-31 01:56:05', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562930', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(260, '2025-05-31 01:56:05', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562931', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(261, '2025-05-31 01:56:05', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562931', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(262, '2025-05-31 01:56:05', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562931', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(263, '2025-05-31 01:56:05', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562931', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(264, '2025-05-31 01:56:05', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748656562932', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(265, '2025-05-31 02:03:34', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012048', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(266, '2025-05-31 02:03:34', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012048', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(267, '2025-05-31 02:03:34', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012048', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(268, '2025-05-31 02:03:34', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012049', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(269, '2025-05-31 02:03:34', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012046', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(270, '2025-05-31 02:03:34', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012049', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(271, '2025-05-31 02:03:34', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012049', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(272, '2025-05-31 02:03:34', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012049', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(273, '2025-05-31 02:03:34', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012050', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(274, '2025-05-31 02:03:34', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012049', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(275, '2025-05-31 02:03:35', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012050', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(276, '2025-05-31 02:03:35', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012050', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(277, '2025-05-31 02:03:35', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012051', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(278, '2025-05-31 02:03:35', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012052', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(279, '2025-05-31 02:03:35', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012051', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(280, '2025-05-31 02:03:35', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012051', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(281, '2025-05-31 02:03:35', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012052', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(282, '2025-05-31 02:03:35', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012052', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(283, '2025-05-31 02:03:35', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012052', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(284, '2025-05-31 02:03:35', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012051', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(285, '2025-05-31 02:03:35', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012050', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(286, '2025-05-31 02:03:35', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012051', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(287, '2025-05-31 02:03:35', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012051', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(288, '2025-05-31 02:03:35', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012050', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(289, '2025-05-31 02:03:35', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012053', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(290, '2025-05-31 02:03:35', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012051', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(291, '2025-05-31 02:03:35', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012052', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(292, '2025-05-31 02:03:35', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012052', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(293, '2025-05-31 02:03:35', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012053', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(294, '2025-05-31 02:03:35', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012047', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(295, '2025-05-31 02:03:35', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012047', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(296, '2025-05-31 02:03:35', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012053', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(297, '2025-05-31 02:03:35', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012047', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(298, '2025-05-31 02:03:35', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012047', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(299, '2025-05-31 02:03:35', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012047', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(300, '2025-05-31 02:03:35', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012046', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(301, '2025-05-31 02:03:35', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012047', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(302, '2025-05-31 02:03:35', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012047', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(303, '2025-05-31 02:03:35', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012048', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(304, '2025-05-31 02:03:35', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012046', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(305, '2025-05-31 02:03:35', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012046', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(306, '2025-05-31 02:03:35', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012046', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(307, '2025-05-31 02:03:35', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012053', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(308, '2025-05-31 02:03:35', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012046', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL);
INSERT INTO `impression_logs` (`id`, `impression_time`, `zone_id`, `campaign_id`, `creative_id`, `ads_request_url`, `client_ip_address`, `client_user_agent`, `page_url`, `country_code`) VALUES
(309, '2025-05-31 02:03:35', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012054', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(310, '2025-05-31 02:03:35', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012053', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(311, '2025-05-31 02:03:35', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012053', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(312, '2025-05-31 02:03:35', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012054', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(313, '2025-05-31 02:03:35', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657012054', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(314, '2025-05-31 02:15:04', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702134', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(315, '2025-05-31 02:15:04', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702134', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(316, '2025-05-31 02:15:04', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702134', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(317, '2025-05-31 02:15:04', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702134', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(318, '2025-05-31 02:15:04', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702134', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(319, '2025-05-31 02:15:04', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702135', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(320, '2025-05-31 02:15:04', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702135', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(321, '2025-05-31 02:15:04', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702135', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(322, '2025-05-31 02:15:04', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702135', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(323, '2025-05-31 02:15:04', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702124', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(324, '2025-05-31 02:15:04', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702124', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(325, '2025-05-31 02:15:04', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702132', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(326, '2025-05-31 02:15:04', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702126', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(327, '2025-05-31 02:15:04', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702125', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(328, '2025-05-31 02:15:04', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702132', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(329, '2025-05-31 02:15:04', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702132', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(330, '2025-05-31 02:15:04', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702132', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(331, '2025-05-31 02:15:04', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702124', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(332, '2025-05-31 02:15:04', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702132', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(333, '2025-05-31 02:15:04', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702124', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(334, '2025-05-31 02:15:04', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702133', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(335, '2025-05-31 02:15:04', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702126', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(336, '2025-05-31 02:15:04', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702133', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(337, '2025-05-31 02:15:04', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702133', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(338, '2025-05-31 02:15:04', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702131', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(339, '2025-05-31 02:15:04', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702133', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(340, '2025-05-31 02:15:04', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702134', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(341, '2025-05-31 02:15:04', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702131', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(342, '2025-05-31 02:15:04', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702131', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(343, '2025-05-31 02:15:04', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702133', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(344, '2025-05-31 02:15:04', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702133', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(345, '2025-05-31 02:15:04', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702133', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(346, '2025-05-31 02:15:04', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702124', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(347, '2025-05-31 02:15:04', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702124', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(348, '2025-05-31 02:15:04', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702126', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(349, '2025-05-31 02:15:04', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702126', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(350, '2025-05-31 02:15:04', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702134', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(351, '2025-05-31 02:15:04', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702132', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(352, '2025-05-31 02:15:04', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702127', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(353, '2025-05-31 02:15:04', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702131', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(354, '2025-05-31 02:15:04', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702127', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(355, '2025-05-31 02:15:04', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702127', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(356, '2025-05-31 02:15:04', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702131', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(357, '2025-05-31 02:15:04', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702131', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(358, '2025-05-31 02:15:04', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702131', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(359, '2025-05-31 02:15:04', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657702132', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(360, '2025-05-31 02:15:07', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705372', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(361, '2025-05-31 02:15:07', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705372', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(362, '2025-05-31 02:15:07', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705373', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(363, '2025-05-31 02:15:07', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705373', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(364, '2025-05-31 02:15:07', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705373', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(365, '2025-05-31 02:15:07', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705373', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(366, '2025-05-31 02:15:07', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705374', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(367, '2025-05-31 02:15:07', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705374', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(368, '2025-05-31 02:15:07', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705373', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(369, '2025-05-31 02:15:07', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705374', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(370, '2025-05-31 02:15:07', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705374', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(371, '2025-05-31 02:15:07', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705374', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(372, '2025-05-31 02:15:07', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705372', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(373, '2025-05-31 02:15:07', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705375', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(374, '2025-05-31 02:15:07', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705373', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(375, '2025-05-31 02:15:07', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705373', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(376, '2025-05-31 02:15:07', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705375', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(377, '2025-05-31 02:15:07', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705374', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(378, '2025-05-31 02:15:07', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705375', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(379, '2025-05-31 02:15:07', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705374', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(380, '2025-05-31 02:15:07', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705375', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(381, '2025-05-31 02:15:07', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705375', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(382, '2025-05-31 02:15:07', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705375', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(383, '2025-05-31 02:15:07', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705376', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(384, '2025-05-31 02:15:07', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705376', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(385, '2025-05-31 02:15:07', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705375', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(386, '2025-05-31 02:15:07', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705377', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(387, '2025-05-31 02:15:07', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705377', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(388, '2025-05-31 02:15:07', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705376', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(389, '2025-05-31 02:15:07', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705377', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(390, '2025-05-31 02:15:07', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705377', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(391, '2025-05-31 02:15:07', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705376', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(392, '2025-05-31 02:15:07', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705376', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(393, '2025-05-31 02:15:07', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705377', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(394, '2025-05-31 02:15:07', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705378', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(395, '2025-05-31 02:15:07', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705376', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(396, '2025-05-31 02:15:07', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705377', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(397, '2025-05-31 02:15:07', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705377', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(398, '2025-05-31 02:15:07', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657705376', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(399, '2025-05-31 02:15:13', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711333', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(400, '2025-05-31 02:15:13', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711333', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(401, '2025-05-31 02:15:13', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711334', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(402, '2025-05-31 02:15:13', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711334', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(403, '2025-05-31 02:15:13', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711334', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(404, '2025-05-31 02:15:13', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711334', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(405, '2025-05-31 02:15:13', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711335', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(406, '2025-05-31 02:15:13', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711335', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(407, '2025-05-31 02:15:13', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711334', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(408, '2025-05-31 02:15:13', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711335', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(409, '2025-05-31 02:15:13', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711336', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(410, '2025-05-31 02:15:13', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711336', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(411, '2025-05-31 02:15:13', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711336', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(412, '2025-05-31 02:15:13', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711336', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(413, '2025-05-31 02:15:13', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711336', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(414, '2025-05-31 02:15:13', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711337', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(415, '2025-05-31 02:15:13', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711335', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(416, '2025-05-31 02:15:13', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711336', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(417, '2025-05-31 02:15:13', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711337', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(418, '2025-05-31 02:15:13', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711337', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(419, '2025-05-31 02:15:13', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711336', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(420, '2025-05-31 02:15:13', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711337', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(421, '2025-05-31 02:15:13', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711338', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(422, '2025-05-31 02:15:13', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711338', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(423, '2025-05-31 02:15:13', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711337', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(424, '2025-05-31 02:15:13', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711335', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(425, '2025-05-31 02:15:13', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711338', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(426, '2025-05-31 02:15:13', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711335', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(427, '2025-05-31 02:15:13', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711339', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(428, '2025-05-31 02:15:13', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711337', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(429, '2025-05-31 02:15:13', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711338', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(430, '2025-05-31 02:15:13', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711335', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(431, '2025-05-31 02:15:13', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711338', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(432, '2025-05-31 02:15:13', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711338', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(433, '2025-05-31 02:15:13', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711339', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(434, '2025-05-31 02:15:13', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711339', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(435, '2025-05-31 02:15:13', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711339', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(436, '2025-05-31 02:15:13', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711337', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(437, '2025-05-31 02:15:13', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711339', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(438, '2025-05-31 02:15:14', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711339', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(439, '2025-05-31 02:15:14', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657711338', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(440, '2025-05-31 02:15:20', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718815', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(441, '2025-05-31 02:15:20', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718816', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(442, '2025-05-31 02:15:20', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718816', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(443, '2025-05-31 02:15:20', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718816', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(444, '2025-05-31 02:15:20', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718816', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(445, '2025-05-31 02:15:20', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718816', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(446, '2025-05-31 02:15:20', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718817', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(447, '2025-05-31 02:15:20', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718817', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(448, '2025-05-31 02:15:20', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718816', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(449, '2025-05-31 02:15:20', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718817', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(450, '2025-05-31 02:15:20', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718816', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(451, '2025-05-31 02:15:20', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718817', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(452, '2025-05-31 02:15:20', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718817', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(453, '2025-05-31 02:15:20', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718817', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(454, '2025-05-31 02:15:20', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718818', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(455, '2025-05-31 02:15:20', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718817', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(456, '2025-05-31 02:15:20', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718818', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(457, '2025-05-31 02:15:20', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718818', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(458, '2025-05-31 02:15:21', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718818', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(459, '2025-05-31 02:15:21', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718818', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(460, '2025-05-31 02:15:21', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718818', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(461, '2025-05-31 02:15:21', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718818', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(462, '2025-05-31 02:15:21', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718819', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(463, '2025-05-31 02:15:21', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718819', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(464, '2025-05-31 02:15:21', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718819', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(465, '2025-05-31 02:15:21', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718819', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(466, '2025-05-31 02:15:21', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718819', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(467, '2025-05-31 02:15:21', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718820', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(468, '2025-05-31 02:15:21', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718819', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL);
INSERT INTO `impression_logs` (`id`, `impression_time`, `zone_id`, `campaign_id`, `creative_id`, `ads_request_url`, `client_ip_address`, `client_user_agent`, `page_url`, `country_code`) VALUES
(469, '2025-05-31 02:15:21', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718819', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(470, '2025-05-31 02:15:21', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718820', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(471, '2025-05-31 02:15:21', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718820', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(472, '2025-05-31 02:15:21', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718820', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(473, '2025-05-31 02:15:21', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718820', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(474, '2025-05-31 02:15:21', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718820', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(475, '2025-05-31 02:15:21', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657718820', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(476, '2025-05-31 02:15:23', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721143', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(477, '2025-05-31 02:15:23', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721142', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(478, '2025-05-31 02:15:23', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721143', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(479, '2025-05-31 02:15:23', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721143', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(480, '2025-05-31 02:15:23', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721143', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(481, '2025-05-31 02:15:23', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721144', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(482, '2025-05-31 02:15:23', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721144', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(483, '2025-05-31 02:15:23', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721143', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(484, '2025-05-31 02:15:23', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721144', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(485, '2025-05-31 02:15:23', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721144', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(486, '2025-05-31 02:15:23', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721144', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(487, '2025-05-31 02:15:23', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721145', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(488, '2025-05-31 02:15:23', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721143', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(489, '2025-05-31 02:15:23', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721144', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(490, '2025-05-31 02:15:23', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721145', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(491, '2025-05-31 02:15:23', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721144', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(492, '2025-05-31 02:15:23', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721146', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(493, '2025-05-31 02:15:23', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721145', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(494, '2025-05-31 02:15:23', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721145', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(495, '2025-05-31 02:15:23', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721145', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(496, '2025-05-31 02:15:23', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721145', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(497, '2025-05-31 02:15:23', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721146', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(498, '2025-05-31 02:15:23', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721146', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(499, '2025-05-31 02:15:23', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721145', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(500, '2025-05-31 02:15:23', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721147', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(501, '2025-05-31 02:15:23', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721146', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(502, '2025-05-31 02:15:23', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721146', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(503, '2025-05-31 02:15:23', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721147', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(504, '2025-05-31 02:15:23', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721147', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(505, '2025-05-31 02:15:23', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721147', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(506, '2025-05-31 02:15:23', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721147', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(507, '2025-05-31 02:15:23', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721147', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(508, '2025-05-31 02:15:23', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721147', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(509, '2025-05-31 02:15:23', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721148', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(510, '2025-05-31 02:15:23', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721146', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(511, '2025-05-31 02:15:23', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721148', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(512, '2025-05-31 02:15:23', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721148', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(513, '2025-05-31 02:15:23', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721146', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(514, '2025-05-31 02:15:23', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657721148', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(515, '2025-05-31 02:15:36', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734470', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(516, '2025-05-31 02:15:36', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734469', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(517, '2025-05-31 02:15:36', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734470', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(518, '2025-05-31 02:15:36', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734470', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(519, '2025-05-31 02:15:36', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734470', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(520, '2025-05-31 02:15:36', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734470', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(521, '2025-05-31 02:15:36', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734470', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(522, '2025-05-31 02:15:36', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734471', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(523, '2025-05-31 02:15:36', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734470', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(524, '2025-05-31 02:15:36', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734471', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(525, '2025-05-31 02:15:36', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734471', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(526, '2025-05-31 02:15:36', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734471', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(527, '2025-05-31 02:15:36', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734471', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(528, '2025-05-31 02:15:36', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734471', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(529, '2025-05-31 02:15:36', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734472', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(530, '2025-05-31 02:15:36', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734472', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(531, '2025-05-31 02:15:36', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734471', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(532, '2025-05-31 02:15:36', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734472', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(533, '2025-05-31 02:15:36', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734472', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(534, '2025-05-31 02:15:36', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734472', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(535, '2025-05-31 02:15:36', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734473', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(536, '2025-05-31 02:15:36', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734472', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(537, '2025-05-31 02:15:36', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734473', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(538, '2025-05-31 02:15:36', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734472', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(539, '2025-05-31 02:15:36', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734473', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(540, '2025-05-31 02:15:36', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734474', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(541, '2025-05-31 02:15:36', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734473', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(542, '2025-05-31 02:15:36', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734473', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(543, '2025-05-31 02:15:36', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734473', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(544, '2025-05-31 02:15:36', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734473', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(545, '2025-05-31 02:15:36', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734474', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(546, '2025-05-31 02:15:36', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734474', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(547, '2025-05-31 02:15:36', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734474', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(548, '2025-05-31 02:15:36', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657734474', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(549, '2025-05-31 02:15:41', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739031', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(550, '2025-05-31 02:15:41', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739031', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(551, '2025-05-31 02:15:41', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739031', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(552, '2025-05-31 02:15:41', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739032', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(553, '2025-05-31 02:15:41', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739032', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(554, '2025-05-31 02:15:41', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739032', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(555, '2025-05-31 02:15:41', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739032', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(556, '2025-05-31 02:15:41', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739033', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(557, '2025-05-31 02:15:41', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739033', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(558, '2025-05-31 02:15:41', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739033', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(559, '2025-05-31 02:15:41', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739033', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(560, '2025-05-31 02:15:41', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739034', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(561, '2025-05-31 02:15:41', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739033', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(562, '2025-05-31 02:15:41', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739033', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(563, '2025-05-31 02:15:41', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739033', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(564, '2025-05-31 02:15:41', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739034', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(565, '2025-05-31 02:15:41', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739034', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(566, '2025-05-31 02:15:41', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739034', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(567, '2025-05-31 02:15:41', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739034', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(568, '2025-05-31 02:15:41', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739034', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(569, '2025-05-31 02:15:41', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739035', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(570, '2025-05-31 02:15:41', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739035', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(571, '2025-05-31 02:15:41', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739035', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(572, '2025-05-31 02:15:41', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739036', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(573, '2025-05-31 02:15:41', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739036', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(574, '2025-05-31 02:15:41', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739036', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(575, '2025-05-31 02:15:41', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739037', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(576, '2025-05-31 02:15:41', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739035', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(577, '2025-05-31 02:15:41', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739035', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(578, '2025-05-31 02:15:41', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739035', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(579, '2025-05-31 02:15:41', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739037', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(580, '2025-05-31 02:15:41', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739038', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(581, '2025-05-31 02:15:41', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739036', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(582, '2025-05-31 02:15:41', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739037', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(583, '2025-05-31 02:15:41', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739038', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(584, '2025-05-31 02:15:41', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739036', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(585, '2025-05-31 02:15:41', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739038', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(586, '2025-05-31 02:15:41', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739036', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(587, '2025-05-31 02:15:41', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739040', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(588, '2025-05-31 02:15:41', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739038', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(589, '2025-05-31 02:15:41', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739039', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(590, '2025-05-31 02:15:41', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739039', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(591, '2025-05-31 02:15:41', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739040', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(592, '2025-05-31 02:15:41', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739039', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(593, '2025-05-31 02:15:41', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739039', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(594, '2025-05-31 02:15:41', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739040', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(595, '2025-05-31 02:15:41', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739038', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(596, '2025-05-31 02:15:41', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739039', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(597, '2025-05-31 02:15:41', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657739038', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(598, '2025-05-31 02:15:50', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748472', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(599, '2025-05-31 02:15:50', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748472', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(600, '2025-05-31 02:15:50', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748471', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(601, '2025-05-31 02:15:50', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748472', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(602, '2025-05-31 02:15:50', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748472', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(603, '2025-05-31 02:15:50', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748472', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(604, '2025-05-31 02:15:50', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748473', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(605, '2025-05-31 02:15:50', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748472', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(606, '2025-05-31 02:15:50', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748473', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(607, '2025-05-31 02:15:50', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748473', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(608, '2025-05-31 02:15:50', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748473', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(609, '2025-05-31 02:15:50', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748474', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(610, '2025-05-31 02:15:50', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748473', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(611, '2025-05-31 02:15:50', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748472', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(612, '2025-05-31 02:15:50', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748474', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(613, '2025-05-31 02:15:50', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748473', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(614, '2025-05-31 02:15:50', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748473', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(615, '2025-05-31 02:15:50', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748474', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(616, '2025-05-31 02:15:50', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748474', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(617, '2025-05-31 02:15:50', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748474', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(618, '2025-05-31 02:15:50', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748475', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(619, '2025-05-31 02:15:50', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748475', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(620, '2025-05-31 02:15:50', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748474', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(621, '2025-05-31 02:15:50', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748475', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(622, '2025-05-31 02:15:50', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748475', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(623, '2025-05-31 02:15:50', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748475', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(624, '2025-05-31 02:15:50', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748475', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(625, '2025-05-31 02:15:50', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748476', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(626, '2025-05-31 02:15:50', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748476', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(627, '2025-05-31 02:15:50', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748476', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(628, '2025-05-31 02:15:50', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748474', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL);
INSERT INTO `impression_logs` (`id`, `impression_time`, `zone_id`, `campaign_id`, `creative_id`, `ads_request_url`, `client_ip_address`, `client_user_agent`, `page_url`, `country_code`) VALUES
(629, '2025-05-31 02:15:50', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748475', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(630, '2025-05-31 02:15:50', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748476', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(631, '2025-05-31 02:15:50', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748476', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(632, '2025-05-31 02:15:50', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748476', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(633, '2025-05-31 02:15:50', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657748476', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(634, '2025-05-31 02:16:03', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760282', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(635, '2025-05-31 02:16:03', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760287', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(636, '2025-05-31 02:16:03', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760290', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(637, '2025-05-31 02:16:03', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760289', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(638, '2025-05-31 02:16:03', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760287', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(639, '2025-05-31 02:16:03', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760287', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(640, '2025-05-31 02:16:03', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760287', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(641, '2025-05-31 02:16:03', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760290', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(642, '2025-05-31 02:16:03', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760290', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(643, '2025-05-31 02:16:03', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760288', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(644, '2025-05-31 02:16:03', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760286', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(645, '2025-05-31 02:16:03', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760286', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(646, '2025-05-31 02:16:03', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760283', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(647, '2025-05-31 02:16:03', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760290', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(648, '2025-05-31 02:16:03', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760284', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(649, '2025-05-31 02:16:03', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760284', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(650, '2025-05-31 02:16:03', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760285', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(651, '2025-05-31 02:16:03', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760289', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(652, '2025-05-31 02:16:03', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760290', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(653, '2025-05-31 02:16:03', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760290', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(654, '2025-05-31 02:16:03', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760289', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(655, '2025-05-31 02:16:03', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760289', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(656, '2025-05-31 02:16:03', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760283', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(657, '2025-05-31 02:16:03', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760283', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(658, '2025-05-31 02:16:03', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760289', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(659, '2025-05-31 02:16:03', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760288', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(660, '2025-05-31 02:16:03', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760287', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(661, '2025-05-31 02:16:03', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760286', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(662, '2025-05-31 02:16:04', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760286', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(663, '2025-05-31 02:16:04', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760289', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(664, '2025-05-31 02:16:04', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760283', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(665, '2025-05-31 02:16:04', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760285', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(666, '2025-05-31 02:16:04', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760285', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(667, '2025-05-31 02:16:04', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760287', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(668, '2025-05-31 02:16:04', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760283', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(669, '2025-05-31 02:16:04', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760287', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(670, '2025-05-31 02:16:04', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760288', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(671, '2025-05-31 02:16:04', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760284', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(672, '2025-05-31 02:16:04', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760285', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(673, '2025-05-31 02:16:04', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760284', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(674, '2025-05-31 02:16:04', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760289', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(675, '2025-05-31 02:16:04', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760288', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(676, '2025-05-31 02:16:04', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760288', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(677, '2025-05-31 02:16:04', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760290', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(678, '2025-05-31 02:16:04', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760288', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(679, '2025-05-31 02:16:04', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657760288', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(680, '2025-05-31 02:17:27', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845127', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(681, '2025-05-31 02:17:27', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845132', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(682, '2025-05-31 02:17:27', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845132', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(683, '2025-05-31 02:17:27', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845132', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(684, '2025-05-31 02:17:27', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845133', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(685, '2025-05-31 02:17:27', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845133', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(686, '2025-05-31 02:17:27', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845132', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(687, '2025-05-31 02:17:27', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845132', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(688, '2025-05-31 02:17:27', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845129', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(689, '2025-05-31 02:17:27', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845133', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(690, '2025-05-31 02:17:27', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845132', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(691, '2025-05-31 02:17:27', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845127', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(692, '2025-05-31 02:17:27', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845126', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(693, '2025-05-31 02:17:27', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845126', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(694, '2025-05-31 02:17:27', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845130', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(695, '2025-05-31 02:17:27', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845130', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(696, '2025-05-31 02:17:27', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845127', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(697, '2025-05-31 02:17:27', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845133', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(698, '2025-05-31 02:17:27', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845131', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(699, '2025-05-31 02:17:27', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845131', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(700, '2025-05-31 02:17:28', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845130', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(701, '2025-05-31 02:17:28', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845133', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(702, '2025-05-31 02:17:28', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845130', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(703, '2025-05-31 02:17:28', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845130', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(704, '2025-05-31 02:17:28', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845132', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(705, '2025-05-31 02:17:28', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845131', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(706, '2025-05-31 02:17:28', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845131', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(707, '2025-05-31 02:17:28', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845130', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(708, '2025-05-31 02:17:28', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845128', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(709, '2025-05-31 02:17:28', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845131', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(710, '2025-05-31 02:17:28', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845130', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(711, '2025-05-31 02:17:28', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845128', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(712, '2025-05-31 02:17:28', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845133', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(713, '2025-05-31 02:17:28', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845131', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(714, '2025-05-31 02:17:28', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845127', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(715, '2025-05-31 02:17:28', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845126', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(716, '2025-05-31 02:17:28', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845131', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(717, '2025-05-31 02:17:28', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845129', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(718, '2025-05-31 02:17:28', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845133', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(719, '2025-05-31 02:17:28', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845128', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(720, '2025-05-31 02:17:28', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845127', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(721, '2025-05-31 02:17:28', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845129', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(722, '2025-05-31 02:17:28', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845128', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(723, '2025-05-31 02:17:28', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845129', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(724, '2025-05-31 02:17:28', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845129', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(725, '2025-05-31 02:17:28', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845128', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(726, '2025-05-31 02:17:28', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845127', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(727, '2025-05-31 02:17:28', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748657845129', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(728, '2025-05-31 02:21:30', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088411', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(729, '2025-05-31 02:21:30', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088411', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(730, '2025-05-31 02:21:30', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088411', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(731, '2025-05-31 02:21:30', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088410', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(732, '2025-05-31 02:21:30', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088410', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(733, '2025-05-31 02:21:30', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088411', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(734, '2025-05-31 02:21:30', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088410', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(735, '2025-05-31 02:21:30', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088412', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(736, '2025-05-31 02:21:30', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088411', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(737, '2025-05-31 02:21:30', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088412', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(738, '2025-05-31 02:21:30', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088411', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(739, '2025-05-31 02:21:30', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088405', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(740, '2025-05-31 02:21:30', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088404', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(741, '2025-05-31 02:21:30', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088405', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(742, '2025-05-31 02:21:30', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088406', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(743, '2025-05-31 02:21:30', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088411', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(744, '2025-05-31 02:21:30', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088405', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(745, '2025-05-31 02:21:30', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088412', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(746, '2025-05-31 02:21:30', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088407', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(747, '2025-05-31 02:21:30', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088407', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(748, '2025-05-31 02:21:30', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088406', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(749, '2025-05-31 02:21:30', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088405', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(750, '2025-05-31 02:21:30', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088406', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(751, '2025-05-31 02:21:30', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088407', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(752, '2025-05-31 02:21:30', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088408', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(753, '2025-05-31 02:21:30', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088406', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(754, '2025-05-31 02:21:30', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088406', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(755, '2025-05-31 02:21:30', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088405', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(756, '2025-05-31 02:21:30', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088408', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(757, '2025-05-31 02:21:30', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088408', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(758, '2025-05-31 02:21:30', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088405', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(759, '2025-05-31 02:21:30', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088406', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(760, '2025-05-31 02:21:30', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088408', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(761, '2025-05-31 02:21:30', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088406', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(762, '2025-05-31 02:21:30', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088409', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(763, '2025-05-31 02:21:30', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088409', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(764, '2025-05-31 02:21:30', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088409', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(765, '2025-05-31 02:21:30', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088409', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(766, '2025-05-31 02:21:30', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088408', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(767, '2025-05-31 02:21:30', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088409', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(768, '2025-05-31 02:21:31', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088409', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(769, '2025-05-31 02:21:31', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088410', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(770, '2025-05-31 02:21:31', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088408', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(771, '2025-05-31 02:21:31', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088410', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(772, '2025-05-31 02:21:31', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088410', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(773, '2025-05-31 02:21:31', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658088410', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(774, '2025-05-31 02:21:50', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106843', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(775, '2025-05-31 02:21:50', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106848', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(776, '2025-05-31 02:21:50', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106843', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(777, '2025-05-31 02:21:50', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106841', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(778, '2025-05-31 02:21:50', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106846', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(779, '2025-05-31 02:21:50', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106846', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(780, '2025-05-31 02:21:50', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106845', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(781, '2025-05-31 02:21:50', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106845', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(782, '2025-05-31 02:21:50', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106844', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(783, '2025-05-31 02:21:50', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106844', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(784, '2025-05-31 02:21:50', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106846', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(785, '2025-05-31 02:21:50', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106843', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(786, '2025-05-31 02:21:50', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106842', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(787, '2025-05-31 02:21:50', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106845', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(788, '2025-05-31 02:21:50', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106844', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL);
INSERT INTO `impression_logs` (`id`, `impression_time`, `zone_id`, `campaign_id`, `creative_id`, `ads_request_url`, `client_ip_address`, `client_user_agent`, `page_url`, `country_code`) VALUES
(789, '2025-05-31 02:21:50', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106842', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(790, '2025-05-31 02:21:50', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106845', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(791, '2025-05-31 02:21:50', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106845', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(792, '2025-05-31 02:21:50', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106846', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(793, '2025-05-31 02:21:50', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106846', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(794, '2025-05-31 02:21:50', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106847', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(795, '2025-05-31 02:21:50', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106845', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(796, '2025-05-31 02:21:50', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106847', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(797, '2025-05-31 02:21:50', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106845', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(798, '2025-05-31 02:21:50', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106847', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(799, '2025-05-31 02:21:50', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106847', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(800, '2025-05-31 02:21:50', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106846', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(801, '2025-05-31 02:21:50', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106847', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(802, '2025-05-31 02:21:50', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106848', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(803, '2025-05-31 02:21:50', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106848', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(804, '2025-05-31 02:21:50', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106848', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(805, '2025-05-31 02:21:50', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106843', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(806, '2025-05-31 02:21:50', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106847', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(807, '2025-05-31 02:21:50', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106849', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(808, '2025-05-31 02:21:50', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106843', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(809, '2025-05-31 02:21:50', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106848', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(810, '2025-05-31 02:21:50', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106849', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(811, '2025-05-31 02:21:50', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106849', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(812, '2025-05-31 02:21:50', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106842', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(813, '2025-05-31 02:21:50', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106848', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(814, '2025-05-31 02:21:50', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106849', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(815, '2025-05-31 02:21:50', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106841', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(816, '2025-05-31 02:21:50', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106842', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(817, '2025-05-31 02:21:50', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106848', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(818, '2025-05-31 02:21:50', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106844', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(819, '2025-05-31 02:21:50', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106844', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(820, '2025-05-31 02:21:50', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106842', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(821, '2025-05-31 02:21:50', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658106844', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(822, '2025-05-31 02:26:56', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414142', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(823, '2025-05-31 02:26:56', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414133', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(824, '2025-05-31 02:26:56', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414142', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(825, '2025-05-31 02:26:56', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414141', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(826, '2025-05-31 02:26:56', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414140', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(827, '2025-05-31 02:26:56', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414143', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(828, '2025-05-31 02:26:56', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414141', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(829, '2025-05-31 02:26:56', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414140', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(830, '2025-05-31 02:26:56', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414143', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(831, '2025-05-31 02:26:56', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414143', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(832, '2025-05-31 02:26:56', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414144', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(833, '2025-05-31 02:26:56', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414143', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(834, '2025-05-31 02:26:56', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414129', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(835, '2025-05-31 02:26:56', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414130', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(836, '2025-05-31 02:26:56', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414128', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(837, '2025-05-31 02:26:56', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414131', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(838, '2025-05-31 02:26:56', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414130', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(839, '2025-05-31 02:26:56', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414131', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(840, '2025-05-31 02:26:56', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414142', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(841, '2025-05-31 02:26:56', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414145', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(842, '2025-05-31 02:26:56', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414145', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(843, '2025-05-31 02:26:56', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414144', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(844, '2025-05-31 02:26:56', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414131', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(845, '2025-05-31 02:26:56', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414147', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(846, '2025-05-31 02:26:56', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414133', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(847, '2025-05-31 02:26:56', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414139', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(848, '2025-05-31 02:26:56', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414133', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(849, '2025-05-31 02:26:56', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414134', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(850, '2025-05-31 02:26:56', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414148', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(851, '2025-05-31 02:26:56', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414138', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(852, '2025-05-31 02:26:56', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414134', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(853, '2025-05-31 02:26:56', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414145', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(854, '2025-05-31 02:26:56', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414134', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(855, '2025-05-31 02:26:56', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414149', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(856, '2025-05-31 02:26:56', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414147', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(857, '2025-05-31 02:26:56', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414137', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(858, '2025-05-31 02:26:56', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414137', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(859, '2025-05-31 02:26:56', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414137', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(860, '2025-05-31 02:26:56', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414135', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(861, '2025-05-31 02:26:56', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414136', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(862, '2025-05-31 02:26:56', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414136', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(863, '2025-05-31 02:26:56', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414139', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(864, '2025-05-31 02:26:56', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414132', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(865, '2025-05-31 02:26:56', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414148', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(866, '2025-05-31 02:26:56', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414146', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(867, '2025-05-31 02:26:56', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414138', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(868, '2025-05-31 02:26:56', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414145', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(869, '2025-05-31 02:26:56', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414148', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(870, '2025-05-31 02:26:56', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658414147', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(871, '2025-05-31 02:28:53', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530771', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(872, '2025-05-31 02:28:53', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530772', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(873, '2025-05-31 02:28:53', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530771', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(874, '2025-05-31 02:28:53', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530771', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(875, '2025-05-31 02:28:53', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530772', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(876, '2025-05-31 02:28:53', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530772', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(877, '2025-05-31 02:28:53', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530772', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(878, '2025-05-31 02:28:53', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530771', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(879, '2025-05-31 02:28:53', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530772', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(880, '2025-05-31 02:28:53', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530768', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(881, '2025-05-31 02:28:53', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530767', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(882, '2025-05-31 02:28:53', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530767', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(883, '2025-05-31 02:28:53', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530768', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(884, '2025-05-31 02:28:53', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530771', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(885, '2025-05-31 02:28:53', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530772', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(886, '2025-05-31 02:28:53', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530768', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(887, '2025-05-31 02:28:53', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530767', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(888, '2025-05-31 02:28:53', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530768', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(889, '2025-05-31 02:28:53', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530770', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(890, '2025-05-31 02:28:53', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530772', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(891, '2025-05-31 02:28:53', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530769', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(892, '2025-05-31 02:28:53', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530770', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(893, '2025-05-31 02:28:53', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530771', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(894, '2025-05-31 02:28:53', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530766', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(895, '2025-05-31 02:28:53', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530770', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(896, '2025-05-31 02:28:53', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530767', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(897, '2025-05-31 02:28:53', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530770', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(898, '2025-05-31 02:28:53', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530769', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(899, '2025-05-31 02:28:53', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530771', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(900, '2025-05-31 02:28:53', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530766', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(901, '2025-05-31 02:28:53', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530769', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(902, '2025-05-31 02:28:53', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530769', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(903, '2025-05-31 02:28:53', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530770', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(904, '2025-05-31 02:28:53', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530769', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(905, '2025-05-31 02:28:53', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530769', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(906, '2025-05-31 02:28:53', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530769', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(907, '2025-05-31 02:28:53', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530770', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(908, '2025-05-31 02:28:53', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530768', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(909, '2025-05-31 02:28:53', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658530766', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(910, '2025-05-31 02:35:27', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924443', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(911, '2025-05-31 02:35:27', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924444', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(912, '2025-05-31 02:35:27', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924443', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(913, '2025-05-31 02:35:27', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924443', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(914, '2025-05-31 02:35:27', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924444', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(915, '2025-05-31 02:35:27', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924445', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(916, '2025-05-31 02:35:27', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924445', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(917, '2025-05-31 02:35:27', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924442', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(918, '2025-05-31 02:35:27', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924446', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(919, '2025-05-31 02:35:27', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924428', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(920, '2025-05-31 02:35:27', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924446', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(921, '2025-05-31 02:35:27', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924447', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(922, '2025-05-31 02:35:27', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924431', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(923, '2025-05-31 02:35:27', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924447', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(924, '2025-05-31 02:35:27', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924430', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(925, '2025-05-31 02:35:27', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924429', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(926, '2025-05-31 02:35:27', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924430', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(927, '2025-05-31 02:35:27', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924435', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(928, '2025-05-31 02:35:27', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924435', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(929, '2025-05-31 02:35:27', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924430', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(930, '2025-05-31 02:35:27', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924436', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(931, '2025-05-31 02:35:27', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924427', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(932, '2025-05-31 02:35:27', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924447', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(933, '2025-05-31 02:35:27', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924435', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(934, '2025-05-31 02:35:27', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924432', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(935, '2025-05-31 02:35:27', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924436', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(936, '2025-05-31 02:35:27', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924433', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(937, '2025-05-31 02:35:27', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924432', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(938, '2025-05-31 02:35:27', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924438', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(939, '2025-05-31 02:35:27', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924437', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(940, '2025-05-31 02:35:27', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924433', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(941, '2025-05-31 02:35:27', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924433', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(942, '2025-05-31 02:35:27', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924434', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(943, '2025-05-31 02:35:27', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924433', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(944, '2025-05-31 02:35:27', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924438', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(945, '2025-05-31 02:35:27', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924432', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(946, '2025-05-31 02:35:27', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924438', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(947, '2025-05-31 02:35:27', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924438', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(948, '2025-05-31 02:35:27', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924439', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL);
INSERT INTO `impression_logs` (`id`, `impression_time`, `zone_id`, `campaign_id`, `creative_id`, `ads_request_url`, `client_ip_address`, `client_user_agent`, `page_url`, `country_code`) VALUES
(949, '2025-05-31 02:35:27', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924440', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(950, '2025-05-31 02:35:27', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924439', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(951, '2025-05-31 02:35:27', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924441', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(952, '2025-05-31 02:35:28', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924440', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(953, '2025-05-31 02:35:28', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924439', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(954, '2025-05-31 02:35:28', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924441', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(955, '2025-05-31 02:35:28', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924441', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(956, '2025-05-31 02:35:28', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924442', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(957, '2025-05-31 02:35:28', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924441', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(958, '2025-05-31 02:35:28', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748658924442', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(959, '2025-05-31 02:37:24', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042197', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(960, '2025-05-31 02:37:25', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042198', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(961, '2025-05-31 02:37:25', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042197', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(962, '2025-05-31 02:37:25', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042198', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(963, '2025-05-31 02:37:25', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042199', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(964, '2025-05-31 02:37:25', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042197', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(965, '2025-05-31 02:37:25', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042200', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(966, '2025-05-31 02:37:25', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042199', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(967, '2025-05-31 02:37:25', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042199', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(968, '2025-05-31 02:37:25', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042200', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(969, '2025-05-31 02:37:25', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042180', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(970, '2025-05-31 02:37:25', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042183', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(971, '2025-05-31 02:37:25', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042183', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(972, '2025-05-31 02:37:25', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042181', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(973, '2025-05-31 02:37:25', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042184', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(974, '2025-05-31 02:37:25', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042184', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(975, '2025-05-31 02:37:25', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042188', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(976, '2025-05-31 02:37:25', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042188', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(977, '2025-05-31 02:37:25', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042187', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(978, '2025-05-31 02:37:25', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042190', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(979, '2025-05-31 02:37:25', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042180', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(980, '2025-05-31 02:37:25', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042180', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(981, '2025-05-31 02:37:25', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042181', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(982, '2025-05-31 02:37:25', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042190', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(983, '2025-05-31 02:37:25', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042191', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(984, '2025-05-31 02:37:25', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042185', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(985, '2025-05-31 02:37:25', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042189', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(986, '2025-05-31 02:37:25', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042186', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(987, '2025-05-31 02:37:25', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042185', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(988, '2025-05-31 02:37:25', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042185', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(989, '2025-05-31 02:37:25', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042187', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(990, '2025-05-31 02:37:25', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042179', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(991, '2025-05-31 02:37:25', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042179', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(992, '2025-05-31 02:37:25', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042191', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(993, '2025-05-31 02:37:25', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042187', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(994, '2025-05-31 02:37:25', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042192', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(995, '2025-05-31 02:37:25', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042191', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(996, '2025-05-31 02:37:25', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042193', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(997, '2025-05-31 02:37:25', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042192', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(998, '2025-05-31 02:37:25', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042193', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(999, '2025-05-31 02:37:25', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042193', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1000, '2025-05-31 02:37:25', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042194', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1001, '2025-05-31 02:37:25', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042194', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1002, '2025-05-31 02:37:25', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042195', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1003, '2025-05-31 02:37:25', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042194', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1004, '2025-05-31 02:37:25', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042195', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1005, '2025-05-31 02:37:25', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042196', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1006, '2025-05-31 02:37:25', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042196', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1007, '2025-05-31 02:37:25', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659042196', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1008, '2025-05-31 02:38:22', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098765', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1009, '2025-05-31 02:38:22', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098782', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1010, '2025-05-31 02:38:22', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098781', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1011, '2025-05-31 02:38:22', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098780', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1012, '2025-05-31 02:38:22', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098781', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1013, '2025-05-31 02:38:22', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098778', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1014, '2025-05-31 02:38:22', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098769', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1015, '2025-05-31 02:38:22', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098782', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1016, '2025-05-31 02:38:22', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098775', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1017, '2025-05-31 02:38:22', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098767', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1018, '2025-05-31 02:38:22', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098778', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1019, '2025-05-31 02:38:22', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098780', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1020, '2025-05-31 02:38:22', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098772', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1021, '2025-05-31 02:38:22', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098771', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1022, '2025-05-31 02:38:22', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098761', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1023, '2025-05-31 02:38:22', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098773', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1024, '2025-05-31 02:38:22', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098775', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1025, '2025-05-31 02:38:22', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098760', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1026, '2025-05-31 02:38:22', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098764', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1027, '2025-05-31 02:38:22', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098763', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1028, '2025-05-31 02:38:22', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098768', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1029, '2025-05-31 02:38:22', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098762', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1030, '2025-05-31 02:38:22', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098769', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1031, '2025-05-31 02:38:22', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098779', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1032, '2025-05-31 02:38:22', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098772', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1033, '2025-05-31 02:38:22', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098777', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1034, '2025-05-31 02:38:22', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098769', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1035, '2025-05-31 02:38:22', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098773', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1036, '2025-05-31 02:38:22', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098760', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1037, '2025-05-31 02:38:22', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098761', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1038, '2025-05-31 02:38:22', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098777', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1039, '2025-05-31 02:38:22', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098778', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1040, '2025-05-31 02:38:22', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098766', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1041, '2025-05-31 02:38:22', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098766', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1042, '2025-05-31 02:38:22', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098775', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1043, '2025-05-31 02:38:22', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098781', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1044, '2025-05-31 02:38:22', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098762', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1045, '2025-05-31 02:38:22', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098776', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1046, '2025-05-31 02:38:22', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098774', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1047, '2025-05-31 02:38:22', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098766', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1048, '2025-05-31 02:38:22', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098770', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1049, '2025-05-31 02:38:22', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098776', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1050, '2025-05-31 02:38:22', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098774', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1051, '2025-05-31 02:38:22', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098779', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1052, '2025-05-31 02:38:22', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098771', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1053, '2025-05-31 02:38:22', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098768', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1054, '2025-05-31 02:38:22', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098764', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1055, '2025-05-31 02:38:22', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098768', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1056, '2025-05-31 02:38:23', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659098765', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1057, '2025-05-31 02:40:05', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202179', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1058, '2025-05-31 02:40:05', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202183', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1059, '2025-05-31 02:40:05', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202177', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1060, '2025-05-31 02:40:05', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202179', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1061, '2025-05-31 02:40:05', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202186', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1062, '2025-05-31 02:40:05', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202187', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1063, '2025-05-31 02:40:05', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202186', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1064, '2025-05-31 02:40:05', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202182', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1065, '2025-05-31 02:40:05', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202186', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1066, '2025-05-31 02:40:05', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202182', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1067, '2025-05-31 02:40:05', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202181', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1068, '2025-05-31 02:40:05', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202181', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1069, '2025-05-31 02:40:05', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202183', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1070, '2025-05-31 02:40:05', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202185', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1071, '2025-05-31 02:40:05', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202178', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1072, '2025-05-31 02:40:05', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202178', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1073, '2025-05-31 02:40:05', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202178', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1074, '2025-05-31 02:40:06', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202183', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1075, '2025-05-31 02:40:06', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202179', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1076, '2025-05-31 02:40:06', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202188', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1077, '2025-05-31 02:40:06', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202189', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1078, '2025-05-31 02:40:06', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202189', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1079, '2025-05-31 02:40:06', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202190', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1080, '2025-05-31 02:40:06', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202185', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1081, '2025-05-31 02:40:06', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202198', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1082, '2025-05-31 02:40:06', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202197', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1083, '2025-05-31 02:40:06', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202197', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1084, '2025-05-31 02:40:06', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202196', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1085, '2025-05-31 02:40:06', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202195', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1086, '2025-05-31 02:40:06', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202194', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1087, '2025-05-31 02:40:06', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202194', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1088, '2025-05-31 02:40:06', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202197', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1089, '2025-05-31 02:40:06', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202195', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1090, '2025-05-31 02:40:06', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202195', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1091, '2025-05-31 02:40:06', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202193', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1092, '2025-05-31 02:40:06', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202196', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1093, '2025-05-31 02:40:06', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202192', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1094, '2025-05-31 02:40:06', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202191', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1095, '2025-05-31 02:40:06', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202193', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1096, '2025-05-31 02:40:06', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202187', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1097, '2025-05-31 02:40:06', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202201', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1098, '2025-05-31 02:40:06', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202201', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1099, '2025-05-31 02:40:06', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202200', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1100, '2025-05-31 02:40:06', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202200', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1101, '2025-05-31 02:40:06', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202200', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1102, '2025-05-31 02:40:06', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202199', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1103, '2025-05-31 02:40:06', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202199', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1104, '2025-05-31 02:40:06', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202198', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1105, '2025-05-31 02:40:06', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659202189', '23.106.56.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1106, '2025-05-31 02:42:01', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318623', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1107, '2025-05-31 02:42:01', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318623', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1108, '2025-05-31 02:42:01', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318625', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL);
INSERT INTO `impression_logs` (`id`, `impression_time`, `zone_id`, `campaign_id`, `creative_id`, `ads_request_url`, `client_ip_address`, `client_user_agent`, `page_url`, `country_code`) VALUES
(1109, '2025-05-31 02:42:01', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318623', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1110, '2025-05-31 02:42:01', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318624', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1111, '2025-05-31 02:42:01', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318624', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1112, '2025-05-31 02:42:01', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318625', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1113, '2025-05-31 02:42:01', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318622', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1114, '2025-05-31 02:42:01', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318627', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1115, '2025-05-31 02:42:01', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318620', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1116, '2025-05-31 02:42:01', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318620', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1117, '2025-05-31 02:42:01', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318626', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1118, '2025-05-31 02:42:01', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318621', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1119, '2025-05-31 02:42:01', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318626', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1120, '2025-05-31 02:42:01', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318626', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1121, '2025-05-31 02:42:01', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318621', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1122, '2025-05-31 02:42:01', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318612', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1123, '2025-05-31 02:42:01', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318614', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1124, '2025-05-31 02:42:01', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318605', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1125, '2025-05-31 02:42:01', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318615', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1126, '2025-05-31 02:42:01', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318620', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1127, '2025-05-31 02:42:01', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318625', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1128, '2025-05-31 02:42:01', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318615', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1129, '2025-05-31 02:42:01', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318621', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1130, '2025-05-31 02:42:01', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318616', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1131, '2025-05-31 02:42:01', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318607', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1132, '2025-05-31 02:42:01', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318609', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1133, '2025-05-31 02:42:01', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318622', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1134, '2025-05-31 02:42:01', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318613', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1135, '2025-05-31 02:42:01', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318616', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1136, '2025-05-31 02:42:01', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318607', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1137, '2025-05-31 02:42:01', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318610', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1138, '2025-05-31 02:42:01', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318617', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1139, '2025-05-31 02:42:01', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318619', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1140, '2025-05-31 02:42:01', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318611', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1141, '2025-05-31 02:42:01', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318608', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1142, '2025-05-31 02:42:01', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318618', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1143, '2025-05-31 02:42:01', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318617', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1144, '2025-05-31 02:42:01', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318612', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1145, '2025-05-31 02:42:01', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318609', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1146, '2025-05-31 02:42:01', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318618', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1147, '2025-05-31 02:42:01', '3', NULL, NULL, '/get_ad.php?zid=3&w=300&h=100&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318606', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1148, '2025-05-31 02:42:01', '6', NULL, NULL, '/get_ad.php?zid=6&w=300&h=50&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318618', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1149, '2025-05-31 02:42:01', '7', NULL, NULL, '/get_ad.php?zid=7&w=900&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318612', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1150, '2025-05-31 02:42:01', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318611', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1151, '2025-05-31 02:42:01', '2', NULL, NULL, '/get_ad.php?zid=2&w=160&h=600&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318619', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1152, '2025-05-31 02:42:01', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318611', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1153, '2025-05-31 02:42:01', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318619', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1154, '2025-05-31 02:42:01', '4', NULL, NULL, '/get_ad.php?zid=4&w=300&h=500&purl=https%3A%2F%2Fadstart.click%2Fads.html&cb=1748659318615', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/ads.html', NULL),
(1155, '2025-05-31 02:57:02', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fhtmleditor.gitlab.io%2F&cb=1748660219445', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://htmleditor.gitlab.io/', NULL),
(1156, '2025-05-31 02:57:06', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fhtmleditor.gitlab.io%2F&cb=1748660223665', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://htmleditor.gitlab.io/', NULL),
(1157, '2025-05-31 02:57:07', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fhtmleditor.gitlab.io%2F&cb=1748660225658', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://htmleditor.gitlab.io/', NULL),
(1158, '2025-05-31 03:10:06', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fhtmleditor.gitlab.io%2F&cb=1748661003270', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://htmleditor.gitlab.io/', NULL),
(1159, '2025-05-31 03:57:37', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Ftest_panel_ads.html&cb=1748663854240', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/test_panel_ads.html', NULL),
(1160, '2025-05-31 03:57:37', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Ftest_panel_ads.html&cb=1748663854239', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/test_panel_ads.html', NULL),
(1161, '2025-05-31 04:04:12', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Ftest_panel_ads.html&cb=1748664249876', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/test_panel_ads.html', NULL),
(1162, '2025-05-31 04:04:12', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Ftest_panel_ads.html&cb=1748664249876', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/test_panel_ads.html', NULL),
(1163, '2025-05-31 04:08:34', '1', 1, 101, '/get_ad.php?zid=1&w=300&h=250&purl=https%3A%2F%2Fadstart.click%2Ftest_panel_ads.html&cb=1748664511344', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/test_panel_ads.html', NULL),
(1164, '2025-05-31 04:08:34', '5', 5, 501, '/get_ad.php?zid=5&w=728&h=90&purl=https%3A%2F%2Fadstart.click%2Ftest_panel_ads.html&cb=1748664511344', '110.137.38.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'https://adstart.click/test_panel_ads.html', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `login_attempts`
--

CREATE TABLE `login_attempts` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'Link to users table if login attempt was for an existing user',
  `email_attempted` varchar(100) NOT NULL COMMENT 'Email used in the login attempt',
  `ip_address` varchar(45) NOT NULL,
  `attempted_at` datetime NOT NULL DEFAULT current_timestamp(),
  `success` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Logs login attempts for security auditing';

-- --------------------------------------------------------

--
-- Struktur dari tabel `sites`
--

CREATE TABLE `sites` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `site_name` varchar(100) NOT NULL,
  `domain` varchar(255) NOT NULL,
  `status` enum('pending','active','rejected','suspended') DEFAULT 'pending',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data untuk tabel `sites`
--

INSERT INTO `sites` (`id`, `user_id`, `category_id`, `site_name`, `domain`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 'sxytn', 'sxytn.com', 'active', '2025-05-29 15:53:44', '2025-05-29 16:02:19');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(50) NOT NULL COMMENT 'Unique username, can be same as email or separate',
  `email` varchar(100) NOT NULL COMMENT 'User''s email address, used for login',
  `password_hash` varchar(255) NOT NULL COMMENT 'Hashed password (use password_hash())',
  `role` enum('admin','publisher','dsp') NOT NULL DEFAULT 'publisher' COMMENT 'User role',
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `company_name` varchar(100) DEFAULT NULL,
  `status` enum('active','inactive','pending_approval','suspended') NOT NULL DEFAULT 'pending_approval',
  `email_verified` tinyint(1) NOT NULL DEFAULT 0,
  `email_verification_token` varchar(100) DEFAULT NULL,
  `password_reset_token` varchar(100) DEFAULT NULL,
  `password_reset_expires` datetime DEFAULT NULL,
  `last_login_at` datetime DEFAULT NULL,
  `last_login_ip` varchar(45) DEFAULT NULL,
  `failed_login_attempts` tinyint(3) UNSIGNED DEFAULT 0,
  `lockout_until` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores user accounts for all panel types';

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password_hash`, `role`, `first_name`, `last_name`, `company_name`, `status`, `email_verified`, `email_verification_token`, `password_reset_token`, `password_reset_expires`, `last_login_at`, `last_login_ip`, `failed_login_attempts`, `lockout_until`, `created_at`, `updated_at`) VALUES
(1, 'adminuser', 'admin@adstart.click', '$2y$10$R3bE8CDApWSpSkI67DqucOX84vAYzveuubsPekg/c6P3W3cn2kPvW', 'admin', 'Admin', NULL, NULL, 'active', 1, NULL, NULL, NULL, '2025-05-30 12:50:21', '114.79.0.156', 0, NULL, '2025-05-29 07:28:52', '2025-05-30 12:50:21'),
(2, 'ari513270', 'ari513270@gmail.com', '$2y$10$jeTahbuf.A2Va7v0Qyy0/ehYZskIVdaVCl8DxRJ20Z8gnVS0EoH1q', 'publisher', 'Ari', 'Andrianto', NULL, 'active', 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, '2025-05-29 07:45:08', '2025-05-29 07:45:08');

-- --------------------------------------------------------

--
-- Struktur dari tabel `zones`
--

CREATE TABLE `zones` (
  `id` int(10) UNSIGNED NOT NULL,
  `site_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `zone_type` enum('banner','video','native','text_ad','popup','popunder') DEFAULT 'banner',
  `width` int(10) UNSIGNED DEFAULT NULL COMMENT 'Width in pixels, for banner/video',
  `height` int(10) UNSIGNED DEFAULT NULL COMMENT 'Height in pixels, for banner/video',
  `status` enum('active','inactive','archived') DEFAULT 'active',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data untuk tabel `zones`
--

INSERT INTO `zones` (`id`, `site_id`, `name`, `description`, `zone_type`, `width`, `height`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Banner', '', 'banner', 300, 250, 'active', '2025-05-29 16:31:59', '2025-05-29 16:32:09'),
(2, 1, '160x600', '', 'banner', 160, 600, 'active', '2025-05-31 00:55:52', '2025-05-31 00:55:52'),
(3, 1, '300x100', '', 'banner', 300, 100, 'active', '2025-05-31 00:56:15', '2025-05-31 00:56:15'),
(4, 1, '300x500', '', 'banner', 300, 500, 'active', '2025-05-31 01:08:32', '2025-05-31 01:08:32'),
(5, 1, '728x90', '', 'banner', 728, 90, 'active', '2025-05-31 01:12:06', '2025-05-31 01:12:06'),
(6, 1, '300x50', '', 'banner', 300, 50, 'active', '2025-05-31 01:12:51', '2025-05-31 01:12:51'),
(7, 1, '900x250', '', 'banner', 900, 250, 'active', '2025-05-31 01:13:15', '2025-05-31 01:13:15');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `banner_sizes`
--
ALTER TABLE `banner_sizes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_dimensions` (`width`,`height`),
  ADD UNIQUE KEY `unique_name` (`name`);

--
-- Indeks untuk tabel `campaigns`
--
ALTER TABLE `campaigns`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `dsp_endpoint_id` (`dsp_endpoint_id`),
  ADD KEY `idx_campaigns_campaign_type` (`campaign_type`);

--
-- Indeks untuk tabel `campaign_ad_formats`
--
ALTER TABLE `campaign_ad_formats`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_campaign_format` (`campaign_id`,`ad_format_key`);

--
-- Indeks untuk tabel `campaign_categories`
--
ALTER TABLE `campaign_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_campaign_category` (`campaign_id`,`category_id`),
  ADD KEY `fk_campaigncategories_category` (`category_id`);

--
-- Indeks untuk tabel `campaign_creatives`
--
ALTER TABLE `campaign_creatives`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_campaign_creative` (`campaign_id`,`creative_id`),
  ADD KEY `creative_id` (`creative_id`);

--
-- Indeks untuk tabel `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indeks untuk tabel `click_logs`
--
ALTER TABLE `click_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_click_time` (`click_time`),
  ADD KEY `idx_campaign_creative_click` (`campaign_id`,`creative_id`),
  ADD KEY `idx_zone_click` (`zone_id`);

--
-- Indeks untuk tabel `creatives`
--
ALTER TABLE `creatives`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `dsp_endpoints`
--
ALTER TABLE `dsp_endpoints`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_dsp_endpoints_category` (`category_id`);

--
-- Indeks untuk tabel `dsp_endpoint_banner_sizes`
--
ALTER TABLE `dsp_endpoint_banner_sizes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_dsp_banner_size` (`dsp_endpoint_id`,`banner_size_id`),
  ADD KEY `fk_dspbanners_bannersize` (`banner_size_id`);

--
-- Indeks untuk tabel `dsp_endpoint_formats`
--
ALTER TABLE `dsp_endpoint_formats`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_dsp_format` (`dsp_endpoint_id`,`ad_format`);

--
-- Indeks untuk tabel `impression_logs`
--
ALTER TABLE `impression_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_impression_time` (`impression_time`),
  ADD KEY `idx_campaign_creative` (`campaign_id`,`creative_id`),
  ADD KEY `idx_zone` (`zone_id`);

--
-- Indeks untuk tabel `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_email_attempted` (`email_attempted`),
  ADD KEY `idx_ip_address` (`ip_address`);

--
-- Indeks untuk tabel `sites`
--
ALTER TABLE `sites`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `fk_sites_category` (`category_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_email_unique` (`email`),
  ADD UNIQUE KEY `idx_username_unique` (`username`),
  ADD KEY `idx_role` (`role`),
  ADD KEY `idx_status` (`status`);

--
-- Indeks untuk tabel `zones`
--
ALTER TABLE `zones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_zones_site` (`site_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `banner_sizes`
--
ALTER TABLE `banner_sizes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `campaigns`
--
ALTER TABLE `campaigns`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `campaign_ad_formats`
--
ALTER TABLE `campaign_ad_formats`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `campaign_categories`
--
ALTER TABLE `campaign_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `campaign_creatives`
--
ALTER TABLE `campaign_creatives`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `click_logs`
--
ALTER TABLE `click_logs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `creatives`
--
ALTER TABLE `creatives`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `dsp_endpoints`
--
ALTER TABLE `dsp_endpoints`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `dsp_endpoint_banner_sizes`
--
ALTER TABLE `dsp_endpoint_banner_sizes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT untuk tabel `dsp_endpoint_formats`
--
ALTER TABLE `dsp_endpoint_formats`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `impression_logs`
--
ALTER TABLE `impression_logs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1165;

--
-- AUTO_INCREMENT untuk tabel `login_attempts`
--
ALTER TABLE `login_attempts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `sites`
--
ALTER TABLE `sites`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `zones`
--
ALTER TABLE `zones`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `campaigns`
--
ALTER TABLE `campaigns`
  ADD CONSTRAINT `campaigns_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `campaigns_ibfk_2` FOREIGN KEY (`dsp_endpoint_id`) REFERENCES `dsp_endpoints` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_campaigns_dsp_endpoint_id_unique_20250530` FOREIGN KEY (`dsp_endpoint_id`) REFERENCES `dsp_endpoints` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `campaign_ad_formats`
--
ALTER TABLE `campaign_ad_formats`
  ADD CONSTRAINT `caf_campaign_id_fk` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `campaign_categories`
--
ALTER TABLE `campaign_categories`
  ADD CONSTRAINT `fk_campaigncategories_campaign` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_campaigncategories_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `campaign_creatives`
--
ALTER TABLE `campaign_creatives`
  ADD CONSTRAINT `campaign_creatives_ibfk_1` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `campaign_creatives_ibfk_2` FOREIGN KEY (`creative_id`) REFERENCES `creatives` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `creatives`
--
ALTER TABLE `creatives`
  ADD CONSTRAINT `creatives_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `dsp_endpoints`
--
ALTER TABLE `dsp_endpoints`
  ADD CONSTRAINT `fk_dsp_endpoints_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `dsp_endpoint_banner_sizes`
--
ALTER TABLE `dsp_endpoint_banner_sizes`
  ADD CONSTRAINT `fk_dspbanners_bannersize` FOREIGN KEY (`banner_size_id`) REFERENCES `banner_sizes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_dspbanners_dspendpoint` FOREIGN KEY (`dsp_endpoint_id`) REFERENCES `dsp_endpoints` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `dsp_endpoint_formats`
--
ALTER TABLE `dsp_endpoint_formats`
  ADD CONSTRAINT `fk_dspformats_dspendpoint` FOREIGN KEY (`dsp_endpoint_id`) REFERENCES `dsp_endpoints` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD CONSTRAINT `fk_login_attempts_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `sites`
--
ALTER TABLE `sites`
  ADD CONSTRAINT `fk_sites_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `sites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `zones`
--
ALTER TABLE `zones`
  ADD CONSTRAINT `fk_zones_site` FOREIGN KEY (`site_id`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
