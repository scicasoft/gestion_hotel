-- phpMyAdmin SQL Dump
-- version 2.11.5
-- http://www.phpmyadmin.net
--
-- Serveur: localhost
-- Généré le : Jeu 17 Juillet 2008 à 11:43
-- Version du serveur: 5.0.51
-- Version de PHP: 5.2.5

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Base de données: `hotel`
--
CREATE DATABASE `hotel` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `hotel`;

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE `categories` (
  `classe` varchar(11) NOT NULL,
  `tarif_normal` float NOT NULL,
  `tarif_special` float NOT NULL,
  PRIMARY KEY  (`classe`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `categories`
--

INSERT INTO `categories` (`classe`, `tarif_normal`, `tarif_special`) VALUES
('AFFAIRE', 30000, 25000),
('ECONOMIQUE', 10000, 7500),
('STANDING', 20000, 15000);

-- --------------------------------------------------------

--
-- Structure de la table `chambres`
--

CREATE TABLE `chambres` (
  `num_chambre` varchar(5) NOT NULL,
  `classe` varchar(20) default NULL,
  `etat` char(1) NOT NULL,
  PRIMARY KEY  (`num_chambre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `chambres`
--

INSERT INTO `chambres` (`num_chambre`, `classe`, `etat`) VALUES
('00001', 'STANDING', 'L'),
('00002', 'ECONOMIQUE', 'L'),
('00003', 'AFFAIRE', 'L'),
('00004', 'ECONOMIQUE', 'L'),
('00005', 'ECONOMIQUE', 'L'),
('01001', 'AFFAIRE', 'L'),
('01002', 'AFFAIRE', 'L'),
('01003', 'ECONOMIQUE', 'L'),
('01004', 'ECONOMIQUE', 'L'),
('01005', 'STANDING', 'L'),
('02001', 'STANDING', 'L'),
('02002', 'STANDING', 'L'),
('02003', 'AFFAIRE', 'L'),
('02004', 'STANDING', 'L'),
('02005', 'ECONOMIQUE', 'L'),
('03001', 'AFFAIRE', 'L'),
('03002', 'AFFAIRE', 'L'),
('03003', 'STANDING', 'L'),
('03004', 'ECONOMIQUE', 'L'),
('03005', 'STANDING', 'L'),
('04001', 'AFFAIRE', 'L'),
('04002', 'STANDING', 'L'),
('04003', 'ECONOMIQUE', 'L'),
('04004', 'ECONOMIQUE', 'L'),
('04005', 'ECONOMIQUE', 'L');

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

CREATE TABLE `clients` (
  `num_chambre` varchar(5) NOT NULL default '',
  `date_entree` date NOT NULL,
  `num_tel` varchar(30) default NULL,
  `date_reservation` date NOT NULL,
  `nom_client` varchar(20) NOT NULL,
  `prenom_client` varchar(30) NOT NULL,
  `classe` varchar(11) default NULL,
  `groupe_special` tinyint(1) default '0',
  `date_sortie` date default NULL,
  `nuite` int(11) NOT NULL default '1',
  PRIMARY KEY  (`date_entree`,`num_chambre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `clients`
--


-- --------------------------------------------------------

--
-- Structure de la table `facture`
--

CREATE TABLE `facture` (
  `num_chambre` varchar(5) NOT NULL default '',
  `date_entree` date NOT NULL,
  `num_tel` varchar(30) default NULL,
  `date_reservation` date NOT NULL,
  `nom_client` varchar(20) NOT NULL,
  `prenom_client` varchar(30) NOT NULL,
  `classe` varchar(11) default NULL,
  `groupe_special` tinyint(1) default '0',
  `prix_chambre` float NOT NULL,
  `date_sortie` date default NULL,
  PRIMARY KEY  (`date_entree`,`num_chambre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `facture`
--


-- --------------------------------------------------------

--
-- Structure de la table `informations`
--

CREATE TABLE `informations` (
  `nom_hotel` char(20) NOT NULL default '',
  `nbre_de_niveau` int(11) default NULL,
  `nbre_de_chambre` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `informations`
--

INSERT INTO `informations` (`nom_hotel`, `nbre_de_niveau`, `nbre_de_chambre`) VALUES
('NDIATENE HOTEL', 5, 5);

-- --------------------------------------------------------

--
-- Structure de la table `services_annexes`
--

CREATE TABLE `services_annexes` (
  `nom_service` varchar(30) NOT NULL,
  PRIMARY KEY  (`nom_service`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `services_annexes`
--

INSERT INTO `services_annexes` (`nom_service`) VALUES
('bar'),
('piscine'),
('restaurant'),
('telephone');
