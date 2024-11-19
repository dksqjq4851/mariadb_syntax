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
select * from author where id in(select author_id from post);


-- like : 특정 문자를 포함하는 데이터를 조회하기 위해 사용하는 키워드
select * from post where title like '&h'; -- h로 끝나는 title검색
select * from post where title like 'h%'; -- h로 시작하는 title검색
select * from post where title like '&h%'; -- 단어의 중간에 h라는 키워드가 있는 경우 검색

-- regexp : 정규표현식을 활용한 조회
select * from post where title regexp '[a-z]'; -- 하나라도 알파벳 소문자가 들어있으면
select * from post where title regexp '[가-힣]';--하나라도 한글이 포함돼 있으면

-- 날짜변환 cast, convert : 숫자 -> 날짜, 문자 -> 날짜
select cast(20241119 as date);
select cast('20241119' as date);
select convert(20241119, date);
select convert('20241119', date);
-- 문자 -> 숫자 변환
select cast('12' as unsigned);

-- 날짜조회 방법
-- like패턴, 부등호 활용, date_format
select * from post where created_time like '2024-11&'; --문자열처럼 조회
select * from post where created_time >= '2024-01-01' and created_time < '2025-01-01';
-- date_format 활용
select date_format(created_time, '%Y-%m-%d') from post;
select date_format(created_time, '%H:%i:%s') from post;
select * from post where date_format(created_time, '%Y')='2024'
select * from post where  cast(date_format(created_time, '%Y')='2024' as unsigned) = 2024;

-- 오늘현재시간
select now();