BEGIN TRANSACTION;
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
	`user_id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`user_nom`	TINYTEXT NOT NULL,
	`user_login`	VARCHAR ( 45 ) NOT NULL,
	`user_email`	TINYTEXT NOT NULL,
	`user_password`	VARCHAR ( 100 ) NOT NULL
);
DROP TABLE IF EXISTS `place`;
CREATE TABLE IF NOT EXISTS `place` (
	`place_id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`place_nom`	TINYTEXT NOT NULL,
	`place_description`	TEXT,
	`place_longitude`	NUMERIC NOT NULL,
	`place_latitude`	NUMERIC NOT NULL,
	`place_type`	TINYTEXT NOT NULL
);
DROP TABLE IF EXISTS `variante`;
CREATE TABLE IF NOT EXISTS `variante` (
	`variante_id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`variante_nom`	TINYTEXT NOT NULL,
	`variante_lang_code`	VARCHAR ( 45 ) NOT NULL,
	`variante_place_id`	integer NOT NULL,
	FOREIGN KEY(variante_place_id) REFERENCES place(place_id)
);
DROP TABLE IF EXISTS `authorship`;
CREATE TABLE IF NOT EXISTS `authorship` (
	`authorship_id`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`authorship_user_id`	integer NOT NULL,
	`authorship_place_id`	integer NOT NULL,
	`authorship_date`	DATETIME DEFAULT current_timestamp,
	FOREIGN KEY(authorship_user_id) REFERENCES user(user_id),
	FOREIGN KEY(authorship_place_id) REFERENCES place(place_id)
);
DROP INDEX IF EXISTS `fk_authorship_2_idx`;
CREATE INDEX IF NOT EXISTS `fk_authorship_2_idx` ON `authorship` (
	`authorship_user_id`	ASC
);
DROP INDEX IF EXISTS `fk_authorship_1_idx`;
CREATE INDEX IF NOT EXISTS `fk_authorship_1_idx` ON `authorship` (
	`authorship_place_id`	ASC
);
COMMIT;