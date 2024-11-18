-- insert into : 테이블에 데이터 삽입
insert into 테이블명(컬럼명1, 컬럼명2, 컬럼명3) values(데이터1, 데이터2, 데이터3);
-- 문자열은 일반적으로 작은따옴표 ''를 사용
insert into author(id, name, email) values(3, 'hans', 'hans@naver.com')
select * from author;
select name, ramil from author;

-- post 데이터 1줄 추가
insert into post(id, title, contents) values(1, 'hi', '하하')

-- 테이블 제약조건 조회
select * from information_schema.key_column_usage where table_name = 'post';

-- insert문을 통해 author 데이터 2개정도 추가, post 데이터 2개정도추가(1개는 익명)

-- update : 데이터 수정
-- where문을 빠뜨리게 될 경우, 모든 데이터에 update문이 실행됨에 유의.
update author set name = 'hongs' where id = 1;
update author set name = 'hongs2', email='hongs2@naver.com' where id = 2;

-- delete : 데이터 삭제
-- where문을 빠뜨리게 될 경우, 모든 데이터가 삭제됨에 유의
delete from author where id = 5;

-- select : 조회
select * from author; --어떠한 조회조건없이 모든 컬럼 조회
select * from author where id = 1; --where 뒤에 조회조건을 통해 조회
select * from author where name = 'hongildong';
select * from author where id > 3;
select * from author where id > 2 and name ="kim"; --또는일경우에는 or를 사용하면됨

-- 중복제거 조회 : distinct
select name from author;
select disticnt name from author;

-- 정령 : order by + 컬럼명
-- 아무런 정렬조건 없이 조회할 경우에는 pk기준으로 오름차순 정렬
-- asc : 오름차순, desc : 내림차순
select * from author order by name desc;

-- 멀티컬럼 order by : 여러 컬럼으로 정렬, 먼저쓴컬럼 우선 정렬, 중복시 그 다음 정렬옵션 적용.

select * from author order by name desc, email asc; --name으로 먼저 정렬후, name이 중복되면 email로 정렬.

-- 결과값 개수 제한
select * from author order by id desc limit 2;

-- 별칭(alias)을 이용한 select 
select name as '이름', email as '이메일' from author;
select a.name, a.email from author as a;
select a.name, a.email from author a;

-- null을 조회조건으로 활용
select * from author where password is null; --
select * from author where password is not null;