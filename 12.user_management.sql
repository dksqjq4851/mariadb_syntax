-- 사용자관리
-- 사용자목록조회
select * from mysql.user;

-- 사용자생성
-- %는 원격 포함한 anywhere 접속
create user '계정명'@'%' identified by '4321';

-- 사용자에게 select 권한 부여
grant select on board.author to 'hans'@'localhost';

-- 사용자 권한 회수
revoke select on board.author from 'hans'@'localhost';

-- 사용자 계정삭제
drop user 'hans'@'localhost';