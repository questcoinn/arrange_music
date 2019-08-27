/*
[앨범]
id 아티스트 앨범제목 발매일 추천수 설명

[사용자]
id pwd 닉네임 생년월일

사용자별로 추천한 앨범, 들은 앨범 정리해야함 > txt 파일로?
*/

/* CREATE DATABASE webpj; */

USE webpj;

/*CREATE TABLE album(
	id int PRIMARY KEY NOT NULL auto_increment,
    artist varchar(50) NOT NULL,
    title varchar(200) NOT NULL,
    r_date date NULL,
    img varchar(255) DEFAULT "nothing.png",
    recommend int DEFAULT 0,
    dsc varchar(16383) NULL,
    writer varchar(20) NOT NULL,
    FULLTEXT KEY artist(artist),
    FULLTEXT KEY title(title)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;*/

/* CREATE TABLE webuser(
	id varchar(20) PRIMARY KEY NOT NULL,
    pwd varchar(20) NOT NULL,
    nickname varchar(20) NOT NULL,
    birth date NULL
); */

/*INSERT INTO album(artist, title, r_date, dsc, writer) VALUES(
	"test-abbbbbb", "test-rr", "2019-08-14", "test-sdas", "test"
);*/

/*ALTER TABLE album MODIFY dsc VARCHAR(21844);*/

/*DELETE FROM album;*/
/*ALTER TABLE album auto_increment=1;
SET @CNT=0;
UPDATE album SET id=@CNT:=@CNT+1;*/

/*UPDATE album SET recommend=1 WHERE id=2;*/

/*ALTER TABLE album ADD writer varchar(20) AFTER dsc;*/

/*SELECT artist, title, DAY(r_date) AS r_day FROM album
	WHERE YEAR(r_date)=2019 AND MONTH(r_date)=8 ORDER BY r_date;*/
/*select * from album order by id limit 8;*/
/*SELECT * FROM album where artist="Clairo" AND title="Immunity";*/

/*SELECT * FROM album
	WHERE MATCH(artist, title) AGAINST('care package*' IN BOOLEAN MODE);*/
    
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

/*DELETE FROM webuser_info WHERE userid="null";*/
SELECT * FROM webuser_info ORDER BY id DESC;

/*SET @CNT=0;*/
/*SELECT * FROM 
(SELECT *, IF(true, @CNT:=@CNT+1, 0) AS count FROM album ORDER BY id)t
WHERE count BETWEEN 6 AND 13 ORDER BY count DESC;*/
/*SELECT *, IF(true, @CNT:=@CNT+1, 0) AS count FROM album
	WHERE MATCH(artist, title) AGAINST('black*' IN BOOLEAN MODE)
    ORDER BY id;*/