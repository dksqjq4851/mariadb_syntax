-- view : 실제데이터를 참조만 하는 가상의 테이블
-- 사용목적 1) 복잡한 쿼리 대신 2) 테이블의 컬럼까지 권한 분리

-- view생성
create view author_for_marketing as select name, email from author;


-- view조회
select * from author_for_marketing;

-- view권한부여
grant select on board.author_for_marketing to '계정명'@'localthost';

-- view삭제
drop view author_for_marketing;

-- 프로시저 생성
DELEMITER //
create procedure  hello_procedure()
begin
    select 'hello world';
end
// DELIMETIER ;

-- 프로시저 호출
call hello_procedure();

-- 프로시저 삭제
drop procedure hello_procedure();

-- 게시글목록조회 프로시저 생성
DELIMITER //
create procedure  게시글목록조회()
begin
    select * from post;
end
// DELIMITER ;


call 게시글목록조회();

-- 게시글 id 단건 조회
DELIMITER //
create procedure  게시글id단건조회(in postid bigint)
begin
    select * from post where id = postid;
end
// DELIMITER ;


call 게시글단건조회(1);

-- 본인이 쓴 글 목록 조회, 본인의 email을 입력값으로 조회
-- 목록조희의 결과는 *

-- 게시글목록조회byemail
DELIMITER //
create procedure  게시글목록조회byemail(in inputEmail varchar(255))
begin
    select p.id, p.title, p.contents from author_post ap inner join post p on p.id = ap.post_id 
inner join author a on a.id = ap.author_id where a.email = inputEmail;
end
// DELIMITER ;


-- 글쓰기
DELIMITER //
create procedure 글쓰기(in inputTitle varchar(255),in inputContents varchar(255),in inputEmail varchar(255))
begin
    declare authorId bigint;
    declare postId bigint;
    -- post테이블에 insert :
    insert into post(title, contents) values (inputTitle, inputContents);
    select id into postId from post order by id desc limit 1;

    -- author_post테이블 insert : author_id, post_id
    select id into authorId from author where email = inputEmail;

    insert into author_post(author_id, post_id) values (authorId,postId);
end
// DELIMITER ;


-- 글삭제 : 입력값으로 글id, 본인email
DELIMITER //

create procedure 글삭제(in inputPostId bigint, in inputEmail varchar(255))
begin
    declare authorPostCount bigint;
    declare authorId bigint;
    select id into authorId from author where email = inputEmail;
    select count(*) into authorPostCount from author_post where post_id = inputPostId;
    if authorPostCount>=2 then
    -- elseif까지 사용가능
        delete from author_post where post_id = inputPostId and author_id = authorId;
        
    else
        delete from author_post where post_id = inputPostId and author_id = authorId;
        delete from post where id = inputPostId;

    end if;
end
// DELIMITER ;

-- 반복문을 통해 post 대량생성 : title, 글쓴이email
DELIMITER //

create procedure 글도배(in count int, in inputEmail varchar(255))
begin
    declare authorId bigint;
    declare postId bigint;
    declare countValue int default 0;
    while countValue<count
        
        -- post테이블에 insert :
        insert into post(title) values ("안녕하세요");
        select id into postId from post order by id desc limit 1;

        -- author_post테이블 insert : author_id, post_id
        select id into authorId from author where email = inputEmail;

        insert into author_post(author_id, post_id) values (authorId,postId);
        set countValue = countValue+1;

    end while
end
// DELIMITER ;

