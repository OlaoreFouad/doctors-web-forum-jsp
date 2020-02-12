-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 26, 2019 at 04:20 PM
-- Server version: 10.1.25-MariaDB
-- PHP Version: 7.1.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `webforum`
--

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

CREATE TABLE `doctors` (
  `id` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `fullname` varchar(50) NOT NULL,
  `password` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `awards` text NOT NULL,
  `qualifications` text NOT NULL,
  `profession` text NOT NULL,
  `experience` int(11) NOT NULL,
  `isAdmin` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `replies`
--

CREATE TABLE `replies` (
  `id` text NOT NULL,
  `content` text NOT NULL,
  `did` text NOT NULL,
  `tid` text NOT NULL,
  `createdAt` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `replies`
--

INSERT INTO `replies` (`id`, `content`, `did`, `tid`, `createdAt`) VALUES
('67865711-cef0-466e-bd34-7a0d71bf27e5', 'devdevon\'s reply', '7a106ba2-c8c3-4dde-b2e8-bce962ff8ff8', 'd6a5265d-0fc5-4f1e-b432-c6a99dab23ed', 1568809193609),
('68e6b2dd-05c1-4fa6-9e0b-bc0c04d79f7f', 'First reply', '7a106ba2-c8c3-4dde-b2e8-bce962ff8ff8', '8f7df505-4f07-49cc-9f4e-4e657ca597d1', 1569237385145),
('6c57c9f5-b17f-41e5-8a15-b4eba0912be2', 'devdevon\'s reply', 'feb3e169-0b71-4b93-b8ca-82bab9995e7a', 'd6a5265d-0fc5-4f1e-b432-c6a99dab23ed', 1569074955191),
('79d9f49f-43d6-4a81-8a1a-637f817c1845', 'rotimi is here', 'b55dd9e5-7b0e-4cb6-b746-9510f081c9ed', '68c70a96-551b-40c7-b8bb-45bdb80ebdef', 1568808861789),
('acaf4b88-afa7-4df6-8c7f-f30b112ccc03', 'my first reply', 'b55dd9e5-7b0e-4cb6-b746-9510f081c9ed', '68c70a96-551b-40c7-b8bb-45bdb80ebdef', 1568807482162),
('c122fe6f-dcb2-474f-9ece-65f85b72ef3a', 'admin don reach here oo....', 'feb3e169-0b71-4b93-b8ca-82bab9995e7a', '6545829c-d0bc-495c-b958-03a11f3461a4', 1569076109474),
('d9d06e38-22ca-4c72-97fb-b029bb3002ca', 'first reply', 'feb3e169-0b71-4b93-b8ca-82bab9995e7a', '5fb6077d-085d-4a30-9b96-43038a48aa01', 1569075010978);

-- --------------------------------------------------------

--
-- Table structure for table `topics`
--

CREATE TABLE `topics` (
  `id` varchar(100) NOT NULL,
  `title` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `createdAt` bigint(20) NOT NULL,
  `did` varchar(100) NOT NULL,
  `categories` text NOT NULL,
  `tags` text NOT NULL,
  `views` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `topics`
--

INSERT INTO `topics` (`id`, `title`, `content`, `createdAt`, `did`, `categories`, `tags`, `views`) VALUES
('008b9711-c100-4436-9ef9-1a019d48f310', 'First Post', 'This is a fast test!', 1568219760240, 'feb3e169-0b71-4b93-b8ca-82bab9995e7a', 'Cat 1', 'first, boring, very boring', 1),
('5fb6077d-085d-4a30-9b96-43038a48aa01', 'New user\'s topic', 'the new user\'s topic\'s content!', 1568300762398, 'b55dd9e5-7b0e-4cb6-b746-9510f081c9ed', 'Cat 3', 'a, b, c', 2),
('6545829c-d0bc-495c-b958-03a11f3461a4', 'Admin First Title', 'Admin First Content first post', 1569075604563, 'a6fad30a-d99d-4965-b03a-e06ce50c8b50', 'Cat 3', 'admin, shit, shit and more shit!', 6),
('68c70a96-551b-40c7-b8bb-45bdb80ebdef', 'One more test', 'One more test content', 1568299769934, 'b55dd9e5-7b0e-4cb6-b746-9510f081c9ed', 'Cat 3', 'tag1, tag2, tag3', 25),
('80e77dca-64a4-4945-928f-d02ebfc23185', 'Another Post', 'This is another post!.', 1568804323288, 'feb3e169-0b71-4b93-b8ca-82bab9995e7a', 'Cat 3', 'another, post', 9),
('8f7df505-4f07-49cc-9f4e-4e657ca597d1', 'Second Post', 'More content goes here...', 1568724149882, 'feb3e169-0b71-4b93-b8ca-82bab9995e7a', 'Cat 3', 'one, one, one', 3),
('b8750f03-3690-432a-aefd-b4c76dc77a42', 'ffff', 'gggg', 1568298091700, 'feb3e169-0b71-4b93-b8ca-82bab9995e7a', 'Cat 2', 'one, two, three', 0),
('d6a5265d-0fc5-4f1e-b432-c6a99dab23ed', 'Rotimi is herwe totle', 'the content is fine!', 1568809146000, '7a106ba2-c8c3-4dde-b2e8-bce962ff8ff8', 'Cat 3', 'rotimi, chris, tian, fag', 13);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `replies`
--
ALTER TABLE `replies`
  ADD PRIMARY KEY (`id`(100));

--
-- Indexes for table `topics`
--
ALTER TABLE `topics`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
