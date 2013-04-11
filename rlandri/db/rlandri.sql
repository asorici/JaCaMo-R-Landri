-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Gazda: 127.0.0.1
-- Timp de generare: 11 Apr 2013 la 14:06
-- Versiune server: 5.5.16
-- Versiune PHP: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Baza de date: `rlandri`
--

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `auth_group`
--

CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `auth_group_permissions`
--

CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_425ae3c4` (`group_id`),
  KEY `auth_group_permissions_1e014c8f` (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `auth_permission`
--

CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_1bb8f392` (`content_type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=61 ;

--
-- Salvarea datelor din tabel `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add permission', 1, 'add_permission'),
(2, 'Can change permission', 1, 'change_permission'),
(3, 'Can delete permission', 1, 'delete_permission'),
(4, 'Can add group', 2, 'add_group'),
(5, 'Can change group', 2, 'change_group'),
(6, 'Can delete group', 2, 'delete_group'),
(7, 'Can add user', 3, 'add_user'),
(8, 'Can change user', 3, 'change_user'),
(9, 'Can delete user', 3, 'delete_user'),
(10, 'Can add content type', 4, 'add_contenttype'),
(11, 'Can change content type', 4, 'change_contenttype'),
(12, 'Can delete content type', 4, 'delete_contenttype'),
(13, 'Can add session', 5, 'add_session'),
(14, 'Can change session', 5, 'change_session'),
(15, 'Can delete session', 5, 'delete_session'),
(16, 'Can add site', 6, 'add_site'),
(17, 'Can change site', 6, 'change_site'),
(18, 'Can delete site', 6, 'delete_site'),
(19, 'Can add log entry', 7, 'add_logentry'),
(20, 'Can change log entry', 7, 'change_logentry'),
(21, 'Can delete log entry', 7, 'delete_logentry'),
(22, 'Can add city', 8, 'add_city'),
(23, 'Can change city', 8, 'change_city'),
(24, 'Can delete city', 8, 'delete_city'),
(25, 'Can add ring', 9, 'add_ring'),
(26, 'Can change ring', 9, 'change_ring'),
(27, 'Can delete ring', 9, 'delete_ring'),
(28, 'Can add sub environment', 10, 'add_subenvironment'),
(29, 'Can change sub environment', 10, 'change_subenvironment'),
(30, 'Can delete sub environment', 10, 'delete_subenvironment'),
(31, 'Can add owner relationship', 11, 'add_ownerrelationship'),
(32, 'Can change owner relationship', 11, 'change_ownerrelationship'),
(33, 'Can delete owner relationship', 11, 'delete_ownerrelationship'),
(34, 'Can add default extra', 12, 'add_defaultextra'),
(35, 'Can change default extra', 12, 'change_defaultextra'),
(36, 'Can delete default extra', 12, 'delete_defaultextra'),
(37, 'Can add agent', 13, 'add_agent'),
(38, 'Can change agent', 13, 'change_agent'),
(39, 'Can delete agent', 13, 'delete_agent'),
(40, 'Can add artifact', 14, 'add_artifact'),
(41, 'Can change artifact', 14, 'change_artifact'),
(42, 'Can delete artifact', 14, 'delete_artifact'),
(43, 'Can add organization', 15, 'add_organization'),
(44, 'Can change organization', 15, 'change_organization'),
(45, 'Can delete organization', 15, 'delete_organization'),
(46, 'Can add env user', 16, 'add_envuser'),
(47, 'Can change env user', 16, 'change_envuser'),
(48, 'Can delete env user', 16, 'delete_envuser'),
(49, 'Can add env agent', 17, 'add_envagent'),
(50, 'Can change env agent', 17, 'change_envagent'),
(51, 'Can delete env agent', 17, 'delete_envagent'),
(52, 'Can add solution', 18, 'add_solution'),
(53, 'Can change solution', 18, 'change_solution'),
(54, 'Can delete solution', 18, 'delete_solution'),
(55, 'Can add schedule', 19, 'add_schedule'),
(56, 'Can change schedule', 19, 'change_schedule'),
(57, 'Can delete schedule', 19, 'delete_schedule'),
(58, 'Can add abstract process', 20, 'add_abstractprocess'),
(59, 'Can change abstract process', 20, 'change_abstractprocess'),
(60, 'Can delete abstract process', 20, 'delete_abstractprocess');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `auth_user`
--

CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `password` varchar(128) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `last_login` datetime NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Salvarea datelor din tabel `auth_user`
--

INSERT INTO `auth_user` (`id`, `username`, `first_name`, `last_name`, `email`, `password`, `is_staff`, `is_active`, `is_superuser`, `last_login`, `date_joined`) VALUES
(1, 'admin', '', '', 'popa.tiberiu@gmail.com', 'pbkdf2_sha256$10000$TYcolTXv5TOb$AyS/4V7xwQ3lvojxnCkQd7i+Tsntwy3lO3oGSgQ5Hj0=', 1, 1, 1, '2013-04-11 11:57:54', '2012-07-12 11:13:16'),
(2, 'tibi', '', '', '', 'pbkdf2_sha256$10000$j4VqrRFjDGoy$mMDRAp9YUBpIDZXDoQDBJLe4ZhNQilyHnU7f4LUqIt4=', 0, 1, 0, '2013-02-07 09:19:31', '2012-07-12 11:14:25'),
(3, 'andrei', '', '', '', 'pbkdf2_sha256$10000$WDjG5qD6agbH$GtnTKn45ca2zlUa1uSEgtGolmWIzJ/9+iqhTaUZ86z8=', 0, 1, 0, '2013-02-07 09:19:43', '2012-07-12 11:14:40'),
(4, 'mihai', '', '', '', 'pbkdf2_sha256$10000$Ac6AXMUmTKvR$EyJJuVXpvAAq/6hPqgufSiTLweRfKQPSvoJHuvVDVbA=', 0, 1, 0, '2012-07-26 21:14:53', '2012-07-12 11:14:46');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `auth_user_groups`
--

CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_403f60f` (`user_id`),
  KEY `auth_user_groups_425ae3c4` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `auth_user_user_permissions`
--

CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_403f60f` (`user_id`),
  KEY `auth_user_user_permissions_1e014c8f` (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `city_city`
--

CREATE TABLE IF NOT EXISTS `city_city` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Salvarea datelor din tabel `city_city`
--

INSERT INTO `city_city` (`id`, `name`, `description`) VALUES
(1, 'The White City of R''Landri', 'It''s a city. Its purity is represented by its white color.');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `city_ring`
--

CREATE TABLE IF NOT EXISTS `city_ring` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `city_id` int(11) NOT NULL,
  `index` int(10) unsigned NOT NULL,
  `size` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `city_ring_586a73b5` (`city_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Salvarea datelor din tabel `city_ring`
--

INSERT INTO `city_ring` (`id`, `city_id`, `index`, `size`) VALUES
(1, 1, 0, 1),
(2, 1, 1, 4),
(3, 1, 2, 16);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `django_admin_log`
--

CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_403f60f` (`user_id`),
  KEY `django_admin_log_1bb8f392` (`content_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `django_content_type`
--

CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

--
-- Salvarea datelor din tabel `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `name`, `app_label`, `model`) VALUES
(1, 'permission', 'auth', 'permission'),
(2, 'group', 'auth', 'group'),
(3, 'user', 'auth', 'user'),
(4, 'content type', 'contenttypes', 'contenttype'),
(5, 'session', 'sessions', 'session'),
(6, 'site', 'sites', 'site'),
(7, 'log entry', 'admin', 'logentry'),
(8, 'city', 'city', 'city'),
(9, 'ring', 'city', 'ring'),
(10, 'sub environment', 'subenvironment', 'subenvironment'),
(11, 'owner relationship', 'subenvironment', 'ownerrelationship'),
(12, 'default extra', 'subenvironment', 'defaultextra'),
(13, 'agent', 'subenvironment', 'agent'),
(14, 'artifact', 'subenvironment', 'artifact'),
(15, 'organization', 'subenvironment', 'organization'),
(16, 'env user', 'envuser', 'envuser'),
(17, 'env agent', 'envuser', 'envagent'),
(18, 'solution', 'solution', 'solution'),
(19, 'schedule', 'schedule', 'schedule'),
(20, 'abstract process', 'simulator', 'abstractprocess');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `django_session`
--

CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_3da3d3d8` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('0305f91d962a32c7db201aab5b0479c0', 'NmJmZWUyZWExMGEyNzU1NGUwZjg2MzhiNzA4ZjA3MDI5YTg0MzNiYjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQJ1Lg==\n', '2012-09-30 13:56:55'),
('0b014a2378d2641580d3f7c5d34fdf4e', 'NmJmZWUyZWExMGEyNzU1NGUwZjg2MzhiNzA4ZjA3MDI5YTg0MzNiYjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQJ1Lg==\n', '2012-08-19 19:17:54'),
('650eb530def73bf9dda692173a7ddb50', 'N2RjY2UwOTYxNTQ3OThlMWY1YjAyZWJlMGQyZWI2YjYyYzYzMmM3OTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==\n', '2013-04-25 11:57:54'),
('6525b83b8a7f28eccc91f99befb478cb', 'MTVlM2MwNGM0YzQ0Y2UxYWQ5MmNiZjlkNTZjZmI4MDMyNjFiZTVjYTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQN1Lg==\n', '2013-02-21 09:19:43');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `django_site`
--

CREATE TABLE IF NOT EXISTS `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Salvarea datelor din tabel `django_site`
--

INSERT INTO `django_site` (`id`, `domain`, `name`) VALUES
(1, 'example.com', 'example.com');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `envuser_envagent`
--

CREATE TABLE IF NOT EXISTS `envuser_envagent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `envUser_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  `timePool` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `envuser_envagent_75b32dfd` (`envUser_id`),
  KEY `envuser_envagent_319d859` (`location_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Salvarea datelor din tabel `envuser_envagent`
--

INSERT INTO `envuser_envagent` (`id`, `name`, `envUser_id`, `location_id`, `timePool`) VALUES
(1, 'Chivu', 2, 1, 272),
(2, 'Mutu', 2, 1, 272),
(3, 'Pacyno', 3, 1, 272),
(4, 'Obama', 3, 1, 272),
(5, 'Kovesi', 3, 1, 272),
(6, 'Carlos', 4, 1, 272),
(7, 'Gigel', 4, 1, 272),
(8, 'Gogu', 4, 1, 272);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `envuser_envuser`
--

CREATE TABLE IF NOT EXISTS `envuser_envuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rank` bigint(20) NOT NULL,
  `economy` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Salvarea datelor din tabel `envuser_envuser`
--

INSERT INTO `envuser_envuser` (`id`, `rank`, `economy`, `user_id`) VALUES
(2, 0, 0, 2),
(3, 0, 0, 3),
(4, 0, 0, 4);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `schedule_schedule`
--

CREATE TABLE IF NOT EXISTS `schedule_schedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `solution_id` int(11) NOT NULL,
  `turn` int(10) unsigned NOT NULL,
  `step` int(10) unsigned NOT NULL,
  `lastModified` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `solution_id` (`solution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `simulator_abstractprocess`
--

CREATE TABLE IF NOT EXISTS `simulator_abstractprocess` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `solution_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `simulator_abstractprocess_6c4d8baf` (`solution_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=51 ;

--
-- Salvarea datelor din tabel `simulator_abstractprocess`
--

INSERT INTO `simulator_abstractprocess` (`id`, `solution_id`, `created`) VALUES
(50, 12, '2013-02-08 09:12:33');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `solution_solution`
--

CREATE TABLE IF NOT EXISTS `solution_solution` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `envUser_id` int(11) NOT NULL,
  `subEnvironment_id` int(11) NOT NULL,
  `description` longtext NOT NULL,
  `isVisible` tinyint(1) NOT NULL,
  `agents` varchar(100) NOT NULL,
  `artifacts` varchar(100) NOT NULL,
  `organizations` varchar(100) NOT NULL,
  `lastModified` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `solution_solution_75b32dfd` (`envUser_id`),
  KEY `solution_solution_e004a33` (`subEnvironment_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Salvarea datelor din tabel `solution_solution`
--

INSERT INTO `solution_solution` (`id`, `name`, `envUser_id`, `subEnvironment_id`, `description`, `isVisible`, `agents`, `artifacts`, `organizations`, `lastModified`) VALUES
(1, 'Gambler', 2, 1, 'You win some, lose some, it''s all the same to me!', 1, 'users/2/solutions/1/roulette_solution_agents.zip', '', '', '2012-07-12 11:25:15'),
(2, 'Auction solution', 4, 3, 'DA-MI HOTELU', 1, 'users/4/solutions/3/auction_solution_agents.zip', '', '', '2012-07-13 10:38:01'),
(4, 'Factorial', 4, 2, 'Trivial computation!', 1, 'users/4/solutions/2/factorial_solution_agents.zip', '', '', '2012-07-13 10:56:26'),
(5, 'sail', 2, 4, 'description', 1, 'users/2/solutions/4/roulette_feedback_solution_agents.zip', '', '', '2012-07-19 10:55:12'),
(6, 'Toer', 2, 5, 'Really dumb agent for TicTacToe!', 1, 'users/2/solutions/5/tictactoe_solution_agents.zip', '', '', '2012-07-19 11:42:36'),
(12, 'compare1', 3, 6, 'tit for tat vs extortionist', 0, 'users/3/solutions/6/compare1_1.zip', '', '', '2013-02-08 09:08:09');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `subenvironment_agent`
--

CREATE TABLE IF NOT EXISTS `subenvironment_agent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `subenvironment_id` int(11) NOT NULL,
  `file` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `subenvironment_agent_4d5c45ed` (`subenvironment_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Salvarea datelor din tabel `subenvironment_agent`
--

INSERT INTO `subenvironment_agent` (`id`, `name`, `subenvironment_id`, `file`) VALUES
(1, 'Roulette Master', 1, 'subenvironments/1/agents/roulette_master_agents.zip'),
(2, 'Roulette Feedback Master', 4, 'subenvironments/4/agents/roulette_feedback_master_agents.zip'),
(3, 'Iterated Prisoner s Dilemma Master', 6, 'subenvironments\\6\\agents\\iterated_prisoner_dilemma_master_agents.zip');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `subenvironment_artifact`
--

CREATE TABLE IF NOT EXISTS `subenvironment_artifact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `subenvironment_id` int(11) NOT NULL,
  `file` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `subenvironment_artifact_4d5c45ed` (`subenvironment_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Salvarea datelor din tabel `subenvironment_artifact`
--

INSERT INTO `subenvironment_artifact` (`id`, `name`, `subenvironment_id`, `file`) VALUES
(1, 'Biased Artifacts', 1, 'subenvironments/1/artifacts/roulette_artifacts.zip'),
(2, 'Factorial', 2, 'subenvironments/2/artifacts/factorial_artifacts.zip'),
(3, 'Auction', 3, 'subenvironments/3/artifacts/auction_artifacts.zip'),
(6, 'Feedback Artifacts', 4, 'subenvironments/4/artifacts/roulette_feedback_artifacts.zip'),
(7, 'TicTac Artifacts', 5, 'subenvironments/5/artifacts/tictactoe_artifacts.zip'),
(8, 'Iterated Prisoner s Dilemma Artifacts', 6, 'subenvironments\\6\\artifacts\\iterated_prisoner_dilemma_artifacts.zip');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `subenvironment_defaultextra`
--

CREATE TABLE IF NOT EXISTS `subenvironment_defaultextra` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `file` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Salvarea datelor din tabel `subenvironment_defaultextra`
--

INSERT INTO `subenvironment_defaultextra` (`id`, `name`, `file`) VALUES
(1, 'Generic Artifacts', 'subenvironments/generic/extra/generic-artifacts.jar'),
(3, 'Logging Properties', 'subenvironments/generic/extra/logging.zip'),
(4, 'Generic Environment', 'subenvironments/generic/extra/Generic Environment.zip');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `subenvironment_organization`
--

CREATE TABLE IF NOT EXISTS `subenvironment_organization` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `subenvironment_id` int(11) NOT NULL,
  `file` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `subenvironment_organization_4d5c45ed` (`subenvironment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `subenvironment_ownerrelationship`
--

CREATE TABLE IF NOT EXISTS `subenvironment_ownerrelationship` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subEnvironment_id` int(11) NOT NULL,
  `envUser_id` int(11) NOT NULL,
  `shares` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `subenvironment_ownerrelationship_e004a33` (`subEnvironment_id`),
  KEY `subenvironment_ownerrelationship_75b32dfd` (`envUser_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Salvarea datelor din tabel `subenvironment_ownerrelationship`
--

INSERT INTO `subenvironment_ownerrelationship` (`id`, `subEnvironment_id`, `envUser_id`, `shares`) VALUES
(1, 1, 3, 300),
(2, 2, 4, 300),
(3, 3, 4, 300),
(4, 4, 4, 100),
(5, 5, 3, 298),
(6, 5, 2, 1),
(7, 5, 4, 1),
(8, 6, 3, 100);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `subenvironment_subenvironment`
--

CREATE TABLE IF NOT EXISTS `subenvironment_subenvironment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `ring_id` int(11) NOT NULL,
  `index` int(10) unsigned NOT NULL,
  `envType` varchar(10) NOT NULL,
  `coordinatorClass` varchar(200) NOT NULL,
  `numSteps` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subenvironment_subenvironment_77550576` (`ring_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Salvarea datelor din tabel `subenvironment_subenvironment`
--

INSERT INTO `subenvironment_subenvironment` (`id`, `name`, `description`, `ring_id`, `index`, `envType`, `coordinatorClass`, `numSteps`) VALUES
(1, 'Roulette', 'European Roulette', 2, 1, 'setb', 'Roulette', 3),
(2, 'Factorial', 'Subenvironment pentru oamenii limitati din punct de vedere mental', 3, 1, 'rtsp', 'Factorial', NULL),
(3, 'Auction', 'You must buy hotel Cismigiu', 3, 2, 'rtmp', 'Auction', NULL),
(4, 'Roulette Feedback', 'Roulette with instant feedback after bet', 2, 2, 'setb', 'RouletteFeedback', 2),
(5, 'TicTacToe', 'The glorious game of TicTacToe.', 3, 6, 'patb', 'TicTacToe', 5),
(6, 'Iterated Prisoner''s Dilemma', 'Will you cooperate or will you defect?', 2, 4, 'setb', 'IteratedPrisonerDilemma', 20);

--
-- Restrictii pentru tabele sterse
--

--
-- Restrictii pentru tabele `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `group_id_refs_id_3cea63fe` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `permission_id_refs_id_5886d21f` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`);

--
-- Restrictii pentru tabele `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `content_type_id_refs_id_728de91f` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Restrictii pentru tabele `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `group_id_refs_id_f116770` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `user_id_refs_id_7ceef80f` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Restrictii pentru tabele `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `permission_id_refs_id_67e79cb` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `user_id_refs_id_dfbab7d` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Restrictii pentru tabele `city_ring`
--
ALTER TABLE `city_ring`
  ADD CONSTRAINT `city_id_refs_id_1da26b18` FOREIGN KEY (`city_id`) REFERENCES `city_city` (`id`);

--
-- Restrictii pentru tabele `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `content_type_id_refs_id_288599e6` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `user_id_refs_id_c8665aa` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Restrictii pentru tabele `envuser_envagent`
--
ALTER TABLE `envuser_envagent`
  ADD CONSTRAINT `envUser_id_refs_id_215320fa` FOREIGN KEY (`envUser_id`) REFERENCES `envuser_envuser` (`id`),
  ADD CONSTRAINT `location_id_refs_id_3357fab0` FOREIGN KEY (`location_id`) REFERENCES `subenvironment_subenvironment` (`id`);

--
-- Restrictii pentru tabele `envuser_envuser`
--
ALTER TABLE `envuser_envuser`
  ADD CONSTRAINT `user_id_refs_id_48bb7f82` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Restrictii pentru tabele `schedule_schedule`
--
ALTER TABLE `schedule_schedule`
  ADD CONSTRAINT `solution_id_refs_id_5cb40c7` FOREIGN KEY (`solution_id`) REFERENCES `solution_solution` (`id`);

--
-- Restrictii pentru tabele `simulator_abstractprocess`
--
ALTER TABLE `simulator_abstractprocess`
  ADD CONSTRAINT `solution_id_refs_id_68a5c410` FOREIGN KEY (`solution_id`) REFERENCES `solution_solution` (`id`);

--
-- Restrictii pentru tabele `solution_solution`
--
ALTER TABLE `solution_solution`
  ADD CONSTRAINT `envUser_id_refs_id_7d140cb` FOREIGN KEY (`envUser_id`) REFERENCES `envuser_envuser` (`id`),
  ADD CONSTRAINT `subEnvironment_id_refs_id_110e3a39` FOREIGN KEY (`subEnvironment_id`) REFERENCES `subenvironment_subenvironment` (`id`);

--
-- Restrictii pentru tabele `subenvironment_agent`
--
ALTER TABLE `subenvironment_agent`
  ADD CONSTRAINT `subenvironment_id_refs_id_2e3d8414` FOREIGN KEY (`subenvironment_id`) REFERENCES `subenvironment_subenvironment` (`id`);

--
-- Restrictii pentru tabele `subenvironment_artifact`
--
ALTER TABLE `subenvironment_artifact`
  ADD CONSTRAINT `subenvironment_id_refs_id_77311c2e` FOREIGN KEY (`subenvironment_id`) REFERENCES `subenvironment_subenvironment` (`id`);

--
-- Restrictii pentru tabele `subenvironment_organization`
--
ALTER TABLE `subenvironment_organization`
  ADD CONSTRAINT `subenvironment_id_refs_id_3ff55ced` FOREIGN KEY (`subenvironment_id`) REFERENCES `subenvironment_subenvironment` (`id`);

--
-- Restrictii pentru tabele `subenvironment_ownerrelationship`
--
ALTER TABLE `subenvironment_ownerrelationship`
  ADD CONSTRAINT `envUser_id_refs_id_13a65d2` FOREIGN KEY (`envUser_id`) REFERENCES `envuser_envuser` (`id`),
  ADD CONSTRAINT `subEnvironment_id_refs_id_51b8c39c` FOREIGN KEY (`subEnvironment_id`) REFERENCES `subenvironment_subenvironment` (`id`);

--
-- Restrictii pentru tabele `subenvironment_subenvironment`
--
ALTER TABLE `subenvironment_subenvironment`
  ADD CONSTRAINT `ring_id_refs_id_55709796` FOREIGN KEY (`ring_id`) REFERENCES `city_ring` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
