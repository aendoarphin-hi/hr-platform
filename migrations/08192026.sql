-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 19, 2026 at 09:48 PM
-- Server version: 8.0.46-0ubuntu0.24.04.3
-- PHP Version: 8.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hayden_ttprod`
--

-- --------------------------------------------------------

--
-- Table structure for table `hrcomms_content`
--

CREATE TABLE `hrcomms_content` (
  `id` int UNSIGNED NOT NULL,
  `type` enum('image','video','pdf','other') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'other',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `filename` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `thumbnail` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `duration` int UNSIGNED DEFAULT NULL COMMENT 'Duration in seconds',
  `uploaded_by` int UNSIGNED NOT NULL COMMENT 'Employee number',
  `status` enum('active','inactive','archived') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hrcomms_content`
--

INSERT INTO `hrcomms_content` (`id`, `type`, `title`, `filename`, `thumbnail`, `duration`, `uploaded_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 'image', 'Volunteer Day Group Shot', 'content/image/volunteer-day-group-shot-001.png', 'content/thumbnails/volunteer-day-group-shot-001-thumb.jpg', 12, 5352, 'active', '2026-06-03 08:00:00', '2026-08-18 11:00:13'),
(2, 'image', 'Process Flow Diagram', 'content/graphic/process-flow-diagram-002.png', 'content/thumbnails/process-flow-diagram-002-thumb.jpg', 15, 5352, 'active', '2025-10-08 12:00:00', '2026-08-18 11:00:13'),
(3, 'image', 'Core Values Graphic', 'content/graphic/core-values-graphic-003.png', 'content/thumbnails/core-values-graphic-003-thumb.jpg', 15, 5352, 'active', '2026-01-28 00:00:00', '2026-08-18 11:00:13'),
(4, 'image', 'New Product Launch Banner', 'content/graphic/new-product-launch-banner-004.png', 'content/thumbnails/new-product-launch-banner-004-thumb.jpg', NULL, 5352, 'inactive', '2026-06-12 06:00:00', '2026-08-18 11:00:13'),
(5, 'pdf', 'Q1 Benefits Summary', 'content/pdf/q1-benefits-summary-005.pdf', 'content/thumbnails/q1-benefits-summary-005-thumb.jpg', NULL, 5352, 'active', '2025-10-11 17:00:00', '2026-08-18 11:00:13'),
(6, 'image', 'Fire Extinguisher Locations', 'content/safety_graphic/fire-extinguisher-locations-006.jpg', 'content/thumbnails/fire-extinguisher-locations-006-thumb.jpg', 8, 5352, 'active', '2026-01-04 00:00:00', '2026-08-18 11:00:13'),
(7, 'pdf', 'Open Enrollment Guide', 'content/pdf/open-enrollment-guide-007.pdf', NULL, 15, 5352, 'active', '2025-12-02 20:00:00', '2026-08-18 11:00:13'),
(8, 'image', 'Hearing Protection Zone Notice', 'content/safety_graphic/hearing-protection-zone-notice-008.png', 'content/thumbnails/hearing-protection-zone-notice-008-thumb.jpg', NULL, 5352, 'active', '2026-04-28 09:00:00', '2026-08-18 11:00:13'),
(9, 'image', 'Recognition Wall Graphic', 'content/graphic/recognition-wall-graphic-009.svg', 'content/thumbnails/recognition-wall-graphic-009-thumb.jpg', 8, 5352, 'active', '2026-02-14 00:00:00', '2026-08-18 11:00:13'),
(10, 'image', 'Plant Floor Overview', 'content/image/plant-floor-overview-010.jpg', 'content/thumbnails/plant-floor-overview-010-thumb.jpg', 8, 5352, 'active', '2026-01-22 12:00:00', '2026-08-18 11:00:13'),
(11, 'other', 'Miscellaneous Notice Template', 'content/other/miscellaneous-notice-template-011.png', 'content/thumbnails/miscellaneous-notice-template-011-thumb.jpg', NULL, 5352, 'active', '2026-03-27 09:00:00', '2026-08-18 11:00:13'),
(12, 'image', 'New Equipment Delivery', 'content/image/new-equipment-delivery-012.jpg', 'content/thumbnails/new-equipment-delivery-012-thumb.jpg', 15, 5352, 'active', '2026-05-08 12:00:00', '2026-08-18 11:00:13'),
(13, 'video', 'CEO New Year Message', 'content/video/ceo-new-year-message-013.mp4', 'content/thumbnails/ceo-new-year-message-013.jpg', 45, 5352, 'active', '2025-10-08 12:00:00', '2026-08-18 11:00:13'),
(14, 'image', 'Hearing Protection Zone Notice (2)', 'content/safety_graphic/hearing-protection-zone-notice-014.png', 'content/thumbnails/hearing-protection-zone-notice-014-thumb.jpg', NULL, 5352, 'active', '2025-11-05 17:00:00', '2026-08-18 11:00:13'),
(15, 'image', 'New Product Launch Banner (2)', 'content/graphic/new-product-launch-banner-015.png', 'content/thumbnails/new-product-launch-banner-015-thumb.jpg', 15, 5352, 'active', '2025-10-27 09:00:00', '2026-08-18 11:00:13'),
(16, 'pdf', 'Q1 Benefits Summary (2)', 'content/pdf/q1-benefits-summary-016.pdf', NULL, 10, 5352, 'active', '2026-03-23 07:00:00', '2026-08-18 11:00:13'),
(17, 'image', 'Quarterly Goals Infographic', 'content/graphic/quarterly-goals-infographic-017.svg', 'content/thumbnails/quarterly-goals-infographic-017-thumb.jpg', NULL, 5352, 'inactive', '2026-06-03 00:00:00', '2026-08-18 11:00:13'),
(18, 'pdf', 'Employee Handbook Excerpt', 'content/pdf/employee-handbook-excerpt-018.pdf', 'content/thumbnails/employee-handbook-excerpt-018-thumb.jpg', 10, 5352, 'inactive', '2026-06-02 09:00:00', '2026-08-18 11:00:13'),
(19, 'image', 'Spill Response Steps', 'content/safety_graphic/spill-response-steps-019.png', 'content/thumbnails/spill-response-steps-019-thumb.jpg', 15, 5352, 'active', '2026-04-14 07:00:00', '2026-08-18 11:00:13'),
(20, 'image', 'Facility Tour Group', 'content/image/facility-tour-group-020.png', 'content/thumbnails/facility-tour-group-020-thumb.jpg', 12, 5352, 'active', '2026-05-04 09:00:00', '2026-08-18 11:00:13'),
(21, 'image', 'Process Flow Diagram (2)', 'content/graphic/process-flow-diagram-021.png', 'content/thumbnails/process-flow-diagram-021-thumb.jpg', NULL, 5352, 'active', '2026-04-22 06:00:00', '2026-08-18 11:00:13'),
(22, 'image', 'Plant Floor Overview (2)', 'content/image/plant-floor-overview-022.jpg', 'content/thumbnails/plant-floor-overview-022-thumb.jpg', NULL, 5352, 'active', '2026-02-22 07:00:00', '2026-08-18 11:00:13'),
(23, 'image', 'Fire Extinguisher Locations (2)', 'content/safety_graphic/fire-extinguisher-locations-023.jpg', 'content/thumbnails/fire-extinguisher-locations-023-thumb.jpg', 8, 5352, 'active', '2025-12-25 07:00:00', '2026-08-18 11:00:13'),
(24, 'image', 'KPI Dashboard Snapshot', 'content/graphic/kpi-dashboard-snapshot-024.png', 'content/thumbnails/kpi-dashboard-snapshot-024-thumb.jpg', 10, 5352, 'inactive', '2025-10-30 00:00:00', '2026-08-18 11:00:13'),
(25, 'image', 'Core Values Graphic (2)', 'content/graphic/core-values-graphic-025.svg', 'content/thumbnails/core-values-graphic-025-thumb.jpg', 15, 5352, 'archived', '2025-12-29 08:00:00', '2026-08-18 11:00:13'),
(26, 'video', 'Benefits Overview Video', 'content/video/benefits-overview-video-026.mp4', 'content/thumbnails/benefits-overview-video-026.jpg', 90, 5352, 'active', '2026-02-03 13:00:00', '2026-08-18 11:00:13'),
(27, 'pdf', 'Holiday Schedule 2026', 'content/pdf/holiday-schedule-2026-027.pdf', 'content/thumbnails/holiday-schedule-2026-027-thumb.jpg', NULL, 5352, 'inactive', '2025-10-31 20:00:00', '2026-08-18 11:00:13'),
(28, 'pdf', 'Facility Map', 'content/pdf/facility-map-028.pdf', NULL, 15, 5352, 'inactive', '2026-01-06 06:00:00', '2026-08-18 11:00:13'),
(29, 'pdf', 'Safety Data Sheet', 'content/pdf/safety-data-sheet-029.pdf', NULL, 10, 5352, 'active', '2025-11-08 06:00:00', '2026-08-18 11:00:13'),
(30, 'image', 'Quarterly Goals Infographic (2)', 'content/graphic/quarterly-goals-infographic-030.svg', 'content/thumbnails/quarterly-goals-infographic-030-thumb.jpg', 8, 5352, 'inactive', '2026-04-18 13:00:00', '2026-08-18 11:00:13'),
(31, 'pdf', 'Q1 Benefits Summary (3)', 'content/pdf/q1-benefits-summary-031.pdf', 'content/thumbnails/q1-benefits-summary-031-thumb.jpg', NULL, 5352, 'active', '2026-02-19 13:00:00', '2026-08-18 11:00:13'),
(32, 'image', 'New Product Launch Banner (3)', 'content/graphic/new-product-launch-banner-032.png', 'content/thumbnails/new-product-launch-banner-032-thumb.jpg', 8, 5352, 'active', '2026-03-17 17:00:00', '2026-08-18 11:00:13'),
(33, 'other', 'Unsorted Upload', 'content/other/unsorted-upload-033.png', NULL, NULL, 5352, 'inactive', '2026-04-09 08:00:00', '2026-08-18 11:00:13'),
(34, 'image', 'Department Directory Graphic', 'content/graphic/department-directory-graphic-034.png', 'content/thumbnails/department-directory-graphic-034-thumb.jpg', 8, 5352, 'inactive', '2026-04-16 09:00:00', '2026-08-18 11:00:13'),
(35, 'image', 'Quarterly Goals Infographic (3)', 'content/graphic/quarterly-goals-infographic-035.png', 'content/thumbnails/quarterly-goals-infographic-035-thumb.jpg', NULL, 5352, 'active', '2026-03-09 13:00:00', '2026-08-18 11:00:13'),
(36, 'image', 'Groundbreaking Ceremony', 'content/image/groundbreaking-ceremony-036.jpg', 'content/thumbnails/groundbreaking-ceremony-036-thumb.jpg', NULL, 5352, 'inactive', '2026-03-04 13:00:00', '2026-08-18 11:00:13'),
(37, 'image', 'Core Values Graphic (3)', 'content/graphic/core-values-graphic-037.png', 'content/thumbnails/core-values-graphic-037-thumb.jpg', 12, 5352, 'active', '2026-01-14 12:00:00', '2026-08-18 11:00:13'),
(38, 'other', 'Legacy Bulletin Scan', 'content/other/legacy-bulletin-scan-038.jpg', NULL, NULL, 5352, 'active', '2026-03-14 20:00:00', '2026-08-18 11:00:13'),
(39, 'image', 'Ribbon Cutting Event', 'content/image/ribbon-cutting-event-039.jpg', 'content/thumbnails/ribbon-cutting-event-039-thumb.jpg', NULL, 5352, 'archived', '2026-02-20 13:00:00', '2026-08-18 11:00:13'),
(40, 'image', 'New Product Launch Banner (4)', 'content/graphic/new-product-launch-banner-040.svg', 'content/thumbnails/new-product-launch-banner-040-thumb.jpg', 8, 5352, 'inactive', '2026-02-21 07:00:00', '2026-08-18 11:00:13'),
(41, 'image', 'Department Directory Graphic (2)', 'content/graphic/department-directory-graphic-041.png', 'content/thumbnails/department-directory-graphic-041-thumb.jpg', NULL, 5352, 'active', '2025-10-18 12:00:00', '2026-08-18 11:00:13'),
(42, 'other', 'Unsorted Upload (2)', 'content/other/unsorted-upload-042.pdf', NULL, 15, 5352, 'archived', '2025-10-21 13:00:00', '2026-08-18 11:00:13'),
(43, 'image', 'New Product Launch Banner (5)', 'content/graphic/new-product-launch-banner-043.png', 'content/thumbnails/new-product-launch-banner-043-thumb.jpg', NULL, 5352, 'inactive', '2025-12-15 06:00:00', '2026-08-18 11:00:13'),
(44, 'image', 'Plant Floor Overview (3)', 'content/image/plant-floor-overview-044.png', 'content/thumbnails/plant-floor-overview-044-thumb.jpg', NULL, 5352, 'active', '2025-12-25 07:00:00', '2026-08-18 11:00:13'),
(45, 'image', 'Quarterly Goals Infographic (4)', 'content/graphic/quarterly-goals-infographic-045.svg', 'content/thumbnails/quarterly-goals-infographic-045-thumb.jpg', NULL, 5352, 'active', '2026-04-25 20:00:00', '2026-08-18 11:00:13'),
(46, 'pdf', 'Emergency Procedures Guide', 'content/pdf/emergency-procedures-guide-046.pdf', 'content/thumbnails/emergency-procedures-guide-046-thumb.jpg', NULL, 5352, 'archived', '2025-11-07 06:00:00', '2026-08-18 11:00:13'),
(47, 'video', 'Safety Training Clip', 'content/video/safety-training-clip-047.mp4', 'content/thumbnails/safety-training-clip-047.jpg', 15, 5352, 'inactive', '2026-06-09 17:00:00', '2026-08-18 11:00:13'),
(48, 'video', 'New Hire Welcome Video', 'content/video/new-hire-welcome-video-048.mp4', 'content/thumbnails/new-hire-welcome-video-048.jpg', 30, 5352, 'active', '2026-03-30 09:00:00', '2026-08-18 11:00:13'),
(49, 'other', 'Unsorted Upload (3)', 'content/other/unsorted-upload-049.png', 'content/thumbnails/unsorted-upload-049-thumb.jpg', NULL, 5352, 'active', '2026-01-04 20:00:00', '2026-08-18 11:00:13'),
(50, 'video', 'Safety Training Clip (2)', 'content/video/safety-training-clip-050.mp4', 'content/thumbnails/safety-training-clip-050.jpg', 30, 5352, 'active', '2025-10-31 07:00:00', '2026-08-18 11:00:13'),
(51, 'image', 'Division Badge - Tulsa', 'content/logo/division-badge---tulsa-051.svg', 'content/thumbnails/division-badge---tulsa-051-thumb.jpg', 12, 5352, 'active', '2025-12-20 00:00:00', '2026-08-18 11:00:13'),
(52, 'pdf', 'New Hire Onboarding Packet', 'content/pdf/new-hire-onboarding-packet-052.pdf', 'content/thumbnails/new-hire-onboarding-packet-052-thumb.jpg', NULL, 5352, 'inactive', '2026-05-05 06:00:00', '2026-08-18 11:00:13'),
(53, 'pdf', 'Safety Data Sheet (2)', 'content/pdf/safety-data-sheet-053.pdf', 'content/thumbnails/safety-data-sheet-053-thumb.jpg', 15, 5352, 'inactive', '2025-12-29 00:00:00', '2026-08-18 11:00:13'),
(54, 'pdf', 'Org Chart', 'content/pdf/org-chart-054.pdf', NULL, 10, 5352, 'active', '2026-02-21 00:00:00', '2026-08-18 11:00:13'),
(55, 'video', 'Facility Time-Lapse', 'content/video/facility-time-lapse-055.mp4', 'content/thumbnails/facility-time-lapse-055.jpg', 30, 5352, 'active', '2026-01-16 17:00:00', '2026-08-18 11:00:13'),
(56, 'pdf', 'Q1 Benefits Summary (4)', 'content/pdf/q1-benefits-summary-056.pdf', NULL, NULL, 5352, 'archived', '2025-10-13 13:00:00', '2026-08-18 11:00:13'),
(57, 'image', 'New Equipment Delivery (2)', 'content/image/new-equipment-delivery-057.png', 'content/thumbnails/new-equipment-delivery-057-thumb.jpg', NULL, 5352, 'active', '2026-02-24 17:00:00', '2026-08-18 11:00:13'),
(58, 'pdf', 'Open Enrollment Guide (2)', 'content/pdf/open-enrollment-guide-058.pdf', 'content/thumbnails/open-enrollment-guide-058-thumb.jpg', NULL, 5352, 'active', '2026-04-04 07:00:00', '2026-08-18 11:00:13'),
(59, 'image', 'Quarterly Goals Infographic (5)', 'content/graphic/quarterly-goals-infographic-059.png', 'content/thumbnails/quarterly-goals-infographic-059-thumb.jpg', 12, 5352, 'active', '2026-01-17 20:00:00', '2026-08-18 11:00:13'),
(60, 'pdf', 'Facility Map (2)', 'content/pdf/facility-map-060.pdf', NULL, NULL, 5352, 'active', '2026-05-26 17:00:00', '2026-08-18 11:00:13'),
(61, 'image', 'Company Picnic 2026', 'content/image/company-picnic-2026-061.png', 'content/thumbnails/company-picnic-2026-061-thumb.jpg', NULL, 5352, 'active', '2026-04-12 08:00:00', '2026-08-18 11:00:13'),
(62, 'image', 'Department Directory Graphic (3)', 'content/graphic/department-directory-graphic-062.png', 'content/thumbnails/department-directory-graphic-062-thumb.jpg', 10, 5352, 'inactive', '2026-01-14 00:00:00', '2026-08-18 11:00:13'),
(63, 'pdf', 'Emergency Procedures Guide (2)', 'content/pdf/emergency-procedures-guide-063.pdf', 'content/thumbnails/emergency-procedures-guide-063-thumb.jpg', NULL, 5352, 'active', '2025-12-21 13:00:00', '2026-08-18 11:00:13'),
(64, 'image', 'Quarterly Goals Infographic (6)', 'content/graphic/quarterly-goals-infographic-064.png', 'content/thumbnails/quarterly-goals-infographic-064-thumb.jpg', 15, 5352, 'archived', '2026-03-01 17:00:00', '2026-08-18 11:00:13'),
(65, 'image', 'Emergency Exit Map', 'content/safety_graphic/emergency-exit-map-065.jpg', 'content/thumbnails/emergency-exit-map-065-thumb.jpg', 12, 5352, 'active', '2025-10-14 12:00:00', '2026-08-18 11:00:13'),
(66, 'image', 'Fire Extinguisher Locations (3)', 'content/safety_graphic/fire-extinguisher-locations-066.jpg', 'content/thumbnails/fire-extinguisher-locations-066-thumb.jpg', NULL, 5352, 'active', '2026-05-18 06:00:00', '2026-08-18 11:00:13'),
(67, 'image', 'Award Ceremony Photo', 'content/image/award-ceremony-photo-067.png', 'content/thumbnails/award-ceremony-photo-067-thumb.jpg', 12, 5352, 'inactive', '2025-12-03 08:00:00', '2026-08-18 11:00:13'),
(68, 'pdf', 'Open Enrollment Guide (3)', 'content/pdf/open-enrollment-guide-068.pdf', NULL, NULL, 5352, 'active', '2026-02-13 06:00:00', '2026-08-18 11:00:13'),
(69, 'other', 'Placeholder Slide', 'content/other/placeholder-slide-069.jpg', NULL, NULL, 5352, 'active', '2026-06-12 17:00:00', '2026-08-18 11:00:13'),
(70, 'image', 'Award Ceremony Photo (2)', 'content/image/award-ceremony-photo-070.png', 'content/thumbnails/award-ceremony-photo-070-thumb.jpg', NULL, 5352, 'active', '2025-12-12 09:00:00', '2026-08-18 11:00:13'),
(71, 'pdf', 'Compliance Policy Update', 'content/pdf/compliance-policy-update-071.pdf', NULL, 15, 5352, 'inactive', '2025-10-11 08:00:00', '2026-08-18 11:00:13'),
(72, 'image', 'New Product Launch Banner (6)', 'content/graphic/new-product-launch-banner-072.svg', 'content/thumbnails/new-product-launch-banner-072-thumb.jpg', 8, 5352, 'active', '2026-04-06 07:00:00', '2026-08-18 11:00:13'),
(73, 'image', 'New Product Launch Banner (7)', 'content/graphic/new-product-launch-banner-073.svg', 'content/thumbnails/new-product-launch-banner-073-thumb.jpg', 12, 5352, 'inactive', '2026-01-23 17:00:00', '2026-08-18 11:00:13'),
(74, 'pdf', 'Q1 Benefits Summary (5)', 'content/pdf/q1-benefits-summary-074.pdf', 'content/thumbnails/q1-benefits-summary-074-thumb.jpg', 15, 5352, 'archived', '2025-11-14 12:00:00', '2026-08-18 11:00:13'),
(75, 'image', 'New Equipment Delivery (3)', 'content/image/new-equipment-delivery-075.jpg', 'content/thumbnails/new-equipment-delivery-075-thumb.jpg', 15, 5352, 'active', '2026-03-17 12:00:00', '2026-08-18 11:00:13'),
(76, 'image', 'Team Photo Q1', 'content/image/team-photo-q1-076.png', 'content/thumbnails/team-photo-q1-076-thumb.jpg', NULL, 5352, 'active', '2025-12-17 00:00:00', '2026-08-18 11:00:13'),
(77, 'image', 'New Equipment Delivery (4)', 'content/image/new-equipment-delivery-077.jpg', 'content/thumbnails/new-equipment-delivery-077-thumb.jpg', 10, 5352, 'active', '2025-12-25 20:00:00', '2026-08-18 11:00:13'),
(78, 'image', 'Volunteer Day Group Shot (2)', 'content/image/volunteer-day-group-shot-078.jpg', 'content/thumbnails/volunteer-day-group-shot-078-thumb.jpg', 15, 5352, 'active', '2026-01-13 08:00:00', '2026-08-18 11:00:13'),
(79, 'image', 'Groundbreaking Ceremony (2)', 'content/image/groundbreaking-ceremony-079.jpg', 'content/thumbnails/groundbreaking-ceremony-079-thumb.jpg', NULL, 5352, 'archived', '2025-11-19 08:00:00', '2026-08-18 11:00:13'),
(80, 'image', 'Quarterly Goals Infographic (7)', 'content/graphic/quarterly-goals-infographic-080.svg', 'content/thumbnails/quarterly-goals-infographic-080-thumb.jpg', NULL, 5352, 'active', '2026-04-02 13:00:00', '2026-08-18 11:00:13');

-- --------------------------------------------------------

--
-- Table structure for table `hrcomms_content_approvals`
--

CREATE TABLE `hrcomms_content_approvals` (
  `id` int UNSIGNED NOT NULL,
  `content_id` int UNSIGNED NOT NULL,
  `approver_id` int UNSIGNED NOT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `comment` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `decided_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hrcomms_content_approvals`
--

INSERT INTO `hrcomms_content_approvals` (`id`, `content_id`, `approver_id`, `status`, `comment`, `created_at`, `updated_at`, `decided_at`) VALUES
(1, 1, 1001, 'approved', 'Approved for use.', '2026-06-03 09:00:00', '2026-06-03 09:15:00', '2026-06-03 09:15:00'),
(2, 2, 1001, 'approved', 'Looks good.', '2025-10-08 13:00:00', '2025-10-08 13:10:00', '2025-10-08 13:10:00'),
(3, 3, 1002, 'approved', 'Approved.', '2026-01-28 08:00:00', '2026-01-28 08:20:00', '2026-01-28 08:20:00'),
(4, 5, 1002, 'approved', 'Benefits information approved.', '2025-10-12 08:00:00', '2025-10-12 08:30:00', '2025-10-12 08:30:00'),
(5, 6, 1001, 'approved', 'Safety graphic approved.', '2026-01-04 08:30:00', '2026-01-04 08:45:00', '2026-01-04 08:45:00'),
(6, 4, 1001, 'pending', NULL, '2026-06-12 07:00:00', '2026-06-12 07:00:00', NULL),
(7, 17, 1002, 'pending', NULL, '2026-06-03 01:00:00', '2026-06-03 01:00:00', NULL),
(8, 18, 1002, 'pending', NULL, '2026-06-02 10:00:00', '2026-06-02 10:00:00', NULL),
(9, 24, 1001, 'pending', NULL, '2025-10-30 01:00:00', '2025-10-30 01:00:00', NULL),
(10, 27, 1002, 'rejected', 'Schedule needs to be updated before publication.', '2025-10-31 21:00:00', '2025-11-01 08:00:00', '2025-11-01 08:00:00'),
(11, 30, 1001, 'rejected', 'Please revise the graphic.', '2026-04-18 14:00:00', '2026-04-18 15:00:00', '2026-04-18 15:00:00'),
(12, 25, 1002, 'approved', 'Previously approved; subsequently archived.', '2025-12-29 09:00:00', '2025-12-29 09:15:00', '2025-12-29 09:15:00'),
(13, 39, 1001, 'approved', 'Previously approved; subsequently archived.', '2026-02-20 14:00:00', '2026-02-20 14:15:00', '2026-02-20 14:15:00'),
(14, 46, 1002, 'approved', 'Previously approved; subsequently archived.', '2025-11-07 07:00:00', '2025-11-07 07:20:00', '2025-11-07 07:20:00');

-- --------------------------------------------------------

--
-- Table structure for table `hrcomms_displays`
--

CREATE TABLE `hrcomms_displays` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` enum('Tulsa','Owasso','Claremore') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('online','offline','disabled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'online',
  `resolution` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `playlist_id` int UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hrcomms_displays`
--

INSERT INTO `hrcomms_displays` (`id`, `name`, `location`, `status`, `resolution`, `playlist_id`, `created_at`, `updated_at`) VALUES
(26, 'Packaging Area', 'Owasso', 'online', '1920x1080', 3, '2026-07-31 15:53:30', '2026-08-02 11:01:11'),
(27, 'Tool Crib TV', 'Tulsa', 'disabled', '1366x768', NULL, '2026-07-31 15:53:30', '2026-07-31 16:13:42'),
(28, 'South Hallway', 'Claremore', 'online', '1920x1080', 1, '2026-07-31 15:53:30', '2026-07-31 16:17:03'),
(29, 'North Hallway', 'Owasso', 'online', '1920x1080', 1, '2026-07-31 15:53:30', '2026-07-31 16:17:03'),
(30, 'Visitor Center', 'Owasso', 'disabled', '1920x1080', 2, '2026-07-31 15:53:30', '2026-08-02 11:01:11'),
(31, 'Front Office Lobby', 'Owasso', 'disabled', '3840x2160', 10, '2026-02-18 07:00:00', '2026-03-06 07:00:00'),
(32, 'Shipping Dock A', 'Owasso', 'disabled', '1920x1080', 3, '2026-01-24 20:00:00', '2026-02-13 20:00:00'),
(33, 'Shipping Dock B', 'Tulsa', 'disabled', '3840x2160', 10, '2026-02-10 00:00:00', '2026-02-26 00:00:00'),
(34, 'Break Room East', 'Tulsa', 'online', NULL, 10, '2026-01-08 17:00:00', '2026-01-18 17:00:00'),
(35, 'Break Room West', 'Owasso', 'disabled', '1920x1080', 8, '2026-01-02 06:00:00', '2026-01-16 06:00:00'),
(36, 'Main Cafeteria', 'Claremore', 'online', '1920x1080', 6, '2026-02-28 20:00:00', '2026-03-09 20:00:00'),
(37, 'Assembly Line 1', 'Tulsa', 'online', '1920x1080', 5, '2026-04-09 06:00:00', '2026-04-09 06:00:00'),
(38, 'Assembly Line 2', 'Claremore', 'online', '1920x1080', 12, '2026-04-12 13:00:00', '2026-04-14 13:00:00'),
(39, 'Assembly Line 3', 'Claremore', 'online', '1366x768', 5, '2026-03-27 00:00:00', '2026-04-09 00:00:00'),
(40, 'Quality Control Lab', 'Tulsa', 'online', '1920x1080', NULL, '2026-04-30 17:00:00', '2026-05-05 17:00:00'),
(41, 'Maintenance Shop', 'Claremore', 'disabled', '1920x1080', 13, '2026-02-03 13:00:00', '2026-02-23 13:00:00'),
(42, 'IT Help Desk', 'Owasso', 'online', '1920x1080', NULL, '2026-03-19 00:00:00', '2026-03-25 00:00:00'),
(43, 'Training Room A', 'Tulsa', 'offline', '1920x1080', NULL, '2026-02-07 08:00:00', '2026-02-21 08:00:00'),
(44, 'Training Room B', 'Owasso', 'online', '1366x768', 7, '2026-01-19 06:00:00', '2026-01-21 06:00:00'),
(45, 'Executive Conference Room', 'Tulsa', 'disabled', '1920x1080', 6, '2026-04-27 07:00:00', '2026-05-15 07:00:00'),
(46, 'HR Waiting Area', 'Owasso', 'disabled', '3840x2160', 3, '2026-03-21 08:00:00', '2026-04-09 08:00:00'),
(47, 'Security Checkpoint', 'Tulsa', 'online', '1920x1080', 7, '2026-05-04 06:00:00', '2026-05-17 06:00:00'),
(48, 'Employee Entrance', 'Tulsa', 'online', '1366x768', 12, '2026-04-11 09:00:00', '2026-04-24 09:00:00'),
(49, 'Loading Dock Office', 'Claremore', 'offline', '1920x1080', 2, '2026-02-02 08:00:00', '2026-02-17 08:00:00'),
(50, 'Second Floor Landing', 'Claremore', 'disabled', '1366x768', 4, '2026-01-05 06:00:00', '2026-01-13 06:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `hrcomms_display_content_settings`
--

CREATE TABLE `hrcomms_display_content_settings` (
  `id` int UNSIGNED NOT NULL,
  `display_id` int UNSIGNED NOT NULL,
  `category` enum('employee','company','announcement') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subtype` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hrcomms_display_content_settings`
--

INSERT INTO `hrcomms_display_content_settings` (`id`, `display_id`, `category`, `subtype`, `enabled`, `created_at`, `updated_at`) VALUES
(26, 26, 'employee', 'birthday', 1, '2026-05-02 09:00:00', '2026-05-18 09:00:00'),
(27, 26, 'employee', 'anniversary', 1, '2026-03-05 20:00:00', '2026-03-05 20:00:00'),
(28, 26, 'employee', 'promotion', 0, '2026-01-23 07:00:00', '2026-02-04 07:00:00'),
(29, 26, 'employee', 'new hire', 1, '2026-04-11 00:00:00', '2026-04-20 00:00:00'),
(30, 26, 'company', 'general', 1, '2026-03-01 06:00:00', '2026-03-19 06:00:00'),
(31, 26, 'company', 'holiday', 1, '2026-02-09 13:00:00', '2026-02-19 13:00:00'),
(32, 26, 'company', 'training', 1, '2026-05-07 07:00:00', '2026-05-16 07:00:00'),
(33, 26, 'company', 'meeting', 1, '2026-02-07 00:00:00', '2026-02-23 00:00:00'),
(34, 26, 'announcement', 'general', 1, '2026-05-10 07:00:00', '2026-05-26 07:00:00'),
(35, 26, 'announcement', 'urgent', 1, '2026-05-26 00:00:00', '2026-06-13 00:00:00'),
(36, 26, 'announcement', 'maintenance', 1, '2026-02-28 06:00:00', '2026-02-28 06:00:00'),
(37, 26, 'announcement', 'production', 0, '2026-04-03 06:00:00', '2026-04-15 06:00:00'),
(38, 26, 'announcement', 'weather', 1, '2026-05-23 00:00:00', '2026-06-12 00:00:00'),
(39, 26, 'announcement', 'safety', 0, '2026-05-17 08:00:00', '2026-06-01 08:00:00'),
(40, 27, 'employee', 'birthday', 1, '2026-04-27 06:00:00', '2026-05-13 06:00:00'),
(41, 27, 'employee', 'anniversary', 1, '2026-01-24 20:00:00', '2026-01-26 20:00:00'),
(42, 27, 'employee', 'promotion', 1, '2026-05-02 09:00:00', '2026-05-04 09:00:00'),
(43, 27, 'employee', 'new hire', 1, '2026-03-02 08:00:00', '2026-03-09 08:00:00'),
(44, 27, 'company', 'general', 1, '2026-04-28 17:00:00', '2026-05-10 17:00:00'),
(45, 27, 'company', 'holiday', 0, '2026-03-15 00:00:00', '2026-04-03 00:00:00'),
(46, 27, 'company', 'training', 1, '2026-02-20 06:00:00', '2026-03-11 06:00:00'),
(47, 27, 'company', 'meeting', 1, '2026-03-07 09:00:00', '2026-03-26 09:00:00'),
(48, 27, 'announcement', 'general', 1, '2026-01-04 17:00:00', '2026-01-05 17:00:00'),
(49, 27, 'announcement', 'urgent', 1, '2026-01-26 08:00:00', '2026-02-10 08:00:00'),
(50, 27, 'announcement', 'maintenance', 1, '2026-05-13 09:00:00', '2026-05-27 09:00:00'),
(51, 27, 'announcement', 'production', 1, '2026-01-31 20:00:00', '2026-02-06 20:00:00'),
(52, 27, 'announcement', 'weather', 1, '2026-01-22 17:00:00', '2026-01-22 17:00:00'),
(53, 27, 'announcement', 'safety', 1, '2026-01-20 20:00:00', '2026-02-03 20:00:00'),
(54, 28, 'employee', 'birthday', 1, '2026-04-10 08:00:00', '2026-04-16 08:00:00'),
(55, 28, 'employee', 'anniversary', 0, '2026-01-24 07:00:00', '2026-02-09 07:00:00'),
(56, 28, 'employee', 'promotion', 1, '2026-04-03 07:00:00', '2026-04-22 07:00:00'),
(57, 28, 'employee', 'new hire', 1, '2026-05-11 09:00:00', '2026-05-14 09:00:00'),
(58, 28, 'company', 'general', 1, '2026-03-01 17:00:00', '2026-03-16 17:00:00'),
(59, 28, 'company', 'holiday', 1, '2026-02-10 00:00:00', '2026-02-25 00:00:00'),
(60, 28, 'company', 'training', 1, '2026-04-14 09:00:00', '2026-04-18 09:00:00'),
(61, 28, 'company', 'meeting', 1, '2026-04-07 12:00:00', '2026-04-10 12:00:00'),
(62, 28, 'announcement', 'general', 1, '2026-01-01 12:00:00', '2026-01-11 12:00:00'),
(63, 28, 'announcement', 'urgent', 1, '2026-01-31 08:00:00', '2026-01-31 08:00:00'),
(64, 28, 'announcement', 'maintenance', 1, '2026-03-16 09:00:00', '2026-03-27 09:00:00'),
(65, 28, 'announcement', 'production', 0, '2026-04-10 06:00:00', '2026-04-21 06:00:00'),
(66, 28, 'announcement', 'weather', 1, '2026-03-12 00:00:00', '2026-03-20 00:00:00'),
(67, 28, 'announcement', 'safety', 0, '2026-03-15 07:00:00', '2026-03-22 07:00:00'),
(68, 29, 'employee', 'birthday', 1, '2026-04-22 20:00:00', '2026-05-02 20:00:00'),
(69, 29, 'employee', 'anniversary', 1, '2026-04-06 13:00:00', '2026-04-06 13:00:00'),
(70, 29, 'employee', 'promotion', 1, '2026-04-13 20:00:00', '2026-04-30 20:00:00'),
(71, 29, 'employee', 'new hire', 1, '2026-01-21 00:00:00', '2026-02-03 00:00:00'),
(72, 29, 'company', 'general', 1, '2026-02-05 09:00:00', '2026-02-20 09:00:00'),
(73, 29, 'company', 'holiday', 0, '2026-05-21 07:00:00', '2026-05-26 07:00:00'),
(74, 29, 'company', 'training', 1, '2026-03-29 09:00:00', '2026-04-07 09:00:00'),
(75, 29, 'company', 'meeting', 1, '2026-03-08 13:00:00', '2026-03-28 13:00:00'),
(76, 29, 'announcement', 'general', 1, '2026-05-04 20:00:00', '2026-05-16 20:00:00'),
(77, 29, 'announcement', 'urgent', 0, '2026-02-11 06:00:00', '2026-02-17 06:00:00'),
(78, 29, 'announcement', 'maintenance', 1, '2026-05-08 20:00:00', '2026-05-15 20:00:00'),
(79, 29, 'announcement', 'production', 1, '2026-03-27 17:00:00', '2026-04-09 17:00:00'),
(80, 29, 'announcement', 'weather', 1, '2026-02-19 08:00:00', '2026-02-21 08:00:00'),
(81, 29, 'announcement', 'safety', 1, '2026-05-23 06:00:00', '2026-06-02 06:00:00'),
(82, 30, 'employee', 'birthday', 1, '2026-03-08 08:00:00', '2026-03-08 08:00:00'),
(83, 30, 'employee', 'anniversary', 1, '2026-04-16 13:00:00', '2026-04-29 13:00:00'),
(84, 30, 'employee', 'promotion', 1, '2026-02-23 13:00:00', '2026-03-03 13:00:00'),
(85, 30, 'employee', 'new hire', 1, '2026-01-16 17:00:00', '2026-01-24 17:00:00'),
(86, 30, 'company', 'general', 1, '2026-04-03 07:00:00', '2026-04-19 07:00:00'),
(87, 30, 'company', 'holiday', 1, '2026-02-25 06:00:00', '2026-03-05 06:00:00'),
(88, 30, 'company', 'training', 1, '2026-04-09 13:00:00', '2026-04-29 13:00:00'),
(89, 30, 'company', 'meeting', 1, '2026-03-21 00:00:00', '2026-03-25 00:00:00'),
(90, 30, 'announcement', 'general', 0, '2026-05-02 17:00:00', '2026-05-02 17:00:00'),
(91, 30, 'announcement', 'urgent', 0, '2026-05-16 17:00:00', '2026-05-30 17:00:00'),
(92, 30, 'announcement', 'maintenance', 1, '2026-01-28 08:00:00', '2026-02-01 08:00:00'),
(93, 30, 'announcement', 'production', 1, '2026-01-28 17:00:00', '2026-01-30 17:00:00'),
(94, 30, 'announcement', 'weather', 1, '2026-01-11 00:00:00', '2026-01-15 00:00:00'),
(95, 30, 'announcement', 'safety', 1, '2026-01-10 09:00:00', '2026-01-14 09:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `hrcomms_events`
--

CREATE TABLE `hrcomms_events` (
  `id` int UNSIGNED NOT NULL,
  `category` enum('employee','company','announcement') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subtype` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'employee: birthday, anniversary, promotion, new hire | company: general, holiday, training, meeting | announcement: general, urgent, maintenance, production, weather, safety',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `location` enum('Tulsa','Claremore','Owasso','Mingo','Amah','Robinson') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employee_id` int UNSIGNED DEFAULT NULL COMMENT 'Joins employee table',
  `content_id` int UNSIGNED DEFAULT NULL COMMENT 'Joins hrcomms_content table',
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `status` enum('draft','active','expired','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `priority` int NOT NULL DEFAULT '0' COMMENT 'Low (0) to high (255) priority in the display queue',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Source of truth for adding content to each display';

--
-- Dumping data for table `hrcomms_events`
--

INSERT INTO `hrcomms_events` (`id`, `category`, `subtype`, `title`, `description`, `location`, `employee_id`, `content_id`, `start`, `end`, `status`, `priority`, `created_at`, `updated_at`) VALUES
(121, 'company', 'general', 'Company Update: Network Upgrade Window', 'See HR for more details or reach out to your manager with questions.', 'Robinson', 109, 12, '2026-04-22 07:00:00', '2026-04-22 08:00:00', 'active', 214, '2026-04-15 07:00:00', '2026-08-19 16:47:46'),
(122, 'company', 'general', 'Company Update: HVAC System Maintenance', 'Contact facilities if you have any concerns about this notice.', 'Amah', 98, 45, '2026-11-06 08:00:00', '2026-11-06 09:00:00', 'expired', 63, '2026-10-25 08:00:00', '2026-08-19 16:48:09'),
(123, 'company', 'training', 'Upcoming Training: Building A Elevator Outage', 'More information will be shared as it becomes available.', 'Mingo', NULL, NULL, '2026-07-14 08:00:00', '2026-07-21 08:00:00', 'active', 186, '2026-07-09 08:00:00', '2026-08-19 16:47:58'),
(124, 'company', 'training', 'Upcoming Training: Quarterly Town Hall', 'More information will be shared as it becomes available.', 'Amah', NULL, NULL, '2026-12-19 12:00:00', '2026-12-19 20:00:00', 'expired', 28, '2026-12-12 12:00:00', '2026-08-19 16:48:09'),
(125, 'announcement', 'production', 'Production Notice: Loading Dock Closure', 'All employees are encouraged to attend.', 'Amah', NULL, NULL, '2026-08-23 07:00:00', '2026-08-24 07:00:00', 'active', 134, '2026-08-05 07:00:00', '2026-08-19 16:48:09'),
(126, 'announcement', 'production', 'Production Notice: Server Room Cooling Repair', NULL, NULL, 29, 21, '2026-12-15 09:00:00', '2026-12-15 11:00:00', 'active', 239, '2026-11-29 09:00:00', '2026-12-07 09:00:00'),
(127, 'announcement', 'general', 'Announcement: HVAC System Maintenance', 'See HR for more details or reach out to your manager with questions.', 'Mingo', NULL, NULL, '2026-05-15 12:00:00', '2026-05-15 16:00:00', 'active', 54, '2026-04-25 12:00:00', '2026-08-19 16:47:58'),
(128, 'announcement', 'weather', 'Weather Advisory: Ice Storm Closure Policy', 'This event is open to all staff at the listed location.', 'Robinson', NULL, NULL, '2026-09-08 00:00:00', '2026-09-08 02:00:00', 'cancelled', 157, '2026-09-01 00:00:00', '2026-08-19 16:47:46'),
(129, 'employee', 'birthday', 'Happy Birthday Jennifer White!', NULL, 'Mingo', 169, NULL, '2026-10-09 07:00:00', '2026-10-10 07:00:00', 'active', 216, '2026-10-03 07:00:00', '2026-08-19 16:47:58'),
(130, 'announcement', 'safety', 'Safety Notice: Forklift Certification Class', 'All employees are encouraged to attend.', 'Robinson', NULL, 9, '2026-06-23 00:00:00', '2026-06-23 08:00:00', 'active', 3, '2026-06-21 00:00:00', '2026-08-19 16:47:46'),
(131, 'company', 'holiday', 'Holiday Notice: HVAC System Maintenance', 'See HR for more details or reach out to your manager with questions.', 'Amah', NULL, 17, '2026-10-20 12:00:00', '2026-10-27 12:00:00', 'active', 242, '2026-10-07 12:00:00', '2026-08-19 16:48:09'),
(132, 'employee', 'new hire', 'Welcome to the Team, Daniel Wilson!', 'Please join us in celebrating this milestone.', 'Robinson', 26, 44, '2026-02-25 07:00:00', '2026-02-25 15:00:00', 'active', 229, '2026-02-21 07:00:00', '2026-08-19 16:47:46'),
(133, 'employee', 'new hire', 'Welcome to the Team, Jessica Ramirez!', NULL, NULL, 167, NULL, '2026-01-08 00:00:00', '2026-01-08 08:00:00', 'active', 248, '2025-12-24 00:00:00', '2025-12-30 00:00:00'),
(134, 'announcement', 'general', 'Announcement: Forklift Certification Class', 'Contact facilities if you have any concerns about this notice.', 'Amah', NULL, NULL, '2026-10-12 13:00:00', '2026-10-19 13:00:00', 'active', 151, '2026-10-06 13:00:00', '2026-08-19 16:48:09'),
(135, 'company', 'general', 'Company Update: Loading Dock Closure', NULL, 'Robinson', 246, NULL, '2026-04-06 00:00:00', '2026-04-06 02:00:00', 'expired', 120, '2026-03-25 00:00:00', '2026-08-19 16:47:46'),
(136, 'announcement', 'weather', 'Weather Advisory: Employee Wellness Fair', 'See HR for more details or reach out to your manager with questions.', 'Robinson', NULL, 34, '2026-04-15 13:00:00', '2026-04-17 13:00:00', 'active', 202, '2026-04-11 13:00:00', '2026-08-19 16:47:46'),
(137, 'company', 'general', 'Company Update: New Benefits Enrollment', NULL, 'Amah', 90, NULL, '2026-05-06 08:00:00', '2026-05-07 08:00:00', 'active', 154, '2026-04-17 08:00:00', '2026-08-19 16:48:09'),
(138, 'employee', 'promotion', 'Congratulations to Michael Lewis on Your Promotion!', 'See HR for more details or reach out to your manager with questions.', 'Robinson', 142, 37, '2026-11-06 07:00:00', '2026-11-08 07:00:00', 'active', 135, '2026-10-21 07:00:00', '2026-08-19 16:47:46'),
(139, 'employee', 'birthday', 'Happy Birthday Jennifer Lee!', 'Please join us in celebrating this milestone.', NULL, 198, 34, '2026-03-24 13:00:00', '2026-03-31 13:00:00', 'active', 218, '2026-03-07 13:00:00', '2026-03-07 13:00:00'),
(140, 'employee', 'anniversary', 'Paul Johnson\'s 10-Year Work Anniversary', NULL, NULL, 33, 47, '2026-01-21 08:00:00', '2026-01-21 16:00:00', 'expired', 52, '2026-01-10 08:00:00', '2026-01-18 08:00:00'),
(141, 'announcement', 'production', 'Production Notice: Line 3 Equipment Check', 'This event is open to all staff at the listed location.', 'Mingo', NULL, 43, '2026-07-30 17:00:00', '2026-07-31 01:00:00', 'active', 55, '2026-07-18 17:00:00', '2026-08-19 16:47:58'),
(142, 'announcement', 'urgent', 'URGENT: Ice Storm Closure Policy', 'Contact facilities if you have any concerns about this notice.', 'Mingo', NULL, NULL, '2026-07-24 08:00:00', '2026-07-25 08:00:00', 'expired', 142, '2026-07-13 08:00:00', '2026-08-19 16:47:58'),
(143, 'company', 'training', 'Upcoming Training: Fire Drill Scheduled', 'Reminder: this affects normal operations for the duration listed.', 'Amah', 153, NULL, '2026-06-10 09:00:00', '2026-06-10 11:00:00', 'active', 97, '2026-06-02 09:00:00', '2026-08-19 16:48:09'),
(144, 'announcement', 'general', 'Announcement: Ice Storm Closure Policy', 'Details subject to change; check back for updates.', NULL, NULL, 41, '2026-12-06 17:00:00', '2026-12-06 19:00:00', 'expired', 153, '2026-11-20 17:00:00', '2026-11-29 17:00:00'),
(145, 'announcement', 'maintenance', 'Scheduled Maintenance: Quarterly Town Hall', 'This event is open to all staff at the listed location.', 'Robinson', NULL, NULL, '2026-03-31 12:00:00', '2026-04-01 12:00:00', 'active', 0, '2026-03-22 12:00:00', '2026-08-19 16:47:46'),
(146, 'employee', 'promotion', 'Congratulations to Sandra Anderson on Your Promotion!', NULL, 'Robinson', 44, NULL, '2026-05-26 12:00:00', '2026-05-28 12:00:00', 'draft', 120, '2026-05-17 12:00:00', '2026-08-19 16:47:46'),
(147, 'announcement', 'urgent', 'URGENT: Software Rollout: New Timeclock', 'Reminder: this affects normal operations for the duration listed.', 'Mingo', NULL, NULL, '2026-10-22 07:00:00', '2026-10-25 07:00:00', 'active', 124, '2026-10-18 07:00:00', '2026-08-19 16:47:58'),
(148, 'announcement', 'general', 'Announcement: Server Room Cooling Repair', NULL, NULL, NULL, NULL, '2026-08-22 07:00:00', '2026-08-29 07:00:00', 'expired', 162, '2026-08-08 07:00:00', '2026-08-17 07:00:00'),
(149, 'announcement', 'weather', 'Weather Advisory: Fire Drill Scheduled', NULL, 'Mingo', NULL, 67, '2026-09-06 13:00:00', '2026-09-06 21:00:00', 'active', 39, '2026-08-28 13:00:00', '2026-08-19 16:47:58'),
(150, 'employee', 'promotion', 'Congratulations to Paul Williams on Your Promotion!', 'More information will be shared as it becomes available.', 'Mingo', 181, 54, '2026-07-28 08:00:00', '2026-08-04 08:00:00', 'active', 105, '2026-07-15 08:00:00', '2026-08-19 16:47:58'),
(151, 'announcement', 'weather', 'Weather Advisory: Software Rollout: New Timeclock', 'Please join us in celebrating this milestone.', 'Amah', NULL, NULL, '2026-08-03 12:00:00', '2026-08-03 20:00:00', 'active', 139, '2026-07-21 12:00:00', '2026-08-19 16:48:09'),
(152, 'employee', 'promotion', 'Congratulations to Betty White on Your Promotion!', 'This event is open to all staff at the listed location.', 'Robinson', 7, NULL, '2026-10-31 12:00:00', '2026-10-31 13:00:00', 'draft', 219, '2026-10-27 12:00:00', '2026-08-19 16:47:46'),
(153, 'employee', 'promotion', 'Congratulations to Matthew Hernandez on Your Promotion!', 'All employees are encouraged to attend.', 'Amah', 72, NULL, '2026-08-04 08:00:00', '2026-08-04 10:00:00', 'active', 26, '2026-07-24 08:00:00', '2026-08-19 16:48:09'),
(154, 'announcement', 'safety', 'Safety Notice: Line 3 Equipment Check', 'More information will be shared as it becomes available.', 'Robinson', 33, NULL, '2026-02-28 12:00:00', '2026-02-28 20:00:00', 'active', 131, '2026-02-17 12:00:00', '2026-08-19 16:47:46'),
(155, 'company', 'general', 'Company Update: Loading Dock Closure', 'Please join us in celebrating this milestone.', 'Robinson', NULL, NULL, '2026-07-23 13:00:00', '2026-07-23 21:00:00', 'draft', 124, '2026-07-20 13:00:00', '2026-08-19 16:47:46'),
(156, 'announcement', 'weather', 'Weather Advisory: Ice Storm Closure Policy', NULL, 'Amah', 166, 54, '2026-09-08 00:00:00', '2026-09-11 00:00:00', 'cancelled', 235, '2026-09-04 00:00:00', '2026-08-19 16:48:09'),
(157, 'employee', 'promotion', 'Congratulations to Michelle Sanchez on Your Promotion!', 'Details subject to change; check back for updates.', 'Robinson', 69, 32, '2026-02-14 08:00:00', '2026-02-21 08:00:00', 'active', 237, '2026-01-27 08:00:00', '2026-08-19 16:47:46'),
(158, 'employee', 'new hire', 'Welcome to the Team, Christopher Garcia!', 'All employees are encouraged to attend.', 'Amah', 72, NULL, '2026-12-26 08:00:00', '2026-12-26 09:00:00', 'active', 97, '2026-12-24 08:00:00', '2026-08-19 16:48:09'),
(159, 'announcement', 'production', 'Production Notice: Software Rollout: New Timeclock', NULL, 'Mingo', 57, NULL, '2026-05-05 08:00:00', '2026-05-07 08:00:00', 'active', 176, '2026-04-22 08:00:00', '2026-08-19 16:47:58'),
(160, 'company', 'training', 'Upcoming Training: Cafeteria Menu Changes', 'More information will be shared as it becomes available.', NULL, 31, NULL, '2026-12-20 07:00:00', '2026-12-20 15:00:00', 'active', 247, '2026-12-12 07:00:00', '2026-12-20 07:00:00'),
(161, 'company', 'general', 'Company Update: Ice Storm Closure Policy', 'This event is open to all staff at the listed location.', 'Robinson', NULL, 7, '2026-10-11 08:00:00', '2026-10-11 12:00:00', 'active', 251, '2026-10-08 08:00:00', '2026-08-19 16:47:46'),
(162, 'company', 'meeting', 'All-Hands Meeting: Fire Drill Scheduled', 'Please join us in celebrating this milestone.', 'Amah', 17, NULL, '2026-02-07 12:00:00', '2026-02-07 13:00:00', 'active', 155, '2026-02-05 12:00:00', '2026-08-19 16:48:09'),
(163, 'employee', 'new hire', 'Welcome to the Team, Joshua Martin!', 'Details subject to change; check back for updates.', 'Amah', 77, NULL, '2026-08-08 08:00:00', '2026-08-08 09:00:00', 'active', 50, '2026-08-02 08:00:00', '2026-08-19 16:48:09'),
(164, 'employee', 'birthday', 'Happy Birthday William Davis!', 'See HR for more details or reach out to your manager with questions.', 'Amah', 116, NULL, '2026-08-29 08:00:00', '2026-08-29 09:00:00', 'active', 144, '2026-08-15 08:00:00', '2026-08-19 16:48:09'),
(165, 'announcement', 'maintenance', 'Scheduled Maintenance: Annual Compliance Training', 'See HR for more details or reach out to your manager with questions.', 'Robinson', 69, NULL, '2026-02-06 00:00:00', '2026-02-06 04:00:00', 'expired', 147, '2026-01-23 00:00:00', '2026-08-19 16:47:46'),
(166, 'company', 'training', 'Upcoming Training: Warehouse Safety Walkthrough', 'See HR for more details or reach out to your manager with questions.', 'Amah', NULL, NULL, '2026-01-14 00:00:00', '2026-01-14 08:00:00', 'cancelled', 10, '2026-01-06 00:00:00', '2026-08-19 16:48:09'),
(167, 'announcement', 'urgent', 'URGENT: Cafeteria Menu Changes', 'This event is open to all staff at the listed location.', 'Amah', NULL, NULL, '2026-02-16 09:00:00', '2026-02-18 09:00:00', 'active', 164, '2026-02-13 09:00:00', '2026-08-19 16:48:09'),
(168, 'employee', 'new hire', 'Welcome to the Team, Charles Perez!', 'Please join us in celebrating this milestone.', 'Amah', 65, 52, '2026-09-21 17:00:00', '2026-09-21 18:00:00', 'expired', 236, '2026-09-08 17:00:00', '2026-08-19 16:48:09'),
(169, 'employee', 'promotion', 'Congratulations to Michelle Harris on Your Promotion!', 'Please join us in celebrating this milestone.', 'Robinson', 34, NULL, '2026-08-13 13:00:00', '2026-08-20 13:00:00', 'active', 122, '2026-08-08 13:00:00', '2026-08-19 16:47:46'),
(170, 'company', 'meeting', 'All-Hands Meeting: Warehouse Safety Walkthrough', 'See HR for more details or reach out to your manager with questions.', 'Mingo', NULL, NULL, '2026-09-18 13:00:00', '2026-09-19 13:00:00', 'active', 247, '2026-09-03 13:00:00', '2026-08-19 16:47:58'),
(171, 'company', 'holiday', 'Holiday Notice: New Benefits Enrollment', 'Contact facilities if you have any concerns about this notice.', 'Amah', NULL, NULL, '2026-05-17 17:00:00', '2026-05-17 18:00:00', 'active', 152, '2026-04-29 17:00:00', '2026-08-19 16:48:09'),
(172, 'announcement', 'production', 'Production Notice: Ice Storm Closure Policy', 'All employees are encouraged to attend.', 'Robinson', NULL, NULL, '2026-04-07 13:00:00', '2026-04-07 21:00:00', 'active', 119, '2026-03-25 13:00:00', '2026-08-19 16:47:46'),
(173, 'employee', 'new hire', 'Welcome to the Team, Matthew Gonzalez!', 'Please join us in celebrating this milestone.', NULL, 248, NULL, '2026-02-21 17:00:00', '2026-02-28 17:00:00', 'draft', 233, '2026-02-21 17:00:00', '2026-02-21 17:00:00'),
(174, 'company', 'holiday', 'Holiday Notice: HVAC System Maintenance', 'Reminder: this affects normal operations for the duration listed.', 'Robinson', 85, NULL, '2026-10-01 09:00:00', '2026-10-03 09:00:00', 'active', 249, '2026-09-14 09:00:00', '2026-08-19 16:47:46'),
(175, 'company', 'holiday', 'Holiday Notice: Annual Compliance Training', 'See HR for more details or reach out to your manager with questions.', 'Robinson', NULL, NULL, '2026-12-22 08:00:00', '2026-12-22 09:00:00', 'draft', 28, '2026-12-13 08:00:00', '2026-08-19 16:47:46'),
(176, 'company', 'holiday', 'Holiday Notice: Loading Dock Closure', 'This event is open to all staff at the listed location.', 'Mingo', NULL, 31, '2026-09-12 12:00:00', '2026-09-12 16:00:00', 'active', 130, '2026-08-29 12:00:00', '2026-08-19 16:47:58'),
(177, 'announcement', 'production', 'Production Notice: New Benefits Enrollment', NULL, 'Robinson', NULL, NULL, '2026-12-20 08:00:00', '2026-12-27 08:00:00', 'expired', 101, '2026-12-08 08:00:00', '2026-08-19 16:47:46'),
(178, 'employee', 'new hire', 'Welcome to the Team, Andrew Lopez!', 'Please join us in celebrating this milestone.', 'Robinson', 102, 73, '2026-12-18 17:00:00', '2026-12-18 18:00:00', 'cancelled', 254, '2026-12-09 17:00:00', '2026-08-19 16:47:46'),
(179, 'company', 'training', 'Upcoming Training: Employee Wellness Fair', 'Contact facilities if you have any concerns about this notice.', 'Robinson', NULL, NULL, '2026-03-12 13:00:00', '2026-03-12 15:00:00', 'cancelled', 20, '2026-03-03 13:00:00', '2026-08-19 16:47:46'),
(180, 'employee', 'promotion', 'Congratulations to David Williams on Your Promotion!', 'Details subject to change; check back for updates.', 'Mingo', 202, NULL, '2026-07-07 12:00:00', '2026-07-08 12:00:00', 'expired', 131, '2026-06-22 12:00:00', '2026-08-19 16:47:58'),
(181, 'announcement', 'maintenance', 'Scheduled Maintenance: Network Upgrade Window', 'More information will be shared as it becomes available.', 'Robinson', NULL, 72, '2026-07-07 00:00:00', '2026-07-10 00:00:00', 'draft', 63, '2026-06-23 00:00:00', '2026-08-19 16:47:46'),
(182, 'announcement', 'safety', 'Safety Notice: Ice Storm Closure Policy', 'See HR for more details or reach out to your manager with questions.', 'Amah', 227, NULL, '2026-06-17 12:00:00', '2026-06-17 20:00:00', 'active', 237, '2026-06-08 12:00:00', '2026-08-19 16:48:09'),
(183, 'employee', 'birthday', 'Happy Birthday Robert Martinez!', 'See HR for more details or reach out to your manager with questions.', 'Robinson', 35, 48, '2026-12-10 13:00:00', '2026-12-13 13:00:00', 'active', 79, '2026-11-27 13:00:00', '2026-08-19 16:47:46'),
(184, 'employee', 'new hire', 'Welcome to the Team, Michelle Wilson!', 'All employees are encouraged to attend.', 'Amah', 244, 47, '2026-02-20 13:00:00', '2026-02-22 13:00:00', 'active', 183, '2026-02-19 13:00:00', '2026-08-19 16:48:09'),
(185, 'employee', 'birthday', 'Happy Birthday Sandra Williams!', 'Please join us in celebrating this milestone.', NULL, 86, 17, '2026-10-17 07:00:00', '2026-10-17 09:00:00', 'expired', 106, '2026-09-29 07:00:00', '2026-10-05 07:00:00'),
(186, 'announcement', 'urgent', 'URGENT: Employee Wellness Fair', 'Please join us in celebrating this milestone.', 'Mingo', NULL, NULL, '2026-03-31 00:00:00', '2026-03-31 01:00:00', 'active', 183, '2026-03-24 00:00:00', '2026-08-19 16:47:58'),
(187, 'employee', 'promotion', 'Congratulations to Patricia Jones on Your Promotion!', 'See HR for more details or reach out to your manager with questions.', 'Amah', 115, NULL, '2026-09-20 12:00:00', '2026-09-20 14:00:00', 'active', 113, '2026-09-01 12:00:00', '2026-08-19 16:48:09'),
(188, 'announcement', 'safety', 'Safety Notice: Q3 Goals Review', 'Please join us in celebrating this milestone.', 'Amah', NULL, 57, '2026-02-07 00:00:00', '2026-02-09 00:00:00', 'active', 33, '2026-02-03 00:00:00', '2026-08-19 16:48:09'),
(189, 'company', 'training', 'Upcoming Training: Warehouse Safety Walkthrough', NULL, 'Mingo', NULL, 71, '2026-04-21 09:00:00', '2026-04-28 09:00:00', 'expired', 211, '2026-04-11 09:00:00', '2026-08-19 16:47:58'),
(190, 'company', 'general', 'Company Update: Cafeteria Menu Changes', 'All employees are encouraged to attend.', 'Robinson', NULL, 11, '2026-02-17 09:00:00', '2026-02-17 11:00:00', 'expired', 190, '2026-02-13 09:00:00', '2026-08-19 16:47:46'),
(191, 'employee', 'promotion', 'Congratulations to Linda Wilson on Your Promotion!', 'Please join us in celebrating this milestone.', 'Robinson', 80, 74, '2026-09-17 07:00:00', '2026-09-17 11:00:00', 'expired', 114, '2026-09-14 07:00:00', '2026-08-19 16:47:46'),
(192, 'announcement', 'maintenance', 'Scheduled Maintenance: Loading Dock Closure', 'More information will be shared as it becomes available.', 'Robinson', NULL, NULL, '2026-11-11 13:00:00', '2026-11-11 14:00:00', 'active', 136, '2026-11-11 13:00:00', '2026-08-19 16:47:46'),
(193, 'employee', 'promotion', 'Congratulations to Nancy Lopez on Your Promotion!', 'This event is open to all staff at the listed location.', 'Amah', 18, 4, '2026-02-16 13:00:00', '2026-02-16 21:00:00', 'active', 232, '2026-02-06 13:00:00', '2026-08-19 16:48:09'),
(194, 'company', 'training', 'Upcoming Training: Building A Elevator Outage', 'This event is open to all staff at the listed location.', 'Robinson', 21, 55, '2026-09-06 12:00:00', '2026-09-13 12:00:00', 'active', 110, '2026-08-21 12:00:00', '2026-08-19 16:47:46'),
(195, 'employee', 'birthday', 'Happy Birthday Charles Perez!', 'Contact facilities if you have any concerns about this notice.', NULL, 102, NULL, '2026-01-29 00:00:00', '2026-01-29 08:00:00', 'active', 108, '2026-01-25 00:00:00', '2026-01-27 00:00:00'),
(196, 'employee', 'birthday', 'Happy Birthday James Thomas!', 'This event is open to all staff at the listed location.', 'Robinson', 59, NULL, '2026-12-09 17:00:00', '2026-12-11 17:00:00', 'draft', 21, '2026-11-26 17:00:00', '2026-08-19 16:47:46'),
(197, 'company', 'general', 'Company Update: Loading Dock Closure', 'Details subject to change; check back for updates.', 'Amah', NULL, NULL, '2026-06-16 07:00:00', '2026-06-23 07:00:00', 'expired', 185, '2026-06-14 07:00:00', '2026-08-19 16:48:09'),
(198, 'announcement', 'urgent', 'URGENT: Server Room Cooling Repair', 'See HR for more details or reach out to your manager with questions.', 'Amah', NULL, 22, '2026-02-09 12:00:00', '2026-02-09 14:00:00', 'active', 99, '2026-01-29 12:00:00', '2026-08-19 16:48:09'),
(199, 'announcement', 'safety', 'Safety Notice: Network Upgrade Window', 'Contact facilities if you have any concerns about this notice.', 'Robinson', 195, NULL, '2026-04-01 17:00:00', '2026-04-08 17:00:00', 'active', 229, '2026-03-14 17:00:00', '2026-08-19 16:47:46'),
(200, 'announcement', 'safety', 'Safety Notice: New Benefits Enrollment', NULL, 'Amah', NULL, NULL, '2026-06-30 12:00:00', '2026-06-30 14:00:00', 'active', 231, '2026-06-29 12:00:00', '2026-08-19 16:48:09'),
(201, 'company', 'training', 'Upcoming Training: Employee Wellness Fair', 'Reminder: this affects normal operations for the duration listed.', 'Amah', NULL, NULL, '2026-01-22 09:00:00', '2026-01-22 17:00:00', 'active', 243, '2026-01-06 09:00:00', '2026-08-19 16:48:09'),
(202, 'announcement', 'production', 'Production Notice: New Benefits Enrollment', NULL, 'Mingo', NULL, NULL, '2026-08-13 12:00:00', '2026-08-13 16:00:00', 'active', 144, '2026-08-01 12:00:00', '2026-08-19 16:47:58'),
(203, 'announcement', 'safety', 'Safety Notice: New Benefits Enrollment', 'All employees are encouraged to attend.', NULL, NULL, 78, '2026-03-18 08:00:00', '2026-03-18 10:00:00', 'active', 72, '2026-03-07 08:00:00', '2026-03-11 08:00:00'),
(204, 'announcement', 'safety', 'Safety Notice: New Badge System Rollout', NULL, 'Amah', NULL, NULL, '2026-12-17 12:00:00', '2026-12-17 14:00:00', 'active', 216, '2026-12-01 12:00:00', '2026-08-19 16:48:09'),
(205, 'employee', 'promotion', 'Congratulations to Barbara Miller on Your Promotion!', 'More information will be shared as it becomes available.', 'Mingo', 40, 13, '2026-09-17 17:00:00', '2026-09-17 18:00:00', 'expired', 67, '2026-08-29 17:00:00', '2026-08-19 16:47:58'),
(206, 'employee', 'anniversary', 'Michelle Sanchez\'s 3-Year Work Anniversary', 'Please join us in celebrating this milestone.', 'Robinson', 185, 57, '2026-11-09 08:00:00', '2026-11-16 08:00:00', 'active', 122, '2026-10-31 08:00:00', '2026-08-19 16:47:46'),
(207, 'announcement', 'urgent', 'URGENT: Warehouse Safety Walkthrough', 'Contact facilities if you have any concerns about this notice.', 'Robinson', NULL, NULL, '2026-04-13 17:00:00', '2026-04-13 21:00:00', 'expired', 26, '2026-03-24 17:00:00', '2026-08-19 16:47:46'),
(208, 'announcement', 'weather', 'Weather Advisory: New Badge System Rollout', 'See HR for more details or reach out to your manager with questions.', 'Amah', NULL, NULL, '2026-08-12 00:00:00', '2026-08-12 08:00:00', 'expired', 178, '2026-08-12 00:00:00', '2026-08-19 16:48:09'),
(209, 'employee', 'promotion', 'Congratulations to Jessica Gonzalez on Your Promotion!', 'More information will be shared as it becomes available.', NULL, 239, 43, '2026-03-16 07:00:00', '2026-03-16 08:00:00', 'active', 241, '2026-03-12 07:00:00', '2026-03-15 07:00:00'),
(210, 'company', 'general', 'Company Update: Severe Storm Warning', 'This event is open to all staff at the listed location.', 'Robinson', NULL, NULL, '2026-05-28 07:00:00', '2026-05-29 07:00:00', 'active', 122, '2026-05-15 07:00:00', '2026-08-19 16:47:46'),
(211, 'announcement', 'production', 'Production Notice: Employee Wellness Fair', NULL, NULL, NULL, 19, '2026-05-30 09:00:00', '2026-05-30 10:00:00', 'active', 123, '2026-05-12 09:00:00', '2026-05-25 09:00:00'),
(212, 'employee', 'birthday', 'Happy Birthday Kimberly Lopez!', NULL, 'Robinson', 142, 61, '2026-01-23 13:00:00', '2026-01-26 13:00:00', 'cancelled', 129, '2026-01-23 13:00:00', '2026-08-19 16:47:46'),
(213, 'announcement', 'maintenance', 'Scheduled Maintenance: Loading Dock Closure', 'All employees are encouraged to attend.', NULL, NULL, 23, '2026-12-17 09:00:00', '2026-12-24 09:00:00', 'active', 69, '2026-12-15 09:00:00', '2026-12-17 09:00:00'),
(214, 'announcement', 'production', 'Production Notice: Building A Elevator Outage', 'More information will be shared as it becomes available.', 'Amah', NULL, NULL, '2026-10-06 09:00:00', '2026-10-07 09:00:00', 'draft', 97, '2026-09-27 09:00:00', '2026-08-19 16:48:09'),
(215, 'announcement', 'general', 'Announcement: Ice Storm Closure Policy', 'Details subject to change; check back for updates.', 'Robinson', NULL, NULL, '2026-06-23 07:00:00', '2026-06-30 07:00:00', 'expired', 188, '2026-06-07 07:00:00', '2026-08-19 16:47:46'),
(216, 'announcement', 'safety', 'Safety Notice: Employee Wellness Fair', 'This event is open to all staff at the listed location.', 'Amah', 84, NULL, '2026-06-06 09:00:00', '2026-06-09 09:00:00', 'active', 227, '2026-05-26 09:00:00', '2026-08-19 16:48:09'),
(217, 'employee', 'promotion', 'Congratulations to Michelle Wilson on Your Promotion!', 'See HR for more details or reach out to your manager with questions.', 'Amah', 94, NULL, '2026-12-14 07:00:00', '2026-12-14 08:00:00', 'active', 224, '2026-12-13 07:00:00', '2026-08-19 16:48:09'),
(218, 'employee', 'promotion', 'Congratulations to Lisa Gonzalez on Your Promotion!', 'This event is open to all staff at the listed location.', 'Amah', 96, NULL, '2026-02-09 12:00:00', '2026-02-09 16:00:00', 'active', 203, '2026-01-30 12:00:00', '2026-08-19 16:48:09'),
(219, 'employee', 'birthday', 'Happy Birthday Mary White!', NULL, 'Robinson', 31, 34, '2026-12-27 09:00:00', '2026-12-27 17:00:00', 'cancelled', 146, '2026-12-12 09:00:00', '2026-08-19 16:47:46'),
(220, 'employee', 'birthday', 'Happy Birthday Mark Garcia!', 'All employees are encouraged to attend.', 'Robinson', 17, NULL, '2026-05-29 08:00:00', '2026-05-29 12:00:00', 'expired', 89, '2026-05-18 08:00:00', '2026-08-19 16:47:46'),
(221, 'employee', 'anniversary', 'David Davis\'s 20-Year Work Anniversary', 'All employees are encouraged to attend.', 'Amah', 120, NULL, '2026-10-10 07:00:00', '2026-10-10 09:00:00', 'draft', 203, '2026-09-25 07:00:00', '2026-08-19 16:48:09'),
(222, 'announcement', 'weather', 'Weather Advisory: New Benefits Enrollment', NULL, 'Robinson', NULL, NULL, '2026-10-10 13:00:00', '2026-10-10 17:00:00', 'expired', 66, '2026-09-27 13:00:00', '2026-08-19 16:47:46'),
(223, 'announcement', 'general', 'Announcement: New Badge System Rollout', 'This event is open to all staff at the listed location.', 'Robinson', NULL, NULL, '2026-09-23 08:00:00', '2026-09-23 10:00:00', 'active', 140, '2026-09-19 08:00:00', '2026-08-19 16:47:46'),
(224, 'company', 'general', 'Company Update: Loading Dock Closure', 'Reminder: this affects normal operations for the duration listed.', 'Robinson', NULL, NULL, '2026-06-22 17:00:00', '2026-06-22 18:00:00', 'expired', 14, '2026-06-20 17:00:00', '2026-08-19 16:47:46'),
(225, 'announcement', 'weather', 'Weather Advisory: Loading Dock Closure', 'Details subject to change; check back for updates.', 'Mingo', NULL, NULL, '2026-05-29 13:00:00', '2026-05-30 13:00:00', 'active', 207, '2026-05-20 13:00:00', '2026-08-19 16:47:58'),
(226, 'employee', 'birthday', 'Happy Birthday William Anderson!', NULL, 'Robinson', 37, 41, '2026-06-26 09:00:00', '2026-06-26 13:00:00', 'expired', 54, '2026-06-16 09:00:00', '2026-08-19 16:47:46'),
(227, 'company', 'training', 'Upcoming Training: Parking Lot Repaving', 'Please join us in celebrating this milestone.', 'Amah', NULL, NULL, '2026-03-23 17:00:00', '2026-03-25 17:00:00', 'cancelled', 160, '2026-03-17 17:00:00', '2026-08-19 16:48:09'),
(228, 'employee', 'new hire', 'Welcome to the Team, Ashley Lewis!', 'Please join us in celebrating this milestone.', NULL, 101, NULL, '2026-05-04 07:00:00', '2026-05-06 07:00:00', 'draft', 144, '2026-04-19 07:00:00', '2026-05-04 07:00:00'),
(229, 'employee', 'birthday', 'Happy Birthday Michael Wilson!', 'All employees are encouraged to attend.', 'Amah', 12, NULL, '2026-10-19 12:00:00', '2026-10-19 20:00:00', 'active', 147, '2026-10-17 12:00:00', '2026-08-19 16:48:09'),
(230, 'company', 'training', 'Upcoming Training: Network Upgrade Window', 'See HR for more details or reach out to your manager with questions.', 'Amah', NULL, 19, '2026-04-12 12:00:00', '2026-04-15 12:00:00', 'active', 23, '2026-04-11 12:00:00', '2026-08-19 16:48:09'),
(231, 'announcement', 'production', 'Production Notice: Employee Wellness Fair', NULL, NULL, NULL, 51, '2026-11-12 13:00:00', '2026-11-13 13:00:00', 'active', 250, '2026-10-25 13:00:00', '2026-11-03 13:00:00'),
(232, 'company', 'general', 'Company Update: Annual Compliance Training', 'Reminder: this affects normal operations for the duration listed.', 'Robinson', NULL, NULL, '2026-11-02 09:00:00', '2026-11-03 09:00:00', 'cancelled', 116, '2026-11-01 09:00:00', '2026-08-19 16:47:46'),
(233, 'employee', 'new hire', 'Welcome to the Team, Elizabeth Clark!', 'Reminder: this affects normal operations for the duration listed.', 'Mingo', 49, 41, '2026-08-03 07:00:00', '2026-08-06 07:00:00', 'expired', 210, '2026-07-18 07:00:00', '2026-08-19 16:47:58'),
(234, 'announcement', 'safety', 'Safety Notice: Server Room Cooling Repair', 'More information will be shared as it becomes available.', 'Robinson', NULL, 23, '2026-08-24 12:00:00', '2026-08-26 12:00:00', 'active', 135, '2026-08-05 12:00:00', '2026-08-19 16:47:46'),
(235, 'employee', 'anniversary', 'Sarah Moore\'s 7-Year Work Anniversary', 'Contact facilities if you have any concerns about this notice.', 'Robinson', 54, NULL, '2026-09-08 08:00:00', '2026-09-15 08:00:00', 'active', 140, '2026-08-30 08:00:00', '2026-08-19 16:47:46'),
(236, 'company', 'meeting', 'All-Hands Meeting: Network Upgrade Window', 'Contact facilities if you have any concerns about this notice.', NULL, NULL, 57, '2026-12-02 08:00:00', '2026-12-09 08:00:00', 'active', 138, '2026-11-15 08:00:00', '2026-11-23 08:00:00'),
(237, 'employee', 'anniversary', 'Jessica Johnson\'s 5-Year Work Anniversary', 'Please join us in celebrating this milestone.', NULL, 85, NULL, '2026-02-21 13:00:00', '2026-02-21 17:00:00', 'draft', 80, '2026-02-08 13:00:00', '2026-02-18 13:00:00'),
(238, 'announcement', 'production', 'Production Notice: New Badge System Rollout', 'All employees are encouraged to attend.', 'Mingo', NULL, 74, '2026-04-29 12:00:00', '2026-04-29 13:00:00', 'cancelled', 89, '2026-04-16 12:00:00', '2026-08-19 16:47:58'),
(239, 'employee', 'birthday', 'Happy Birthday Betty Sanchez!', 'Contact facilities if you have any concerns about this notice.', 'Mingo', 77, NULL, '2026-02-24 08:00:00', '2026-02-25 08:00:00', 'active', 252, '2026-02-20 08:00:00', '2026-08-19 16:47:58'),
(240, 'company', 'holiday', 'Holiday Notice: Warehouse Safety Walkthrough', 'Contact facilities if you have any concerns about this notice.', 'Mingo', NULL, NULL, '2026-10-18 13:00:00', '2026-10-18 21:00:00', 'active', 207, '2026-10-05 13:00:00', '2026-08-19 16:47:58'),
(241, 'employee', 'new hire', 'Welcome to the Team, Michael Garcia!', 'All employees are encouraged to attend.', 'Mingo', 67, 58, '2026-05-17 08:00:00', '2026-05-18 08:00:00', 'active', 5, '2026-05-09 08:00:00', '2026-08-19 16:47:58'),
(242, 'announcement', 'general', 'Announcement: Fire Drill Scheduled', 'Details subject to change; check back for updates.', 'Robinson', NULL, NULL, '2026-11-24 08:00:00', '2026-11-26 08:00:00', 'active', 112, '2026-11-20 08:00:00', '2026-08-19 16:47:46'),
(243, 'employee', 'promotion', 'Congratulations to Anthony Thompson on Your Promotion!', 'More information will be shared as it becomes available.', 'Robinson', 194, NULL, '2026-02-11 12:00:00', '2026-02-18 12:00:00', 'active', 185, '2026-02-09 12:00:00', '2026-08-19 16:47:46'),
(244, 'employee', 'anniversary', 'Andrew Moore\'s 3-Year Work Anniversary', 'All employees are encouraged to attend.', 'Amah', 30, NULL, '2026-10-26 09:00:00', '2026-10-26 11:00:00', 'expired', 228, '2026-10-25 09:00:00', '2026-08-19 16:48:09'),
(245, 'employee', 'new hire', 'Welcome to the Team, Sandra Jackson!', NULL, 'Amah', 186, 33, '2026-01-02 13:00:00', '2026-01-02 21:00:00', 'active', 23, '2025-12-20 13:00:00', '2026-08-19 16:48:09'),
(246, 'announcement', 'weather', 'Weather Advisory: Software Rollout: New Timeclock', 'Please join us in celebrating this milestone.', 'Mingo', NULL, NULL, '2026-11-27 09:00:00', '2026-11-29 09:00:00', 'cancelled', 195, '2026-11-13 09:00:00', '2026-08-19 16:47:58'),
(247, 'announcement', 'production', 'Production Notice: Ice Storm Closure Policy', 'See HR for more details or reach out to your manager with questions.', 'Robinson', NULL, 29, '2026-01-02 17:00:00', '2026-01-02 18:00:00', 'cancelled', 237, '2025-12-16 17:00:00', '2026-08-19 16:47:46'),
(248, 'company', 'holiday', 'Holiday Notice: Network Upgrade Window', 'Contact facilities if you have any concerns about this notice.', 'Robinson', NULL, 54, '2026-11-11 17:00:00', '2026-11-11 18:00:00', 'active', 34, '2026-11-08 17:00:00', '2026-08-19 16:47:46'),
(249, 'company', 'general', 'Company Update: Forklift Certification Class', NULL, 'Mingo', NULL, NULL, '2026-03-13 12:00:00', '2026-03-14 12:00:00', 'active', 163, '2026-02-23 12:00:00', '2026-08-19 16:47:58'),
(250, 'employee', 'anniversary', 'Kimberly Davis\'s 15-Year Work Anniversary', 'Contact facilities if you have any concerns about this notice.', NULL, 243, NULL, '2026-03-31 13:00:00', '2026-04-03 13:00:00', 'active', 24, '2026-03-20 13:00:00', '2026-03-30 13:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `hrcomms_event_displays`
--

CREATE TABLE `hrcomms_event_displays` (
  `id` int UNSIGNED NOT NULL,
  `event_id` int UNSIGNED NOT NULL,
  `display_id` int UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hrcomms_event_displays`
--

INSERT INTO `hrcomms_event_displays` (`id`, `event_id`, `display_id`, `created_at`) VALUES
(6, 121, 30, '2026-06-28 06:00:00'),
(7, 121, 29, '2026-01-26 06:00:00'),
(8, 122, 30, '2026-02-19 13:00:00'),
(9, 123, 30, '2026-01-01 00:00:00'),
(10, 124, 29, '2026-03-22 08:00:00'),
(11, 124, 28, '2026-05-02 20:00:00'),
(12, 125, 27, '2026-01-08 13:00:00'),
(13, 126, 28, '2026-01-06 08:00:00'),
(14, 126, 26, '2026-05-08 13:00:00'),
(15, 127, 27, '2026-06-20 13:00:00'),
(16, 128, 27, '2026-06-28 12:00:00'),
(17, 128, 29, '2026-07-03 13:00:00'),
(18, 128, 26, '2026-04-03 13:00:00'),
(19, 129, 28, '2026-07-09 20:00:00'),
(20, 130, 29, '2026-02-21 09:00:00'),
(21, 131, 27, '2026-04-30 08:00:00'),
(22, 131, 30, '2026-03-09 09:00:00'),
(23, 132, 30, '2026-05-07 07:00:00'),
(24, 133, 29, '2026-01-15 07:00:00'),
(25, 133, 30, '2026-04-11 00:00:00'),
(26, 133, 28, '2026-02-24 00:00:00'),
(27, 134, 27, '2026-07-01 00:00:00'),
(28, 134, 29, '2026-02-17 13:00:00'),
(29, 134, 26, '2026-04-26 12:00:00'),
(30, 135, 26, '2026-03-26 08:00:00'),
(31, 135, 27, '2026-02-17 20:00:00'),
(32, 136, 26, '2026-06-20 13:00:00'),
(33, 136, 28, '2026-04-06 12:00:00'),
(34, 137, 26, '2026-01-01 06:00:00'),
(35, 138, 28, '2026-04-18 06:00:00'),
(36, 139, 27, '2026-04-02 09:00:00'),
(37, 139, 29, '2026-04-21 06:00:00'),
(38, 140, 29, '2026-02-20 12:00:00'),
(39, 141, 29, '2026-03-24 12:00:00'),
(40, 141, 27, '2026-07-08 17:00:00'),
(41, 142, 29, '2026-03-05 13:00:00'),
(42, 143, 26, '2026-04-29 06:00:00'),
(43, 144, 26, '2026-02-19 06:00:00'),
(44, 144, 28, '2026-06-05 12:00:00'),
(45, 145, 28, '2026-06-07 00:00:00'),
(46, 146, 28, '2026-03-12 09:00:00'),
(47, 147, 30, '2026-06-12 06:00:00'),
(48, 148, 27, '2026-01-28 17:00:00'),
(49, 149, 29, '2026-03-06 13:00:00'),
(50, 149, 30, '2026-05-07 07:00:00'),
(51, 150, 27, '2026-03-19 07:00:00'),
(52, 150, 26, '2026-06-05 08:00:00'),
(53, 150, 28, '2026-03-25 12:00:00'),
(54, 151, 30, '2026-01-21 20:00:00'),
(55, 152, 27, '2026-03-05 13:00:00'),
(56, 153, 26, '2026-05-04 20:00:00'),
(57, 154, 27, '2026-01-27 06:00:00'),
(58, 154, 29, '2026-03-09 06:00:00'),
(59, 155, 29, '2026-05-08 17:00:00'),
(60, 156, 27, '2026-04-17 17:00:00'),
(61, 157, 27, '2026-07-19 09:00:00'),
(62, 157, 26, '2026-03-17 09:00:00'),
(63, 158, 28, '2026-07-08 09:00:00'),
(64, 158, 30, '2026-02-20 17:00:00'),
(65, 159, 27, '2026-03-02 07:00:00'),
(66, 160, 30, '2026-02-18 12:00:00'),
(67, 161, 28, '2026-03-04 20:00:00'),
(68, 162, 26, '2026-01-10 06:00:00'),
(69, 162, 29, '2026-01-02 17:00:00'),
(70, 163, 27, '2026-01-11 09:00:00'),
(71, 163, 29, '2026-03-01 06:00:00'),
(72, 163, 30, '2026-01-13 08:00:00'),
(73, 164, 30, '2026-01-20 12:00:00'),
(74, 164, 27, '2026-05-12 07:00:00'),
(75, 165, 28, '2026-07-18 00:00:00'),
(76, 166, 30, '2026-07-01 12:00:00'),
(77, 167, 28, '2026-03-29 07:00:00'),
(78, 168, 28, '2026-01-10 08:00:00'),
(79, 169, 28, '2026-06-23 12:00:00'),
(80, 169, 29, '2026-02-17 09:00:00'),
(81, 170, 26, '2026-05-07 20:00:00'),
(82, 171, 29, '2026-01-26 13:00:00'),
(83, 172, 27, '2026-06-17 07:00:00'),
(84, 172, 26, '2026-04-12 09:00:00'),
(85, 173, 28, '2026-06-20 09:00:00'),
(86, 174, 26, '2026-03-21 12:00:00'),
(87, 175, 26, '2026-07-16 12:00:00'),
(88, 176, 29, '2026-02-22 00:00:00'),
(89, 176, 30, '2026-04-22 07:00:00'),
(90, 177, 26, '2026-04-14 12:00:00'),
(91, 178, 27, '2026-02-03 00:00:00'),
(92, 179, 27, '2026-06-14 13:00:00'),
(93, 180, 30, '2026-04-05 20:00:00'),
(94, 181, 28, '2026-03-14 07:00:00'),
(95, 182, 26, '2026-04-09 17:00:00'),
(96, 182, 30, '2026-07-12 08:00:00'),
(97, 183, 26, '2026-05-04 12:00:00'),
(98, 184, 29, '2026-01-23 07:00:00'),
(99, 185, 27, '2026-06-07 08:00:00'),
(100, 185, 29, '2026-05-02 07:00:00'),
(101, 186, 26, '2026-05-13 07:00:00'),
(102, 186, 29, '2026-04-09 12:00:00'),
(103, 187, 27, '2026-07-05 08:00:00'),
(104, 188, 30, '2026-07-13 00:00:00'),
(105, 189, 28, '2026-04-10 17:00:00'),
(106, 189, 26, '2026-05-21 09:00:00'),
(107, 190, 28, '2026-04-19 13:00:00'),
(108, 190, 27, '2026-06-18 12:00:00'),
(109, 191, 29, '2026-02-15 00:00:00'),
(110, 192, 29, '2026-04-30 08:00:00'),
(111, 193, 30, '2026-07-19 17:00:00'),
(112, 194, 29, '2026-01-28 06:00:00'),
(113, 194, 30, '2026-02-02 12:00:00'),
(114, 195, 26, '2026-04-24 20:00:00'),
(115, 196, 26, '2026-06-12 07:00:00'),
(116, 196, 30, '2026-01-22 12:00:00'),
(117, 197, 30, '2026-01-14 20:00:00'),
(118, 197, 26, '2026-04-07 07:00:00'),
(119, 198, 26, '2026-06-07 06:00:00'),
(120, 199, 29, '2026-03-15 07:00:00'),
(121, 200, 27, '2026-03-31 09:00:00'),
(122, 200, 26, '2026-02-10 12:00:00'),
(123, 201, 28, '2026-03-07 20:00:00'),
(124, 201, 29, '2026-05-03 08:00:00'),
(125, 201, 26, '2026-06-01 09:00:00'),
(126, 202, 27, '2026-04-06 00:00:00'),
(127, 202, 28, '2026-02-20 07:00:00'),
(128, 203, 28, '2026-06-23 12:00:00'),
(129, 204, 27, '2026-07-16 20:00:00'),
(130, 204, 28, '2026-01-13 12:00:00'),
(131, 204, 26, '2026-04-26 20:00:00'),
(132, 205, 26, '2026-05-18 13:00:00'),
(133, 205, 28, '2026-07-08 12:00:00'),
(134, 206, 28, '2026-05-28 07:00:00'),
(135, 207, 26, '2026-04-24 08:00:00'),
(136, 208, 26, '2026-03-17 20:00:00'),
(137, 209, 30, '2026-06-19 12:00:00'),
(138, 210, 26, '2026-02-08 09:00:00'),
(139, 210, 27, '2026-06-07 13:00:00'),
(140, 211, 28, '2026-01-13 07:00:00'),
(141, 212, 30, '2026-06-17 00:00:00'),
(142, 213, 26, '2026-05-26 12:00:00'),
(143, 214, 30, '2026-04-02 20:00:00'),
(144, 215, 30, '2026-03-19 07:00:00'),
(145, 216, 30, '2026-05-02 07:00:00'),
(146, 217, 27, '2026-07-01 07:00:00'),
(147, 218, 26, '2026-06-13 07:00:00'),
(148, 219, 28, '2026-01-03 00:00:00'),
(149, 219, 29, '2026-06-15 20:00:00'),
(150, 219, 27, '2026-03-31 17:00:00'),
(151, 220, 30, '2026-03-05 07:00:00'),
(152, 220, 29, '2026-01-01 00:00:00'),
(153, 221, 26, '2026-04-14 07:00:00'),
(154, 222, 26, '2026-07-19 06:00:00'),
(155, 223, 30, '2026-06-18 08:00:00'),
(156, 224, 27, '2026-05-13 20:00:00'),
(157, 225, 29, '2026-05-11 09:00:00'),
(158, 225, 27, '2026-01-17 09:00:00'),
(159, 226, 29, '2026-04-07 13:00:00'),
(160, 226, 26, '2026-07-10 17:00:00'),
(161, 227, 29, '2026-02-14 08:00:00'),
(162, 228, 28, '2026-01-10 06:00:00'),
(163, 228, 27, '2026-03-27 09:00:00'),
(164, 228, 30, '2026-07-02 00:00:00'),
(165, 229, 30, '2026-06-23 13:00:00'),
(166, 230, 30, '2026-03-17 08:00:00'),
(167, 230, 28, '2026-01-22 20:00:00'),
(168, 231, 28, '2026-03-02 08:00:00'),
(169, 232, 28, '2026-03-26 08:00:00'),
(170, 232, 27, '2026-04-08 20:00:00'),
(171, 232, 29, '2026-05-01 17:00:00'),
(172, 233, 26, '2026-04-22 08:00:00'),
(173, 233, 30, '2026-05-27 09:00:00'),
(174, 234, 29, '2026-05-25 07:00:00'),
(175, 234, 26, '2026-02-07 00:00:00'),
(176, 235, 26, '2026-06-09 07:00:00'),
(177, 236, 27, '2026-06-29 00:00:00'),
(178, 237, 27, '2026-06-27 00:00:00'),
(179, 238, 26, '2026-06-01 12:00:00'),
(180, 238, 30, '2026-02-21 20:00:00'),
(181, 239, 26, '2026-03-05 08:00:00'),
(182, 239, 29, '2026-02-22 06:00:00'),
(183, 239, 30, '2026-01-09 00:00:00'),
(184, 240, 26, '2026-01-26 07:00:00'),
(185, 240, 28, '2026-01-26 08:00:00'),
(186, 240, 27, '2026-03-17 12:00:00'),
(187, 241, 28, '2026-01-06 12:00:00'),
(188, 242, 28, '2026-01-13 12:00:00'),
(189, 243, 30, '2026-06-08 00:00:00'),
(190, 243, 29, '2026-04-16 00:00:00'),
(191, 243, 27, '2026-04-22 20:00:00'),
(192, 244, 28, '2026-06-30 00:00:00'),
(193, 244, 29, '2026-05-18 08:00:00'),
(194, 245, 26, '2026-02-13 13:00:00'),
(195, 245, 28, '2026-01-01 20:00:00'),
(196, 246, 26, '2026-01-02 12:00:00'),
(197, 247, 29, '2026-06-27 07:00:00'),
(198, 248, 30, '2026-03-08 07:00:00'),
(199, 248, 28, '2026-03-14 08:00:00'),
(200, 248, 29, '2026-06-29 08:00:00'),
(201, 249, 26, '2026-06-12 06:00:00'),
(202, 250, 30, '2026-01-27 12:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `hrcomms_playlists`
--

CREATE TABLE `hrcomms_playlists` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hrcomms_playlists`
--

INSERT INTO `hrcomms_playlists` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'South & North Hallway Rotation', 'Shared rotation currently assigned to the hallway displays.', '2026-03-24 07:00:00', '2026-04-05 07:00:00'),
(2, 'Visitor Center Rotation', 'Content shown on the Visitor Center display.', '2026-06-16 00:00:00', '2026-06-18 00:00:00'),
(3, 'Packaging Area Rotation', 'Content shown on the Packaging Area display.', '2026-05-18 06:00:00', '2026-05-29 06:00:00'),
(4, 'Unassigned Rotation', 'Placeholder playlist not yet assigned to a display.', '2026-05-30 00:00:00', '2026-06-05 00:00:00'),
(5, 'Warehouse Safety Loop', 'Safety-focused announcements and reminders for warehouse floors.', '2026-01-10 06:00:00', '2026-01-23 06:00:00'),
(6, 'Break Room Highlights', 'Employee celebrations, birthdays, and light company news.', '2026-04-18 06:00:00', '2026-04-25 06:00:00'),
(7, 'Executive Briefing', 'Leadership announcements and company-wide updates.', '2026-01-24 20:00:00', '2026-02-06 20:00:00'),
(8, 'Shift Change Digest', 'Quick-hit updates shown during shift transitions.', '2026-01-16 06:00:00', '2026-01-23 06:00:00'),
(9, 'Holiday & Events', 'Seasonal notices and upcoming company events.', '2026-06-11 00:00:00', '2026-06-23 00:00:00'),
(10, 'New Hire Welcome Reel', 'Spotlight on recent new hires across all locations.', '2026-01-13 08:00:00', '2026-01-14 08:00:00'),
(11, 'Plant Floor Alerts', 'Time-sensitive production and maintenance notices.', '2026-05-23 07:00:00', '2026-06-01 07:00:00'),
(12, 'Weather & Closures', 'Severe weather advisories and closure notices.', '2026-04-18 07:00:00', '2026-04-21 07:00:00'),
(13, 'Training Spotlight', 'Upcoming and required training sessions.', '2026-05-27 09:00:00', '2026-06-01 09:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `hrcomms_playlist_items`
--

CREATE TABLE `hrcomms_playlist_items` (
  `id` int UNSIGNED NOT NULL,
  `playlist_id` int UNSIGNED NOT NULL,
  `content_id` int UNSIGNED NOT NULL,
  `order_no` int UNSIGNED NOT NULL DEFAULT '0',
  `duration` int UNSIGNED DEFAULT NULL COMMENT 'Override duration in seconds',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hrcomms_playlist_items`
--

INSERT INTO `hrcomms_playlist_items` (`id`, `playlist_id`, `content_id`, `order_no`, `duration`, `created_at`, `updated_at`) VALUES
(16, 1, 75, 0, 15, '2026-04-06 06:00:00', '2026-04-14 06:00:00'),
(17, 1, 9, 1, NULL, '2026-06-08 08:00:00', '2026-06-15 08:00:00'),
(18, 1, 69, 2, 45, '2026-03-22 17:00:00', '2026-03-31 17:00:00'),
(19, 1, 59, 3, 30, '2026-03-18 08:00:00', '2026-03-20 08:00:00'),
(20, 1, 32, 4, NULL, '2026-05-28 09:00:00', '2026-06-05 09:00:00'),
(21, 2, 44, 0, 60, '2026-03-15 06:00:00', '2026-03-16 06:00:00'),
(22, 2, 66, 1, 45, '2026-02-12 12:00:00', '2026-02-14 12:00:00'),
(23, 2, 63, 2, 45, '2026-01-11 06:00:00', '2026-01-19 06:00:00'),
(24, 2, 74, 3, 30, '2026-03-29 12:00:00', '2026-04-07 12:00:00'),
(25, 2, 64, 4, 60, '2026-01-18 06:00:00', '2026-01-22 06:00:00'),
(26, 2, 61, 5, NULL, '2026-01-16 09:00:00', '2026-01-26 09:00:00'),
(27, 2, 74, 6, 60, '2026-03-14 13:00:00', '2026-03-24 13:00:00'),
(28, 2, 45, 7, NULL, '2026-04-29 12:00:00', '2026-05-01 12:00:00'),
(29, 3, 15, 0, 60, '2026-01-16 08:00:00', '2026-01-20 08:00:00'),
(30, 3, 17, 1, 15, '2026-04-12 13:00:00', '2026-04-19 13:00:00'),
(31, 3, 11, 2, 10, '2026-04-25 13:00:00', '2026-05-03 13:00:00'),
(32, 3, 36, 3, 10, '2026-04-21 20:00:00', '2026-04-25 20:00:00'),
(33, 3, 54, 4, 30, '2026-06-24 13:00:00', '2026-06-27 13:00:00'),
(34, 3, 20, 5, NULL, '2026-02-15 07:00:00', '2026-02-18 07:00:00'),
(35, 3, 30, 6, NULL, '2026-05-05 07:00:00', '2026-05-09 07:00:00'),
(36, 3, 37, 7, NULL, '2026-02-07 13:00:00', '2026-02-15 13:00:00'),
(37, 3, 48, 8, 30, '2026-02-02 20:00:00', '2026-02-11 20:00:00'),
(38, 4, 59, 0, 45, '2026-04-12 13:00:00', '2026-04-18 13:00:00'),
(39, 4, 14, 1, 60, '2026-06-12 13:00:00', '2026-06-12 13:00:00'),
(40, 4, 25, 2, NULL, '2026-02-23 17:00:00', '2026-02-25 17:00:00'),
(41, 4, 15, 3, 30, '2026-06-03 00:00:00', '2026-06-04 00:00:00'),
(42, 4, 1, 4, 10, '2026-05-18 06:00:00', '2026-05-23 06:00:00'),
(43, 5, 4, 0, NULL, '2026-02-23 13:00:00', '2026-02-25 13:00:00'),
(44, 5, 33, 1, 30, '2026-06-04 12:00:00', '2026-06-11 12:00:00'),
(45, 5, 16, 2, NULL, '2026-05-05 17:00:00', '2026-05-12 17:00:00'),
(46, 5, 62, 3, 20, '2026-01-22 07:00:00', '2026-01-23 07:00:00'),
(47, 5, 44, 4, 20, '2026-05-03 07:00:00', '2026-05-11 07:00:00'),
(48, 5, 3, 5, 15, '2026-05-16 12:00:00', '2026-05-18 12:00:00'),
(49, 5, 70, 6, NULL, '2026-05-16 09:00:00', '2026-05-26 09:00:00'),
(50, 5, 12, 7, 20, '2026-05-13 12:00:00', '2026-05-15 12:00:00'),
(51, 5, 46, 8, 15, '2026-05-17 20:00:00', '2026-05-25 20:00:00'),
(52, 6, 29, 0, 15, '2026-03-03 13:00:00', '2026-03-06 13:00:00'),
(53, 6, 26, 1, 60, '2026-04-02 00:00:00', '2026-04-02 00:00:00'),
(54, 6, 36, 2, 60, '2026-03-08 08:00:00', '2026-03-17 08:00:00'),
(55, 6, 45, 3, 60, '2026-03-31 12:00:00', '2026-04-01 12:00:00'),
(56, 6, 29, 4, NULL, '2026-02-28 17:00:00', '2026-03-03 17:00:00'),
(57, 6, 44, 5, 15, '2026-05-04 00:00:00', '2026-05-11 00:00:00'),
(58, 6, 45, 6, NULL, '2026-06-19 06:00:00', '2026-06-25 06:00:00'),
(59, 7, 62, 0, 10, '2026-04-22 12:00:00', '2026-04-23 12:00:00'),
(60, 7, 51, 1, 60, '2026-04-13 06:00:00', '2026-04-15 06:00:00'),
(61, 7, 22, 2, 10, '2026-01-08 07:00:00', '2026-01-17 07:00:00'),
(62, 7, 60, 3, 10, '2026-06-06 17:00:00', '2026-06-16 17:00:00'),
(63, 7, 45, 4, 10, '2026-05-21 20:00:00', '2026-05-23 20:00:00'),
(64, 7, 3, 5, NULL, '2026-06-16 06:00:00', '2026-06-24 06:00:00'),
(65, 8, 56, 0, 15, '2026-02-24 00:00:00', '2026-02-28 00:00:00'),
(66, 8, 28, 1, 20, '2026-05-09 08:00:00', '2026-05-18 08:00:00'),
(67, 8, 42, 2, 20, '2026-05-20 13:00:00', '2026-05-22 13:00:00'),
(68, 8, 8, 3, 30, '2026-04-28 20:00:00', '2026-05-04 20:00:00'),
(69, 8, 65, 4, 10, '2026-05-17 07:00:00', '2026-05-25 07:00:00'),
(70, 8, 66, 5, NULL, '2026-04-23 07:00:00', '2026-05-02 07:00:00'),
(71, 9, 20, 0, 10, '2026-02-06 17:00:00', '2026-02-15 17:00:00'),
(72, 9, 16, 1, NULL, '2026-03-25 20:00:00', '2026-04-02 20:00:00'),
(73, 9, 72, 2, 60, '2026-01-28 20:00:00', '2026-01-28 20:00:00'),
(74, 9, 32, 3, 15, '2026-03-12 00:00:00', '2026-03-13 00:00:00'),
(75, 9, 65, 4, 60, '2026-05-24 00:00:00', '2026-05-25 00:00:00'),
(76, 10, 42, 0, 15, '2026-06-27 09:00:00', '2026-07-04 09:00:00'),
(77, 10, 66, 1, 60, '2026-05-10 08:00:00', '2026-05-18 08:00:00'),
(78, 10, 34, 2, 15, '2026-04-25 07:00:00', '2026-05-01 07:00:00'),
(79, 10, 16, 3, 45, '2026-04-24 12:00:00', '2026-04-25 12:00:00'),
(80, 10, 31, 4, 45, '2026-01-19 08:00:00', '2026-01-29 08:00:00'),
(81, 10, 39, 5, NULL, '2026-02-09 12:00:00', '2026-02-11 12:00:00'),
(82, 10, 33, 6, 10, '2026-04-30 08:00:00', '2026-05-01 08:00:00'),
(83, 10, 51, 7, 60, '2026-02-11 08:00:00', '2026-02-13 08:00:00'),
(84, 11, 66, 0, 45, '2026-03-28 13:00:00', '2026-03-31 13:00:00'),
(85, 11, 46, 1, 30, '2026-01-24 12:00:00', '2026-01-24 12:00:00'),
(86, 11, 44, 2, 60, '2026-04-23 00:00:00', '2026-04-29 00:00:00'),
(87, 11, 43, 3, 20, '2026-05-12 06:00:00', '2026-05-13 06:00:00'),
(88, 11, 30, 4, NULL, '2026-01-22 09:00:00', '2026-01-26 09:00:00'),
(89, 11, 6, 5, 10, '2026-03-11 07:00:00', '2026-03-17 07:00:00'),
(90, 11, 34, 6, 45, '2026-02-08 20:00:00', '2026-02-16 20:00:00'),
(91, 11, 74, 7, 60, '2026-06-29 12:00:00', '2026-06-30 12:00:00'),
(92, 12, 8, 0, 10, '2026-04-19 06:00:00', '2026-04-23 06:00:00'),
(93, 12, 3, 1, NULL, '2026-03-08 06:00:00', '2026-03-17 06:00:00'),
(94, 12, 29, 2, NULL, '2026-03-09 06:00:00', '2026-03-16 06:00:00'),
(95, 12, 2, 3, 30, '2026-05-22 13:00:00', '2026-05-26 13:00:00'),
(96, 12, 80, 4, 10, '2026-01-12 20:00:00', '2026-01-15 20:00:00'),
(97, 12, 15, 5, 10, '2026-03-09 00:00:00', '2026-03-11 00:00:00'),
(98, 12, 26, 6, 20, '2026-06-10 09:00:00', '2026-06-18 09:00:00'),
(99, 13, 38, 0, 60, '2026-05-09 07:00:00', '2026-05-13 07:00:00'),
(100, 13, 45, 1, NULL, '2026-03-06 00:00:00', '2026-03-06 00:00:00'),
(101, 13, 3, 2, 15, '2026-05-12 17:00:00', '2026-05-15 17:00:00'),
(102, 13, 58, 3, NULL, '2026-06-18 13:00:00', '2026-06-28 13:00:00'),
(103, 13, 64, 4, 45, '2026-05-10 09:00:00', '2026-05-13 09:00:00'),
(104, 13, 30, 5, 30, '2026-02-20 07:00:00', '2026-02-26 07:00:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `hrcomms_content`
--
ALTER TABLE `hrcomms_content`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_uploaded_by` (`uploaded_by`);

--
-- Indexes for table `hrcomms_content_approvals`
--
ALTER TABLE `hrcomms_content_approvals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_content_id` (`content_id`),
  ADD KEY `idx_approver_status` (`approver_id`,`status`),
  ADD KEY `idx_content_status` (`content_id`,`status`);

--
-- Indexes for table `hrcomms_displays`
--
ALTER TABLE `hrcomms_displays`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_displays_playlist_id` (`playlist_id`);

--
-- Indexes for table `hrcomms_display_content_settings`
--
ALTER TABLE `hrcomms_display_content_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_display_category_subtype` (`display_id`,`category`,`subtype`),
  ADD KEY `idx_dcs_display_id` (`display_id`);

--
-- Indexes for table `hrcomms_events`
--
ALTER TABLE `hrcomms_events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_event_category_subtype` (`category`,`subtype`) USING BTREE,
  ADD KEY `idx_event_content_id` (`content_id`) USING BTREE,
  ADD KEY `idx_event_status` (`status`) USING BTREE,
  ADD KEY `idx_event_dates` (`start`,`end`) USING BTREE;

--
-- Indexes for table `hrcomms_event_displays`
--
ALTER TABLE `hrcomms_event_displays`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_event_display` (`event_id`,`display_id`) USING BTREE,
  ADD KEY `idx_ed_event_id` (`event_id`) USING BTREE,
  ADD KEY `idx_ed_display_id` (`display_id`) USING BTREE;

--
-- Indexes for table `hrcomms_playlists`
--
ALTER TABLE `hrcomms_playlists`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hrcomms_playlist_items`
--
ALTER TABLE `hrcomms_playlist_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_playlist_items_playlist_id` (`playlist_id`),
  ADD KEY `idx_playlist_items_content_id` (`content_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `hrcomms_content`
--
ALTER TABLE `hrcomms_content`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `hrcomms_content_approvals`
--
ALTER TABLE `hrcomms_content_approvals`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `hrcomms_displays`
--
ALTER TABLE `hrcomms_displays`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `hrcomms_display_content_settings`
--
ALTER TABLE `hrcomms_display_content_settings`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT for table `hrcomms_events`
--
ALTER TABLE `hrcomms_events`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=251;

--
-- AUTO_INCREMENT for table `hrcomms_event_displays`
--
ALTER TABLE `hrcomms_event_displays`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=203;

--
-- AUTO_INCREMENT for table `hrcomms_playlists`
--
ALTER TABLE `hrcomms_playlists`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `hrcomms_playlist_items`
--
ALTER TABLE `hrcomms_playlist_items`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
