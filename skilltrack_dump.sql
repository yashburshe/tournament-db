CREATE DATABASE  IF NOT EXISTS `skilltrack` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `skilltrack`;
-- MySQL dump 10.13  Distrib 8.0.38, for macos14 (arm64)
--
-- Host: localhost    Database: skilltrack
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `game`
--

DROP TABLE IF EXISTS `game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tournament_name` varchar(100) DEFAULT NULL,
  `date` date NOT NULL,
  `team1` varchar(100) DEFAULT NULL,
  `team2` varchar(100) DEFAULT NULL,
  `team1_score` int NOT NULL,
  `team2_score` int NOT NULL,
  `map` varchar(100) DEFAULT NULL,
  `time` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_game_tournament` (`tournament_name`),
  KEY `fk_game_team1` (`team1`),
  KEY `fk_game_team2` (`team2`),
  CONSTRAINT `fk_game_team1` FOREIGN KEY (`team1`) REFERENCES `team` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_game_team2` FOREIGN KEY (`team2`) REFERENCES `team` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_game_tournament` FOREIGN KEY (`tournament_name`) REFERENCES `tournament` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game`
--

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;
/*!40000 ALTER TABLE `game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player`
--

DROP TABLE IF EXISTS `player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player` (
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `ign` varchar(100) NOT NULL,
  `nationality` varchar(100) NOT NULL,
  `date_of_birth` date NOT NULL,
  `status` enum('Active','Retired') NOT NULL,
  `year_started` year NOT NULL,
  `year_ended` year DEFAULT NULL,
  `total_winning` int DEFAULT NULL,
  PRIMARY KEY (`ign`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
INSERT INTO `player` VALUES ('Aleksi','Antti Kaarlo Virolainen','Aleksib','Finland','1997-03-30','Active',2015,NULL,784973),('Alistair','Johnston','aliStair','Australia','1998-04-07','Active',2015,NULL,97156),('Андрій','Прохоров','Andi','Ukraine','1986-09-03','Retired',2013,2017,40),('Dan','Madesclaire','apEX','France','1993-02-22','Active',2009,NULL,1619037),('Артем','Харитонов','ArtFr0st','Russia','2001-11-27','Active',2020,NULL,92656),('Johannes','Borup','b0RUP','Denmark','1999-09-29','Active',2015,NULL,221118),('Андрій','Олексійович Городенський','B1ad3','Ukraine','1986-11-11','Active',2003,NULL,88738),('Валерій','Євгенійович Ваховський','b1t','Ukraine','2003-01-05','Active',2019,NULL,1376705),('Benjamin','Vang Bremer','blameF','Denmark','1997-06-10','Active',2015,NULL,360215),('Даулет','Ондасынов','BLVCKM4GIC','Kazakhstan','2004-06-28','Active',2020,NULL,5866),('Alexandre','Pierre Pianaro','bodyy','France','1997-01-08','Active',2013,NULL,398867),('Кирилл','Сергеевич Михайлов','Boombl4','Russia','1998-12-20','Active',2016,NULL,1139397),('Mohammad','Malhas','BOROS','Jordan','2004-05-04','Active',2019,NULL,83964),('Vincent','Cayonte','Brehze','United States','1998-05-22','Active',2015,NULL,428828),('Helvijs','Saukants','broky','Latvia','2001-02-14','Active',2017,NULL,1164952),('Ludvig','William Brolin','Brollan','Sweden','2002-06-17','Active',2016,NULL,567686),('Christian','Møss Andersen','Buzz','Denmark','2003-03-14','Active',2020,NULL,106822),('Casper','Alexander Ahm Møller','cadiaN','Denmark','1995-06-26','Active',2011,NULL,667205),('Peter','Toftbo Ardenskjold','casle','Denmark','1986-09-04','Active',2009,NULL,1050),('Арсеній','Триноженко','ceh9','Ukraine','1989-01-03','Retired',2008,2013,84263),('Леонид','Вишняков','chopper','Russia','1997-02-04','Active',2013,NULL,593164),('Damian','Steele','daps','Canada','1993-07-28','Active',2012,NULL,260928),('Санжар','Талгат','def1zer','Kazakhstan','2004-06-19','Active',2021,NULL,14076),('Nicolai','Hvilshøj Reedtz','dev1ce','Denmark','1995-09-08','Active',2009,NULL,2073978),('Christopher','Nong','dexter','Australia','1994-08-15','Active',2015,NULL,211510),('Oliver','Tierney','DickStacy','Australia','1997-04-16','Retired',2016,2020,50410),('Данил','Крышковец','donk','Russia','2007-01-25','Active',2021,NULL,375104),('Peter','Rothmann Rasmussen','dupreeh','Denmark','1993-03-26','Active',2012,NULL,2237617),('Paweł','Mateusz Dycha','dycha','Poland','1997-08-11','Active',2017,NULL,345388),('Іоанн','Сухарєв','Edward','Ukraine','1987-12-28','Retired',2001,2023,715185),('Денис','Раилевич Шарипов','electroNic','Russia','1998-09-02','Active',2015,NULL,1644788),('Niclas','Krumhorn','enkay J','Germany','1989-06-26','Active',2012,NULL,6982),('Justin','Coakley','FaNg','Canada','2002-05-07','Active',2018,NULL,111253),('שחר','שושן','flameZ','Israel','2003-06-22','Active',2017,NULL,555934),('Егор','Сергеевич Васильев','flamie','Russia','1997-04-05','Active',2012,NULL,1050468),('David','Čerňanský','frozen','Slovakia','2002-07-18','Active',2015,NULL,650644),('Lukas','Egholm Rossander','gla1ve','Denmark','1995-06-07','Active',2010,NULL,1932731),('Krzysztof','Górski','Goofy','Poland','2000-08-29','Active',2017,NULL,109199),('Ladislav','Kovács','GuardiaN','Slovakia','1991-07-09','Active',2006,NULL,799326),('Aleksander','Filip Miśkiewicz','hades','Poland','2000-01-01','Active',2018,NULL,163995),('Сергей','Шаваев','hally','Russia','1993-07-06','Active',2007,NULL,8341),('Jordan','Bajic','Hatz','Australia','1998-06-20','Active',2015,NULL,72675),('Jadan','Postma','HexT','Canada','2001-10-30','Active',2017,NULL,51827),('Немања','Ковач','huNter-','Bosnia and Herzegovina','1996-01-03','Active',2015,NULL,964883),('Кайсар','Файзнуров','ICY','Kazakhstan','2005-06-01','Active',2020,NULL,23070),('Mihai','Ivan','iM','Romania','1999-07-29','Active',2018,NULL,472886),('Joshua','Potter','INS','Australia','1998-09-22','Active',2015,NULL,116319),('Jakob','Nygaard Sørensen','jabbi','Denmark','2003-07-23','Active',2018,NULL,348898),('Jeorge','Endicott','Jeorge','United States','2003-04-14','Active',2020,NULL,65012),('Jimi','Joonas Salo','Jimpphat','Finland','2006-09-09','Active',2019,NULL,301251),('Justin','Kyle Savage','jks','Australia','1995-12-12','Active',2010,NULL,691466),('Justinas','Lekavičius','jL','Lithuania','1999-09-29','Active',2018,NULL,449825),('Михайло','Олексійович Благін','kane','Ukraine','1986-01-04','Active',2001,NULL,12235),('Finn','Andersen','karrigan','Denmark','1990-04-14','Active',2006,NULL,2016752),('Антон','Колесников','kibaken','Russia','1992-11-26','Active',2010,NULL,35744),('David','Kingsford','Kingfisher','Australia','1996-10-16','Active',2016,NULL,562),('Laurențiu','Țârlea','lauNX','Romania','2005-05-10','Active',2020,NULL,34313),('John','James Tregillgas','Liazz','Australia','1997-08-30','Active',2015,NULL,167749),('Илья','Осипов','m0NESY','Russia','2005-05-01','Active',2019,NULL,668348),('Павле','Бошковић','maden','Montenegro','1998-11-12','Active',2016,NULL,342466),('Emil','Hoffmann Reif','Magisk','Denmark','1998-03-05','Active',2015,NULL,1933407),('Борис','Воробьев','magixx','Russia','2003-06-03','Active',2018,NULL,548820),('Mario','Alberto Samayoa Díaz','malbsMd','Guatemala','2002-10-17','Active',2015,NULL,256493),('Sergei','Li','malinger','Kazakhstan','2006-08-06','Active',2022,NULL,0),('Liam','Schembri','malta','Australia','1995-11-01','Retired',2015,2023,104813),('Єгор','Вадимович Маркелов','markeloff','Ukraine','1988-02-12','Retired',2004,2018,168274),('William','Merriman','mezii','United Kingdom','1998-10-15','Active',2016,NULL,430358),('Miłosz','Knasiak','mhL','Poland','2002-03-03','Active',2018,NULL,65046),('Torbjørn','Nyborg','mithR','Denmark','1989-11-16','Active',2013,NULL,243),('Keith','Jordan Markovic','NAF','Canada','1997-11-24','Active',2013,NULL,1281049),('Nathan','Jordan Schmitt','NBK-','France','1994-06-05','Active',2009,NULL,861137),('Ryan','Aubry','Neityu','France','2005-08-03','Active',2021,NULL,40450),('Filip','Borys Kubski','NEO','Poland','1987-06-15','Active',2000,NULL,758773),('גיא','אילוז','NertZ','Israel','1999-07-12','Active',2015,NULL,248739),('Немања','Исаковић','nexa','Serbia','1997-04-25','Active',2013,NULL,489114),('Никола','Ковач','NiKo','Bosnia and Herzegovina','1997-02-16','Active',2009,NULL,1658683),('Nicholas','Cannella','nitr0','United States','1995-08-16','Active',2014,NULL,1057447),('Joshua','Ohm','oSee','United States','1999-05-31','Active',2016,NULL,254236),('Steeve','Flavigni','Ozstrik3r','France','1978-11-20','Active',2000,NULL,11177),('Роберт','Исянов','Patsi','Russia','2003-09-06','Active',2016,NULL,111994),('Илья','Залуцкий','Perfecto','Non-representing','1999-11-24','Active',2018,NULL,1199787),('Paavo','Heiskanen','podi','Finland','2004-08-05','Active',2021,NULL,34034),('Данияр','Бұлдыбаев','Pumpkin66','Kazakhstan','2006-09-07','Active',2022,NULL,8943),('Mathias','Pinholt','R0nic','Denmark','2000-10-17','Active',2016,NULL,1426),('Håvard','Liset Nygaard','rain','Norway','1994-08-27','Active',2013,NULL,1775757),('Алекс','Огнянов Петров','Rainwaker','Bulgaria','2001-04-27','Active',2017,NULL,124964),('Robin','Kool','ropz','Estonia','1999-12-22','Active',2015,NULL,1518477),('Casper','Thrane Due','ruggah','Denmark','1988-09-01','Active',2008,NULL,4174),('Олександр','Олегович Костилєв','s1mple','Ukraine','1997-10-02','Active',2013,NULL,1727447),('Eetu','Juho Oskari Saha','sAw','Finland','1992-07-30','Active',2013,NULL,112660),('Віктор','Оруджев','sdy','Ukraine','1997-03-14','Active',2016,NULL,383427),('Денис','Валерьевич Костин','seized','Russia','1994-09-09','Retired',2009,2024,380205),('Дмитрий','Эдуардович Соколов','sh1ro','Russia','2001-07-15','Active',2018,NULL,916831),('Simon','Williams','Sico','New Zealand','1994-08-08','Active',2014,NULL,87251),('Kamil','Tomasz Szkaradek','siuhy','Poland','2002-08-26','Active',2018,NULL,383752),('Felipe','Frank Medeiros','skullz','Brazil','2002-04-20','Active',2017,NULL,114216),('Marco','Pfeiffer','Snappi','Denmark','1990-06-09','Active',2008,NULL,453175),('Janusz','Andrzej Pogorzelski','Snax','Poland','1993-07-05','Active',2010,NULL,899968),('לוטן','גלעדי','Spinx','Israel','2000-09-13','Active',2019,NULL,748800),('Victor','Staehr Hansen','Staehr','Denmark','2004-07-19','Active',2020,NULL,124316),('Сергій','Іщук','starix','Ukraine','1987-12-14','Active',2001,NULL,126661),('Martin','Lund','stavn','Denmark','2002-03-26','Active',2016,NULL,623615),('Alvaro','Fernández Garcia','SunPayus','Spain','1998-11-19','Active',2018,NULL,261769),('Jan','Müller','Swani','Germany','1995-03-13','Retired',2021,2023,0),('Dennis','Benthin Nielsen','sycrone','Denmark','1996-02-11','Active',2015,NULL,16230),('Әлішер','Марат','tasman','Kazakhstan','2005-09-03','Active',2022,NULL,6618),('Wiktor','Jerzy Wojtas','TaZ','Poland','1986-06-06','Active',2001,NULL,744027),('Темірлан','Нұрмағамет','TNDKingg','Kazakhstan','2001-03-26','Active',2019,NULL,3711),('Ádám','Torzsás','torzsi','Hungary','2002-05-17','Active',2016,NULL,386493),('Russel','David Kevin Van Dulken','Twistzz','Canada','1999-11-14','Active',2015,NULL,1742689),('Roland','Tomkowiak','ultimate','Poland','2003-11-29','Active',2020,NULL,33770),('Ігор','Жданов','w0nderful','Ukraine','2004-12-14','Active',2020,NULL,404406),('Colby','Walsh','Walco','Canada','2001-11-12','Active',2017,NULL,43300),('דוריאן','ברמן','xertioN','Israel','2004-07-22','Active',2018,NULL,373785),('Kacper','Gabara','xKacpersky','Poland','2006-10-22','Active',2022,NULL,27870),('Rémy','Quoniam','XTQZZZ','France','1988-12-23','Active',2009,NULL,165),('Andreas','Højsleth','Xyp9x','Denmark','1995-09-11','Active',2011,NULL,2015280),('Mareks','Gaļinskis','YEKINDAR','Latvia','1999-10-04','Active',2017,NULL,487981),('Данило','Ігорович Тесленко','Zeus','Ukraine','1987-10-08','Active',2002,NULL,786150),('Wilton','Prado','zews','Brazil','1987-11-03','Active',2002,NULL,41055),('Danny','Selim Sørensen','zonic','Denmark','1986-07-30','Active',2003,NULL,119684),('Myroslav','Plakhotja','zont1x','Ukraine','2005-07-20','Active',2020,NULL,372134),('Mathieu','Herbaut','ZywOo','France','2000-11-09','Active',2016,NULL,1137710);
/*!40000 ALTER TABLE `player` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_statistics_per_game`
--

DROP TABLE IF EXISTS `player_statistics_per_game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_statistics_per_game` (
  `game_id` int NOT NULL,
  `team_name` varchar(100) NOT NULL,
  `player_ign` varchar(100) NOT NULL,
  `kills` int NOT NULL,
  `deaths` int NOT NULL,
  `assists` int NOT NULL,
  PRIMARY KEY (`game_id`,`team_name`,`player_ign`),
  KEY `fk_stats_team` (`team_name`),
  KEY `fk_stats_ign` (`player_ign`),
  CONSTRAINT `fk_stats_gameid` FOREIGN KEY (`game_id`) REFERENCES `game` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_stats_ign` FOREIGN KEY (`player_ign`) REFERENCES `player` (`ign`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_stats_team` FOREIGN KEY (`team_name`) REFERENCES `team` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_statistics_per_game`
--

LOCK TABLES `player_statistics_per_game` WRITE;
/*!40000 ALTER TABLE `player_statistics_per_game` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_statistics_per_game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_team`
--

DROP TABLE IF EXISTS `player_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_team` (
  `player_ign` varchar(100) NOT NULL,
  `team_name` varchar(100) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`player_ign`,`team_name`,`start_date`),
  KEY `fk_team` (`team_name`),
  CONSTRAINT `fk_ign` FOREIGN KEY (`player_ign`) REFERENCES `player` (`ign`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_team` FOREIGN KEY (`team_name`) REFERENCES `team` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `player_team_chk_1` CHECK ((`start_date` < `end_date`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_team`
--

LOCK TABLES `player_team` WRITE;
/*!40000 ALTER TABLE `player_team` DISABLE KEYS */;
INSERT INTO `player_team` VALUES ('Aleksib','Natus Vincere','2023-06-30',NULL),('aliStair','Renegades','2021-02-13',NULL),('Andi','Natus Vincere','2017-03-10','2017-08-09'),('apEX','Team Vitality','2018-10-08',NULL),('ArtFr0st','Team Spirit','2023-07-05','2024-01-07'),('b0RUP','Astralis','2023-06-22','2023-12-31'),('B1ad3','Natus Vincere','2019-09-20',NULL),('b1t','Natus Vincere','2020-12-20',NULL),('blameF','Astralis','2021-11-04','2024-05-14'),('BLVCKM4GIC','AVANGAR','2023-02-06',NULL),('bodyy','Team Falcons','2023-01-24','2023-11-27'),('Boombl4','Natus Vincere','2019-05-29','2023-01-01'),('BOROS','Team Falcons','2023-06-20','2024-07-10'),('Brehze','NRG','2023-11-28',NULL),('broky','FaZe Clan','2019-09-26',NULL),('Brollan','MOUZ','2024-01-09',NULL),('Buzz','Astralis','2022-12-22','2024-05-01'),('cadiaN','Astralis','2024-09-17',NULL),('cadiaN','Team Liquid','2023-12-06','2024-09-17'),('casle','Astralis','2022-12-20','2023-12-20'),('ceh9','Natus Vincere','2012-11-04','2013-12-09'),('chopper','Team Spirit','2019-03-03',NULL),('daps','NRG','2023-11-28','2024-03-06'),('daps','NRG','2024-03-06',NULL),('daps','Team Liquid','2022-06-20','2023-11-20'),('def1zer','AVANGAR','2023-02-06',NULL),('dev1ce','Astralis','2022-10-27',NULL),('dexter','Renegades','2019-12-03','2021-02-10'),('DickStacy','Renegades','2019-12-03','2020-01-08'),('donk','Team Spirit','2023-07-05',NULL),('dupreeh','Team Vitality','2022-01-05','2023-10-23'),('dycha','ENCE','2021-01-21','2024-07-10'),('Edward','Natus Vincere','2012-11-04','2013-07-19'),('Edward','Natus Vincere','2013-12-09','2019-12-31'),('electroNic','Natus Vincere','2017-11-06','2023-07-14'),('enkay J','ENCE','2024-09-09',NULL),('FaNg','NRG','2023-11-28','2024-03-07'),('flameZ','Team Vitality','2023-06-22',NULL),('flamie','Natus Vincere','2015-03-17','2015-04-10'),('flamie','Natus Vincere','2015-04-10','2021-09-16'),('frozen','FaZe Clan','2023-12-04',NULL),('frozen','MOUZ','2019-03-14','2023-12-04'),('gla1ve','Astralis','2016-10-24','2023-11-22'),('gla1ve','ENCE','2023-11-27',NULL),('Goofy','ENCE','2023-12-17','2024-09-19'),('GuardiaN','Natus Vincere','2013-12-09','2017-08-03'),('GuardiaN','Natus Vincere','2019-09-20','2021-02-12'),('hades','ENCE','2023-12-17','2024-07-10'),('hally','Team Spirit','2022-02-06',NULL),('Hatz','Renegades','2020-01-12',NULL),('HexT','NRG','2023-11-28',NULL),('huNter-','G2 Esports','2019-09-30',NULL),('ICY','AVANGAR','2021-11-29','2023-12-28'),('iM','Natus Vincere','2023-06-30',NULL),('INS','Renegades','2019-12-03',NULL),('jabbi','Astralis','2023-11-24',NULL),('Jeorge','NRG','2024-11-22',NULL),('Jimpphat','MOUZ','2023-07-11',NULL),('jks','G2 Esports','2022-08-16','2024-02-26'),('jks','Team Liquid','2024-07-12',NULL),('jL','Natus Vincere','2023-06-30',NULL),('kane','Natus Vincere','2017-08-09','2019-09-14'),('karrigan','FaZe Clan','2021-02-15',NULL),('kibaken','Natus Vincere','2013-08-20','2013-12-09'),('Kingfisher','Renegades','2021-06-30',NULL),('lauNX','Team Falcons','2023-06-20','2024-06-07'),('Liazz','Renegades','2022-02-13',NULL),('m0NESY','G2 Esports','2022-01-03',NULL),('maden','ENCE','2022-01-21','2023-12-16'),('Magisk','Team Falcons','2023-12-16',NULL),('Magisk','Team Vitality','2022-01-05','2023-12-16'),('magixx','Team Spirit','2019-09-26',NULL),('malbsMd','G2 Esports','2024-06-28',NULL),('malinger','AVANGAR','2021-11-29',NULL),('malta','Renegades','2019-12-03','2021-12-16'),('markeloff','Natus Vincere','2012-11-04','2013-07-18'),('mezii','Team Vitality','2023-11-08',NULL),('mhL','Team Falcons','2023-06-20','2024-07-13'),('mithR','Renegades','2020-07-02','2020-11-14'),('mithR','Team Liquid','2024-07-11',NULL),('NAF','Team Liquid','2018-02-05',NULL),('NBK-','Team Falcons','2022-08-14','2024-06-07'),('Neityu','ENCE','2024-10-11',NULL),('NEO','FaZe Clan','2023-07-27','2023-11-19'),('NEO','FaZe Clan','2023-11-19',NULL),('NertZ','ENCE','2023-02-16','2023-12-17'),('nexa','G2 Esports','2023-11-21','2024-07-03'),('NiKo','G2 Esports','2020-10-28',NULL),('nitr0','NRG','2024-07-04',NULL),('nitr0','Team Liquid','2022-01-15','2024-01-04'),('oSee','NRG','2023-11-28',NULL),('oSee','Team Liquid','2021-12-27','2023-11-28'),('Ozstrik3r','Team Falcons','2022-02-21','2023-10-31'),('Patsi','Team Liquid','2023-06-22','2023-11-18'),('Perfecto','Natus Vincere','2020-01-24','2023-07-14'),('podi','ENCE','2024-05-29',NULL),('Pumpkin66','AVANGAR','2023-06-01',NULL),('R0nic','Astralis','2024-01-23','2024-02-28'),('rain','FaZe Clan','2016-01-20',NULL),('Rainwaker','Team Liquid','2023-06-22','2023-11-22'),('ropz','FaZe Clan','2022-01-03',NULL),('ruggah','Astralis','2024-03-01',NULL),('s1mple','Team Falcons','2024-09-27','2024-11-21'),('sAw','ENCE','2020-11-05','2023-11-26'),('sdy','ENCE','2024-05-29',NULL),('sdy','Natus Vincere','2022-06-03','2022-12-30'),('seized','Natus Vincere','2013-08-20','2018-01-14'),('sh1ro','Team Spirit','2023-12-17',NULL),('Sico','Renegades','2019-12-03',NULL),('siuhy','MOUZ','2023-07-03',NULL),('skullz','Team Liquid','2023-12-04','2024-07-09'),('Snappi','ENCE','2021-01-21','2023-11-26'),('Snax','G2 Esports','2024-07-03',NULL),('Spinx','Team Vitality','2022-08-15',NULL),('Staehr','Astralis','2023-06-22',NULL),('starix','Natus Vincere','2012-11-04','2015-03-17'),('starix','Natus Vincere','2015-03-17','2017-03-10'),('stavn','Astralis','2023-11-24',NULL),('SunPayus','ENCE','2022-08-20','2023-12-16'),('Swani','G2 Esports','2023-01-20','2023-12-16'),('sycrone','MOUZ','2022-01-06',NULL),('tasman','AVANGAR','2023-12-20',NULL),('TaZ','G2 Esports','2023-12-11',NULL),('TNDKingg','AVANGAR','2023-02-06',NULL),('torzsi','MOUZ','2022-01-03',NULL),('Twistzz','FaZe Clan','2021-01-30','2023-12-01'),('Twistzz','Team Liquid','2023-12-07',NULL),('ultimate','Team Liquid','2024-07-12',NULL),('w0nderful','Natus Vincere','2023-10-31',NULL),('Walco','NRG','2024-03-06','2024-07-04'),('xertioN','MOUZ','2022-08-26',NULL),('xKacpersky','ENCE','2024-10-11',NULL),('XTQZZZ','Team Vitality','2023-10-13',NULL),('Xyp9x','Astralis','2016-01-18','2024-03-11'),('YEKINDAR','Team Liquid','2022-10-18',NULL),('Zeus','Natus Vincere','2012-11-04','2016-10-12'),('Zeus','Natus Vincere','2017-08-09','2019-09-14'),('zews','Team Liquid','2023-12-05','2024-06-25'),('zonic','Team Falcons','2023-11-01',NULL),('zonic','Team Vitality','2022-01-05','2023-10-11'),('zont1x','Team Spirit','2023-07-05',NULL),('ZywOo','Team Vitality','2018-10-08',NULL);
/*!40000 ALTER TABLE `player_team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team` (
  `name` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
INSERT INTO `team` VALUES ('Astralis','Denmark'),('AVANGAR','Kazakhstan'),('ENCE','Finland'),('FaZe Clan','United States'),('G2 Esports','Germany'),('MOUZ','Germany'),('Natus Vincere','Ukraine'),('NRG','United States'),('Renegades','United States'),('Team Falcons','Saudi Arabia'),('Team Liquid','Netherlands'),('Team Spirit','Serbia'),('Team Vitality','France');
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tournament`
--

DROP TABLE IF EXISTS `tournament`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tournament` (
  `name` varchar(100) NOT NULL,
  `organizer` varchar(100) DEFAULT NULL,
  `series` varchar(100) NOT NULL,
  `tier` enum('A-Tier','B-Tier','C-Tier','S-Tier','Major') NOT NULL,
  `type` enum('Offline','Online') NOT NULL,
  `prize_pool` int NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `venue` varchar(100) NOT NULL,
  PRIMARY KEY (`name`),
  KEY `fk_venue` (`venue`),
  CONSTRAINT `fk_venue` FOREIGN KEY (`venue`) REFERENCES `venue` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `tournament_chk_1` CHECK ((`start_date` < `end_date`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tournament`
--

LOCK TABLES `tournament` WRITE;
/*!40000 ALTER TABLE `tournament` DISABLE KEYS */;
INSERT INTO `tournament` VALUES ('Intel Extreme Masters Katowice 2024','ESL','Intel Grand Slam','S-Tier','Offline',1000000,'2024-01-31','2024-02-11','Spodek Arena'),('StarLadder Berlin Major 2019','StarLadder','StarLadder','Major','Offline',1000000,'2019-08-23','2019-09-08','Mercedes-Benz Arena');
/*!40000 ALTER TABLE `tournament` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tournament_team`
--

DROP TABLE IF EXISTS `tournament_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tournament_team` (
  `team_name` varchar(100) NOT NULL,
  `tournament_name` varchar(100) NOT NULL,
  PRIMARY KEY (`team_name`,`tournament_name`),
  KEY `fk_tournament` (`tournament_name`),
  CONSTRAINT `fk_tournament` FOREIGN KEY (`tournament_name`) REFERENCES `tournament` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_tournament_team` FOREIGN KEY (`team_name`) REFERENCES `team` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tournament_team`
--

LOCK TABLES `tournament_team` WRITE;
/*!40000 ALTER TABLE `tournament_team` DISABLE KEYS */;
/*!40000 ALTER TABLE `tournament_team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venue`
--

DROP TABLE IF EXISTS `venue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `venue` (
  `name` varchar(100) NOT NULL,
  `street_number` int NOT NULL,
  `street_name` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `zip_code` varchar(20) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venue`
--

LOCK TABLES `venue` WRITE;
/*!40000 ALTER TABLE `venue` DISABLE KEYS */;
INSERT INTO `venue` VALUES ('Accor Arena',8,'Boulevard de Bercy','Paris','Île-de-France','France','75012'),('Agganis Arena',925,'Commonwealth Avenue','Boston','Massachusetts','USA','02215'),('Antwerpen Sportpaleis',119,'Schijnpoortweg','Antwerp','Antwerp','Belgium','2170'),('Avicii Arena',2,'Globentorget','Stockholm','Stockholm','Sweden','12177'),('Elmia Convention Center',11,'Elmiavägen','Jönköping','Jönköping','Sweden','553 13'),('Fox Theatre',660,'Peachtree Street NE','Atlanta','Georgia','USA','30308'),('Jeunesse Arena',3401,'Avenida Embaixador Abelardo Bueno','Rio de Janeiro','Rio de Janeiro','Brazil','22775-040'),('Lanxess Arena',1,'Willy-Brandt-Platz','Cologne','Cologne','Germany','50679'),('Mercedes-Benz Arena',1,'Mercedes-Platz','Berlin','Berlin','Germany','10243'),('Nationwide Arena',200,'Nationwide Blvd','Columbus','Ohio','USA','43215'),('Sala Polivalentă',134,'Calea Piscului','Cluj-Napoca','Cluj','Romania','040307'),('Spodek Arena',35,'Aleja Korfantego','Katowice','Silesian Voivodeship','Poland','40-005'),('Tauron Arena Kraków',7,'Stanisława Lema','Kraków','Małopolskie','Poland','31-571'),('Wembley Arena',8,'Arena Square','London','London','United Kingdom','HA9 0AA');
/*!40000 ALTER TABLE `venue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'skilltrack'
--

--
-- Dumping routines for database 'skilltrack'
--
/*!50003 DROP PROCEDURE IF EXISTS `AddPlayer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddPlayer`(
    in p_first_name varchar(100),
    in p_last_name varchar(100),
    in p_ign varchar(100),
    in p_nationality varchar(100),
    in p_dob DATE,
    in p_status ENUM('Active', 'Retired'),
    in p_year_started YEAR,
    in p_year_ended YEAR,
    in p_total_winning INT
)
begin

if p_dob > CAST(CONCAT(p_year_started, '-01-01') as date) then signal sqlstate '45000'
set
    message_text = 'Year started has to be after player\'s date of birth';

end if;

if p_year_ended is not null
and p_year_ended < p_year_started then signal sqlstate '45000'
set
    message_text = 'Year ended has to be after year started';

end if;

if p_status = 'Active'
and p_year_ended is not null then signal sqlstate '45000'
set
    message_text = 'Player cannot be active and have an end date';

end if;

if p_status = 'Retired'
and p_year_ended is null then signal sqlstate '45000'
set
    message_text = 'Player cannot be retired and not have an end date';

end if;

insert into
    player (
        first_name,
        last_name,
        ign,
        nationality,
        date_of_birth,
        status,
        year_started,
        year_ended,
        total_winning
    )
values
    (
        p_first_name,
        p_last_name,
        p_ign,
        p_nationality,
        p_dob,
        p_status,
        p_year_started,
        p_year_ended,
        p_total_winning
    );

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddPlayerToTeam` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddPlayerToTeam`(
    in p_ign varchar(100),
    in p_team_name varchar(100),
    in p_start_date date,
    in p_end_date date
)
begin
if not exists (
    select
        1
    from
        player
    where
        ign = p_ign
) then signal sqlstate '45000'
set
    message_text = 'The specified player does not exist.';

else 
if not exists (
    select
        1
    from
        team
    where
        name = p_team_name
) then signal sqlstate '45000'
set
    message_text = 'The specified team does not exist.';

else
insert into
    player_team (player_ign, team_name, start_date, end_date)
values
    (p_ign, p_team_name, p_start_date, p_end_date);

end if;

end if;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddRoleToPlayer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddRoleToPlayer`(
    IN ign varchar(100),
    IN role varchar(100)
)
begin if exists (
    select
        1
    from
        player
    where
        ign = ign
) then signal sqlstate '45000'
set
    message_text = 'The specified player does not exist.';

else
if not exists (
    select
        1
    from
        role
    where
        name = role
) then signal sqlstate '45000'
set
    message_text = 'The specified role does not exist.';

else
insert into
    player_roles (player_ign, role)
values
    (ign, role);

end if;

end if;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddTeam` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddTeam`( in team_name varchar(100), in team_country varchar(100) )
begin
   insert into
      team (name, country) 
   values
      (
         team_name,
         team_country
      )
;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddTournament` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddTournament`( in t_name varchar(100), in t_organizer varchar(100), in t_series varchar(100), in t_tier enum('A-Tier', 'B-Tier', 'C-Tier', 'S-Tier', 'Major'), in t_type enum('Offline', 'Online'), in t_prize_pool int, in t_start_date date, in t_end_date date, in t_venue varchar(100) )
begin
   insert into
      tournament ( name, organizer, series, tier, type, prize_pool, start_date, end_date, venue ) 
   values
      (
         t_name,
         t_organizer,
         t_series,
         t_tier,
         t_type,
         t_prize_pool,
         t_start_date,
         t_end_date,
         t_venue 
      )
;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddVenue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddVenue`(
    IN venue_name VARCHAR(100),
    IN venue_street_number INT,
    IN venue_street_name VARCHAR(100),
    IN venue_city VARCHAR(100),
    IN venue_state VARCHAR(100),
    IN venue_country VARCHAR(100),
    IN venue_zip_code VARCHAR(20)
)
BEGIN
    IF EXISTS (SELECT 1 FROM venue WHERE name = venue_name) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A venue with this name already exists';
    ELSE
        INSERT INTO venue (name, street_number, street_name, city, state, country, zip_code)
        VALUES (venue_name, venue_street_number, venue_street_name, venue_city, venue_state, venue_country, venue_zip_code);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteGame` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteGame`( in p_game_id int )
begin
   delete
   from
      player_statistics_per_game 
   where
      game_id = p_game_id;
delete
from
   game 
where
   id = p_game_id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteTeam` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteTeam`(in team_name varchar(100))
begin
   delete
   from
      team 
   where
      name = team_name;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteTournament` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteTournament`(in tournament_name_param varchar(100))
begin
   delete
   from
      player_statistics_per_game 
   where 
      game_id in 
      (
         select
            id 
         from
            game 
         where
            tournament_name = tournament_name_param 
      )
;
delete
from
   game 
where
   tournament_name = tournament_name_param;
delete
from
   tournament_team 
where
   tournament_name = tournament_name_param;
delete
from
   tournament 
where
   name = tournament_name_param;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteVenue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteVenue`(
    IN venue_name VARCHAR(100)
)
BEGIN
    IF EXISTS (SELECT 1 FROM tournament WHERE venue = venue_name) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'This venue is associated to a tournament';
    ELSE
        delete from venue where name = venue_name;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllActivePlayers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllActivePlayers`()
begin
SELECT ign from player where status = "Active";
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllActiveTeamPlayers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllActiveTeamPlayers`(in p_team_name varchar(100))
begin
select
    p.first_name,
    p.last_name,
    p.ign,
    pt.team_name,
    pt.start_date
from
    player_team pt
    join player p on pt.player_ign = p.ign
where
    pt.team_name = p_team_name
    and pt.end_date is null;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllGames` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllGames`()
begin
   select
      * 
   from
      game;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllInActiveTeamPlayers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllInActiveTeamPlayers`(in p_team_name varchar(100))
begin
select
    p.first_name,
    p.last_name,
    p.ign,
    pt.team_name,
    pt.start_date,
    pt.end_date
from
    player_team pt
    join player p on pt.player_ign = p.ign
where
    pt.team_name = p_team_name
    and pt.end_date is not null;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllPlayers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllPlayers`()
begin
select
    ign,
    first_name,
    last_name,
    status
from
    player;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllPlayersInTeams` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllPlayersInTeams`()
begin
select
    p.ign, pt.team_name
from
    player_team pt
    join player p on pt.player_ign = p.ign
where pt.end_date is null;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllTeams` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllTeams`()
begin
   select
      name 
   from
      team;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllTournaments` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllTournaments`()
begin
   select
      name 
   from
      tournament;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllVenues` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllVenues`(
)
BEGIN
    select name from venue;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetGame` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetGame`( in p_game_id int )
begin
   select
      * 
   from
      game 
   where
      id = p_game_id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetInactivePlayers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetInactivePlayers`()
begin
with t as (
    select player_ign
    from player_team 
    where end_date is null
)
select distinct p.*
from player p
left join player_team pt on p.ign = pt.player_ign
where p.ign not in (select player_ign from t) and status = 'Active';

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPlayer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPlayer`(in p_ign varchar(100))
begin
select *
from player
where ign = p_ign;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPlayerStatsForGame` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPlayerStatsForGame`( in p_game_id int )
begin
   select
      * 
   from
      player_statistics_per_game 
   where
      game_id = p_game_id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPlayerTeamHistory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPlayerTeamHistory`(
	in p_ign varchar(100)
)
begin
	select team_name, start_date, end_date from player join player_team on player_ign = ign where ign = p_ign;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetTeam` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTeam`(in team_name varchar(100))
begin
   select
      * 
   from
      team 
   where
      name = team_name;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetTournamentDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTournamentDetails`(in tournament_name varchar(100))
begin
   select
      * 
   from
      tournament 
   where
      name = tournament_name;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetTournamentGames` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTournamentGames`( in p_tournament_name varchar(100) )
begin
   select
      * 
   from
      game 
   where
      p_tournament_name = tournament_name;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetVenue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetVenue`(
in venue_name varchar(100)
)
BEGIN
    select * from venue where name = venue_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertGame` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertGame`( in p_tournament_name varchar(100), in p_date date, in p_team1 varchar(100), in p_team2 varchar(100), in p_team1_score int, in p_team2_score int, in p_map varchar(100), in p_time time )
begin
   declare tournament_start date;
declare tournament_end date;
select
   start_date,
   end_date into tournament_start,
   tournament_end 
from
   tournament 
where
   name = p_tournament_name;
if p_date between tournament_start and tournament_end 
then
   insert into
      game ( tournament_name, date, team1, team2, team1_score, team2_score, map, time ) 
   values
      (
         p_tournament_name, p_date, p_team1, p_team2, p_team1_score, p_team2_score, p_map, p_time 
      )
;
select
   LAST_INSERT_ID() as game_id;
else
   SIGNAL sqlstate '45000' 
set
   MESSAGE_TEXT = 'Game date must be within tournament dates';
end
if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertPlayerGameStats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertPlayerGameStats`( in p_game_id int, in p_team_name varchar(100), in p_player_ign varchar(100), in p_kills int, in p_deaths int, in p_assists int )
begin
   insert into
      player_statistics_per_game ( game_id, team_name, player_ign, kills, deaths, assists ) 
   values
      (
         p_game_id,
         p_team_name,
         p_player_ign,
         p_kills,
         p_deaths,
         p_assists 
      )
;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RetirePlayer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RetirePlayer`(
    IN player_ign_param VARCHAR(100),
    IN retire_date DATE
)
BEGIN
IF NOT EXISTS (
    SELECT
        1
    FROM
        player
    WHERE
        ign = player_ign_param
) THEN SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'Player does not exist';

END IF;

SET
    @latest_end_date = (
        SELECT
            MAX(end_date)
        FROM
            player_team
        WHERE
            player_ign = player_ign_param
    );

SET
    @player_start_date = (
        SELECT
            year_started
        FROM
            player
        WHERE
            ign = player_ign_param
    );

IF (
    @latest_end_date IS NOT NULL
    AND retire_date <= @latest_end_date
)
OR retire_date < CAST(CONCAT(@player_start_date, '-01-01') AS DATE) THEN SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'Retirement date must be after the latest team end date and the year started';

END IF;

SET
    @current_team_name = (
        SELECT
            team_name
        FROM
            player_team
        WHERE
            player_ign = player_ign_param
            AND end_date IS NULL
    );

IF @current_team_name IS NOT NULL THEN
UPDATE
    player_team
SET
    end_date = retire_date
WHERE
    player_ign = player_ign_param
    AND end_date IS NULL;

END IF;

UPDATE
    player
SET
    status = 'Retired',
    year_ended = YEAR(retire_date)
WHERE
    ign = player_ign_param;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TransferPlayer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TransferPlayer`(
    IN player_ign_param VARCHAR(100),
    IN new_team_name VARCHAR(100),
    IN transfer_date DATE
)
BEGIN
    DECLARE current_team_name VARCHAR(100);
    DECLARE current_start_date DATE;

    IF NOT EXISTS (
        SELECT
            1
        FROM
            player
        WHERE
            ign = player_ign_param
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET
            MESSAGE_TEXT = 'Player does not exist';
    END IF;

    IF NOT EXISTS (
        SELECT
            1
        FROM
            team
        WHERE
            name = new_team_name
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET
            MESSAGE_TEXT = 'Target team does not exist';
    END IF;

    SELECT
        team_name,
        start_date
    INTO
        current_team_name,
        current_start_date
    FROM
        player_team
    WHERE
        player_ign = player_ign_param
        AND end_date IS NULL
    LIMIT 1;

    IF current_team_name = new_team_name THEN
        SIGNAL SQLSTATE '45000'
        SET
            MESSAGE_TEXT = 'Player is already in the target team';
    END IF;

    IF current_team_name IS NOT NULL THEN
        UPDATE
            player_team
        SET
            end_date = transfer_date
        WHERE
            player_ign = player_ign_param
            AND end_date IS NULL;
    END IF;

    INSERT INTO
        player_team (player_ign, team_name, start_date)
    VALUES
        (player_ign_param, new_team_name, transfer_date);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateTournament` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateTournament`( in t_name varchar(100), in t_organizer varchar(100), in t_series varchar(100), in t_tier enum('A-Tier', 'B-Tier', 'C-Tier', 'S-Tier', 'Major'), in t_type enum('Offline', 'Online'), in t_prize_pool int, in t_start_date date, in t_end_date date, in t_venue varchar(100) )
begin
   update
      tournament 
   set
      organizer = t_organizer,
      series = t_series,
      tier = t_tier,
      type = t_type,
      prize_pool = t_prize_pool,
      start_date = t_start_date,
      end_date = t_end_date,
      venue = t_venue 
   where
      name = t_name;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateVenue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateVenue`(
    IN venue_name VARCHAR(100),
    IN venue_street_number INT,
    IN venue_street_name VARCHAR(100),
    IN venue_city VARCHAR(100),
    IN venue_state VARCHAR(100),
    IN venue_country VARCHAR(100),
    IN venue_zip_code VARCHAR(20)
)
BEGIN
        UPDATE venue
        set
        street_number = venue_street_number,
        street_name = venue_street_name,
        city = venue_city,
        state = venue_state,
        country = venue_country,
        zip_code = venue_zip_code
        where
        name = venue_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-06  0:45:38
