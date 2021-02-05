/* *********************************************************************
DML - 데이터를 다루는 sql문
    - insert : 삽입 (Create)
    - select : 조회 (Read, Retrieve)
    - update : 수정 (Update)
    - delete : 삭제 (Delete)

INSERT 문 - 행 추가
구문
 - 한행추가 :
   - INSERT INTO 테이블명 (컬럼 [, 컬럼]) VALUES (값 [, 값[])
   - 모든 컬럼에 값을 넣을 경우 컬럼 지정구문은 생략 할 수 있다.

 - 조회결과를 INSERT 하기 (subquery 이용)
   - INSERT INTO 테이블명 (컬럼 [, 컬럼])  SELECT 구문
	- INSERT할 컬럼과 조회한(subquery) 컬럼의 개수와 타입이 맞아야 한다.
	- 모든 컬럼에 다 넣을 경우 컬럼 설정은 생략할 수 있다.
	
  
************************************************************************ */
DESC dept; -- table 정보 조회
INSERT INTO dept (
    dept_id,
    dept_name,
    loc
) VALUES (
    1000,
    '기획부',
    '서울'
);

INSERT INTO dept (
    dept_id,
    dept_name,
    loc
) VALUES (
    1100,
    '구매부',
    '부산'
);

COMMIT;

INSERT INTO dept (
    dept_id,
    dept_name,
    loc
) VALUES (
    1200,
    '기획부',
    '서울'
);

INSERT INTO dept (
    dept_id,
    dept_name,
    loc
) VALUES (
    1300,
    '기획부',
    '서울'
);

INSERT INTO dept (
    dept_id,
    dept_name,
    loc
) VALUES (
    1400,
    '기획부',
    '서울'
);

COMMIT; -- commit을 하기 전까지는 임시로 처리된 상태. commit 최종 처리
ROLLBACK; --insert/update/delete 하기 전(마지막 commit) 상태로 돌려라

SELECT
    *
FROM
    dept;

DESC emp;

INSERT INTO emp VALUES (
    1000,
    '홍길동',
    'FI_ACCOUNT',
    100,
    '2017/10/20',
    5000,
    0.1,
    20
);

INSERT INTO emp (
    emp_id,
    emp_name,
    hire_date,
    salary
) VALUES (
    1100,
    '이순신',
    '2000/01/05',
    6000
);

INSERT INTO emp VALUES (
    1200,
    '박영희',
    'FI_ACCOUNT',
    NULL,
    '2020/01/02',
    7000,
    NULL,
    10
);

INSERT INTO emp VALUES (
    1300,
    '박영희',
    'FI_ACCOUNT',
    NULL,
    TO_DATE('2020/01', 'yyyy/mm'),
    7000,
    NULL,
    10
);

-- INSERT ERRORS
-- 이미 있는 PK값을 삽입
INSERT INTO emp VALUES (
    1000,
    '김영수',
    'FI_ACCOUNT',
    100,
    '2021/01/06',
    5000,
    0.1,
    20
);
-- Not null 컬럼에 Null을 넣을 수 없다.
INSERT INTO emp VALUES (
    1500,
    NULL,
    'FI_ACCOUNT',
    100,
    '2021/01/06',
    5000,
    0.1,
    20
);
-- emp의 job_id 는 FK column -> 부모테이블의 PK컬럼(job_Id)에 있는 값만 넣을 수 있다.
INSERT INTO emp VALUES (
    1600,
    '김영수',
    '회계',
    100,
    '2021/01/06',
    5000,
    0.1,
    20
);
-- 컬럼 데이터 타입의 크기보다 더 큰 값을 넣는 경우 오류
INSERT INTO emp VALUES (
    1700,
    '김영수김영수김영수',
    'FI_ACCOUNT',
    100,
    '2021/01/06',
    5000,
    0.1,
    20
);

INSERT INTO emp VALUES (
    1000000,
    '김영수김영수김영수',
    'FI_ACCOUNT',
    100,
    '2021/01/06',
    5000,
    0.1,
    20
);

SELECT
    *
FROM
    emp
ORDER BY
    emp_id DESC;

CREATE TABLE emp_copy (
    emp_id    NUMBER(6),
    emp_name  VARCHAR2(20),
    salary    NUMBER(7, 2)
);

SELECT
    emp_id,
    emp_name,
    salary
FROM
    emp
WHERE
    dept_id = 100;

INSERT INTO emp_copy
    SELECT
        emp_id,
        emp_name,
        salary
    FROM
        emp
    WHERE
        dept_id = 10;

SELECT
    *
FROM
    emp_copy; 
--TODO: 부서별 직원의 급여에 대한 통계 테이블 생성. 
--      조회결과를 insert. 집계: 합계, 평균, 최대, 최소, 분산, 표준편차
CREATE TABLE salary_stat (
    dept_id        NUMBER(6),
    salary_sum     NUMBER(15, 2),
    salary_avg     NUMBER(10, 2),
    salary_max     NUMBER(7, 2),
    salary_min     NUMBER(7, 2),
    salary_var     NUMBER(20, 2),
    salary_stddev  NUMBER(7, 2)
);

INSERT INTO salary_stat
    SELECT
        dept_id,
        SUM(salary),
        round(AVG(salary), 2),
        MAX(salary),
        MIN(salary),
        round(VARIANCE(salary), 2),
        round(STDDEV(salary), 2)
    FROM
        emp
    GROUP BY
        dept_id
    ORDER BY
        1;

ROLLBACK;

SELECT
    *
FROM
    salary_stat;

/* *********************************************************************
UPDATE : 테이블의 컬럼의 값을 수정
UPDATE 테이블명
SET    변경할 컬럼 = 변경할 값  [, 변경할 컬럼 = 변경할 값]
[WHERE 제약조건]

 - UPDATE: 변경할 테이블 지정
 - SET: 변경할 컬럼과 값을 지정
 - WHERE: 변경할 행을 선택. 
************************************************************************ */



-- 직원 ID가 200인 직원의 급여를 5000으로 변경
UPDATE emp
SET
    salary = 5000
WHERE
    emp_id = 200;

SELECT
    *
FROM
    emp
WHERE
    emp_id = 200;

COMMIT;

-- 직원 ID가 200인 직원의 급여를 10% 인상한 값으로 변경.
UPDATE emp
SET
    salary = salary * 1.1
WHERE
    emp_id = 200;

SELECT
    *
FROM
    emp
WHERE
    emp_id = 200;

-- 부서 ID가 100인 직원의 커미션 비율을 0.2로 salary는 3000을 더한 값으로, 상사_id는 100 변경.
UPDATE emp
SET
    comm_pct = 0.2,
    salary = salary + 3000,
    mgr_id = 100
WHERE
    emp_id = 100;

SELECT
    *
FROM
    emp
WHERE
    emp_id = 100;

-- TODO: 부서 ID가 100인 직원들의 급여를 100% 인상
UPDATE emp
SET
    salary = salary * 2
WHERE
    dept_id = 100;

SELECT
    *
FROM
    emp
WHERE
    dept_id = 100;


-- TODO: IT 부서의 직원들의 급여를 3배 인상
UPDATE emp
SET
    salary = salary * 3
WHERE
    dept_id IN (
        SELECT
            dept_id
        FROM
            dept
        WHERE
            dept_name = 'IT'
    );

SELECT
    *
FROM
    emp
WHERE
    dept_id = 100;
-- TODO: EMP2 테이블의 모든 데이터를 MGR_ID는 NULL로 HIRE_DATE 는 현재일시로 COMM_PCT는 0.5로 수정.
UPDATE emp
SET
    mgr_id = NULL,
    hire_date = sysdate,
    comm_pct = 0.5;

SELECT
    *
FROM
    emp;
-- TODO: COMM_PCT 가 0.3이상인 직원들의 COMM_PCT를 NULL 로 수정.
UPDATE emp
SET
    comm_pct = NULL;
where COMM_PCT >= 0.3;
select * from emp;
rollback;

-- TODO: 전체 평균급여보다 적게 받는 직원들의 급여를 50% 인상.
update emp
set salary = salary * 1.5;
WHERE
    salary < (
        SELECT
            AVG(salary)
        FROM
            emp
    )
; SELECT * FROM EMP ;
/* *********************************************************************
DELETE : 테이블의 행을 삭제
구문 
 - DELETE FROM 테이블명 [WHERE 제약조건]
   - WHERE: 삭제할 행을 선택
************************************************************************ */
-- 부서테이블에서 부서_ID가 200인 부서 삭제
 DELETE FROM DEPT WHERE DEPT_ID = 200 ; SELECT * FROM DEPT ORDER BY 1 ;

-- 부서테이블에서 부서_ID가 10인 부서 삭제
 SELECT * FROM EMP WHERE DEPT_ID = 10 ;
DELETE FROM EMP WHERE DEPT_ID = 10 ; ROLLBACK ; SELECT * FROM EMP ;
-- TODO: 부서 ID가 없는 직원들을 삭제
 SELECT * FROM EMP WHERE DEPT_ID IS NULL ; DELETE FROM EMP WHERE
DEPT_ID IS NULL ;
-- TODO: 담당 업무(emp.job_id)가 'SA_MAN'이고 급여(emp.salary) 가 12000 미만인 직원들을 삭제.
 DELETE FROM EMP WHERE JOB_ID = 'SA_MAN' AND SALARY < 12000 ;


-- TODO: comm_pct 가 null이고 job_id 가 IT_PROG인 직원들을 삭제
 DELETE FROM EMP WHERE COMM_PCT IS NULL AND JOB_ID =
'IT_PROG' ;


-- TODO: job_id에 CLERK가 들어간 업무를 하는 직원들 삭제
 DELETE FROM EMP WHERE JOB_ID LIKE '%CLERK%' ; COMMIT ;

