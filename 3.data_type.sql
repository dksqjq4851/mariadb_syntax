-- tinyint 는 -128-~127까지 표현(1byte)
alter table author add column age tinyint;
-- author 테이블 age 컬럼 추가
insert into author(id, age) values(6, 200);
alter table author modify column age tinyint unsigned;
insert into author(id, age) values(6, 200);

-- decimal 실습
-- decimal(정수부, 소수부)
alter table post add column price decimal(10, 3);

-- decimal 소수점 초과 후 값 짤림 현상
insert into post(id, title, price) value(6, 'big enough', 10.33412);

-- 문자열 실습
alter table author add column self_introduction text;
insert into author (id, self_introduction) values (7, '미션을 완료했으니 리워드를 받아야지?');

-- blob(바이너리데이터) 타입 실습
alter table author add column profile_image longblob;
insert into author(id, profile_image) values(8, LOAD_FILE('C:\\tanos.jpeg'));


-- 사용자 업로드 -> javaspring(이미지경로저장) -> db(경로를 저장)

-- enum : 삽입될 수 있는 데이터의 종류를 한정하는 데이터 타입
-- role컬럼 추가
alter table author add column role enum('user', 'admin') not null default 'user';
-- user값 세팅 후 insert 
insert into author(id, role) values(10, 'user');
-- users값 세팅 후 insert(잘못된 값)
insert into author(id, role) values(11, 'users');
-- 아무것도 안넣고 insert(default 값)
insert into author(id) values(11);

--  date : 날짜, datetime : 날짜 및 시분추(microseconds)
alter table post add column created_time datetime default current_timestamp(
);

-- 조회시 비교 연산자
select * from author where id >= 2 and id <= 4;
select * from author where id between 2 and 4; --지정된 범위도 포함, 위 >=2 and <=4 구문과 같은 구문
select * from author where id not(id < 2 or id > 4);
select * from author where id in(2,3,4);
select * from author where id not in(1,5); --전체 데이터가 1~5까지 밖에 없다는 가정.



