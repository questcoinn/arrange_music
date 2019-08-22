/*
[앨범]
id 아티스트 앨범제목 발매일 추천수 설명

[사용자]
id pwd 닉네임 생년월일

사용자별로 추천한 앨범, 들은 앨범 정리해야함 > txt 파일로?
*/

/* CREATE DATABASE webpj; */

/*USE webpj;*/

/*CREATE TABLE album(
	id int PRIMARY KEY NOT NULL auto_increment,
    artist varchar(50) NOT NULL,
    title varchar(200) NOT NULL,
    r_date date NULL,
    img varchar(255) DEFAULT "nothing.png",
    recommend int DEFAULT 0,
    dsc varchar(16383) NULL,
    FULLTEXT KEY artist(artist),
    FULLTEXT KEY title(title)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;*/

/* CREATE TABLE webuser(
	id varchar(20) PRIMARY KEY NOT NULL,
    pwd varchar(20) NOT NULL,
    nickname varchar(20) NOT NULL,
    birth date NULL
); */

/* INSERT INTO album(artist, title, r_date, dsc) VALUES(
	"test-artist", "test-title", "2019-08-14", "test-description"
); */

/*ALTER TABLE album MODIFY dsc VARCHAR(21844);*/

/*DELETE FROM album WHERE id=1;*/
/*SET @CNT=0;
UPDATE album SET id=@CNT:=@CNT+1;*/

/*UPDATE album SET img="black-milk-dive.jpeg" WHERE id=2;*/

/*SELECT * FROM album;*/

/* SELECT * FROM album
	WHERE MATCH(artist, title) AGAINST('test' IN BOOLEAN MODE); */
    
 /*INSERT INTO webuser VALUES(
	"test3", "test", "test-user", NULL
); */

/*SELECT * FROM webuser;*/

/*DROP TABLE album;*/

/*CREATE TABLE webuser_info(
	id int PRIMARY KEY NOT NULL auto_increment,
    userid varchar(20) NOT NULL,
    artist varchar(50) NOT NULL,
    title varchar(200) NOT NULL,
    recommended tinyint(1) DEFAULT 0,
    heard tinyint(1) DEFAULT 0
);*/

SELECT * FROM webuser_info;