--한줄 주석
/*
block 주석
테이블 : 회원(member)
속성
id : varchar2(10), primary key
passward : varchar2(10) not null(회원가입시 필수 입력사항)
name : nvarchar2(50) not null
point :  number(7) nullable
join_data(가입일) : date not null
*/
-- 실행: control + enter
create table member(
    id varchar2(10) PRIMARY key,
    password VARCHAR2(10) not null,
    name nvarchar2(50) not null,
    point number(7),
    join_date date not null
);    

select * from tab;

-- delete table
drop table member;

--한행의 값 추가
INSERT into member(id, password, name,point,join_date)
    Values ('id-1','abcde', '홍길동',10000,'2020/10/05');
-- insert values into all columns
INSERT into member VALUES ('id-2','11111','박영희',19999,'2010/05/07');
-- PK 위배 : not null & unique
INSERT into member VALUES ('id-2','11111','박영희',19999,'2010/05/07');
INSERT into member VALUES ('id-3','11111','박영희',null,'2010/05/07'); -- Name Not null

SELECT
    *
FROM member;



