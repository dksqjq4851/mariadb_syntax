-- 여러 사용자가 1개의 글을 수정할수 있다 가정 후 db 리뉴얼
-- author와 post가 n:m관계가되어 관계테이블을 별도로 생성
create table author(id bigint primary key auto_increment, email varchar(255) not null unique,
password varchar(255), name varchar(255) not null, created_time datetime default current_timestamp());

create table post (id bigint primary key auto_increment, title varchar(255) not null, contents varchar(255),
created_time datetime default current_timestamp());

-- 1:1 관계인 author_address
-- 1:1 관계의 보장은 





-- author_post는 연결테이블로 생성
create table author_post(id bigint primary key auto_increment, author_id bigint not null, post_id bigint not null,
created_time datetime default current_timestamp(),
foreign key(author_id) references author(id) on delete cascade, foreign key(post_id) references post(id));


-- 복합키로 author_post 생성
create table author_post2(
    author_id bigint not null.
    post_id bigint not null,
    primary key(author_id, post_id),
    foreign key(author_id) references author(id),
    foreign key(post_id) references post(id));

-- 내 email로 내가 쓴 글 조회,
select p.* from post p inner join author_post ap on p.id=ap.post_id where ap.author_id = 5;

-- 글 2번이상 쓴 사람에 대한 정보 조회
select a.* from author a inner join author_post ap on a.id = ap.author_id group by ap.author_id having count(post_id)>=2;