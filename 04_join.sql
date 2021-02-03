/* ****************************************
조인(JOIN) 이란
- 2개 이상의 테이블에 있는 컬럼들을 합쳐서 가상의 테이블을 만들어 조회하는 방식을 말한다.
 	- 소스테이블 : 내가 먼저 읽어야 한다고 생각하는 테이블 - 메인 데이터 테이블
	- 타겟테이블 : 소스를 읽은 후 소스에 조인할 대상이 되는 테이블 - 추가정보, 부가정보

- id 가 100인 """직원"""의 id.이름 연봉 부서이름 부서위치 --> 소스 직원, 타겟 부서
- id 가 100인 """부서"""의 이름, 위치, 소속직원의 이름, 연봉 --> 소스 부서, 타겟 직원 (부모/자식 관계 x)
 
- 각 테이블을 어떻게 합칠지를 표현하는 것을 조인 연산이라고 한다.
    - 조인 연산에 따른 조인종류
        - Equi join , non-equi join
- 조인의 종류
    - Inner Join 
        - 양쪽 테이블에서 조인 조건을 만족하는 행들만 합친다. 
    - Outer Join
        - 한쪽 테이블의 행들을 모두 사용하고 다른 쪽 테이블은 조인 조건을 만족하는 행만 합친다. 조인조건을 만족하는 행이 없는 경우 NULL을 합친다.
        - 종류 : Left Outer Join,  Right Outer Join, Full Outer Join
    - Cross Join
        - 두 테이블의 곱집합을 반환한다. 
- 조인 문법
    - ANSI 조인 문법
        - 표준 SQL 문법
        - 오라클은 9i 부터 지원.
    - 오라클 조인 문법
        - 오라클 전용 문법이며 다른 DBMS는 지원하지 않는다.
**************************************** */        
        

/* ****************************************
-- inner join : ANSI 조인 구문
FROM  테이블a (별칭) INNER JOIN 테이블b (별칭) ON 조인조건 

- inner는 생략 할 수 있다.
**************************************** */
-- 직원의 ID(emp.emp_id), 이름(emp.emp_name), 입사년도(emp.hire_date), 소속부서이름(dept.dept_name)을 조회
SELECT
    e.emp_id,
    e.emp_name,
    e.hire_date,
    d.dept_name,
    d.dept_id
FROM
         emp e
    INNER JOIN dept d ON e.dept_id = d.dept_id; -- inner join은 이 조건에 만족하는 조건(Not null)만 불러옴

-- 직원의 ID(emp.emp_id)가 100인 직원의 직원_ID(emp.emp_id), 이름(emp.emp_name), 입사년도(emp.hire_date), 소속부서이름(dept.dept_name)을 조회.
SELECT
    e.emp_id,
    e.emp_name,
    to_char(e.hire_date, 'yyyy"년"') hire_year
FROM
         emp e
    JOIN dept d ON e.dept_id = d.dept_id
WHERE
    e.emp_id = 100;

-- 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 담당업무명(job.job_title), 소속부서이름(dept.dept_name)을 조회
SELECT
    e.emp_id,
    e.emp_name,
    e.salary,
    j.job_title,
    d.dept_name
FROM
         emp e
    JOIN job   j ON e.job_id = j.job_id
    JOIN dept  d ON e.dept_id = d.dept_id;


-- 부서_ID(dept.dept_id)가 30인 부서의 이름(dept.dept_name), 위치(dept.loc), 그 부서에 소속된 직원의 이름(emp.emp_name)을 조회.
SELECT
    d.dept_name,
    d.loc,
    e.emp_name,
    d.dept_id
FROM
         dept d
    JOIN emp e ON d.dept_id = e.dept_id
--from    emp e join dept d on e.dept_id = d.dept_id
WHERE
    d.dept_id = 30;

-- 직원의 ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 급여등급(salary_grade.grade) 를 조회. 급여 등급 오름차순으로 정렬
SELECT
    e.emp_id,
    e.emp_name,
    e.salary,
    s.grade || '등급'
FROM
         emp e
    JOIN salary_grade s ON e.salary BETWEEN s.low_sal AND s.high_sal
ORDER BY
    4;
--TODO 200번대(200 ~ 299) 직원 ID(emp.emp_id)를 가진 직원들의 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 
--     소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회. 직원_ID의 오름차순으로 정렬.
SELECT
    e.emp_id,
    e.emp_name,
    e.salary,
--        e.dept_id,
--        d.dept_id,
    d.dept_name,
    d.loc
FROM
         emp e
    JOIN dept d ON e.dept_id = d.dept_id
WHERE
    e.emp_id BETWEEN 200 AND 299;

--TODO 업무(emp.job_id)가 'FI_ACCOUNT'인 직원의 ID(emp.emp_id), 이름(emp.emp_name), 업무(emp.job_id), 
--     소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회.  직원_ID의 오름차순으로 정렬.
SELECT
    e.emp_id,
    e.emp_name,
    e.job_id,
    d.dept_name,
    d.loc
FROM
         emp e
    JOIN dept d ON e.dept_id = d.dept_id
WHERE
    e.job_id = 'FI_ACCOUNT'
ORDER BY
    e.emp_id ASC;


--TODO 커미션비율(emp.comm_pct)이 있는 직원들의 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 커미션비율(emp.comm_pct), 
--     소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회. 직원_ID의 오름차순으로 정렬.
SELECT
    e.emp_id,
    e.emp_name,
    e.salary,
    e.comm_pct,
    d.dept_name,
    d.loc
FROM
         emp e
    JOIN dept d ON e.dept_id = d.dept_id
WHERE
    e.comm_pct IS NOT NULL
ORDER BY
    1 ASC;

--TODO 'New York'에 위치한(dept.loc) 부서의 부서_ID(dept.dept_id), 부서이름(dept.dept_name), 위치(dept.loc), 
--     그 부서에 소속된 직원_ID(emp.emp_id), 직원 이름(emp.emp_name), 업무(emp.job_id)를 조회. 부서_ID 의 오름차순으로 정렬.
SELECT
    d.dept_id,
    d.dept_name,
    d.loc,
    e.emp_id,
    e.emp_name,
    e.job_id
FROM
         dept d
    JOIN emp e ON d.dept_id = e.dept_id
WHERE
    d.loc = 'New York'
ORDER BY
    1;

SELECT
    *
FROM
    dept
WHERE
    loc = 'New York';

--TODO 직원_ID(emp.emp_id), 이름(emp.emp_name), 업무_ID(emp.job_id), 업무명(job.job_title) 를 조회.
SELECT
    e.emp_id,
    e.emp_name,
    j.job_id,
    j.job_title
FROM
         emp e
    JOIN job j ON e.job_id = j.job_id;

SELECT
    *
FROM
    emp
WHERE
    job_id IS NULL;
              
-- TODO: 직원 ID 가 200 인 직원의 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 
--       담당업무명(job.job_title), 소속부서이름(dept.dept_name)을 조회              
SELECT
    e.emp_id,
    e.emp_name,
    e.salary,
    j.job_title,
    d.dept_name
FROM
         emp e
    JOIN job   j ON e.job_id = j.job_id
    JOIN dept  d ON e.dept_id = d.dept_id
WHERE
    e.emp_id = 200;


-- TODO: 'Shipping' 부서의 부서명(dept.dept_name), 위치(dept.loc), 소속 직원의 이름(emp.emp_name), 업무명(job.job_title)을 조회. 
--       직원이름 내림차순으로 정렬
SELECT
    d.dept_name,
    d.loc,
    e.emp_name,
    j.job_title
FROM
         dept d
    JOIN emp  e ON d.dept_id = e.dept_id
    JOIN job  j ON e.job_id = j.job_id
WHERE
    d.dept_name = 'Shipping'
ORDER BY
    3 DESC;              


-- TODO:  'San Francisco' 에 근무(dept.loc)하는 직원의 id(emp.emp_id), 이름(emp.emp_name), 입사일(emp.hire_date)를 조회
--         입사일은 'yyyy-mm-dd' 형식으로 출력
SELECT
    e.emp_id,
    e.emp_name,
    to_char(e.hire_date, 'yyyy/mm/dd') hire_date
FROM
         emp e
    JOIN dept d ON e.dept_id = d.dept_id
WHERE
    d.loc = 'San Francisco';


-- TODO 부서별 급여(salary)의 평균을 조회. 부서이름(dept.dept_name)과 급여평균을 출력. 급여 평균이 높은 순서로 정렬.
-- 급여는 , 단위구분자와 $ 를 붙여 출력.

SELECT
    d.dept_id,
    d.dept_name,
    to_char(round(AVG(salary), 2), '$999,999') salary_평균
FROM
         emp e
    JOIN dept d ON e.dept_id = d.dept_id
GROUP BY
    d.dept_id,
    d.dept_name
ORDER BY
    3 DESC;

--100 Sales New York
--200 Sales SF
SELECT
    dept_id,
    avg
( SALARY FROM emp
group by dept_id;

--TODO 직원의 ID(emp.emp_id), 이름(emp.emp_name), 업무명(job.job_title), 급여(emp.salary), 
--     급여등급(salary_grade.grade), 소속부서명(dept.dept_name)을 조회. 등급 내림차순으로 정렬
select  e.emp_id,
        e.emp_name,
        j.job_title,
        e.salary,
        s.grade||'등급' grade,
        d.dept_name
from    emp e join job j on e.job_id = j.job_id
              join salary_grade s on e.salary between s.low_sal and s.high_sal
              join dept d on e.dept_id = d.dept_id
order by s.grade;              


--TODO 부서별 급여등급이(salary_grade.grade) 1인 직원있는 부서이름(dept.dept_name)과 1등급인 직원수 조회. 직원수가 많은 부서 순서대로 정렬.
select  d.dept_name,
        count(*) 직원수
from    emp e join dept d on e.dept_id = d.dept_id
              join salary_grade s on e.salary between s.low_sal and s.high_sal
where  s.grade = 1
group by d.dept_id, d.dept_name
order by 1;


select * from salary_grade;


SELECT
    d.dept_name,
    COUNT(*) 직원수
FROM
         emp e
    JOIN dept          d ON e.dept_id = d.dept_id
    JOIN salary_grade  s ON e.salary BETWEEN s.low_sal AND s.high_sal
WHERE
    s.grade = 1
GROUP BY
    d.dept_name
ORDER BY
    2 DESC;


/* ###################################################################################### 
오라클 조인 
- Join할 테이블들을 from절에 나열한다.
- Join 연산은 where절에 기술한다. 

###################################################################################### */
-- 직원의 ID(emp.emp_id), 이름(emp.emp_name), 입사년도(emp.hire_date), 소속부서이름(dept.dept_name)을 조회
-- 입사년도는 년도만 출력
SELECT
    e.emp_id,
    e.emp_name,
    to_char(hire_date, 'yyyy"년"') 입사년도,
    d.dept_name
FROM
    emp   e,
    dept  d
WHERE
    e.emp_id = d.dept_id;


-- 직원의 ID(emp.emp_id)가 100인 직원의 직원_ID(emp.emp_id), 이름(emp.emp_name), 입사년도(emp.hire_date), 소속부서이름(dept.dept_name)을 조회
-- 입사년도는 년도만 출력
SELECT
    e.emp_id,
    e.emp_name,
    to_char(hire_date, 'yyyy"년"') 입사년도,
    d.dept_name
FROM
    emp   e,
    dept  d
WHERE
        e.emp_id = d.dept_id
    AND e.emp_id = 100;


-- 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 담당업무명(job.job_title), 소속부서이름(dept.dept_name)을 조회
SELECT
    e.emp_id,
    e.emp_name,
    e.salary,
    j.job_title,
    d.dept_name
FROM
    emp   e,
    dept  d,
    job   j
WHERE
        e.emp_id = d.dept_id
    AND e.job_id = j.job_id;


--TODO 200번대(200 ~ 299) 직원 ID(emp.emp_id)를 가진 직원들의 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 
--     소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회. 직원_ID의 오름차순으로 정렬.
SELECT
    e.emp_id,
    e.emp_name,
    e.salary,
    d.dept_name,
    d.loc
FROM
    emp   e,
    dept  d
WHERE
    e.dept_id = d.dept_id
ORDER BY
    1;


--TODO 업무(emp.job_id)가 'FI_ACCOUNT'인 직원의 ID(emp.emp_id), 이름(emp.emp_name), 업무(emp.job_id), 
--     소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회.  직원_ID의 오름차순으로 정렬.
SELECT
    e.emp_id,
    e.emp_name,
    e.job_id,
    d.dept_name,
    d.loc
FROM
    emp   e,
    dept  d
WHERE
        e.dept_id = d.dept_id
    AND e.job_id = 'FI_ACCOUNT';


--TODO 커미션비율(emp.comm_pct)이 있는 직원들의 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 커미션비율(emp.comm_pct), 
--     소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회. 직원_ID의 오름차순으로 정렬.

SELECT
    e.emp_id,
    e.emp_name,
    e.salary,
    e.comm_pct,
    d.dept_name,
    d.loc
FROM
    emp   e,
    dept  d
WHERE
        e.dept_id = d.dept_id
    AND e.comm_pct IS NOT NULL
ORDER BY
    1;


--TODO 'New York'에 위치한(dept.loc) 부서의 부서_ID(dept.dept_id), 부서이름(dept.dept_name), 위치(dept.loc), 
--     그 부서에 소속된 직원_ID(emp.emp_id), 직원 이름(emp.emp_name), 업무(emp.job_id)를 조회. 부서_ID 의 오름차순으로 정렬.
SELECT
    d.dept_id,
    d.dept_name,
    d.loc,
    e.emp_id,
    e.emp_name,
    e.job_id
FROM
    emp   e,
    dept  d
WHERE
        d.dept_id = e.dept_id
    AND d.loc = 'New York'
ORDER BY
    1;



--TODO 직원_ID(emp.emp_id), 이름(emp.emp_name), 업무_ID(emp.job_id), 업무명(job.job_title) 를 조회.

SELECT
    e.emp_id,
    e.emp_name,
    e.job_id,
    j.job_title
FROM
    emp  e,
    job  j
WHERE
    e.job_id = j.job_id;

             
-- TODO: 직원 ID 가 200 인 직원의 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 
--       담당업무명(job.job_title), 소속부서이름(dept.dept_name)을 조회              
SELECT
    e.emp_id,
    e.emp_name,
    e.salary,
    j.job_title,
    d.dept_name
FROM
    emp   e,
    job   j,
    dept  d
WHERE
        e.job_id = j.job_id
    AND e.emp_id = 200;



-- TODO: 'Shipping' 부서의 부서명(dept.dept_name), 위치(dept.loc), 소속 직원의 이름(emp.emp_name), 업무명(job.job_title)을 조회. 
--       직원이름 내림차순으로 정렬
SELECT
    d.dept_name,
    d.loc,
    e.emp_name,
    j.job_title
FROM
    emp   e,
    dept  d,
    job   j
WHERE
        e.dept_id = d.dept_id
    AND e.job_id = j.job_id
    AND d.dept_name = 'Shipping'
ORDER BY
    3 DESC;


-- TODO:  'San Francisco' 에 근무(dept.loc)하는 직원의 id(emp.emp_id), 이름(emp.emp_name), 입사일(emp.hire_date)를 조회
--         입사일은 'yyyy-mm-dd' 형식으로 출력

SELECT
    e.emp_id,
    e.emp_name,
    to_char(e.hire_date, 'yyyy-mm-dd') "yyyy-mm-dd"
FROM
    emp   e,
    dept  d
WHERE
        e.dept_id = d.dept_id
    AND d.loc = 'San Francisco';


--TODO 부서별 급여(salary)의 평균을 조회. 부서이름(dept.dept_name)과 급여평균을 출력. 급여 평균이 높은 순서로 정렬.
-- 급여는 , 단위구분자와 $ 를 붙여 출력.
SELECT
    to_char(round(AVG(salary), 2), 'fmL999,999,999.99') sal_avg,
    d.dept_name
FROM
    emp   e,
    dept  d
WHERE
    e.dept_id = d.dept_id
GROUP BY
    d.dept_name
ORDER BY
    AVG(salary) DESC; -- 숫자 자체를 order by에 적용



--TODO 직원의 ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 급여등급(salary_grade.grade) 를 조회. 직원 id 오름차순으로 정렬
SELECT
    e.emp_id,
    e.emp_name,
    e.salary,
    s.grade
FROM
    emp           e,
    salary_grade  s
WHERE
    e.salary BETWEEN s.low_sal AND s.high_sal
ORDER BY
    1;

--TODO 직원의 ID(emp.emp_id), 이름(emp.emp_name), 업무명(job.job_title), 급여(emp.salary), 
--     급여등급(salary_grade.grade), 소속부서명(dept.dept_name)을 조회. 등급 내림차순으로 정렬
SELECT
    e.emp_id,
    e.emp_name,
    j.job_title,
    e.salary,
    s.grade,
    d.dept_name
FROM
    emp           e,
    dept          d,
    job           j,
    salary_grade  s
WHERE
        e.job_id = j.job_id
    AND e.dept_id = d.dept_id
    AND e.salary BETWEEN s.low_sal AND s.high_sal
ORDER BY
    s.grade DESC;


--TODO 부서별 급여등급이(salary_grade.grade) 1인 직원있는 부서이름(dept.dept_name)과 1등급인 직원수 조회. 직원수가 많은 부서 순서대로 정렬.
SELECT
    d.dept_name,
    COUNT(*)
FROM
    emp           e,
    dept          d,
    salary_grade  s
WHERE
        e.dept_id = d.dept_id
    AND e.salary BETWEEN s.low_sal AND s.high_sal
    AND s.grade = 1
GROUP BY
    d.dept_name
ORDER BY
    2;



/* ****************************************************
Self 조인
- 물리적으로 하나의 테이블을 두개의 테이블처럼 조인하는 것.
**************************************************** */
--직원의 ID(emp.emp_id), 이름(emp.emp_name), 상사이름(emp.emp_name)을 조회
SELECT
    e1.emp_id,
    e1.emp_name    부하이름,
    e1.salary,
    e2.emp_id,
    e2.emp_name    상사이름,
    e2.salary
FROM
         emp e1
    JOIN emp e2 ON e1.mgr_id = e2.emp_id;

SELECT
    e1.emp_id,
    e1.emp_name    부하이름,
    e1.salary,
    e2.emp_id,
    e2.emp_name    상사이름,
    e2.salary
FROM
    emp  e1,
    emp  e2
WHERE
    e1.mgr_id = e2.emp_id;


-- TODO : EMP 테이블에서 직원 ID(emp.emp_id)가 110인 직원의 급여(salary)보다 많이 받는 직원들의 id(emp.emp_id), 
-- 이름(emp.emp_name), 급여(emp.salary)를 직원 ID(emp.emp_id) 오름차순으로 조회.
SELECT
    e2.emp_id,
    e2.emp_name,
    e2.salary,
    e1.salary
FROM
         emp e1
    JOIN emp e2 ON e1.salary < e2.salary
WHERE
    e1.emp_id = 110
ORDER BY
    3;

SELECT
    e2.emp_id,
    e2.emp_name,
    e2.salary,
    e1.salary
FROM
    emp  e1,
    emp  e2
WHERE
        e1.salary < e2.salary
    AND e1.emp_id = 110
ORDER BY
    3;


--카티션 곱 : join연산을 잘못해서 두 테이블의 모든 행들이 cross로 join된것
-- 6개 Tables -> join 연산 최소 5개
-- N개 Tables -> join 연산 최소 n-1개
-- 오라클 조인에서 발생
SELECT
    *
FROM
    emp   e,
    dept  d;

-- 부모-자식 테이블간 조인연산 : 부모 pk 컬럼 = 자식 fk 컬럼


/* ****************************************************
아우터 조인 (Outer Join)
- 조인테이블에 소스 테이블의 행은 모두 붙이고 타겟테이블의 행은 조인여산을 만족하는 것만 붙인다.

-불충분 조인 (조인 연산시 한쪽의 행이 불충분 해도 붙이도록) 
 - 소스(완전해야하는테이블)가 왼쪽이면 left join, 오른쪽이면 right join 양쪽이면 full outer join

-ANSI 문법
from 테이블a [LEFT | RIGHT | FULL] OUTER JOIN 테이블b ON 조인조건
- OUTER는 생략 가능.

-오라클 JOIN 문법
- FROM 절에 조인할 테이블을 나열
- WHERE 절에 조인 조건을 작성
    - 타겟 테이블에 (+) 를 붙인다.
    - FULL OUTER JOIN은 지원하지 않는다.
**************************************************** */
-- 직원의 id(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 부서명(dept.dept_name), 부서위치(dept.loc)를 조회. 
-- 부서가 없는 직원의 정보도 나오도록 조회. (부서정보는 null). dept_name의 내림차순으로 정렬한다.
SELECT
    e.emp_id,
    e.emp_name,
    e.salary,
    d.dept_name,
    d.loc
FROM
    emp   e
    LEFT JOIN dept  d ON e.dept_id = d.dept_id -- outer 생략 가능
--from    dept d right outer
ORDER BY
    dept_name;

-- 오라클문법
SELECT
    e.emp_id,
    e.emp_name,
    e.salary,
    d.dept_name,
    d.loc
FROM
    emp   e,
    dept  d
WHERE
    e.dept_id = d.dept_id (+)
ORDER BY
    d.dept_name DESC; -- e:Source , d: Target

-- 모든 직원의 id(emp.emp_id), 이름(emp.emp_name), 부서_id(emp.dept_id)를 조회하는데
-- 부서_id가 80 인 직원들은 부서명(dept.dept_name)과 부서위치(dept.loc) 도 같이 출력한다. (부서 ID가 80이 아니면 null이 나오도록)

SELECT
    e.emp_id,
    e.emp_name,
    e.dept_id,
    d.dept_name,
    d.loc
FROM
    emp   e
    LEFT JOIN dept  d ON e.dept_id = d.dept_id
                        AND d.dept_id = 80;

--오라클 문법
SELECT
    e.emp_id,
    e.emp_name,
    e.dept_id,
    d.dept_name,
    d.loc
FROM
    emp   e,
    dept  d
WHERE
        e.dept_id = d.dept_id (+)
    AND d.dept_id (+) = 80;


--TODO: 직원_id(emp.emp_id)가 100, 110, 120, 130, 140인 직원의 ID(emp.emp_id), 이름(emp.emp_name), 업무명(job.job_title) 을 조회. 
-- 업무명이 없을 경우 '미배정' 으로 조회
SELECT
    e.emp_id,
    e.emp_name,
    nvl(j.job_title, '미배정')
FROM
    emp  e
    LEFT JOIN job  j ON e.job_id = j.job_id
WHERE
    e.emp_id IN ( 100, 110, 120, 130, 140 );

--오라클 문법
SELECT
    e.emp_id,
    e.emp_name,
    nvl(j.job_title, '미배정')
FROM
    emp  e,
    job  j
WHERE
        e.job_id = j.job_id (+)
    AND e.emp_id IN ( 100, 110, 120, 130, 140 );

--TODO: 부서의 ID(dept.dept_id), 부서이름(dept.dept_name)과 그 부서에 속한 직원들의 수를 조회. 
--      직원이 없는 부서는 0이 나오도록 조회하고 직원수가 많은 부서 순서로 조회.

SELECT
    d.dept_id,
    d.dept_name,
    COUNT(e.emp_id) 직원수 -- 직원관련 pk컬럼 count()
FROM
    dept  d
    LEFT JOIN emp   e ON d.dept_id = e.dept_id
GROUP BY (
    d.dept_id,
    d.dept_name
)
ORDER BY
    3;

--오라클 문법
SELECT
    d.dept_id,
    d.dept_name,
    COUNT(e.emp_id) 직원수
FROM
    dept  d,
    emp   e
WHERE
    d.dept_id = e.dept_id (+)
GROUP BY (
    d.dept_id,
    d.dept_name
)
ORDER BY
    3;

-- TODO: EMP 테이블에서 부서_ID(emp.dept_id)가 90 인 직원들의 id(emp.emp_id), 이름(emp.emp_name), 상사이름(emp.emp_name), 입사일(emp.hire_date)을 조회. 
-- 입사일은 yyyy-mm-dd 형식으로 출력

SELECT
    e1.emp_id,
    e1.emp_name,
    e2.emp_name,
    to_char(e1.hire_date, 'yyyy-mm-dd') 입사일
FROM
    emp  e1
    LEFT JOIN emp  e2 ON e1.mgr_id = e2.emp_id
WHERE
    e1.dept_id = 90;

--오라클 문법
SELECT
    e1.emp_id,
    e1.emp_name,
    e2.emp_name,
    to_char(e1.hire_date, 'yyyy-mm-dd') 입사일
FROM
    emp  e1,
    emp  e2
WHERE
        e1.mgr_id = e2.emp_id (+)
    AND e1.dept_id = 90;
-- TODO 2003년~2005년 사이에 입사한 직원의 id(emp.emp_id), 이름(emp.emp_name), 업무명(job.job_title), 급여(emp.salary), 입사일(emp.hire_date),
-- 상사이름(emp.emp_name), 상사의입사일(emp.hire_date), 소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회.
-- 2003년에서 2005년 사이 입사한 직원은 모두 나오도록 조회한다. 

SELECT
    e1.emp_id       직원id,
    e1.emp_name     직원이름,
    j.job_title     직원업무명,
    e1.salary       직원급여,
    e1.hire_date    직원입사일,
    e2.emp_name     상사이름,
    e2.hire_date    상사입사일,
    d.dept_name     직원부서명,
    d.loc           직원부서위치,
    d2.dept_name    상사부서명;
--select e1.*, j.*            -------------------해당 테이블 정보 전체 출력
FROM
    emp   e1
    LEFT JOIN job   j ON e1.job_id = j.job_id
    LEFT JOIN emp   e2 ON e1.mgr_id = e2.emp_id
    LEFT JOIN dept  d ON e1.dept_id = d.dept_id    --d: 직원의 부서 TB
    LEFT JOIN dept  d2 ON e2.dept_id = d2.dept_id  --d: 상사의 부서 TB
WHERE
    EXTRACT(YEAR FROM e1.hire_date) BETWEEN 2003 AND 2005;
SELECT
    e1.emp_id       직원id,
    e1.emp_name     직원이름,
    j.job_title     직원업무명,
    e1.salary       직원급여,
    e1.hire_date    직원입사일,
    e2.emp_name     상사이름,
    e2.hire_date    상사입사일,
    d.dept_name     직원부서명,
    d.loc           직원부서위치,
    d2.dept_name    상사부서명
FROM
    emp   e1,
    job   j,
    emp   e2,
    dept  d,
    dept  d2
WHERE
        e1.job_id = j.job_id (+)
    AND e1.mgr_id = e2.emp_id (+)
        AND e1.dept_id = d.dept_id (+)
            AND e2.dept_id = d2.dept_id (+)
                AND EXTRACT(YEAR FROM e1.hire_date) BETWEEN 2003 AND 2005
ORDER BY
    1;