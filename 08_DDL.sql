/* ***********************************************************************************
DDL - Database에 객체를 관리한다.
- 생성 -create
- 수정 -alter
- 삭제 -drop

테이블 생성
- 구문
create table 테이블 이름(
  컬럼 설정
)

제약조건 설정 
- 컬럼 레벨 설정 [NOT NULL],[default]
    - 컬럼 설정에 같이 설정
- 테이블 레벨 설정
    - 컬럼 설정뒤에 따로 설정

- 기본 문법 : constraint 제약조건이름 제약조건타입
- 테이블 제약 조건 조회
    - USER_CONSTRAINTS 딕셔너리 뷰에서 조회
    
테이블 삭제
- 구분
DROP TABLE 테이블이름 [CASCADE CONSTRAINTS]
*********************************************************************************** */
CREATE TABLE parent_tb (
    no        NUMBER
        CONSTRAINT pk_parent_tb PRIMARY KEY,  -- 컬럼 레벨 설정
    name      NVARCHAR2(30) NOT NULL,
    birthday  DATE DEFAULT sysdate, -- 기본값 설정:insert시 값을 넣지 않으면 기본값 설정
    email     VARCHAR2(100)
        CONSTRAINT uk_parent_tb_email UNIQUE, -- unique제약조건: 중복된 값 설정안됨 (null 제외)
    gender    CHAR(1) NOT NULL
        CONSTRAINT ck_parent_tb_gender CHECK ( gender IN ( 'M', 'F' ) ) -- check 제약조건 : 값에 대한 제약조건[사용자 정의]
);

DESC parent_tb;

INSERT INTO parent_tb VALUES (
    1,
    '홍길동',
    '2000/01/01',
    'a@a.com',
    'M'
);

INSERT INTO parent_tb (
    no,
    name,
    gender
) VALUES (
    2,
    '이순신',
    'M'
); -- 생일은 default 값, 이메일 null 값 출력
INSERT INTO parent_tb VALUES (
    3,
    '홍길동',
    NULL,
    'b@a.com',
    'M'
); -- 명시적으로 null을 넣으면 default 값이 아니라 null이 insert 가 된다.
INSERT INTO parent_tb VALUES (
    4,
    '홍길동',
    NULL,
    'b@a.com',
    'M'
); -- 오류발생시 제약조건의 이름을 통해서 어떤 부분에 오류가 발생했는지 확인 할 수 있다. 
INSERT INTO parent_tb VALUES (
    5,
    '김영수',
    NULL,
    'c@a.com',
    'm'
);

SELECT
    *
FROM
    parent_tb;

CREATE TABLE child_tb (
    no         NUMBER, --pk
    jumin_num  CHAR(14) NOT NULL, --uk
    age        NUMBER(3) DEFAULT 0, -- ck 10 ~ 90
    parent_no  NUMBER, -- parent_tb 참조하는 fk
    CONSTRAINT pk_child_tb PRIMARY KEY ( no ), -- (컬럼명)
    CONSTRAINT uk_child_tb_jumin_num UNIQUE ( jumin_num ),
    CONSTRAINT ck_child_tb_age CHECK ( age BETWEEN 10 AND 90 ),
    CONSTRAINT fk_child_tb_parent_tb FOREIGN KEY ( parent_no )
        REFERENCES parent_tb ( no )
);


/* ************************************************************************************
ALTER : 테이블 수정

컬럼 관련 수정

- 컬럼 추가
  ALTER TABLE 테이블이름 ADD (추가할 컬럼설정 [, 추가할 컬럼설정])
  - 하나의 컬럼만 추가할 경우 ( ) 는 생략가능

- 컬럼 수정
  ALTER TABLE 테이블이름 MODIFY (수정할컬럼명  변경설정 [, 수정할컬럼명  변경설정])
	- 하나의 컬럼만 수정할 경우 ( )는 생략 가능
	- 숫자/문자열 컬럼은 크기를 늘릴 수 있다.
		- 크기를 줄일 수 있는 경우 : 열에 값이 없거나 모든 값이 줄이려는 크기보다 작은 경우
	- 데이터가 모두 NULL이면 데이터타입을 변경할 수 있다. (단 CHAR<->VARCHAR2 는 가능.)

- 컬럼 삭제	
  ALTER TABLE 테이블이름 DROP COLUMN 컬럼이름 [CASCADE CONSTRAINTS]
    - CASCADE CONSTRAINTS : 삭제하는 컬럼이 Primary Key인 경우 그 컬럼을 참조하는 다른 테이블의 Foreign key 설정을 모두 삭제한다.
	- 한번에 하나의 컬럼만 삭제 가능.
	
  ALTER TABLE 테이블이름 SET UNUSED (컬럼명 [, ..])
  ALTER TABLE 테이블이름 DROP UNUSED COLUMNS
	- SET UNUSED 설정시 컬럼을 바로 삭제하지 않고 삭제 표시를 한다. 
	- 설정된 컬럼은 사용할 수 없으나 실제 디스크에는 저장되 있다. 그래서 속도가 빠르다.
	- DROP UNUSED COLUMNS 로 SET UNUSED된 컬럼을 디스크에서 삭제한다. 

- 컬럼 이름 바꾸기
  ALTER TABLE 테이블이름 RENAME COLUMN 원래이름 TO 바꿀이름;

**************************************************************************************  
제약 조건 관련 수정
-제약조건 추가
  ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건 설정

- 제약조건 삭제
  ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건이름
  PRIMARY KEY 제거: ALTER TABLE 테이블명 DROP PRIMARY KEY [CASCADE]
	- CASECADE : 제거하는 Primary Key를 Foreign key 가진 다른 테이블의 Foreign key 설정을 모두 삭제한다.

- NOT NULL <-> NULL 변환은 컬럼 수정을 통해 한다.
   - ALTER TABLE 테이블명 MODIFY (컬럼명 NOT NULL),  - ALTER TABLE 테이블명 MODIFY (컬럼명 NULL)  
************************************************************************************ */
-- customers 카피해서 cust
-- select 결과 set을 테이블로 생성 (Not null을 제외한 제약조건 카피 안됨.)
CREATE TABLE cust
    AS
        SELECT
            *
        FROM
            customers;

CREATE TABLE cust2
    AS
        SELECT
            cust_id,
            cust_name,
            address
        FROM
            customers;

CREATE TABLE cust3
    AS
        SELECT
            *
        FROM
            customers
        WHERE
            1 = 0; -- False , 컬럼들만 카피. 안의 내용은 카피하지 않는다.

SELECT
    *
FROM
    cust3;

DESC cust3;
-- 추가
ALTER TABLE cust3 ADD (
    age    NUMBER DEFAULT 0 NOT NULL,
    point  NUMBER
);
-- 수정
ALTER TABLE cust3 MODIFY (
    age NUMBER(3)
); -- NOT NULL 과 같은 다른 설정 변경 x
ALTER TABLE cust3 MODIFY (
    cust_email null
); -- NOT NULL 컬럼을 NULL 컬럼으로 변경
ALTER TABLE cust3 MODIFY (
    cust_email NOT NULL
);
-- 컬럼명 변경
ALTER TABLE cust3 RENAME COLUMN cust_email TO email; -- cust_email --> email 변경
-- 컬럼 삭제
ALTER TABLE cust3 DROP COLUMN age;

SELECT
    *
FROM
    cust;

DESC cust;

ALTER TABLE cust MODIFY (
    cust_id NUMBER(2)
); -- -99 ~ 99 --> 이미 id 100 존재하기 때문에 에러 발생
ALTER TABLE cust3 MODIFY (
    cust_id NUMBER(3)
); -- 값 존재 하지 않기 때문에 가능
ALTER TABLE cust MODIFY (
    cust_id NUMBER(5)
); -- 기존 데이터에 영향을 끼치지 않을 경우(늘리는)에는 범위 변경 가능
ROLLBACK; -- 변경된 타입은 돌아가지 않음. rollback/commit[DML명령어]은 대상이 아니다.

alter cust ADD (
    age NUMBER(3) NOT NULL
); -- 이미 존재하는 테이블에 값 대입 없기 때문에 null로 채워진다. 하지만 not null조건 때문에 오류 발생

--제약조건 변경
-- 각 테이블의 제약조건들 조회
SELECT
    *
FROM
    user_constraints;

SELECT
    *
FROM
    user_constraints
WHERE
    table_name = 'CUST';

-- 제약조건 추가
ALTER TABLE cust ADD CONSTRAINT pk_cust PRIMARY KEY ( cust_id );

ALTER TABLE cust ADD CONSTRAINT uk_cust_email UNIQUE ( cust_email );

ALTER TABLE cust
    ADD CONSTRAINT ck_cust_gender CHECK ( gender IN ( 'M', 'F' ) );

-- 제약조건 제거
ALTER TABLE cust DROP CONSTRAINT ck_cust_gender;

ALTER TABLE cust DROP PRIMARY KEY; -- pk 는 유일하기 때문에


--TODO: emp 테이블을 카피해서 emp2를 생성(틀만 카피)
CREATE TABLE emp2
    AS
        SELECT
            *
        FROM
            emp
        WHERE
            1 = 0;

SELECT
    *
FROM
    emp2;

--TODO: gender 컬럼을 추가: type char(1)
ALTER TABLE emp2 ADD (
    gender CHAR(1)
);

DESC emp2;

--TODO: email 컬럼 추가. type: varchar2(100),  not null  컬럼
ALTER TABLE emp2 ADD (
    email VARCHAR2(100) NOT NULL
);

DESC emp2;

--TODO: jumin_num(주민번호) 컬럼을 추가. type: char(14), null 허용. 유일한 값을 가지는 컬럼.
ALTER TABLE emp2 ADD (
    jumin_num CHAR(14) NULL
);

ALTER TABLE emp2 ADD CONSTRAINT uk_emp2_jumin_num UNIQUE ( jumin_num );

DESC emp2;

SELECT
    *
FROM
    user_constraints
WHERE
    table_name = 'EMP2';

--TODO: emp_id 를 primary key 로 변경
ALTER TABLE emp2 ADD CONSTRAINT pk_emp2 PRIMARY KEY ( emp_id );

SELECT
    *
FROM
    user_constraints
WHERE
    table_name = 'EMP2';
  
--TODO: gender 컬럼의 M, F 저장하도록  제약조건 추가
ALTER TABLE emp2
    ADD CONSTRAINT pk_emp2_gender CHECK ( gender IN ( 'M', 'F' ) );

SELECT
    *
FROM
    user_constraints
WHERE
    table_name = 'EMP2';
 
--TODO: salary 컬럼에 0이상의 값들만 들어가도록 제약조건 추가
ALTER TABLE emp2 ADD CONSTRAINT pk_emp2_salary CHECK ( salary >= 0 );

SELECT
    *
FROM
    user_constraints
WHERE
    table_name = 'EMP2';

--TODO: email 컬럼을 null을 가질 수 있되 다른 행과 같은 값을 가지지 못하도록 제약 조건 변경
ALTER TABLE emp2 ADD CONSTRAINT uk_emp2_email UNIQUE ( email );

SELECT
    *
FROM
    user_constraints
WHERE
    table_name = 'EMP2';

--TODO: emp_name 의 데이터 타입을 varchar2(100) 으로 변환
ALTER TABLE emp2 MODIFY (
    emp_name VARCHAR2(100)
);

DESC emp2;

--TODO: job_id를 not null 컬럼으로 변경
ALTER TABLE emp2 MODIFY (
    job_id NOT NULL
);

DESC emp2;

--TODO: dept_id를 not null 컬럼으로 변경
ALTER TABLE emp2 MODIFY (
    dept_id NOT NULL
);

SELECT
    *
FROM
    emp2;

DESC emp2;

--TODO: job_id  를 null 허용 컬럼으로 변경
ALTER TABLE emp2 MODIFY (
    job_id null
);

SELECT
    *
FROM
    emp2;

DESC emp2;

--TODO: dept_id  를 null 허용 컬럼으로 변경
ALTER TABLE emp2 MODIFY (
    dept_id null
);

SELECT
    *
FROM
    emp2;

DESC emp2;


--TODO: 위에서 지정한 emp2_email_uk 제약 조건을 제거
ALTER TABLE emp2 DROP CONSTRAINT uk_emp2_email;

SELECT
    *
FROM
    user_constraints
WHERE
    table_name = 'EMP2';

--TODO: 위에서 지정한 emp2_salary_ck 제약 조건을 제거
ALTER TABLE emp2 DROP CONSTRAINT pk_emp2_salary;

SELECT
    *
FROM
    user_constraints
WHERE
    table_name = 'EMP2';

--TODO: primary key 제약조건 제거
ALTER TABLE emp2 DROP PRIMARY KEY;

SELECT
    *
FROM
    user_constraints
WHERE
    table_name = 'EMP2';

--TODO: gender 컬럼제거
ALTER TABLE emp2 DROP COLUMN gender;

DESC emp2;

--TODO: email 컬럼 제거
ALTER TABLE emp2 DROP COLUMN email;

DESC emp2;

/* **************************************************************************************************************
시퀀스 : SEQUENCE
- 자동증가하는 숫자를 제공하는 오라클 객체
- 테이블 컬럼이 자동증가하는 고유번호를 가질때 사용한다.
	- 하나의 시퀀스를 여러 테이블이 공유하면 중간이 빈 값들이 들어갈 수 있다.

생성 구문
CREATE SEQUENCE sequence이름
	[INCREMENT BY n]	
	[START WITH n]                		  
	[MAXVALUE n | NOMAXVALUE]   
	[MINVALUE n | NOMINVALUE]	
	[CYCLE | NOCYCLE(기본)]		
	[CACHE n | NOCACHE]		  

- INCREMENT BY n: 증가치 설정. 생략시 1
- START WITH n: 시작 값 설정. 생략시 0
	- 시작값 설정시
	 - 증가: MINVALUE 보다 크커나 같은 값이어야 한다.
	 - 감소: MAXVALUE 보다 작거나 같은 값이어야 한다.
- MAXVALUE n: 시퀀스가 생성할 수 있는 최대값을 지정
- NOMAXVALUE : 시퀀스가 생성할 수 있는 최대값을 오름차순의 경우 10^27 의 값. 내림차순의 경우 -1을 자동으로 설정. 
- MINVALUE n :최소 시퀀스 값을 지정
- NOMINVALUE :시퀀스가 생성하는 최소값을 오름차순의 경우 1, 내림차순의 경우 -(10^26)으로 설정
- CYCLE 또는 NOCYCLE : 최대/최소값까지 갔을때 순환할 지 여부. NOCYCLE이 기본값(순환반복하지 않는다.)
- CACHE|NOCACHE : 캐쉬 사용여부 지정.(오라클 서버가 시퀀스가 제공할 값을 미리 조회해 메모리에 저장) NOCACHE가 기본값(CACHE를 사용하지 않는다. )


시퀀스 자동증가값 조회
 - sequence이름.nextval  : 다음 증감치 조회
 - sequence이름.currval  : 현재 시퀀스값 조회


시퀀스 수정
ALTER SEQUENCE 수정할 시퀀스이름
	[INCREMENT BY n]	               		  
	[MAXVALUE n | NOMAXVALUE]   
	[MINVALUE n | NOMINVALUE]	
	[CYCLE | NOCYCLE(기본)]		
	[CACHE n | NOCACHE]	

수정후 생성되는 값들이 영향을 받는다. (그래서 start with 절은 수정대상이 아니다.)	  


시퀀스 제거
DROP SEQUENCE sequence이름
	
************************************************************************************************************** */

-- 1부터 1씩 자동증가하는 시퀀스
CREATE SEQUENCE dept_id_seq; 

--seq이름.nextval()

SELECT
    dept_id_seq.NEXTVAL
FROM
    dual;

SELECT
    dept_id_seq.CURRVAL
FROM
    dual;

INSERT INTO dept VALUES (
    dept_id_seq.NEXTVAL,
    'new' || dept_id_seq.CURRVAL,
    'seoul'
);

SELECT
    *
FROM
    dept;
-- 1부터 50까지 10씩 자동증가 하는 시퀀스
CREATE SEQUENCE ex1_seq INCREMENT BY 10 MAXVALUE 50;

SELECT
    exl_seq.NEXTVAL
FROM
    dual;

-- 100 부터 150까지 10씩 자동증가하는 시퀀스
CREATE SEQUENCE ex2_seq INCREMENT BY 10 START WITH 100 MAXVALUE 150;

SELECT
    ex2_seq.NEXTVAL
FROM
    dual;        



-- 100 부터 150까지 10씩 자동증가하되 최대값에 다다르면 순환하는 시퀀스
-- 순환(cycle) 할때 증가(increment by 양수) : minvalue(기본값:1)에서 시작
-- 순환(cycle) 할때 증가(increment by 음수) : maxvalue(기본값:-1)에서 시작
DROP SEQUENCE ex3_seq;

CREATE SEQUENCE ex3_seq INCREMENT BY 20 START WITH 100 MINVALUE 100 MAXVALUE 150 NOCACHE CYCLE;

SELECT
    ex3_seq.NEXTVAL
FROM
    dual;     


-- -1부터 -1씩 자동 감소하는 시퀀스
CREATE SEQUENCE ex4_seq INCREMENT BY - 1; -- 자동감소 : start with 기본값 -1

SELECT
    ex4_seq.NEXTVAL
FROM
    dual;   


-- -1부터 -50까지 -10씩 자동 감소하는 시퀀스

CREATE SEQUENCE ex5_seq INCREMENT BY - 10 MINVALUE - 50;

SELECT
    ex5_seq.NEXTVAL
FROM
    dual;   

-- 100 부터 -100까지 -100씩 자동 감소하는 시퀀스
CREATE SEQUENCE ex6_seq INCREMENT BY - 100 START WITH 100 MINVALUE - 100 MAXVALUE 100; -- maxvalue :-1(감소), 1(증가)| 감소 : maxvalue >= startvalue, 증가 : maxvalue=<startvalue

SELECT
    ex6_seq.NEXTVAL
FROM
    dual; 


-- 15ㅎ에서 -15까지 1씩 감소하는 시퀀스 작성
CREATE SEQUENCE ex7_seq INCREMENT BY - 1 START WITH 15 MINVALUE - 15 MAXVALUE 15;

SELECT
    ex7_seq.NEXTVAL
FROM
    dual; 



-- -10 부터 1씩 증가하는 시퀀스 작성

CREATE SEQUENCE ex8_seq INCREMENT BY 1 START WITH - 10 MINVALUE - 10;

SELECT
    ex8_seq.NEXTVAL
FROM
    dual; 



-- TODO: 부서ID(dept.dept_id)의 값을 자동증가 시키는 sequence를 생성. 10 부터 10씩 증가하는 sequence
-- 위에서 생성한 sequence를 사용해서  dept_copy에 5개의 행을 insert.
DROP SEQUENCE dept_id_seq;

CREATE SEQUENCE dept_id_seq INCREMENT BY 10 START WITH 10 MINVALUE 10;

DROP TABLE dept_copy;

CREATE TABLE dept_copy
    AS
        SELECT
            *
        FROM
            dept
        WHERE
            1 = 0;

INSERT INTO dept_copy VALUES (
    dept_id_seq.NEXTVAL,
    '마케팅',
    '서울'
);

INSERT INTO dept_copy VALUES (
    dept_id_seq.NEXTVAL,
    '구매부',
    '서울'
);

INSERT INTO dept_copy VALUES (
    dept_id_seq.NEXTVAL,
    '기획부',
    '서울'
);

SELECT
    *
FROM
    dept_copy;

-- TODO: 직원ID(emp.emp_id)의 값을 자동증가 시키는 sequence를 생성. 10 부터 1씩 증가하는 sequence
-- 위에서 생성한 sequence를 사용해 emp_copy에 값을 5행 insert
CREATE SEQUENCE emp_id_seq START WITH 10;

DROP TABLE emp_copy;

CREATE TABLE emp_copy
    AS
        SELECT
            *
        FROM
            emp
        WHERE
            1 = 0;

INSERT INTO emp_copy VALUES (
    emp_id_seq.NEXTVAL,
    'KJH',
    NULL,
    NULL,
    sysdate,
    30000,
    NULL,
    NULL
);

INSERT INTO emp_copy VALUES (
    emp_id_seq.NEXTVAL,
    'KJH',
    NULL,
    NULL,
    sysdate,
    30000,
    NULL,
    NULL
);

INSERT INTO emp_copy VALUES (
    emp_id_seq.NEXTVAL,
    'KJH',
    NULL,
    NULL,
    sysdate,
    30000,
    NULL,
    NULL
);

DESC emp_copy;

SELECT
    *
FROM
    emp_copy;