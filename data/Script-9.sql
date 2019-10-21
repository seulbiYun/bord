create table article(
	article_no int(11) not null auto_increment,
	writer_id varchar(50) not null,
	writer_name varchar(50) not null,
	title varchar(255) not null,
	regdate datetime not null,
	moddate datetime not null,
	read_cnt int (11) default null,
	primary key (article_no)
);

drop table article_countent;

create table article_content(
	article_no int(11) not null,
	content text,
	primary key(article_no)
);

select * from article;
select * from article_content;

insert into article values(null,'user00','user00','title', now(),now(),0);
select last_insert_id() from article;
insert into article_content values(last_insert_id(),'내용');

insert into article values(null,'user02','user02','title2', now(),now(),0);

insert into article_content values(last_insert_id(),'내용');

select * from article as a left join article_content as c on a.article_no = c.article_no;


delete from article where article_no = 3;
delete from article_content where article_no = 3;


update article set title = '띵똥' where article_no = 4;
update article_content set content = '무슨일이오?' where article_no = 4;


