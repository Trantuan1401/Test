-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th10 29, 2022 lúc 10:10 AM
-- Phiên bản máy phục vụ: 10.4.25-MariaDB
-- Phiên bản PHP: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `webg301-asm`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `category`
--

INSERT INTO `category` (`id`, `name`, `description`) VALUES
(1, 'Phone', 'This category contain all phones.'),
(2, 'Laptop', 'This category contain all laptops.'),
(3, 'PC', 'PC category');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20221019163250', '2022-10-20 09:01:33', 62),
('DoctrineMigrations\\Version20221021134046', '2022-10-21 15:41:03', 81),
('DoctrineMigrations\\Version20221021134418', '2022-10-21 15:44:28', 49),
('DoctrineMigrations\\Version20221021142525', '2022-10-23 16:15:45', 119),
('DoctrineMigrations\\Version20221021145113', '2022-10-23 16:15:46', 146),
('DoctrineMigrations\\Version20221022015856', '2022-10-23 16:15:46', 29),
('DoctrineMigrations\\Version20221023141555', '2022-10-23 16:16:43', 49),
('DoctrineMigrations\\Version20221023142624', '2022-10-23 16:43:09', 216),
('DoctrineMigrations\\Version20221023143907', '2022-10-23 16:43:10', 88),
('DoctrineMigrations\\Version20221024084502', '2022-10-24 11:38:17', 208),
('DoctrineMigrations\\Version20221026072717', '2022-10-26 09:27:26', 671),
('DoctrineMigrations\\Version20221028085229', '2022-10-28 10:58:21', 213);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `messenger_messages`
--

CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `available_at` datetime NOT NULL,
  `delivered_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order`
--

CREATE TABLE `order` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `purchase_date` datetime NOT NULL,
  `total` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `order`
--

INSERT INTO `order` (`id`, `user_id`, `purchase_date`, `total`) VALUES
(1, 1, '2022-10-28 21:01:25', 16779),
(2, 1, '2022-10-29 11:29:36', 69091);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_detail`
--

CREATE TABLE `order_detail` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `orders_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `order_detail`
--

INSERT INTO `order_detail` (`id`, `product_id`, `orders_id`, `quantity`) VALUES
(1, 1, 1, 21),
(2, 12, 2, 55),
(3, 8, 2, 45),
(4, 24, 2, 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `imgurl` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `publisher_id` int(11) DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `product`
--

INSERT INTO `product` (`id`, `name`, `price`, `category_id`, `imgurl`, `publisher_id`, `description`) VALUES
(1, 'Iphone 14', 799, 1, '1.png', 1, 'Telephone'),
(2, 'Iphone 14 Plus', 899, 1, '2.png', 1, 'iOS 16-6 GB-128 GB'),
(8, 'PC ESPORT 01', 3000, 3, '8.png', 1, 'i3-10105F/H510/8GB RAM/240GB SSD/GT 710'),
(10, 'Laptop Acer Nitro 5', 2000, 2, '10.jpg', 1, 'i5 12500H/8GB/512GB/15.6\"FHD'),
(11, 'Iphone 13 Pro', 999, 1, '11.jpg', 1, 'iOS 15-128GB- 6 GB'),
(12, 'Samsung Galaxy S10 5G', 867, 1, '12.jpg', 1, 'Android 9 (Pie)-Exynos 9820-8 GB-256 GB'),
(13, 'Samsung Galaxy Note 10+', 1222, 1, '13.jpg', 1, 'Android 9 (Pie)-Exynos 9825-12 GB-256 GB'),
(14, 'MacBook Pro 14 M1 Pro 2021', 2999, 2, '14.jpg', 4, '10-core CPU/16GB/1TB SSD/16-core GPU (MKGQ3SA/A)'),
(15, 'XUMGamingPC', 1299, 3, '15.jpg', 4, 'CPU : Intel Core i5-12400F-MAIN : B660-RAM : 8GB DDR4-SSD : 250GB SSD-VGA: GTX 1660 SUPER'),
(16, 'Samsung Galaxy Note 20 Ultra', 1799, 1, '16.jpg', 4, 'Android 10-Exynos 990-8 GB-256 GB'),
(17, 'Asus Gaming ROG Flow Z13 GZ301Z', 2799, 2, '17.jpg', 4, 'i7 12700H-16GB-512GB-4GB RTX3050-120Hz'),
(18, 'iPhone 12 Pro Max', 1455, 1, '18.jpg', 4, 'iOS 15-Apple A14 Bionic-6 GB-256 GB'),
(19, 'Samsung Galaxy S22 Ultra', 1666, 1, '19.jpg', 4, 'Android 12-Snapdragon 8 Gen 1-12 GB-256 GB'),
(20, 'Asus Vivobook', 1239, 2, '20.jpg', 1, 'i5 1240P-8GB-512GB-Win11'),
(21, 'HP Pavilion 15', 899, 2, '21.jpg', 5, 'i5 1235U-8GB-512GB-2GB MX550-Win11'),
(22, 'Acer Nitro 5', 2199, 2, '22.jpg', 5, 'i7 12700H-8GB-512GB-4GB RTX3050Ti-144Hz'),
(23, 'Dell Vostro 5620', 1889, 2, '23.jpg', 5, 'i5 1240P-8GB-256GB-OfficeHS-Win11'),
(24, 'Apple iPhone 7 Plus', 578, 1, '24.jpg', 5, '128 GB-1080 x 1920 pixels (FullHD)'),
(25, 'iPhone Xs Max 256GB', 699, 1, '25.jpg', 5, 'iOS 12-Apple A12 Bionic-4 GB-256 GB'),
(26, 'Asus ROG Strix Gaming', 2367, 2, '26.jpg', 1, '6800H-8GB-512GB-4GB RTX3050-144Hz'),
(27, 'PC VAMPIRIC', 2899, 3, '27.png', 1, 'Core I3 - 16GB Ram - SSD 256GB - 3060 12GB - 650W'),
(28, 'PC STREAMER 15', 3499, 3, '28.png', 1, 'i7 12700F | RTX 3070 6GB | RAM 16GB'),
(29, 'PC Ryzen 5', 1999, 3, '29.png', 1, '7800X | RAM 32GB | SSD 1000GB NVMe'),
(30, 'PC ULTRA 11', 2499, 3, '30.png', 1, 'Ryzen 7 5800X/ B550M/ 32GB RAM/ 250GB SSD/ 1TB HDD/ RTX 3060 Ti/ 750W'),
(31, 'PC AMD Ryzen 9', 2899, 3, '31.png', 1, '5900X | 3080 12GB | RAM 16GB'),
(32, 'PC Ryzen 5 5600G', 1000, 3, '32.png', 1, '5600G | RAM 16GB | SSD 500GB NVMe'),
(33, 'PC AMD Ryzen 7 5900X', 2477, 3, '33.png', 1, '5900X | 3080 12GB | RAM 16GB');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_num` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `password`, `name`, `phone_num`) VALUES
(1, 'tien1902@gmail.com', '[\"ROLE_SELLER\"]', '$2y$13$0dxF9uZxjTV2f/pY5.4vruHeyVlcfUlRYM0ZIv8HpSRIF7A5g/Sxi', 'tien', '1234567890'),
(2, 'khanh@gmail.com', '[\"ROLE_CUSTOMER\"]', '$2y$13$jx9MOvBDkqxr1CfmpcNBrecLBlOvYl4vYENwP5m6E5hNIIA3jt5O2', 'khanh', '1123456789'),
(3, 'abc@gmail.com', '[\"ROLE_SELLER\"]', '$2y$13$onlfq2WT/PXJNLhLOqktduGGbjcMgpr9AXTMFTWi6ujnPA4/9Y9l6', 'abc', '1112345678'),
(4, 'khang@gmail.com', '[\"ROLE_SELLER\"]', '$2y$13$QpLfSyjK0SkeRwrx57o4VeqJ9KYZWOXkDRc6x2zKb6jKLlrg/CGpe', 'khang', '1111567890'),
(5, 'khanhseller@gmail.com', '[\"ROLE_SELLER\"]', '$2y$13$yvGL3HaXDvQMAA04/Pmk/eDFXE9DgtOhxjAUxVuYSw4R9erPij3lG', 'khanhs', '0984342423');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Chỉ mục cho bảng `messenger_messages`
--
ALTER TABLE `messenger_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  ADD KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  ADD KEY `IDX_75EA56E016BA31DB` (`delivered_at`);

--
-- Chỉ mục cho bảng `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_F5299398A76ED395` (`user_id`);

--
-- Chỉ mục cho bảng `order_detail`
--
ALTER TABLE `order_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_ED896F464584665A` (`product_id`),
  ADD KEY `IDX_ED896F46CFFE9AD6` (`orders_id`);

--
-- Chỉ mục cho bảng `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_D34A04AD12469DE2` (`category_id`),
  ADD KEY `IDX_D34A04AD40C86FCE` (`publisher_id`);

--
-- Chỉ mục cho bảng `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `messenger_messages`
--
ALTER TABLE `messenger_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `order`
--
ALTER TABLE `order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `order_detail`
--
ALTER TABLE `order_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT cho bảng `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `FK_F5299398A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Các ràng buộc cho bảng `order_detail`
--
ALTER TABLE `order_detail`
  ADD CONSTRAINT `FK_ED896F464584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `FK_ED896F46CFFE9AD6` FOREIGN KEY (`orders_id`) REFERENCES `order` (`id`);

--
-- Các ràng buộc cho bảng `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `FK_D34A04AD12469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `FK_D34A04AD40C86FCE` FOREIGN KEY (`publisher_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
