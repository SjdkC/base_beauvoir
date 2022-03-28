BEGIN TRANSACTION;
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
	`user_id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`user_nom`	VARCHAR( 45 ) NOT NULL,
	`user_login`	VARCHAR ( 45 ) NOT NULL,
	`user_email`	VARCHAR ( 45 ) NOT NULL,
	`user_password`	VARCHAR ( 100 ) NOT NULL
);
DROP TABLE IF EXISTS `type`;
CREATE TABLE IF NOT EXISTS `type` (
	`type_nom`	VARCHAR ( 45 ) NOT NULL PRIMARY KEY UNIQUE
);
DROP TABLE IF EXISTS `book`;
CREATE TABLE IF NOT EXISTS `book` (
	`book_id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`book_nom`	TEXT NOT NULL,
	`book_date`	NUMERIC NOT NULL,
	`book_type`	VARCHAR ( 45 ) NOT NULL,
	`book_description` TEXT,
	FOREIGN KEY(book_type) REFERENCES type(type_nom)
);
DROP TABLE IF EXISTS `mentions`;
CREATE TABLE IF NOT EXISTS `mentions` (
	`mentions_id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`mentions_book_id`	integer NOT NULL,
	`is_mentioned_book_id`	integer NOT NULL,
	`mentions_chapter`	TEXT,
	FOREIGN KEY(mentions_book_id) REFERENCES book(book_id),
	FOREIGN KEY(is_mentioned_book_id) REFERENCES book(book_id)
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

INSERT INTO `type` (`type_nom`) VALUES ('Récit autobiographique');
INSERT INTO `type` (`type_nom`) VALUES ('Roman');
INSERT INTO `type` (`type_nom`) VALUES ('Théâtre');
INSERT INTO `type` (`type_nom`) VALUES ('Essai philosophique');
INSERT INTO `type` (`type_nom`) VALUES ('Recueil de nouvelles');
INSERT INTO `type` (`type_nom`) VALUES ('Autre');

INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (0, 'Mémoires d''une jeune fille rangée', '1958', 'Récit autobiographique', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (1, 'La Force de l''âge', '1960', 'Récit autobiographique', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (2, 'La Force des choses', '1963', 'Récit autobiographique', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (3, 'Une mort très douce', '1964', 'Récit autobiographique', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (4, 'Tout compte fait', '1972', 'Récit autobiographique', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (5, 'La Cérémonie des adieux', '1991', 'Récit autobiographique', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (6, 'L''invitée', '1943', 'Roman', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (7, 'Le sang des autres', '1945', 'Roman', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (8, 'Tous les hommes sont mortels', '1946', 'Roman', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (9, 'Les Mandarins', '1954', 'Roman', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (10, 'Les Belles Images', '1966', 'Roman', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (11, 'Les Inséparables', '2020', 'Roman', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (12, 'Les Bouches inutiles', '1958', 'Théâtre', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (13, 'Djamila Boupacha', '1962', 'Autre', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (14, 'La Femme Rompue', '1967', 'Recueil de nouvelles', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (15, 'Quand prime le spirituel', '1979', 'Recueil de nouvelles', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (16, 'Pyrrhus et Cinéas', '1944', 'Essai philosophique', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (17, 'Pour une morale de l''ambiguïté', '1947', 'Essai philosophique', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (18, 'Le Deuxième Sexe', '1949', 'Essai philosophique', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (19, 'Privilèges', '1955', 'Essai philosophique', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (20, 'La Vieillesse', '1970', 'Essai philosophique', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (21, 'La Longue Marche', '1957', 'Essai philosophique', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (22, 'Faut-il brûler Sade ?', '1972', 'Essai philosophique', 'Insérer ici une description');
INSERT INTO `book` (`book_id`, `book_nom`, `book_date`, `book_type`, `book_description`) VALUES (23, 'L''Amérique au jour le jour', '1948', 'Autre', 'Insérer ici une description');

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
(14, '1', '13'),
(15, '0', '14'),
(16, '0', '15'),
(17, '0', '16'),
(18, '0', '17'),
(19, '0', '18'),
(20, '0', '19'),
(21, '0', '20'),
(22, '0', '21'),
(23, '0', '22'),
(24, '0', '23');

INSERT INTO `mentions` (`mentions_id`, `mentions_book_id`, `is_mentioned_book_id`, `mentions_chapter`) VALUES (0, 0, 11, 'Chapitre X'),
(1, 2, 6, 'Chapitre Y');

INSERT INTO `user` (`user_id`, `user_nom`, `user_login`, `user_email`, `user_password`) VALUES (1, 'Administrator', 'admin', 'admin@supersite.com', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8');

COMMIT;