/* **********************************************************************************************
집합 연산자 (결합 쿼리)
- 둘 이상의 select 결과를 가지고 하는 연산.
- 구문
 select문  집합연산자 select문 [집합연산자 select문 ...] [order by 정렬컬럼 정렬방식]

-연산자
  - UNION: 두 select 결과를 하나로 결합한다. 단 중복되는 행은 제거한다. (합집합)
  - UNION ALL : 두 select 결과를 하나로 결합한다. 중복되는 행을 포함한다. (합집합)
  - INTERSECT: 두 select 결과의 동일한 결과행만 결합한다. (교집합)
  - MINUS: 왼쪽 조회결과에서 오른쪽 조회결과에 없는 행만 결합한다. (차집합)
   
 - 규칙
  - 연산대상 select 문의 컬럼 수가 같아야 한다. 
  - 연산대상 select 문의 컬럼의 타입이 같아야 한다.
  - 연산 결과의 컬럼이름은 첫번째 왼쪽 select문의 것을 따른다.
  - order by 절은 구문의 마지막에 넣을 수 있다.
  - UNION ALL을 제외한 나머지 연산은 중복되는 행은 제거한다.
*************************************************************************************************/
SELECT
    emp_id,
    emp_name
FROM
    emp
WHERE
    dept_id IN ( 10, 20, 30, 40 )
UNION
SELECT
    dept_id,
    to_char(salary)
FROM
    emp
WHERE
    salary > 15000
ORDER BY
    1;

SELECT
    *
FROM
    emp
WHERE
    dept_id IN ( 10, 20 )
UNION ALL
SELECT
    *
FROM
    emp
WHERE
    dept_id IN ( 20, 30 );

SELECT
    *
FROM
    emp
WHERE
    dept_id IN ( 10, 20 )
UNION
SELECT
    *
FROM
    emp
WHERE
    dept_id IN ( 20, 30 ); -- 중복 제거

-- 중복이 없는 조회 -> Union all // union 은 중복된것이 있는지 한번 더 확인하는 절차가 있음.
SELECT
    *
FROM
    emp
WHERE
    dept_id IN ( 10, 20 )
UNION
SELECT
    *
FROM
    emp
WHERE
    dept_id IN ( 30, 40 ); -- 중복

SELECT
    *
FROM
    emp
WHERE
    dept_id IN ( 10, 20 )
MINUS -- 차집합
SELECT
    *
FROM
    emp
WHERE
    dept_id IN ( 20, 40 )
UNION ALL
SELECT
    *
FROM
    emp
WHERE
    salary > 10000;
-- emp 테이블의 salary 최대값와 salary 최소값, salary 평균값 조회
SELECT
    MAX(salary)                   최대값,
    MIN(salary)                   최소값,
    round(AVG(salary), 2)         "salary 평균값"
FROM
    emp;

SELECT
    'Max',
    MAX(salary) 급여집계
FROM
    emp
UNION ALL
SELECT
    'Min',
    MIN(salary)
FROM
    emp
UNION ALL
SELECT
    'AVG',
    round(AVG(salary), 2)
FROM
    emp;

-- emp 테이블에서 업무별(emp.job_id) 급여 합계와 전체 직원의 급여합계를 조회.
SELECT
    decode(GROUPING_ID(job_id), 1, '총계', 0, job_id) job_id,
    SUM(salary)
FROM
    emp
GROUP BY
    ROLLUP(job_id);

SELECT
    job_id,
    SUM(salary) 급여합
FROM
    emp
GROUP BY
    job_id
UNION ALL
SELECT
    '총계',
    SUM(salary)
FROM
    emp;


--한국 연도별 수출 품목 랭킹
DROP TABLE export_rank;

CREATE TABLE export_rank (
    year     CHAR(4) NOT NULL,
    ranking  NUMBER(2) NOT NULL,
    item     VARCHAR2(60) NOT NULL
);

INSERT INTO export_rank VALUES (
    1990,
    1,
    '의류'
);

INSERT INTO export_rank VALUES (
    1990,
    2,
    '반도체'
);

INSERT INTO export_rank VALUES (
    1990,
    3,
    '가구'
);

INSERT INTO export_rank VALUES (
    1990,
    4,
    '영상기기'
);

INSERT INTO export_rank VALUES (
    1990,
    5,
    '선박해양구조물및부품'
);

INSERT INTO export_rank VALUES (
    1990,
    6,
    '컴퓨터'
);

INSERT INTO export_rank VALUES (
    1990,
    7,
    '음향기기'
);

INSERT INTO export_rank VALUES (
    1990,
    8,
    '철강판'
);

INSERT INTO export_rank VALUES (
    1990,
    9,
    '인조장섬유직물'
);

INSERT INTO export_rank VALUES (
    1990,
    10,
    '자동차'
);

INSERT INTO export_rank VALUES (
    2000,
    1,
    '반도체'
);

INSERT INTO export_rank VALUES (
    2000,
    2,
    '컴퓨터'
);

INSERT INTO export_rank VALUES (
    2000,
    3,
    '자동차'
);

INSERT INTO export_rank VALUES (
    2000,
    4,
    '석유제품'
);

INSERT INTO export_rank VALUES (
    2000,
    5,
    '선박해양구조물및부품'
);

INSERT INTO export_rank VALUES (
    2000,
    6,
    '무선통신기기'
);

INSERT INTO export_rank VALUES (
    2000,
    7,
    '합성수지'
);

INSERT INTO export_rank VALUES (
    2000,
    8,
    '철강판'
);

INSERT INTO export_rank VALUES (
    2000,
    9,
    '의류'
);

INSERT INTO export_rank VALUES (
    2000,
    10,
    '영상기기'
);

INSERT INTO export_rank VALUES (
    2018,
    1,
    '반도체'
);

INSERT INTO export_rank VALUES (
    2018,
    2,
    '석유제품'
);

INSERT INTO export_rank VALUES (
    2018,
    3,
    '자동차'
);

INSERT INTO export_rank VALUES (
    2018,
    4,
    '평판디스플레이및센서'
);

INSERT INTO export_rank VALUES (
    2018,
    5,
    '합성수지'
);

INSERT INTO export_rank VALUES (
    2018,
    6,
    '자동차부품'
);

INSERT INTO export_rank VALUES (
    2018,
    7,
    '철강판'
);

INSERT INTO export_rank VALUES (
    2018,
    8,
    '선박해양구조물및부품'
);

INSERT INTO export_rank VALUES (
    2018,
    9,
    '무선통신기기'
);

INSERT INTO export_rank VALUES (
    2018,
    10,
    '컴퓨터'
);

--년도별 수입 품목 랭킹
DROP TABLE import_rank;

CREATE TABLE import_rank (
    year     CHAR(4) NOT NULL,
    ranking  NUMBER(2) NOT NULL,
    item     VARCHAR2(60) NOT NULL
);

INSERT INTO import_rank VALUES (
    1990,
    1,
    '원유'
);

INSERT INTO import_rank VALUES (
    1990,
    2,
    '반도체'
);

INSERT INTO import_rank VALUES (
    1990,
    3,
    '석유제품'
);

INSERT INTO import_rank VALUES (
    1990,
    4,
    '섬유및화학기계'
);

INSERT INTO import_rank VALUES (
    1990,
    5,
    '가죽'
);

INSERT INTO import_rank VALUES (
    1990,
    6,
    '컴퓨터'
);

INSERT INTO import_rank VALUES (
    1990,
    7,
    '철강판'
);

INSERT INTO import_rank VALUES (
    1990,
    8,
    '항공기및부품'
);

INSERT INTO import_rank VALUES (
    1990,
    9,
    '목재류'
);

INSERT INTO import_rank VALUES (
    1990,
    10,
    '계측제어분석기'
);

INSERT INTO import_rank VALUES (
    2000,
    1,
    '원유'
);

INSERT INTO import_rank VALUES (
    2000,
    2,
    '반도체'
);

INSERT INTO import_rank VALUES (
    2000,
    3,
    '컴퓨터'
);

INSERT INTO import_rank VALUES (
    2000,
    4,
    '석유제품'
);

INSERT INTO import_rank VALUES (
    2000,
    5,
    '천연가스'
);

INSERT INTO import_rank VALUES (
    2000,
    6,
    '반도체제조용장비'
);

INSERT INTO import_rank VALUES (
    2000,
    7,
    '금은및백금'
);

INSERT INTO import_rank VALUES (
    2000,
    8,
    '유선통신기기'
);

INSERT INTO import_rank VALUES (
    2000,
    9,
    '철강판'
);

INSERT INTO import_rank VALUES (
    2000,
    10,
    '정밀화학원료'
);

INSERT INTO import_rank VALUES (
    2018,
    1,
    '원유'
);

INSERT INTO import_rank VALUES (
    2018,
    2,
    '반도체'
);

INSERT INTO import_rank VALUES (
    2018,
    3,
    '천연가스'
);

INSERT INTO import_rank VALUES (
    2018,
    4,
    '석유제품'
);

INSERT INTO import_rank VALUES (
    2018,
    5,
    '반도체제조용장비'
);

INSERT INTO import_rank VALUES (
    2018,
    6,
    '석탄'
);

INSERT INTO import_rank VALUES (
    2018,
    7,
    '컴퓨터'
);

INSERT INTO import_rank VALUES (
    2018,
    8,
    '정밀화학원료'
);

INSERT INTO import_rank VALUES (
    2018,
    9,
    '자동차'
);

INSERT INTO import_rank VALUES (
    2018,
    10,
    '무선통신기기'
);

COMMIT;

SELECT
    *
FROM
    export_rank;

SELECT
    *
FROM
    import_rank;

--TODO:  2018년(year) 수출(export_rank)과 수입(import_rank)을 동시에 많이한 품목(item)을 조회
-- 양쪽에 있는 것. insersect
SELECT
    item
FROM
    export_rank
WHERE
    year = 2018
INTERSECT
SELECT
    item
FROM
    import_rank
WHERE
    year = 2018;


--TODO:  2018년(export_rank.year) 주요 수출 품목(export_rank.item)중 2000년에는 없는 품목 조회
-- 2018-2000
SELECT
    item
FROM
    export_rank
WHERE
    year = 2018
MINUS
SELECT
    item
FROM
    export_rank
WHERE
    year = 2000;

--TODO: 1990 수출(export_rank)과 수입(import_rank) 랭킹에 포함된  품목(item)들을 합쳐서 조회. 중복된 품목도 나오도록 조회
--union all
SELECT
    item
FROM
    export_rank
WHERE
    year = 1990
UNION ALL
SELECT
    item
FROM
    import_rank
WHERE
    year = 1990;
--TODO: 1990 수출(export_rank)과 수입(import_rank) 랭킹에 포함된  품목(item)들을 합쳐서 조회. 중복된 품목은 안나오도록 조회
--union
SELECT
    item
FROM
    export_rank
WHERE
    year = 1990
UNION
SELECT
    item
FROM
    import_rank
WHERE
    year = 1990;

--TODO: 1990년과 2018년의 공통 주요 수출 품목(export_rank.item) 조회
-- intersect
SELECT
    item
FROM
    export_rank
WHERE
    year = 1990
INTERSECT
SELECT
    item
FROM
    export_rank
WHERE
    year = 2018;


--TODO: 1990년 주요 수출 품목(export_rank.item)중 2018년과 2000년에는 없는 품목 조회
--1990 - 2018 - 2000
SELECT
    item
FROM
    export_rank
WHERE
    year = 1990
MINUS
SELECT
    item
FROM
    export_rank
WHERE
    year = 2018
MINUS
SELECT
    item
FROM
    export_rank
WHERE
    year = 2000;
--TODO: 2000년 수입품목중(import_rank.item) 2018년에는 없는 품목을 조회.
-- 2000 - 2018
SELECT
    item
FROM
    import_rank
WHERE
    year = 2000
MINUS
SELECT
    item
FROM
    import_rank
WHERE
    year = 2018;