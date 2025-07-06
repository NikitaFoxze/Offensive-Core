-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: MySQL-5.7
-- Время создания: Май 29 2025 г., 21:39
-- Версия сервера: 5.7.44
-- Версия PHP: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `offensive_core`
--

-- --------------------------------------------------------

--
-- Структура таблицы `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `nickname` varchar(24) NOT NULL,
  `password` varchar(65) NOT NULL,
  `second_password` varchar(20) NOT NULL DEFAULT 'No',
  `referal` varchar(24) NOT NULL DEFAULT 'No',
  `found_server` int(11) NOT NULL DEFAULT '1',
  `promo_code` varchar(16) NOT NULL DEFAULT 'No',
  `sex` int(11) NOT NULL DEFAULT '1',
  `rank` int(11) NOT NULL DEFAULT '1',
  `exp` int(11) NOT NULL DEFAULT '0',
  `money` int(11) NOT NULL DEFAULT '0',
  `gold_coins` int(11) NOT NULL DEFAULT '0',
  `kills` int(11) NOT NULL DEFAULT '0',
  `deaths` int(11) NOT NULL DEFAULT '0',
  `winning_matches` int(11) NOT NULL DEFAULT '0',
  `losing_matches` int(11) NOT NULL DEFAULT '0',
  `shots_enemy` int(11) NOT NULL DEFAULT '0',
  `shots_head` int(11) NOT NULL DEFAULT '0',
  `series_kills` int(11) NOT NULL DEFAULT '0',
  `daily_bonus_days` int(11) NOT NULL DEFAULT '1',
  `daily_bonus_datetime` varchar(19) NOT NULL DEFAULT 'No',
  `inv_uses_items` text NOT NULL,
  `inv_items` text NOT NULL,
  `inv_items_count` text NOT NULL,
  `inv_banners` text NOT NULL,
  `inv_banners_count` text NOT NULL,
  `blacklist` text NOT NULL,
  `animations` text NOT NULL,
  `helper_dina` text NOT NULL,
  `premium` int(11) NOT NULL DEFAULT '0',
  `premium_datetime` varchar(19) NOT NULL DEFAULT 'No',
  `nickname_color` varchar(15) NOT NULL DEFAULT 'No',
  `warns` int(11) NOT NULL DEFAULT '0',
  `muted_minutes` int(11) NOT NULL DEFAULT '0',
  `played_hours` int(11) NOT NULL DEFAULT '0',
  `played_minutes` int(11) NOT NULL DEFAULT '0',
  `reg_ip` varchar(15) NOT NULL DEFAULT 'No',
  `last_ip` varchar(15) NOT NULL DEFAULT 'No',
  `reg_datetime` datetime NOT NULL,
  `last_datetime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `accounts`
--

INSERT INTO `accounts` (`id`, `nickname`, `password`, `second_password`, `referal`, `found_server`, `promo_code`, `sex`, `rank`, `exp`, `money`, `gold_coins`, `kills`, `deaths`, `winning_matches`, `losing_matches`, `shots_enemy`, `shots_head`, `series_kills`, `daily_bonus_days`, `daily_bonus_datetime`, `inv_uses_items`, `inv_items`, `inv_items_count`, `inv_banners`, `inv_banners_count`, `blacklist`, `animations`, `helper_dina`, `premium`, `premium_datetime`, `nickname_color`, `warns`, `muted_minutes`, `played_hours`, `played_minutes`, `reg_ip`, `last_ip`, `reg_datetime`, `last_datetime`) VALUES
(14, 'Foxze', '$2y$12$ORDtWh/XbhTRZyLkWzH4T.5R90V.jK41P7nk8UWHYmIoDStZqpoLa', 'No', 'No', 1, 'No', 0, 8, 1000, 95600, 0, 0, 24, 6, 3, 0, 0, 0, 10, '2025-05-06 02:23:01', '1,16,351,0,0,451,0,1,', '42,0,6,0,23,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,', '1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,', 0, 'No', 'No', 0, 0, 3, 19, '127.0.0.1', '127.0.0.1', '2025-04-27 02:08:09', '2025-07-15 01:10:12'),
(15, 'Foxze2', '$2y$12$b0L2YTXGPVbHPjTXUCHpPOuq6a2YxLVMsNOmPFta1MJohZx2QBmXy', 'No', 'No', 1, 'No', 0, 1, 300, 450, 5, 0, 0, 0, 0, 0, 0, 0, 2, '2025-05-26 23:12:41', '1,1,0,0,0,0,0,1,', '312,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '1,1,1,1,0,0,1,1,1,1,1,1,0,1,1,0,0,0,1,0,', 0, 'No', 'No', 0, 0, 0, 0, '127.0.0.1', '127.0.0.1', '2025-05-25 23:12:39', '2025-05-25 23:12:39'),
(16, 'Foxze3', '$2y$12$XyjvRjT0PTW0XlXkKxjmbOCHetpMfyn6gBA/Zwf.Szi3oC7ag39J.', 'No', 'No', 1, 'No', 0, 2, 0, 1450, 5, 0, 0, 1, 0, 0, 0, 0, 2, '2025-05-26 23:55:38', '3,3,0,0,0,0,0,1,', '312,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '1,1,1,1,0,0,1,1,1,0,0,0,0,0,1,0,0,0,0,0,', 0, 'No', 'No', 0, 0, 0, 2, '127.0.0.1', '127.0.0.1', '2025-05-25 23:55:37', '2025-07-15 00:11:40');

-- --------------------------------------------------------

--
-- Структура таблицы `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `nickname` varchar(24) NOT NULL,
  `key` varchar(6) NOT NULL,
  `level` int(11) NOT NULL DEFAULT '1',
  `reputation` int(11) NOT NULL DEFAULT '0',
  `reprimands` int(11) NOT NULL DEFAULT '0',
  `kicks` int(11) NOT NULL DEFAULT '0',
  `bans` int(11) NOT NULL DEFAULT '0',
  `unbans` int(11) NOT NULL DEFAULT '0',
  `muts` int(11) NOT NULL DEFAULT '0',
  `unmuts` int(11) NOT NULL DEFAULT '0',
  `warns` int(11) NOT NULL DEFAULT '0',
  `unwarns` int(11) NOT NULL DEFAULT '0',
  `reg_datetime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `admins`
--

INSERT INTO `admins` (`id`, `nickname`, `key`, `level`, `reputation`, `reprimands`, `kicks`, `bans`, `unbans`, `muts`, `unmuts`, `warns`, `unwarns`, `reg_datetime`) VALUES
(0, 'Foxze', '1111', 6, 10, 0, 0, 6, 1, 9, 0, 5, 5, '2019-01-27 14:32:49'),
(1, 'Foxze3', '1111', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2025-05-29 21:38:16');

-- --------------------------------------------------------

--
-- Структура таблицы `bans`
--

CREATE TABLE `bans` (
  `id` int(11) NOT NULL,
  `player_nickname` varchar(24) NOT NULL,
  `admin_nickname` varchar(24) NOT NULL,
  `reason` text NOT NULL,
  `unban_datetime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `bugs`
--

CREATE TABLE `bugs` (
  `id` int(11) NOT NULL,
  `player_nickname` varchar(24) NOT NULL,
  `text` varchar(100) NOT NULL,
  `sending_datetime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `promocodes`
--

CREATE TABLE `promocodes` (
  `id` int(11) NOT NULL,
  `code` varchar(16) NOT NULL,
  `money` int(11) NOT NULL,
  `donate` int(11) NOT NULL,
  `click` int(11) NOT NULL,
  `days` int(11) NOT NULL,
  `people` int(11) NOT NULL,
  `datetime` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `quests`
--

CREATE TABLE `quests` (
  `id` int(11) NOT NULL,
  `tdm_quests_progress` text NOT NULL,
  `tdm_quests` text NOT NULL,
  `dm_quests_progress` text NOT NULL,
  `dm_quests` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `quests`
--

INSERT INTO `quests` (`id`, `tdm_quests_progress`, `tdm_quests`, `dm_quests_progress`, `dm_quests`) VALUES
(14, '0,0,3,0,2,0,', '0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '0,0,1,0,2,0,', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'),
(15, '0,0,3,0,2,0,', '0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '0,0,1,0,2,0,', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'),
(16, '0,0,1,0,2,0,', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,', '0,0,1,0,2,0,', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,');

-- --------------------------------------------------------

--
-- Структура таблицы `tdm_stats`
--

CREATE TABLE `tdm_stats` (
  `id` int(11) NOT NULL,
  `kills` text NOT NULL,
  `deaths` text NOT NULL,
  `assault_weapons` text NOT NULL,
  `assault_ammo` text NOT NULL,
  `medic_weapons` text NOT NULL,
  `medic_ammo` text NOT NULL,
  `engineer_weapons` text NOT NULL,
  `engineer_ammo` text NOT NULL,
  `recon_weapons` text NOT NULL,
  `recon_ammo` text NOT NULL,
  `uses_cap` text NOT NULL,
  `uses_armour` text NOT NULL,
  `assault_caps` text NOT NULL,
  `assault_armours` text NOT NULL,
  `medic_caps` text NOT NULL,
  `medic_armours` text NOT NULL,
  `engineer_caps` text NOT NULL,
  `engineer_armours` text NOT NULL,
  `recon_caps` text NOT NULL,
  `recon_armours` text NOT NULL,
  `assault_abilities` text NOT NULL,
  `medic_abilities` text NOT NULL,
  `engineer_abilities` text NOT NULL,
  `recon_abilities` text NOT NULL,
  `skill_m4` text NOT NULL,
  `skill_ak47` text NOT NULL,
  `skill_deagle` text NOT NULL,
  `skill_shotgun` text NOT NULL,
  `skill_sawshotgun` text NOT NULL,
  `skill_uzi` text NOT NULL,
  `skill_mp5` text NOT NULL,
  `skill_sniperrifle` text NOT NULL,
  `skill_normal` text NOT NULL,
  `skill_boxing` text NOT NULL,
  `skill_kungfu` text NOT NULL,
  `skill_kneehead` text NOT NULL,
  `skill_grabkick` text NOT NULL,
  `skill_elbow` text NOT NULL,
  `played_hours` text NOT NULL,
  `played_minutes` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `tdm_stats`
--

INSERT INTO `tdm_stats` (`id`, `kills`, `deaths`, `assault_weapons`, `assault_ammo`, `medic_weapons`, `medic_ammo`, `engineer_weapons`, `engineer_ammo`, `recon_weapons`, `recon_ammo`, `uses_cap`, `uses_armour`, `assault_caps`, `assault_armours`, `medic_caps`, `medic_armours`, `engineer_caps`, `engineer_armours`, `recon_caps`, `recon_armours`, `assault_abilities`, `medic_abilities`, `engineer_abilities`, `recon_abilities`, `skill_m4`, `skill_ak47`, `skill_deagle`, `skill_shotgun`, `skill_sawshotgun`, `skill_uzi`, `skill_mp5`, `skill_sniperrifle`, `skill_normal`, `skill_boxing`, `skill_kungfu`, `skill_kneehead`, `skill_grabkick`, `skill_elbow`, `played_hours`, `played_minutes`) VALUES
(14, '0,0,0,0,', '23,0,1,0,', '30,22,16,1,', '152,40,3,1,', '29,22,17,5,', '100,50,1,1,', '30,22,17,8,', '100,35,2,1,', '34,22,17,1,', '25,40,2,1,', '0,0,0,0,', '1,0,0,0,', '0,0,0,', '1,0,0,', '0,0,0,', '0,0,0,', '0,0,0,', '0,0,0,', '0,0,0,', '0,0,0,', '0,', '0,', '0,', '0,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '2,0,0,0,', '51,2,4,0,'),
(15, '0,0,0,0,', '1,0,0,0,', '30,22,16,1,', '150,30,3,1,', '29,22,17,5,', '100,50,1,1,', '30,22,17,8,', '100,35,2,1,', '34,22,17,1,', '25,40,2,1,', '0,0,0,0,', '0,0,0,0,', '0,0,0,', '0,0,0,', '0,0,0,', '0,0,0,', '0,0,0,', '0,0,0,', '0,0,0,', '0,0,0,', '0,', '0,', '0,', '0,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0,0,0,0,', '9,0,0,0,'),
(16, '0,0,0,0,', '0,0,0,0,', '30,22,16,1,', '150,30,3,1,', '29,22,17,5,', '100,50,1,1,', '30,22,17,8,', '100,35,2,1,', '34,22,17,1,', '25,40,2,1,', '0,0,0,0,', '0,0,0,0,', '0,0,0,', '0,0,0,', '0,0,0,', '0,0,0,', '0,0,0,', '0,0,0,', '0,0,0,', '0,0,0,', '0,', '0,', '0,', '0,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0.00,0.00,0.00,0.00,', '0,0,0,0,', '2,0,0,0,');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `bans`
--
ALTER TABLE `bans`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `bugs`
--
ALTER TABLE `bugs`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `promocodes`
--
ALTER TABLE `promocodes`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `quests`
--
ALTER TABLE `quests`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `tdm_stats`
--
ALTER TABLE `tdm_stats`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT для таблицы `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `bans`
--
ALTER TABLE `bans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `promocodes`
--
ALTER TABLE `promocodes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
