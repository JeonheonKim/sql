/* *************************************
함수 - 문자열관련 함수
 UPPER()/ LOWER() : 대문자/소문자 로 변환
 INITCAP(): 단어 첫글자만 대문자 나머진 소문자로 변환
 LENGTH() : 글자수 조회
 LPAD(값, 크기, 채울값) : "값"을 지정한 "크기"의 고정길이 문자열로 만들고 모자라는 것은 왼쪽부터 "채울값"으로 채운다.
 RPAD(값, 크기, 채울값) : "값"을 지정한 "크기"의 고정길이 문자열로 만들고 모자라는 것은 오른쪽부터 "채울값"으로 채운다.
 SUBSTR(값, 시작index, 글자수) - "값"에서 "시작index"번째 글자부터 지정한 "글자수" 만큼의 문자열을 추출. 글자수 생략시 끝까지. 
 REPLACE(값, 찾을문자열, 변경할문자열) - "값"에서 "찾을문자열"을 "변경할문자열"로 바꾼다.
 LTRIM(값): 왼공백 제거
 RTRIM(값): 오른공백 제거
 TRIM(값): 양쪽 공백 제거
 ************************************* */

SELECT
    upper('aa')            대문자,
--        initcap('abcde abecd'),
--        length ('asdfsdf a  '),
--        lpad('abc',10,'+') A,
--        rpad('abc',10) B,
--        rpad('1234567',3),
    substr('123456789', '2', '5'), -- 2번째글자부터 5글자만
    substr('123456789', '2'), -- 2번째글자부터 끝까지
    replace('010-1234-5678', '5678', '#'),
    TRIM('   abc   ')      "A",
    ltrim('   abc   ')     "B",
    rtrim('   abc   ')     "c"
FROM
    dual;

SELECT
    upper(emp_name),
    lower(emp_name),
    initcap(emp_name),
    length(emp_name)
FROM
    emp;

SELECT
    TRIM(emp_name)
FROM
    emp;

SELECT
    *
FROM
    emp
WHERE
    length(emp_name) > 10;


--EMP 테이블에서 직원의 이름(emp_name)을 모두 대문자, 소문자, 첫글자 대문자, 이름 글자수를 조회

SELECT
    upper(emp_name)
FROM
    emp;

-- TODO: EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 급여(salary), 부서(dept_name)를 조회. 단 직원이름(emp_name)은 모두 대문자, 부서(dept_name)는 모두 소문자로 출력.
-- UPPER/LOWER
SELECT
    emp_id,
    lower(emp_name),
    salary,
    lower(dept_name)
FROM
    emp;

--(아래 2개는 비교값의 대소문자를 확실히 모르는 가정)
--TODO: EMP 테이블에서 직원의 이름(emp_name)이 PETER인 직원의 모든 정보를 조회하시오.
SELECT
    *
FROM
    emp
WHERE
    lower(emp_name) = 'peter';


--TODO: EMP 테이블에서 업무(job)가 'Sh_Clerk' 인 직원의의  ID(emp_id), 이름(emp_name), 업무(job), 급여(salary)를 조회
SELECT
    emp_id,
    emp_name,
    job,
    salary
FROM
    emp
WHERE
    lower(job) = 'sh_clerk';


--TODO: 직원 이름(emp_name) 의 자릿수를 15자리로 맞추고 글자수가 모자랄 경우 공백을 앞에 붙여 조회. 끝이 맞도록 조회
SELECT
    lpad(emp_name, 15)
FROM
    emp;
--        rpad('abc',10) B,
    
--TODO: EMP 테이블에서 모든 직원의 이름(emp_name)과 급여(salary)를 조회.
--(단, "급여(salary)" 열을 길이가 7인 문자열로 만들고, 길이가 7이 안될 경우 왼쪽부터 빈 칸을 '_'로 채우시오. EX) ______5000) -LPAD() 이용
SELECT
    emp_name,
    lpad(salary, 7, '_')
FROM
    emp;


-- TODO: EMP 테이블에서 이름(emp_name)이 10글자 이상인 직원들의 이름(emp_name)과 이름의 글자수 조회

SELECT
    emp_name,
    length(emp_name)
FROM
    emp
WHERE
    length(emp_name) >= 10;


/* *************************************
함수 - 숫자관련 함수

- 결과 : 정수, 실수
 round(값, 자릿수) : 자릿수이하에서 반올림 (양수 - 실수부, 음수 - 정수부, 기본값 : 0)
 trunc(값, 자릿수) : 자릿수이하에서 절삭(양수 - 실수부, 음수 - 정수부, 기본값: 0)
- 결과 : 정수
 ceil(값) : 올림
 floor(값) : 내림
 mod(나뉘는수, 나누는수) : 나눗셈의 나머지 연산
 
************************************* */

SELECT
    round(1.2345, 2),
    round(1.5678, 2),
    round(1.2345),
    round(156.12, - 1),
    trunc(1.56778, 2),
    trunc(156, - 2)
FROM
    dual;

SELECT
    ceil(15.17),
    floor(15.67),
    mod(10, 3)
FROM
    dual;


--TODO: EMP 테이블에서 각 직원에 대해 직원ID(emp_id), 이름(emp_name), 급여(salary) 그리고 15% 인상된 급여(salary)를 조회하는 질의를 작성하시오.
--(단, 15% 인상된 급여는 올림해서 정수로 표시하고, 별칭을 "SAL_RAISE"로 지정.)
SELECT
    emp_id,
    emp_name,
    salary,
    ceil(salary * 1.15) "SAL_RAISE"
FROM
    emp;


--TODO: 위의 SQL문에서 인상 급여(sal_raise)와 급여(salary) 간의 차액을 추가로 조회 (직원ID(emp_id), 이름(emp_name), 15% 인상급여, 인상된 급여와 기존 급여(salary)와 차액)
SELECT
    emp_id,
    emp_name,
    salary,
    ceil(salary * 1.15) "SAL_RAISE",
    ceil(salary * 1.15) - salary
FROM
    emp;


-- TODO: EMP 테이블에서 커미션이 있는 직원들의 직원_ID(emp_id), 이름(emp_name), 커미션비율(comm_pct), 커미션비율(comm_pct)을 8% 인상한 결과를 조회.
--(단 커미션을 8% 인상한 결과는 소숫점 이하 2자리에서 반올림하고 별칭은 comm_raise로 지정)
SELECT
    emp_id,
    emp_name,
    comm_pct,
    round(comm_pct * 1.08, 1) comm_raise
FROM
    emp
WHERE
    comm_pct IS NOT NULL;


/* *************************************
함수 - 날짜관련 계산 및 함수

sysdate : 실행시점의 일시
Date +- 정수 : 날짜 계산.
months_between(d1, d2) -경과한 개월수(d1이 최근, d2가 과거)
add_months(d1, 정수) - 정수개월 지난 날짜. 마지막 날짜의 1개월 후는 달의 마지막 날이 된다. 
next_day(d1, '요일') - d1에서 첫번째 지정한 요일의 날짜. 요일은 한글(locale)로 지정한다.
last_day(d) - d 달의 마지막날.
extract(year|month|day from date) - date에서 year/month/day만 추출
************************************* */
--TODO: EMP 테이블에서 부서이름(dept_name)이 'IT'인 직원들의 '입사일(hire_date)로 부터 10일전', 입사일과 '입사일로 부터 10일후',  의 날짜를 조회. 

SELECT
    sysdate,
    to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss') -- insert 시 sysdate 입력 시기를 알고 싶을 때 많이 사용한다.
FROM
    dual;

SELECT
    sysdate + 10 "10days later",
    trunc(months_between(sysdate, '2020/11/12'))
    || '개월'
FROM
    dual;

SELECT
    add_months(sysdate, 2),
    add_months(sysdate, - 2),
    add_months('2021/01/31', 1) -- 마지막 날 기준으로,,,
FROM
    dual;

SELECT
    next_day(sysdate, '금요일'),
    next_day(sysdate, '수요일')
FROM
    dual;

SELECT
    EXTRACT(MONTH FROM sysdate)
FROM
    dual;

SELECT
    *
FROM
    emp
WHERE
    EXTRACT(MONTH FROM hire_date) = 11;

--TODO: 부서가 'Purchasing' 인 직원의 이름(emp_name), 입사 6개월전과 입사일(hire_date), 6개월후 날짜를 조회.
SELECT
    emp_name,
    hire_date,
    add_months(hire_date, - 6),
    add_months(hire_date, + 6),
    dept_name
FROM
    emp
WHERE
    dept_name = 'Purchasing';

--TODO: EMP 테이블에서 입사일과 입사일 2달 후, 입사일 2달 전 날짜를 조회.


-- TODO: 각 직원의 이름(emp_name), 근무 개월수 (입사일에서 현재까지의 달 수)를 계산하여 조회.
--(단 근무 개월수가 실수 일 경우 정수로 반올림. 근무개월수 내림차순으로 정렬.)
SELECT
    emp_name,
    round(months_between(sysdate, hire_date), 0) t
FROM
    emp
ORDER BY
    round(months_between(sysdate, hire_date), 0) DESC;

--TODO: 직원 ID(emp_id)가 100 인 직원의 입사일 이후 첫번째 금요일의 날짜를 구하시오.
SELECT
    next_day(hire_date, '금요일')
FROM
    emp
WHERE
    emp_id = 100;


/* *************************************
함수 - 변환 함수 ---내가 원하는 타입으로 변환할때

#####################################################################################
#				# = to_char() =>	#					#<=to_char()=	#			#
#   Number 타입	#					#  Character 타입	#				#  Date 타입	#
#				# <=to_number()=    #	    			#=to_date()=>	#			#
#####################################################################################

to_xxxx(value, type)

to_char() : 숫자형, 날짜형을 문자형으로 변환
to_number() : 문자형을 숫자형으로 변환 
to_date() : 문자형을 날짜형으로 변환

fm99999.999
345.78
00000.000
00345.780

형식(format)문자 
숫자 :
    0, 9 : 숫자가 들어갈 자릿수 지정. (9: 정수부 남는자리를 공백으로 채움, 0은 0으로 채움) - 실수부 남는 자리는 둘다 0으로 채운다.
           fm으로 시작하면 9일 경우 공백을 제거.
    . : 정수/실수부 구문자.
    ,: 정수부 단위구분자
    'L', '$' : 통화표시. L; 로컬통화기호
일시 :yyyy : 연도 4자리, yy: 연도 2자리(2000년대), rr: 연도2자리(50이상:90년대, 50미만:2000년대)
      mm: 월 2자리  (11, 05)
      dd: 일 2자리
      hh24: 시간(00 ~ 23) 2자리, hh(01 ~ 12)
      mi: 분 2자리
      ss: 초 2자리
      day(요일), 
      am 또는 pm : 오전/오후
************************************* */

SELECT
    10 + to_number('1,000', '9,999')
FROM
    dual;

SELECT
    to_char(100000000, '999,999,999')
FROM
    dual;

SELECT
    to_char(salary, 'fmL999,999,999.00') a
FROM
    emp;

SELECT
    10 + to_number('1,000.53', 'fm999,999.99')
FROM
    dual;

SELECT
    to_char(12345678, '999999.99') a
FROM
    dual; --설계도에서 데이터 입력 크기 정해줬기때문에 그거를 확인해서 fm 으로 범위 정함

SELECT
    to_char(1234.567, '00,000.0000')
FROM
    dual;

SELECT
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'),
    to_char(sysdate, 'yyyy"년" mm"월" dd"일" hh24"시"mi"분"ss"초"')
FROM
    dual;

SELECT
    TO_DATE('00/10', 'yy/mm')
FROM
    dual;

-- EMP 테이블에서 업무(job)에 "CLERK"가 들어가는 직원들의 ID(emp_id), 이름(name), 업무(job), 급여(salary)를 조회
--(급여는 단위 구분자 , 를 사용하고 앞에 $를 붙여서 출력.)

SELECT
    emp_id,
    emp_name,
    job,
    to_char(salary, 'fm$999,999.00') "salary"
FROM
    emp
WHERE
    job LIKE '%CLERK%';

-- 문자열 '20030503' 를 2003년 05월 03일 로 출력.
SELECT
    to_char(TO_DATE('20030503', 'yyyymmdd'), 'yyyy"년" mm"월" dd"일"')
FROM
    dual;

--날짜 : char(8) yyyymmdd
--일시 : char(15) yyyymmddhhmiss

-- TODO: 부서명(dept_name)이 'Finance'인 직원들의 ID(emp_id), 이름(emp_name)과 입사년도(hire_date) 4자리만 출력하시오. (ex: 2004);
--to_char()

SELECT
    emp_id,
    emp_name,
    to_char(hire_date, 'yyyy')
FROM
    emp
WHERE
    dept_name = 'Finance';
--TODO: 직원들중 11월에 입사한 직원들의 직원ID(emp_id), 이름(emp_name), 입사일(hire_date)을 조회
--to_char()
SELECT
    emp_id,
    emp_name,
    hire_date
FROM
    emp
WHERE
    EXTRACT(MONTH FROM hire_date) = 11;

--TODO: 2006년에 입사한 모든 직원의 이름(emp_name)과 입사일(yyyy-mm-dd 형식)을 입사일(hire_date)의 오름차순으로 조회
--to_char()
SELECT
    emp_name,
    to_char(hire_date, 'yyyy-mm-dd')
FROM
    emp
WHERE
    EXTRACT(YEAR FROM hire_date) = 2006
ORDER BY
    hire_date;

--TODO: 2004년 05월 이후 입사한 직원 조회의 이름(emp_name)과 입사일(hire_date) 조회
SELECT
    emp_name,
    hire_date
FROM
    emp
WHERE
    hire_date > '2004/05/01';


-- TODO: 문자열 '20100107232215' 를 2010년 01월 07일 23시 22분 15초 로 출력. (dual 테입블 사용)

SELECT
    to_char(TO_DATE('20100107232215', 'yyyymmddhh24miss'), 'yyyy"년" mm"월" dd"일" hh24"시" mi"분" ss"초"')
FROM
    dual;

/* *************************************
함수 - null 관련 함수 
NVL()
NVL2(expr, nn, null) - expr이 null이 아니면 nn, 널이면 세번째
nullif(ex1, ex2) 둘이 같으면 null, 다르면 ex1

************************************* */
SELECT
    nvl(NULL, 0),
    nvl(NULL, '없음'),
    nvl(20, 0)
FROM
    dual;

SELECT
    nvl2(NULL, 'null아님', 'null임'),
    nvl2(30, 'null아님', 'null임')
FROM
    dual;

SELECT
    nullif(10, 10),
    nullif(10, 20)
FROM
    dual;
-- EMP 테이블에서 직원 ID(emp_id), 이름(emp_name), 급여(salary), 커미션비율(comm_pct)을 조회. 단 커미션비율이 NULL인 직원은 0이 출력되도록 한다..
SELECT
    emp_id,
    emp_name,
    salary,
    nvl(comm_pct, 0)                       comm_pct,
    nvl2(comm_pct, '커미션있음', '커미션없음')       comm_pct2
FROM
    emp; 

--TODO: EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 업무(job), 부서(dept_name)을 조회. 부서가 없는 경우 '부서미배치'를 출력.
SELECT
    emp_id,
    emp_name,
    job,
    nvl(dept_name, '부서미배치') 부서
FROM
    emp
ORDER BY
    dept_name DESC;


--TODO: EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 급여(salary), 커미션 (salary * comm_pct)을 조회. 커미션이 없는 직원은 0이 조회되록 한다.
SELECT
    emp_id,
    emp_name,
    salary,
    comm_pct,
    nvl(salary * comm_pct, 0)      커미션,
    salary * nvl(comm_pct, 0)      commision
FROM
    emp;

IF 컬럼 = 10 THEN 'A'
ELSE IF 컬럼=20 THEN 'B'
ELSE IF 컬럼=30 THEN 'C'
ELSE 'D'
decode(컬럼, 10, 'A', 
            20, 'B', 
            30,'C', 
            'D') -- ELSE 값 입력 하지 않을 시 NULL 값 반환

case 컬럼 when 10 then 'A'
         when 20 then 'B'
         when 30 then 'c'
         else 'D'  end

/* *************************************
DECODE함수와 CASE 문
decode(컬럼, [비교값, 출력값, ...] , else출력) 

case문 동등비교
case 컬럼 when 비교값 then 출력값
              [when 비교값 then 출력값]
              [else 출력값]
              end
              
case문 조건문 
case when 조건!! then 출력값
       [when 조건 then 출력값]
       [else 출력값]
       end
************************************* */
select  decode(dept_name, 'Shipping', '배송', 
                          'Sales','영업', 
                          'Purchasing', '구매', 
                          'Marketing', '마케팅', 
                          null, '부서없음',
                          dept_name) dept, -- else: 원래값
        dept_name
from   emp
order by dept_name desc;


select  dept_name,
        case dept_name  when 'Shipping' then '배송' 
                        when 'Sales' then '영업' 
                        when 'Purchasing' then '구매'    
                        else nvl(dept_name,'부서없음') end "DEPT"
from    emp
order by 1 desc;        


select case when dept_name is null then 'nonono' else dept_name end AA
from emp
order by 1 desc;



--EMP테이블에서 급여와 급여의 등급을 조회하는데 급여 등급은 10000이상이면 '1등급', 10000미만이면 '2등급' 으로 나오도록 조회
select salary,
case when salary >=10000 then '1grade'
    else '2grade' end "GRADE"
from emp;

--decode()/case 를 이용한 정렬
-- 직원들의 모든 정보를 조회한다. 단 정렬은 업무(job)가 'ST_CLERK', 'IT_PROG', 'PU_CLERK', 'SA_MAN' 순서대로 먼저나오도록 한다. (나머지 JOB은 상관없음)
select *
from emp
order by decode(job, 'ST_CLERK', '1',
                    'IT_PROG', '2',
                    'PU_CLERK','3',
                    'SA_MAN','4',
                    job);
select *
from emp
order by case job when 'ST_CLERK' then '1'
                when 'IT_PROG' then '2'
                else job end desc;

--TODO: EMP 테이블에서 업무(job)이 'AD_PRES'거나 'FI_ACCOUNT'거나 'PU_CLERK'인 직원들의 ID(emp_id), 이름(emp_name), 업무(job)을 조회. 
-- 업무(job)가 'AD_PRES'는 '대표', 'FI_ACCOUNT'는 '회계', 'PU_CLERK'의 경우 '구매'가 출력되도록 조회
select emp_id,emp_name,decode(job,'AD_PRES','대표',
                            'FI_ACCOUNT','회계',
                            'PU_CLERK','구매'
                            ,job) from emp
                            
--                            case job when 'AD_PRES' then '대표'
--                                when 'FI_ACCOUNT' then '회계'
--                                else job end
                            
where job in ('AD_PRES','FI_ACCOUNT','PU_CLERK');


--TODO: EMP 테이블에서 부서이름(dept_name)과 급여 인상분을 조회. 급여 인상분은 부서이름이 'IT' 이면 급여(salary)에 10%를 'Shipping' 이면 급여(salary)의 20%를 'Finance'이면 30%를 나머지는 0을 출력
-- decode 와 case문을 이용해 조회
select dept_name,decode(dept_name,'IT',salary * 1.1,    -- dept_name,'IT','인상안함' : decode 인 경우 첫번째 반환값이 데이터 타입이 된다.
                           'Shipping',salary * 1.2,     --                           salary * 1.2 값인 숫자가 to_char(salary*1.2)가 된 것     
                           'Finance',salary * 1.3,
                           0) "급여인상분",case dept_name
    WHEN 'IT' THEN
        salary * 1.1 WHEN 'Shipping' THEN SALARY * 1 . 2 WHEN 'Finance' THEN SALARY * 1 . 3 ELSE NVL ( NULL , 0 ) END "인상된 급여" FROM emp order
        by dept_name ;

--TODO: EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 급여(salary), 인상된 급여를 조회한다. 
--단 급여 인상율은 급여가 5000 미만은 30%, 5000이상 10000 미만는 20% 10000 이상은 10% 로 한다.
         SELECT EMP_ID , EMP_NAME , DEPT_NAME , SALARY , CASE WHEN SALARY < 5000 THEN SALARY * 1 . 3 WHEN SALARY BETWEEN
        5000 AND 10000 THEN SALARY * 1 . 2 ELSE SALARY * 1 . 1 END "인상된 급여" FROM EMP ;


