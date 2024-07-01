-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 01, 2024 at 05:34 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `house_residence`
--

-- --------------------------------------------------------

--
-- Table structure for table `houses`
--

CREATE TABLE `houses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `house_number` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `houses`
--

INSERT INTO `houses` (`id`, `house_number`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'House 1', 1, '2024-06-30 02:12:27', '2024-06-30 02:12:27'),
(2, 'House 2', 1, '2024-06-30 02:12:27', '2024-06-30 02:12:27'),
(3, 'House 3', 1, '2024-06-30 02:12:27', '2024-06-30 02:12:27'),
(4, 'House 4', 1, '2024-06-30 02:12:27', '2024-06-30 02:12:27'),
(5, 'House 5', 1, '2024-06-30 02:12:27', '2024-06-30 02:12:27'),
(6, 'House 6', 1, '2024-06-30 02:12:27', '2024-06-30 02:12:27'),
(7, 'House 7', 1, '2024-06-30 02:12:27', '2024-06-30 02:12:27'),
(8, 'House 8', 1, '2024-06-30 02:12:27', '2024-06-30 02:12:27'),
(9, 'House 9', 1, '2024-06-30 02:12:27', '2024-06-30 02:12:27'),
(10, 'House 10', 0, '2024-06-30 02:12:27', '2024-06-30 02:12:27'),
(11, 'House 11', 0, '2024-06-30 02:12:27', '2024-06-30 02:12:27'),
(12, 'House 12', 0, '2024-06-30 02:12:27', '2024-06-30 02:12:27'),
(13, 'House ABC 1 edit', 0, '2024-06-30 21:07:11', '2024-07-01 04:22:08'),
(15, 'House ABC 11 edit', 1, '2024-07-01 02:18:38', '2024-07-01 02:33:41');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2024_06_29_042841_create_houses_table', 1),
(2, '2024_06_29_042914_create_people_table', 1),
(3, '2024_06_29_042922_create_payments_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `person_id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(255) NOT NULL,
  `bill_for` date NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `paid_at` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `person_id`, `type`, `bill_for`, `amount`, `paid_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'security', '2024-01-01', 100000.00, '2024-01-05', '2024-06-30 02:14:06', '2024-06-30 02:14:06'),
(2, 1, 'cleaning_services', '2024-01-01', 15000.00, '2024-01-10', '2024-06-30 02:14:06', '2024-06-30 02:14:06'),
(3, 4, 'security', '2024-01-01', 100000.00, '2024-01-06', '2024-06-30 02:14:06', '2024-06-30 02:14:06'),
(4, 4, 'cleaning_services', '2024-01-01', 15000.00, '2024-01-09', '2024-06-30 02:14:06', '2024-06-30 02:14:06'),
(5, 7, 'security', '2024-01-01', 100000.00, '2024-01-07', '2024-06-30 02:14:06', '2024-06-30 02:14:06'),
(6, 7, 'cleaning_services', '2024-01-01', 15000.00, '2024-01-08', '2024-06-30 02:14:06', '2024-06-30 02:14:06'),
(7, 10, 'security', '2024-01-01', 100000.00, '2024-01-03', '2024-06-30 02:14:06', '2024-06-30 02:14:06'),
(8, 10, 'cleaning_services', '2024-01-01', 15000.00, '2024-01-11', '2024-06-30 02:14:06', '2024-06-30 02:14:06'),
(9, 13, 'security', '2024-01-01', 100000.00, '2024-01-04', '2024-06-30 02:14:06', '2024-06-30 02:14:06'),
(10, 13, 'cleaning_services', '2024-01-01', 15000.00, '2024-01-12', '2024-06-30 02:14:06', '2024-06-30 02:14:06'),
(11, 16, 'security', '2024-01-01', 100000.00, '2024-01-02', '2024-06-30 02:14:06', '2024-06-30 02:14:06'),
(12, 16, 'cleaning_services', '2024-01-01', 15000.00, '2024-01-10', '2024-06-30 02:14:06', '2024-06-30 02:14:06'),
(13, 19, 'security', '2024-01-01', 100000.00, '2024-01-03', '2024-06-30 02:14:06', '2024-06-30 02:14:06'),
(14, 19, 'cleaning_services', '2024-01-01', 15000.00, '2024-01-09', '2024-06-30 02:14:06', '2024-06-30 02:14:06'),
(15, 22, 'security', '2024-01-01', 100000.00, '2024-01-06', '2024-06-30 02:14:06', '2024-06-30 02:14:06'),
(16, 22, 'cleaning_services', '2024-01-01', 15000.00, '2024-01-07', '2024-06-30 02:14:06', '2024-06-30 02:14:06'),
(17, 25, 'security', '2024-01-01', 100000.00, '2024-01-04', '2024-06-30 02:14:06', '2024-06-30 02:14:06'),
(18, 25, 'cleaning_services', '2024-01-01', 15000.00, '2024-01-10', '2024-06-30 02:14:06', '2024-06-30 02:14:06');

-- --------------------------------------------------------

--
-- Table structure for table `people`
--

CREATE TABLE `people` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `id_card_photo` varchar(255) DEFAULT NULL,
  `is_full` tinyint(1) NOT NULL DEFAULT 1,
  `phone_number` varchar(255) NOT NULL,
  `married_status` varchar(255) NOT NULL,
  `house_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `people`
--

INSERT INTO `people` (`id`, `full_name`, `id_card_photo`, `is_full`, `phone_number`, `married_status`, `house_id`, `created_at`, `updated_at`) VALUES
(1, 'Person 1', NULL, 1, '1234567890', 'single', 1, '2024-06-30 02:13:13', '2024-06-30 02:13:13'),
(2, 'Person 2', NULL, 0, '1234567891', 'married', 1, '2024-06-30 02:13:13', '2024-06-30 02:13:13'),
(3, 'Person 3', NULL, 1, '1234567892', 'single', 1, '2024-06-30 02:13:13', '2024-06-30 02:13:13'),
(4, 'Person 4', NULL, 1, '1234567893', 'married', 2, '2024-06-30 02:13:13', '2024-06-30 02:13:13'),
(5, 'Person 5', NULL, 0, '1234567894', 'single', 2, '2024-06-30 02:13:13', '2024-06-30 02:13:13'),
(6, 'Person 6', NULL, 1, '1234567895', 'married', 2, '2024-06-30 02:13:13', '2024-06-30 02:13:13'),
(7, 'Person 7', NULL, 1, '1234567896', 'single', 3, '2024-06-30 02:13:13', '2024-06-30 02:13:13'),
(8, 'Person 8', NULL, 0, '1234567897', 'married', 3, '2024-06-30 02:13:13', '2024-06-30 02:13:13'),
(9, 'Person 9', NULL, 1, '1234567898', 'single', 3, '2024-06-30 02:13:13', '2024-06-30 02:13:13'),
(10, 'Person 10', NULL, 1, '1234567899', 'married', 4, '2024-06-30 02:13:13', '2024-06-30 02:13:13'),
(11, 'Person 11', NULL, 0, '1234567890', 'single', 4, '2024-06-30 02:13:13', '2024-06-30 02:13:13'),
(12, 'Person 12', NULL, 1, '1234567891', 'married', 4, '2024-06-30 02:13:13', '2024-06-30 02:13:13'),
(13, 'Person 13', NULL, 1, '1234567892', 'single', 5, '2024-06-30 02:13:13', '2024-06-30 02:13:13'),
(14, 'Person 14', NULL, 0, '1234567893', 'married', 5, '2024-06-30 02:13:13', '2024-06-30 02:13:13'),
(15, 'Person 15', NULL, 1, '1234567894', 'single', 5, '2024-06-30 02:13:13', '2024-06-30 02:13:13'),
(16, 'Person 16', NULL, 1, '1234567895', 'married', 6, '2024-06-30 02:13:13', '2024-06-30 02:13:13'),
(18, 'Person 18', NULL, 1, '1234567897', 'married', 6, '2024-06-30 02:13:13', '2024-06-30 02:13:13'),
(19, 'Person 19', NULL, 1, '1234567898', 'single', 7, '2024-06-30 02:13:13', '2024-06-30 02:13:13'),
(20, 'Person 20', NULL, 0, '1234567899', 'married', 7, '2024-06-30 02:13:13', '2024-06-30 02:13:13'),
(21, 'Person 21', NULL, 1, '1234567890', 'single', 7, '2024-06-30 02:13:13', '2024-06-30 02:13:13'),
(22, 'Person 22', NULL, 1, '1234567891', 'married', 8, '2024-06-30 02:13:13', '2024-06-30 02:13:13'),
(23, 'Person 23', NULL, 0, '1234567892', 'single', 8, '2024-06-30 02:13:13', '2024-06-30 02:13:13'),
(24, 'Person 24', NULL, 1, '1234567893', 'married', 8, '2024-06-30 02:13:13', '2024-06-30 02:13:13'),
(25, 'Person 25', NULL, 1, '1234567894', 'single', 9, '2024-06-30 02:13:13', '2024-06-30 02:13:13'),
(26, 'Person 26', NULL, 0, '1234567895', 'married', 9, '2024-06-30 02:13:13', '2024-06-30 02:13:13'),
(27, 'Person 27', NULL, 1, '1234567896', 'single', 9, '2024-06-30 02:13:13', '2024-06-30 02:13:13'),
(28, 'Person test 1', NULL, 1, '123456', 'single', 1, '2024-07-01 13:48:18', '2024-07-01 13:48:18'),
(29, 'Person test 2', NULL, 1, '56788', 'single', 1, '2024-07-01 13:48:18', '2024-07-01 13:48:18'),
(30, 'Test full name', 'AsxWO6rrye1KFRW7aE3BerSthLZkvmMlai8POi0X.png', 0, '123', 'menikah', 13, '2024-07-01 07:45:21', '2024-07-01 07:45:21');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payments_person_id_foreign` (`person_id`);

--
-- Indexes for table `people`
--
ALTER TABLE `people`
  ADD PRIMARY KEY (`id`),
  ADD KEY `people_house_id_foreign` (`house_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `houses`
--
ALTER TABLE `houses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `people`
--
ALTER TABLE `people`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_person_id_foreign` FOREIGN KEY (`person_id`) REFERENCES `people` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `people`
--
ALTER TABLE `people`
  ADD CONSTRAINT `people_house_id_foreign` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
