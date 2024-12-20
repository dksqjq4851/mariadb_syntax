-- inner join
-- 두 테이블 사이에 지정된 조건에 맞는 레코드만 반환. on 조건을 통해 교집합찾기
select * from author inner join post on author.id = post.author_id;
select * from author a inner join post p on a.id = p.author_id;
-- 출력 순서만 달라질뿐 조회결과는 동일.
select * from post inner join author on author.id = post.author_id;
-- 글쓴이가 있는 글 목록과 글쓴이의 이메일을 출력하시오.
-- post의 글쓴이가 없는데이터는 포함x, 글쓴이중에 글을 한번도 안쓴사람 포함 x
select p.*, a.email from post p inner join author a on a.id=p.author_id;
-- 글쓴이가 있는 글의 제목, 내용 과 글쓴이의 이메일을 출력하시오.
select p.title, p.contents, a.email from post p inner join author a on a.id=p.author_id;

-- 모든 글 목록을 출력하고, 만약에 글쓴이가 있다면 이메일 정보를 출력
-- left outer join -> left join으로 생략가능
-- 글을 한번도 안쓴 글쓴이 정보는 포함 x

select *.p, a.email from post p left join author a on a.id=p.author_id;

-- 글쓴이를 기준으로 left join 할 경우. 글쓴이가 n개의 글을 쓸수 있으므로 같은 글쓴이가 여러번 출력될수 있음
-- author와 post가 1:n 관계이므로, 
-- 글쓴이가 없는 글은 포함 x
select * from author a left join post p on a.id=p.author_id;

-- 실습)글쓴이가 있는 글 중에서 글의 title과 저자의 email만을 출력하되,
-- 저자의 나이가 30세 이상인 글만 출력
select p.title, a.email, a.age from post p inner join author a on a.id=p.author_id where a.age >= 30;

-- 글의 내용과 글의 저자의 이름이 있는, 글 목록을 출력하되, 2024-06 이후에 만들어지 글만 출력
select p.* , a.name from post p inner join author a on a.id=p.author_id 
where p.contents is not null and a.name is not null and date_format(p.created_time, '%Y-%m') > '2024-06';

-- 코드를 입력하세요
SELECT BOOK_ID, AUTHOR_NAME, date_format(b.published_date, '%Y-%m-%d') as PUBLISHED_DATE
FROM BOOK B INNER JOIN AUTHOR A ON B.AUTHOR_ID=A.AUTHOR_ID WHERE B.CATEGORY ='경제'ORDER BY PUBLISHED_DATE;


-- 조건에 맞는 도서와 저자 리스트 출력

-- union : 두 테이블의 select 결과를 횡으로 결합(기본적으로 distinct 적용)
-- 컬럼의 개수와 컬럼의 타입이 같아야 함에 유의
-- union all : 중복까지 모두 포함
select name, email from author union select title, contents from post;


-- 서브쿼리 : select문 안에 또다른 select문을 서브퀴리라 한다.
-- where절 안에 서브쿼리
-- 한번이라도 글을쓴 author 목록 조회
select distinct a.* from post p inner join author a on a.id=p.author_id;
select * from author where id in(select author_id from post);

-- select절 안에 서브쿼리
-- author의 email과 author별로 본인이 쓴 글의 개수를 출력
select a.email, (select count(*) from post where author_id = a.id) from author a;


-- from절 안에 서브쿼리
select a.name from ( select * from author) as a;

-- 없어진 기록 찾기
-- 서브쿼리
ANIMAL_OUTS ANIMAL_INS 

-- 집계함수
select count(id) from author;
select sum(price) from post;
select avg(price) from post;
-- 소수점 첫번째자리에서 반올림해서 소수점을 없앰
select round(avg(price), 1) from post;

-- group by : 그룹화된 데이터를 하나의 행(row)처럼 취급
-- author_id 로 그룹핑 하였으면, 그외의 컬럼을 조회하는 것은 적절치않음
select author_id from post group by author_id;
-- group by와 집계함수
-- 아래 쿼리에서 *은 그룹화된 데이터내에서의 개수
select author_id, count(*) from post group by author_id;
select author_id, count(*), sum(*) from post group by author_id;

-- author의 email과 author별로 본인이 쓴글의 개수를 출력
select a.email, (select count(*) from post where author_id = a.id) from author a;
-- join과 group by, 집계함수 활용한 글의 개수 출력
select email, count(p.author_id) from author a left join post p on p.author_id=a.id group by a.id; 

-- where와 gruopby
-- 연도별 post 글의 개수 출력, 연도가 null 인 값은 제외
select date_format(created_time, '%Y') as year, count(*) from post where created_time is not null group by year;

-- 자동차 종류 별 특정 옵션이 포함된 자동차 수 구하기

-- 입양 시각 구하기 (1)


-- having : group by를 통해 나온 집계값을 대한 조건
-- 글을 2개 이상 쓴사람에 대한 정보조회하기
select author_id from post group by author_id having count(*)>=2;
-- 동명 동물 수 찾기
-- 다중열 group by
-- post에서 작성자별로 만든 제목의 개수를 출력하시오.
select author_id, titlem, count(*) from post group by author_id, title;

-- 재구매가 일어난 상품과 회원 리스트 구하기