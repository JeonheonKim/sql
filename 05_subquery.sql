/* **************************************************************************
서브쿼리(Sub Query)
- 쿼리(insert, delete, update, select)안에서 select 쿼리를 사용하는 것.
- 메인 쿼리 - 서브쿼리

서브쿼리가 사용되는 구
 - select절, from절, where절, having절
 
서브쿼리의 종류
- 어느 구절에 사용되었는지에 따른 구분
    - 스칼라 서브쿼리 - select 절에 사용. 반드시 서브쿼리 결과가 1행 1열(값 하나-스칼라) 0행이 조회되면 null을 반환
    - 인라인 뷰 - from 절에 사용되어 테이블의 역할을 한다.
서브쿼리 조회결과 행수에 따른 구분
    - 단일행 서브쿼리 - 서브쿼리의 조회결과 행이 한행인 것.
    - 다중행 서브쿼리 - 서브쿼리의 조회결과 행이 여러행인 것.
동작 방식에 따른 구분
    - 비상관(비연관) 서브쿼리 - 서브쿼리에 메인쿼리의 컬럼이 사용되지 않는다. 메인쿼리에 사용할 값을 서브쿼리가 제공하는 역할을 한다.
    - 상관(연관) 서브쿼리 - 서브쿼리에서 메인쿼리의 컬럼을 사용한다. 
                            메인쿼리가 먼저 수행되어 읽혀진 데이터를 서브쿼리에서 조건이 맞는지 확인하고자 할때 주로 사용한다.

- 서브쿼리는 반드시 ( ) 로 묶어줘야 한다.
************************************************************************** */
--단일행 서브쿼리

-- 직원_ID(emp.emp_id)가 120번인 직원과 같은 업무(emp.job_id)가진 
-- 직원의 id(emp_id),이름(emp.emp_name), 업무(emp.job_id), 급여(emp.salary) 조회
SELECT
    emp_id,
    emp_name,
    job_id,
    salary
FROM
    emp
WHERE
    job_id = (
        SELECT
            job_id
        FROM
            emp
        WHERE
            emp_id = 120
    );


-- 직원_id(emp.emp_id)가 115번인 직원과 같은 업무(emp.job_id)를 하고 같은 부서(emp.dept_id)에 속한 직원들을 조회하시오.

-- pair 방식 서브쿼리
SELECT
    *
FROM
    emp
WHERE
    ( job_id,
      dept_id ) = (
        SELECT
            job_id,
            dept_id
        FROM
            emp
        WHERE
            emp_id = 115
    );


-- 직원들 중 급여(emp.salary)가 전체 직원의 평균 급여보다 적은 
-- 직원들의 id(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary)를 조회. 급여(emp.salary) 내림차순 정렬.
SELECT
    emp_id,
    emp_name,
    salary
FROM
    emp
WHERE
    salary < (
        SELECT
            AVG(salary)
        FROM
            emp
    )
ORDER BY
    3 DESC;



-- 전체 직원의 평균 급여(emp.salary) 이상을 받는 부서의  이름(dept.dept_name), 소속직원들의 평균 급여(emp.salary) 출력. 
-- 평균급여는 소숫점 2자리까지 나오고 통화표시($)와 단위 구분자 출력

SELECT
    d.dept_name,
    to_char(round(AVG(e.salary), 2), 'fm$999,999.99') 평균급여
FROM
         emp e
    JOIN dept d ON e.dept_id = d.dept_id
GROUP BY
    d.dept_name
HAVING
    AVG(e.salary) > (
        SELECT
            AVG(e.salary)
        FROM
            emp e
    );



-- TODO: 직원의 ID(emp.emp_id)가 145인 직원보다 많은 연봉을 받는 직원들의 이름(emp.emp_name)과 급여(emp.salary) 조회.
-- 급여가 큰 순서대로 조회
SELECT
    emp_name,
    salary
FROM
    emp
WHERE
    salary > (
        SELECT
            salary
        FROM
            emp
        WHERE
            emp_id = 145
    )
ORDER BY
    2 DESC;


-- TODO: 직원의 ID(emp.emp_id)가 150인 직원과 같은 업무(emp.job_id)를 하고 같은 상사(emp.mgr_id)를 가진 직원들의 
-- id(emp.emp_id), 이름(emp.emp_name), 업무(emp.job_id), 상사(emp.mgr_id) 를 조회

SELECT
    emp_id,
    emp_name,
    job_id,
    mgr_id
FROM
    emp
WHERE
        ( job_id,
          mgr_id ) = (
            SELECT
                job_id,
                mgr_id
            FROM
                emp
            WHERE
                emp_id = 150
        )
    AND emp_id <> 150;


-- TODO : EMP 테이블에서 직원 이름이(emp.emp_name)이  'John'인 직원들 중에서 급여(emp.salary)가 가장 높은 직원의 salary(emp.salary)보다 많이 받는 
-- 직원들의 id(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary)를 직원 ID(emp.emp_id) 오름차순으로 조회.

SELECT
    emp_id,
    emp_name,
    salary
FROM
    emp
WHERE
    salary > (
        SELECT
            MAX(salary)
        FROM
            emp
        WHERE
            emp_name = 'John'
    )
ORDER BY
    1;
-- TODO: 급여(emp.salary)가 가장 높은 직원이 속한 부서의 이름(dept.dept_name), 위치(dept.loc)를 조회.

SELECT
    d.dept_name,
    d.loc
FROM
         emp
    JOIN dept d ON emp.dept_id = d.dept_id
WHERE
    salary = (
        SELECT
            MAX(salary)
        FROM
            emp
    );


-- TODO: 급여(emp.salary)를 제일 많이 받는 직원들의 이름(emp.emp_name), 부서명(dept.dept_name), 급여(emp.salary) 조회. 
--       급여는 앞에 $를 붙이고 단위구분자 , 를 출력

SELECT
    e.emp_name,
    d.dept_name,
    e.salary
FROM
    emp   e
    LEFT JOIN dept  d ON e.dept_id = d.dept_id
WHERE
    salary = (
        SELECT
            MAX(e.salary)
        FROM
            emp e
    );



-- TODO: 담당 업무ID(emp.job_id) 가 'ST_CLERK'인 직원들의 평균 급여보다 적은 급여를 받는 직원들의 모든 정보를 조회. 단 업무 ID가 'ST_CLERK'이 아닌 직원들만 조회. 

SELECT
    *
FROM
    emp
WHERE
        salary < (
            SELECT
                AVG(salary)
            FROM
                emp
            WHERE
                job_id = 'ST_CLERK'
        )
    AND ( job_id != 'ST_CLERK' -- JOB_ID 가 NULL 인 항 삭제됨. 
          OR job_id IS NULL ); -- OR 연산자로 NULL인 항 포함.


-- TODO: 30번 부서(emp.dept_id) 의 평균 급여(emp.salary)보다 급여가 많은 직원들의 모든 정보를 조회.

SELECT
    *
FROM
         emp e
    JOIN dept d ON e.dept_id = d.dept_id
WHERE
    e.salary > (
        SELECT
            AVG(e.salary)
        FROM
            emp e
        WHERE
            e.dept_id = 30
    );


-- TODO: EMP 테이블에서 업무(emp.job_id)가 'IT_PROG' 인 직원들의 평균 급여 이상을 받는 
-- 직원들의 id(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary)를 급여 내림차순으로 조회.

SELECT
    emp_id,
    emp_name,
    salary
FROM
    emp
WHERE
    salary > (
        SELECT
            AVG(salary)
        FROM
            emp
        WHERE
            job_id = 'IT_PROG'
    )
ORDER BY
    3 DESC;


-- TODO: 'IT' 부서(dept.dept_name)의 최대 급여보다 많이 받는 직원의 ID(emp.emp_id), 이름(emp.emp_name), 입사일(emp.hire_date), 부서 ID(emp.dept_id), 급여(emp.salary) 조회
-- 입사일은 "yyyy년 mm월 dd일" 형식으로 출력
-- 급여는 앞에 $를 붙이고 단위구분자 , 를 출력

SELECT
    emp_id,
    emp_name,
    to_char(hire_date, 'yyyy"년" mm"월" dd"일"') hire_date,
    salary
FROM
    emp
WHERE
    salary > (
        SELECT
            MAX(e.salary)
        FROM
                 emp e
            JOIN dept d ON e.dept_id = d.dept_id
        WHERE
            d.dept_name = 'IT'
    )
ORDER BY
    4;                


/* ----------------------------------------------
 다중행 서브쿼리
 - 서브쿼리의 조회 결과가 여러행인 경우
 - where절 에서의 연산자
	- in
	- 비교연산자 any : 조회된 값들 중 하나만 참이면 참 (where 컬럼 > any(서브쿼리) )
	- 비교연산자 all : 조회된 값들 모두와 참이면 참 (where 컬럼 > all(서브쿼리) )
------------------------------------------------*/
--'Alexander' 란 이름(emp.emp_name)을 가진 관리자(emp.mgr_id)의 
-- 부하 직원들의 ID(emp_id), 이름(emp_name), 업무(job_id), 입사년도(hire_date-년도만출력), 급여(salary)를 조회
-- 급여는 앞에 $를 붙이고 단위구분자 , 를 출력

SELECT
    emp_id,
    emp_name,
    job_id,
    EXTRACT(YEAR FROM hire_date),
    to_char(salary, 'fm$999,999,999')
FROM
    emp
WHERE
    mgr_id IN (
        SELECT
            emp_id
        FROM
            emp
        WHERE
            emp_name = 'Alexander'
    );

-- 직원 ID(emp.emp_id)가 101, 102, 103 인 직원들 보다 급여(emp.salary)를 많이 받는 직원의 모든 정보를 조회.

SELECT
    *
FROM
    emp
WHERE
    salary > (
        SELECT
            MAX(salary)
        FROM
            emp
        WHERE
            emp_id IN ( 101, 102, 103 )
    );

-- 직원 ID(emp.emp_id)가 101, 102, 103 인 직원들 중 급여가 가장 적은 직원보다 급여를 많이 받는 직원의 모든 정보를 조회.
SELECT
    *
FROM
    emp
WHERE
    salary > (
        SELECT
            MIN(salary)
        FROM
            emp
        WHERE
            emp_id IN ( 101, 102, 103 )
    );

-- TODO : 부서 위치(dept.loc) 가 'New York'인 부서에 소속된 직원의 ID(emp.emp_id), 이름(emp.emp_name), 부서_id(emp.dept_id) 를 sub query를 이용해 조회.

SELECT
    e.emp_id,
    e.emp_name,
    e.dept_id
FROM
    emp e
WHERE
    dept_id IN (
        SELECT
            dept_id
        FROM
            dept
        WHERE
            loc = 'New York'
    );

-- TODO : 최대 급여(job.max_salary)가 6000이하인 업무를 담당하는 직원(emp)의 모든 정보를 sub query를 이용해 조회.

SELECT
    *
FROM
    emp
WHERE
    job_id IN (
        SELECT
            job_id
        FROM
            job
        WHERE
            max_salary <= 6000
    );

-- TODO: 부서_ID(emp.dept_id)가 20인 부서의 직원들 보다 급여(emp.salary)를 많이 받는 직원들의 정보를  sub query를 이용해 조회.
SELECT
    *
FROM
    emp
WHERE
    salary > ALL (
        SELECT
            salary
        FROM
            emp
        WHERE
            dept_id = 20
    );


-- TODO: 부서별 급여의 평균중 가장 적은 부서의 평균 급여보다 보다 많이 받는 직원들이 이름, 급여, 업무를 sub query를 이용해 조회
SELECT
    emp_name,
    salary,
    job_id
FROM
    emp
WHERE
    salary > ANY (
        SELECT
            ( AVG(salary) )
        FROM
            emp
        GROUP BY
            dept_id
    );

-- TODO: 업무 id(job_id)가 'SA_REP' 인 직원들중 가장 많은 급여를 받는 직원보다 많은 급여를 받는 직원들의 이름(emp_name), 급여(salary), 업무(job_id) 를 sub query를 이용해 조회.

SELECT
    emp_name,
    salary,
    job_id
FROM
    emp
WHERE
    salary > ALL (
        SELECT
            salary
        FROM
            emp
        WHERE
            job_id = 'SA_REP'
    );


-- 비상관쿼리 실행 순서 : subquery 실행 -> subquery 실행결과를 가지고 main 쿼리가 실행.
/* ****************************************************************
상관(연관) 쿼리
메인쿼리문의 조회값을 서브쿼리의 조건에서 사용하는 쿼리.
메인쿼리를 실행하고 그 결과를 바탕으로 서브쿼리의 조건절을 비교한다.
* ****************************************************************/
-- 각 부서에서(DEPT) 급여(emp.salary)를 가장 많이 받는 직원들의 id(emp.emp_id), 이름(emp.emp_name), 연봉(emp.salary), 소속부서ID(dept.dept_id) 조회
select  e.emp_id,
        e.emp_name,
        e.salary,
        nvl(to_char(e.dept_id),'미배정') 부서
from    emp e
where   salary = (select max(salary) from emp where nvl(dept_id,0) = nvl(e.dept_id,0))
order by 4;


/* ******************************************************************************************************************
EXISTS, NOT EXISTS 연산자 (상관(연관)쿼리와 같이 사용된다)
-- 서브쿼리의 결과를 만족하는 값이 존재하는지 여부를 확인하는 조건. 조건을 만족하는 행이 여러개라도 한행만 있으면 더이상 검색하지 않는다.

데이터 테이블(고객, 장비 - 부모) -Transaction(내역) 테이블(주문, 대여 - 자식)
-- 내역테이블에서 데이터 테이블의 값이 참조되고 있는지(ExISTS) 없는지(NOT EXISTS)
-- 고객 중에 (한번이상) 주문한 고객
**********************************************************************************************************************/


-- 직원이 한명이상 있는 부서의 부서ID(dept.dept_id)와 이름(dept.dept_name), 위치(dept.loc)를 조회

select  d.dept_id,
        d.dept_name,
        d.loc
from dept d
where EXISTS (select * from emp e where e.dept_id = d.dept_id); -- column 명 중요 x , where 절의 존재 유무만 확인

select * from dept
where dept_id in (select distinct dept_id from emp)
order by 1; -- 전체데이터 다 비교, 서브쿼리 안의 Table 모든 행 스캔 후 결과 출력,
            -- but EXISTS 는 break 조건이 포함, 즉 하나만 만족 하면 바로 출력

-- 직원이 한명도 없는 부서의 부서ID(dept.dept_id)와 이름(dept.dept_name), 위치(dept.loc)를 조회

select  d.dept_id,
        d.dept_name,
        d.loc
from    dept d
where   NOT EXISTS (select * from emp e where e.dept_id = d.dept_id);

-- 부서(dept)에서 연봉(emp.salary)이 13000이상인 한명이라도 있는 부서의 부서ID(dept.dept_id)와 이름(dept.dept_name), 위치(dept.loc)를 조회

select  *
from    dept d
where exists (select * from emp e where e.dept_id = d.dept_id and salary >= 13000); 



/* ******************************
주문 관련 테이블들 이용.
******************************* */

--TODO: 고객(customers) 중 주문(orders)을 한번 이상 한 고객들을 조회.
select *
from customers c
where exists (select * from orders o where o.cust_id = c.cust_id);
--TODO: 고객(customers) 중 주문(orders)을 한번도 하지 않은 고객들을 조회.
select *
from customers c
where not exists (select * from orders o where o.cust_id = c.cust_id);

--TODO: 제품(products) 중 한번이상 주문된 제품 정보 조회
select *
from products p
where exists (select * from order_items oi where oi.product_id = p.product_id);


--TODO: 제품(products)중 주문이 한번도 안된 제품 정보 조회