BEGIN TRANSACTION;
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
	`user_id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`user_nom`	VARCHAR( 45 ) NOT NULL,
	`user_login`	VARCHAR ( 45 ) NOT NULL,
	`user_email`	VARCHAR ( 45 ) NOT NULL,
	`user_password`	VARCHAR ( 100 ) NOT NULL
);
DROP TABLE IF EXISTS `book`;
CREATE TABLE IF NOT EXISTS `book` (
	`book_id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`book_nom`	TEXT NOT NULL,
	`book_date`	NUMERIC NOT NULL,
	`book_type`	TEXT NOT NULL,
	`book_description` TEXT,
	FOREIGN KEY(book_type) REFERENCES type(type_id)
);
DROP TABLE IF EXISTS `type`;
CREATE TABLE IF NOT EXISTS `type` (
	`type_id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`type_nom`	TEXT NOT NULL
);
DROP TABLE IF EXISTS `references`;
CREATE TABLE IF NOT EXISTS `references` (
	`references_id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`references_book_id`	integer NOT NULL,
	`is_referenced_book_id`	integer NOT NULL,
	`references_chapter`	TEXT,
	FOREIGN KEY(references_book_id) REFERENCES book(book_id),
	FOREIGN KEY(references_book_id) REFERENCES book(book_id)
);
DROP TABLE IF EXISTS `writer`;
CREATE TABLE IF NOT EXISTS `writer` (
	`writer_id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`writer_nom`	TEXT NOT NULL,
	`writer_prenom`	TEXT,
	`writer_naissance`	NUMERIC,
	`writer_mort`	NUMERIC,
	`writer_sameas`	TEXT,
	`writer_description`	TEXT
);
DROP TABLE IF EXISTS `writes`;
CREATE TABLE IF NOT EXISTS `writes` (
	`writes_id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`writes_writer_id`	integer NOT NULL,
	`writes_book_id`	integer NOT NULL,
	FOREIGN KEY(writes_writer_id) REFERENCES writer(writer_id),
	FOREIGN KEY(writes_book_id) REFERENCES book(book_id)
);
DROP TABLE IF EXISTS `authorship`;
CREATE TABLE IF NOT EXISTS `authorship` (
	`authorship_id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`authorship_user_id`	integer NOT NULL,
	`authorship_book_id`	integer NOT NULL,
	`authorship_date`	DATETIME DEFAULT current_timestamp,
	FOREIGN KEY(authorship_user_id) REFERENCES user(user_id),
	FOREIGN KEY(authorship_book_id) REFERENCES book(book_id)
);
COMMIT;

BEGIN TRANSACTION;

INSERT INTO `type` (`type_id`, `type_nom`) VALUES (0, 'Récit autobiographique');
INSERT INTO `type` (`type_id`, `type_nom`) VALUES (1, 'Roman');
INSERT INTO `type` (`type_id`, `type_nom`) VALUES (2, 'Théâtre');
INSERT INTO `type` (`type_id`, `type_nom`) VALUES (3, 'Essai philosophique');
INSERT INTO `type` (`type_id`, `type_nom`) VALUES (4, 'Recueil de nouvelles');
INSERT INTO `type` (`type_id`, `type_nom`) VALUES (5, 'Autre');

INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (0, 'Mémoires d''une jeune fille rangée', '1958', '0', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (1, 'La Force de l''âge', '1960', '0', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (2, 'La Force des choses', '1963', '0', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (3, 'Une mort très douce', '1964', '0', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (4, 'Tout compte fait', '1972', '0', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (5, 'La Cérémonie des adieux', '1991', '0', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (6, 'L''invitée', '1943', '1', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (7, 'Le sang des autres', '1945', '1', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (8, 'Tous les hommes sont mortels', '1946', '1', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (9, 'Les Mandarins', '1954', '1', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (10, 'Les Belles Images', '1966', '1', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (11, 'Les Inséparables', '2020', '1', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (12, 'Les Bouches inutiles', '1958', '2', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (13, 'Djamila Boupacha', '1962', '5', 'Insérer ici une description');

INSERT INTO `writer` (`writer_id`, `writer_nom`, `writer_prenom`, `writer_naissance`, `writer_mort`, `writer_sameas`, `writer_description`) VALUES (0, 'de Beauvoir', 'Simone', '1908/01/09', '1986/04/14', 'notice', 'description'),
(1, 'Halimi', 'Gisèle', '1927/07/27', '2020/07/28', 'notice wikidata', 'description');

INSERT INTO `writes` (`writes_id`, `writes_writer_id`, `writes_book_id`) VALUES (0, '0', '0'),
(1, '0', '1'),
(2, '0', '2'),
(3, '0', '3'),
(4, '0', '4'),
(5, '0', '5'),
(6, '0', '6'),
(7, '0', '7'),
(8, '0', '8'),
(9, '0', '9'),
(10, '0', '10'),
(11, '0', '11'),
(12, '0', '12'),
(13, '0', '13'),
(14, '1', '13');

INSERT INTO `user` (`user_id`, `user_nom`, `user_login`, `user_email`, `user_password`) VALUES (1, 'Administrator', 'admin', 'admin@supersite.com', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8');

COMMIT;