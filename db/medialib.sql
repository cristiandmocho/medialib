CREATE SCHEMA medialib;
use medialib;

create table users (
	user_id int unsigned not null auto_increment primary key,
    user_uid varchar(36) default null,
    user_email varchar(100) not null unique,
    user_name varchar(100) not null,
    user_bio text default null,
    user_locked_until datetime default null,
    user_created_on datetime not null default now(),
    user_photo varchar(250) default null
);

create table albums (
	albm_id int unsigned not null auto_increment primary key,
    user_id int unsigned not null,
    albm_name varchar(50) not null,
    albm_title varchar(250) default null,
    albm_private char(1) not null default 'N' comment '(Y)es, (N)o',
    albm_created_on datetime not null default now(),
);

create table photos (
	phto_id int unsigned not null auto_increment primary key,
    albm_id int unsigned default null,
    phto_path varchar(250) not null,
    phto_thumbnail varchar(250) not null,
    phto_description varchar(500) default null,
    phto_metadata text default null comment 'JSON: {is_cover: true|false, exif: {}}',
    phto_sort int unsigned not null default 0
);

create table posts (
	post_id int unsigned not null auto_increment primary key,
    post_title varchar(150) not null,
    user_id int unsigned not null,
    post_body text not null,
    post_datetime datetime not null,
    post_category int unsigned not null,
    post_cover varchar(250) null comment 'image path',
    post_tags varchar(300) default null,
    post_featured char(1) null default 'N' comment '(Y)es, (N)o',
    post_stats text not null comment 'JSON: {views: 0, likes: 0}',
    post_private char(1) not null default 'N' comment '(Y)es, (N)o',
    post_lang varchar(5) NOT NULL comment 'ISO Country Codes. Ex: en-GB'
);

create table comments (
	commt_id int unsigned not null auto_increment primary key,
	post_id int unsigned not null,
    commt_email varchar(250) default null,
    commt_author varchar(50) default null,
    commt_text varchar(3000) not null,
    commt_approved char(1) default 'N' comment '(Y)es, (N)o'
);

create table categories (
	cat_id int unsigned not null auto_increment primary key,
    cat_name varchar(30) not null,
    cat_sort_order int unsigned NOT NULL DEFAULT 0
);


/* SEED DATA */
insert into categories (cat_name, cat_sortorder) values
	('Travel', 1),
	('Food', 2),
	('Lifestyle', 3),
	('Health', 4),
	('Fashion', 5),
    ('Tech', 6),
	('Varieties', 7),
	('Vlogs', 8);


create user 'mluser'@'localhost' identified with mysql_native_password by '@CM19978z#';
grant all privileges on medialib.* to 'mluser'@'localhost';
flush privileges;