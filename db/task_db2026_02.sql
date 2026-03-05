-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: task_db2026_02
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `m_category`
--

DROP TABLE IF EXISTS `m_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `m_category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `delete_flg` char(1) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `update_datetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_category`
--

LOCK TABLES `m_category` WRITE;
/*!40000 ALTER TABLE `m_category` DISABLE KEYS */;
INSERT INTO `m_category` VALUES (1,'販売促進','0','2026-02-24 00:32:52'),(2,'設備修理','0','2026-02-24 00:32:52'),(3,'清掃・衛生','0','2026-02-24 00:32:52'),(4,'報告事項','0','2026-02-24 00:32:52'),(5,'緊急連絡','0','2026-02-27 05:42:32'),(8,'接客・レジ','0','2026-02-27 05:47:17'),(9,'発注・在庫','0','2026-02-27 05:47:17'),(10,'売場・POP','0','2026-02-27 05:47:17'),(11,'事務・管理','0','2026-02-27 05:47:17');
/*!40000 ALTER TABLE `m_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_status`
--

DROP TABLE IF EXISTS `m_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `m_status` (
  `status_code` char(2) COLLATE utf8mb4_general_ci NOT NULL,
  `status_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `delete_flg` char(1) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `update_datetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`status_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_status`
--

LOCK TABLES `m_status` WRITE;
/*!40000 ALTER TABLE `m_status` DISABLE KEYS */;
INSERT INTO `m_status` VALUES ('00','未着手','0','2026-02-24 00:32:53'),('10','確認中','0','2026-02-24 00:32:53'),('50','対応中','0','2026-02-24 00:32:53'),('90','完了','0','2026-02-24 00:32:53');
/*!40000 ALTER TABLE `m_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_user`
--

DROP TABLE IF EXISTS `m_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `m_user` (
  `user_id` varchar(24) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `user_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `delete_flg` char(1) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `update_datetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_user`
--

LOCK TABLES `m_user` WRITE;
/*!40000 ALTER TABLE `m_user` DISABLE KEYS */;
INSERT INTO `m_user` VALUES ('admin','password','システム管理者','0','2026-02-26 00:53:00'),('gotsu','password','江津店','0','2026-02-26 00:53:00'),('hamada','password','浜田店','0','2026-02-26 00:53:00'),('honbu','password','島根コンビニ本部','0','2026-02-26 00:53:00'),('izumo','password','出雲店','0','2026-02-26 00:53:00'),('masuda','password','益田店','0','2026-02-26 00:53:00'),('matsue','password','松江店','0','2026-02-26 00:53:00'),('yasugi','password','安来店','0','2026-02-26 00:53:00');
/*!40000 ALTER TABLE `m_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_comment`
--

DROP TABLE IF EXISTS `t_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_comment` (
  `comment_id` int NOT NULL AUTO_INCREMENT,
  `task_id` int NOT NULL,
  `parent_comment_id` int DEFAULT NULL,
  `user_id` varchar(24) COLLATE utf8mb4_general_ci NOT NULL,
  `comment_body` text COLLATE utf8mb4_general_ci NOT NULL,
  `delete_flg` char(1) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `update_datetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`),
  KEY `task_id` (`task_id`),
  KEY `parent_comment_id` (`parent_comment_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `t_comment_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `t_task` (`task_id`),
  CONSTRAINT `t_comment_ibfk_2` FOREIGN KEY (`parent_comment_id`) REFERENCES `t_comment` (`comment_id`),
  CONSTRAINT `t_comment_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `m_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2396 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_comment`
--

LOCK TABLES `t_comment` WRITE;
/*!40000 ALTER TABLE `t_comment` DISABLE KEYS */;
INSERT INTO `t_comment` VALUES (1,1,NULL,'matsue','什器の部品が一部足りません。','0','2026-02-26 01:02:17'),(2,2,NULL,'izumo','了解しました。チェック表を再作成します。','0','2026-02-26 01:02:50'),(3,7,NULL,'matsue','20代女性に非常に好評です。','0','2026-02-26 01:02:50'),(4,8,NULL,'izumo','業者の到着を待っています。','0','2026-02-26 01:02:50'),(5,5,NULL,'yasugi','在庫5000枚です。報告完了。','0','2026-02-26 01:02:50'),(6,10,NULL,'hamada','清掃完了しました。完璧です。','0','2026-02-27 02:47:14'),(7,1,1,'honbu','@松江店 様 予備を本日便で発送します。','0','2026-02-26 01:03:04'),(8,7,3,'honbu','@松江店 様 増量可能です。','0','2026-02-26 01:03:04'),(9,8,4,'honbu','@出雲店 様 到着が遅れるとの連絡あり。','0','2026-02-26 01:03:04'),(10,1,7,'matsue','@島根コンビニ本部 様 承知いたしました。','0','2026-02-26 01:03:07'),(2365,2,2,'honbu','@出雲店 様 緊急です。チェック表作成急いでください。','0','2026-02-26 01:27:47'),(2366,2,NULL,'izumo','チェック表作成・精査済みです。本部宛送信しました。','0','2026-02-26 01:31:32'),(2367,2,2366,'honbu','@出雲店 様 最新のチェック表確認しました。お疲れ様でした。','0','2026-02-26 01:33:27'),(2369,2,2365,'izumo','@島根コンビニ本部 様 了解しました。','0','2026-02-26 05:18:38'),(2370,2,2367,'izumo','@島根コンビニ本部 様 チェックありがとうございました。タスク終了します。','0','2026-02-26 05:58:31'),(2371,3,NULL,'hamada','現在のところ販売数は順調に推移措定ます。タ～コピ','0','2026-03-02 08:35:20'),(2372,3,2371,'honbu','@浜田店 様 お疲れ様です。時間帯と天候に関するデータを参照しながら、販売戦略を練ってください。','0','2026-02-26 06:15:29'),(2373,3,2372,'hamada','@島根コンビニ本部 様 了解しました。データ解析進めます。う～ん！！！！！！！！！','0','2026-02-27 02:53:53'),(2374,3,NULL,'hamada','焼きおにぎりは午前中に売り上げが集中する傾向があります。更に検証を続けます。ガンバッテマ～ス！','0','2026-03-02 23:10:30'),(2375,10,6,'honbu','@浜田店 様 おでん什器の清掃完了、ご苦労様でした。','0','2026-02-26 07:26:37'),(2376,10,NULL,'hamada','タスク完了します。','0','2026-02-26 07:27:38'),(2377,55,NULL,'izumo','現在、応急処置で対応中です。','0','2026-02-26 07:49:34'),(2378,55,2377,'honbu','@出雲店 様 至急、修理業者を手配します。','0','2026-02-26 07:50:36'),(2379,55,2378,'izumo','@島根コンビニ本部 様 修理業者到着。修理完了したので、様子を見ます。','0','2026-02-26 07:52:41'),(2380,55,2379,'honbu','@出雲店 様 了解。その後、不具合があれば、至急連絡願います。','0','2026-02-26 07:54:51'),(2381,55,NULL,'izumo','その後欠損個所に不具合等は見当たらないので、タスクを終了します。','0','2026-02-26 07:56:44'),(2382,8,9,'izumo','@島根コンビニ本部 様 了解です。待ってま～す。','1','2026-02-27 02:15:10'),(2383,10,2376,'izumo','@浜田店 様 おっ疲れさ～ん。','0','2026-02-27 02:16:31'),(2384,10,2383,'hamada','@出雲店 様 ありがとさ～ん。','1','2026-02-27 02:17:50'),(2385,3,NULL,'hamada','ガンバッテマ～ス！頑張り中。','0','2026-03-02 23:14:18'),(2386,5,5,'admin','@安来店 様 了解です。在庫数は十分なので販売促進してください。','0','2026-03-02 23:33:17'),(2387,5,2386,'yasugi','2387  2387  @システム管理者 様 ここはターゲットとなる客層が少ないので、在庫の少ない多店舗に振り分けましょうか？或いは半額セールの対象にする手もあります。','0','2026-03-02 23:39:02'),(2388,5,NULL,'yasugi','半額在庫セールで在庫処分を完了しました。これでこのタスクを終了します。','0','2026-03-03 00:01:04'),(2389,63,NULL,'gotsu','現在店内奥のPOSレジ2台で稼働しています。\r\nランチタイムの混雑時だけ不便です。','0','2026-03-03 23:19:42'),(2390,4,NULL,'admin','特にトイレ周りを重点的にお願いします。','0','2026-03-04 03:45:36'),(2392,4,2390,'masuda','@システム管理者 様 了解しました。','0','2026-03-04 03:52:17'),(2393,7,8,'masuda','@島根コンビニ本部 様 益田店にも配送してください。','0','2026-03-04 03:59:19'),(2394,7,NULL,'masuda','こちらでは特にタコげそパンが好評です。','0','2026-03-04 04:00:45'),(2395,7,2394,'matsue','@益田店 様 我々も作ってみます。','0','2026-03-04 04:01:59');
/*!40000 ALTER TABLE `t_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_task`
--

DROP TABLE IF EXISTS `t_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_task` (
  `task_id` int NOT NULL AUTO_INCREMENT,
  `task_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `category_id` int DEFAULT NULL,
  `limit_date` date DEFAULT NULL,
  `user_id` varchar(24) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status_code` char(2) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `memo` text COLLATE utf8mb4_general_ci,
  `delete_flg` char(1) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `update_datetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`task_id`),
  KEY `category_id` (`category_id`),
  KEY `user_id` (`user_id`),
  KEY `status_code` (`status_code`),
  CONSTRAINT `t_task_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `m_category` (`category_id`),
  CONSTRAINT `t_task_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `m_user` (`user_id`),
  CONSTRAINT `t_task_ibfk_3` FOREIGN KEY (`status_code`) REFERENCES `m_status` (`status_code`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_task`
--

LOCK TABLES `t_task` WRITE;
/*!40000 ALTER TABLE `t_task` DISABLE KEYS */;
INSERT INTO `t_task` VALUES (1,'春のイチゴフェア設営',1,'2026-03-05','matsue','50','什器の設置をお願いします。陳列棚が不足しています。','0','2026-03-03 23:06:49'),(2,'賞味期限チェックの徹底',5,'2026-02-20','izumo','90','期限切れ商品の有無を再確認してください。','0','2026-02-26 01:33:42'),(3,'新発売おにぎり販売促進',1,'2026-03-10','hamada','50','目標販売数を達成しましょう。\r\n頑張ろう！エイエイオ～！！！\r\nヤッホー！','0','2026-03-02 00:06:16'),(4,'深夜時間帯の清掃強化',3,'2026-03-15','masuda','50','床のワックス掛け実施。','0','2026-03-04 03:53:53'),(5,'レジ袋在庫調査',4,'2026-02-15','yasugi','90','在庫数を報告してください。','0','2026-03-03 00:00:00'),(7,'地域限定パンの試食報告',1,'2026-03-02','matsue','50','お客様の反応を教えてください。','0','2026-02-26 00:53:00'),(8,'什器故障の修理対応',2,'2026-02-28','izumo','10','修理業者の手配完了しました。だよ～ん。タッコ～！','0','2026-03-04 00:57:58'),(9,'新店オープン応援依頼',1,'2026-04-01','honbu','00','ヘルプ人員の調整をお願いします。','0','2026-02-26 00:53:00'),(10,'冬物商品撤去作業',4,'2026-02-28','hamada','90','おでん什器の清掃も含みます。','0','2026-02-26 07:40:55'),(55,'菓子パン用陳列棚一部欠損',2,'2026-02-27','izumo','90','現在菓子パン用として使用している陳列棚の一部欠損があります。早急に修理が必要です。','0','2026-02-26 07:56:58'),(58,'棚卸作業完了',11,'2026-04-03','gotsu','50','先月の棚卸データを送りました。チェック後に問題なければ作業を完了します。','0','2026-03-04 00:49:27'),(59,'仮データ',1,'2026-06-30','admin','50','仮データ','0','2026-03-02 07:05:48'),(60,'仮データ',1,'2026-06-30','masuda','00','仮データ','0','2026-03-04 03:42:57'),(61,'仮データ',1,'2026-06-30','admin','50','仮データ','0','2026-03-02 07:05:55'),(62,'接客マニュアルの見直し作業',8,'2026-06-30','masuda','90','顧客の要望が多い点について、接客マニュアルの見直し作業を行うことにしました。','0','2026-03-04 00:53:45'),(63,'POSレジ故障修理依頼',10,'2026-04-01','yasugi','10','入り口側POSレジ1台が故障中です。','0','2026-03-03 23:20:37'),(64,'トイレットペーパーの在庫確認',11,'2026-03-20','gotsu','50','男子トイレのトイレットペーパーの在庫確認を行いました。在庫数20巻で問題ありません。','0','2026-03-03 08:17:36'),(65,'タコム～チョ発注依頼',9,'2026-03-04','admin','00','タコム～チョの在庫が切れそうです。\r\n80ケース発注お願いします','0','2026-03-03 23:23:15'),(66,'自動生成タスク No.19',11,'2026-04-09','admin','10','あいうえお','0','2026-03-04 03:41:49'),(73,'仮タスク',5,'2026-03-05','masuda','10','仮データ','0','2026-03-04 03:33:52');
/*!40000 ALTER TABLE `t_task` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-05  9:03:40
