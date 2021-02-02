/* *************************************
�Լ� - ���ڿ����� �Լ�
 UPPER()/ LOWER() : �빮��/�ҹ��� �� ��ȯ
 INITCAP(): �ܾ� ù���ڸ� �빮�� ������ �ҹ��ڷ� ��ȯ
 LENGTH() : ���ڼ� ��ȸ
 LPAD(��, ũ��, ä�ﰪ) : "��"�� ������ "ũ��"�� �������� ���ڿ��� ����� ���ڶ�� ���� ���ʺ��� "ä�ﰪ"���� ä���.
 RPAD(��, ũ��, ä�ﰪ) : "��"�� ������ "ũ��"�� �������� ���ڿ��� ����� ���ڶ�� ���� �����ʺ��� "ä�ﰪ"���� ä���.
 SUBSTR(��, ����index, ���ڼ�) - "��"���� "����index"��° ���ں��� ������ "���ڼ�" ��ŭ�� ���ڿ��� ����. ���ڼ� ������ ������. 
 REPLACE(��, ã�����ڿ�, �����ҹ��ڿ�) - "��"���� "ã�����ڿ�"�� "�����ҹ��ڿ�"�� �ٲ۴�.
 LTRIM(��): �ް��� ����
 RTRIM(��): �������� ����
 TRIM(��): ���� ���� ����
 ************************************* */

SELECT
    upper('aa')            �빮��,
--        initcap('abcde abecd'),
--        length ('asdfsdf a  '),
--        lpad('abc',10,'+') A,
--        rpad('abc',10) B,
--        rpad('1234567',3),
    substr('123456789', '2', '5'), -- 2��°���ں��� 5���ڸ�
    substr('123456789', '2'), -- 2��°���ں��� ������
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


--EMP ���̺��� ������ �̸�(emp_name)�� ��� �빮��, �ҹ���, ù���� �빮��, �̸� ���ڼ��� ��ȸ

SELECT
    upper(emp_name)
FROM
    emp;

-- TODO: EMP ���̺��� ������ ID(emp_id), �̸�(emp_name), �޿�(salary), �μ�(dept_name)�� ��ȸ. �� �����̸�(emp_name)�� ��� �빮��, �μ�(dept_name)�� ��� �ҹ��ڷ� ���.
-- UPPER/LOWER
SELECT
    emp_id,
    lower(emp_name),
    salary,
    lower(dept_name)
FROM
    emp;

--(�Ʒ� 2���� �񱳰��� ��ҹ��ڸ� Ȯ���� �𸣴� ����)
--TODO: EMP ���̺��� ������ �̸�(emp_name)�� PETER�� ������ ��� ������ ��ȸ�Ͻÿ�.
SELECT
    *
FROM
    emp
WHERE
    lower(emp_name) = 'peter';


--TODO: EMP ���̺��� ����(job)�� 'Sh_Clerk' �� ��������  ID(emp_id), �̸�(emp_name), ����(job), �޿�(salary)�� ��ȸ
SELECT
    emp_id,
    emp_name,
    job,
    salary
FROM
    emp
WHERE
    lower(job) = 'sh_clerk';


--TODO: ���� �̸�(emp_name) �� �ڸ����� 15�ڸ��� ���߰� ���ڼ��� ���ڶ� ��� ������ �տ� �ٿ� ��ȸ. ���� �µ��� ��ȸ
SELECT
    lpad(emp_name, 15)
FROM
    emp;
--        rpad('abc',10) B,
    
--TODO: EMP ���̺��� ��� ������ �̸�(emp_name)�� �޿�(salary)�� ��ȸ.
--(��, "�޿�(salary)" ���� ���̰� 7�� ���ڿ��� �����, ���̰� 7�� �ȵ� ��� ���ʺ��� �� ĭ�� '_'�� ä��ÿ�. EX) ______5000) -LPAD() �̿�
SELECT
    emp_name,
    lpad(salary, 7, '_')
FROM
    emp;


-- TODO: EMP ���̺��� �̸�(emp_name)�� 10���� �̻��� �������� �̸�(emp_name)�� �̸��� ���ڼ� ��ȸ

SELECT
    emp_name,
    length(emp_name)
FROM
    emp
WHERE
    length(emp_name) >= 10;


/* *************************************
�Լ� - ���ڰ��� �Լ�

- ��� : ����, �Ǽ�
 round(��, �ڸ���) : �ڸ������Ͽ��� �ݿø� (��� - �Ǽ���, ���� - ������, �⺻�� : 0)
 trunc(��, �ڸ���) : �ڸ������Ͽ��� ����(��� - �Ǽ���, ���� - ������, �⺻��: 0)
- ��� : ����
 ceil(��) : �ø�
 floor(��) : ����
 mod(�����¼�, �����¼�) : �������� ������ ����
 
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


--TODO: EMP ���̺��� �� ������ ���� ����ID(emp_id), �̸�(emp_name), �޿�(salary) �׸��� 15% �λ�� �޿�(salary)�� ��ȸ�ϴ� ���Ǹ� �ۼ��Ͻÿ�.
--(��, 15% �λ�� �޿��� �ø��ؼ� ������ ǥ���ϰ�, ��Ī�� "SAL_RAISE"�� ����.)
SELECT
    emp_id,
    emp_name,
    salary,
    ceil(salary * 1.15) "SAL_RAISE"
FROM
    emp;


--TODO: ���� SQL������ �λ� �޿�(sal_raise)�� �޿�(salary) ���� ������ �߰��� ��ȸ (����ID(emp_id), �̸�(emp_name), 15% �λ�޿�, �λ�� �޿��� ���� �޿�(salary)�� ����)
SELECT
    emp_id,
    emp_name,
    salary,
    ceil(salary * 1.15) "SAL_RAISE",
    ceil(salary * 1.15) - salary
FROM
    emp;


-- TODO: EMP ���̺��� Ŀ�̼��� �ִ� �������� ����_ID(emp_id), �̸�(emp_name), Ŀ�̼Ǻ���(comm_pct), Ŀ�̼Ǻ���(comm_pct)�� 8% �λ��� ����� ��ȸ.
--(�� Ŀ�̼��� 8% �λ��� ����� �Ҽ��� ���� 2�ڸ����� �ݿø��ϰ� ��Ī�� comm_raise�� ����)
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
�Լ� - ��¥���� ��� �� �Լ�

sysdate : ��������� �Ͻ�
Date +- ���� : ��¥ ���.
months_between(d1, d2) -����� ������(d1�� �ֱ�, d2�� ����)
add_months(d1, ����) - �������� ���� ��¥. ������ ��¥�� 1���� �Ĵ� ���� ������ ���� �ȴ�. 
next_day(d1, '����') - d1���� ù��° ������ ������ ��¥. ������ �ѱ�(locale)�� �����Ѵ�.
last_day(d) - d ���� ��������.
extract(year|month|day from date) - date���� year/month/day�� ����
************************************* */
--TODO: EMP ���̺��� �μ��̸�(dept_name)�� 'IT'�� �������� '�Ի���(hire_date)�� ���� 10����', �Ի��ϰ� '�Ի��Ϸ� ���� 10����',  �� ��¥�� ��ȸ. 

SELECT
    sysdate,
    to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss') -- insert �� sysdate �Է� �ñ⸦ �˰� ���� �� ���� ����Ѵ�.
FROM
    dual;

SELECT
    sysdate + 10 "10days later",
    trunc(months_between(sysdate, '2020/11/12'))
    || '����'
FROM
    dual;

SELECT
    add_months(sysdate, 2),
    add_months(sysdate, - 2),
    add_months('2021/01/31', 1) -- ������ �� ��������,,,
FROM
    dual;

SELECT
    next_day(sysdate, '�ݿ���'),
    next_day(sysdate, '������')
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

--TODO: �μ��� 'Purchasing' �� ������ �̸�(emp_name), �Ի� 6�������� �Ի���(hire_date), 6������ ��¥�� ��ȸ.
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

--TODO: EMP ���̺��� �Ի��ϰ� �Ի��� 2�� ��, �Ի��� 2�� �� ��¥�� ��ȸ.


-- TODO: �� ������ �̸�(emp_name), �ٹ� ������ (�Ի��Ͽ��� ��������� �� ��)�� ����Ͽ� ��ȸ.
--(�� �ٹ� �������� �Ǽ� �� ��� ������ �ݿø�. �ٹ������� ������������ ����.)
SELECT
    emp_name,
    round(months_between(sysdate, hire_date), 0) t
FROM
    emp
ORDER BY
    round(months_between(sysdate, hire_date), 0) DESC;

--TODO: ���� ID(emp_id)�� 100 �� ������ �Ի��� ���� ù��° �ݿ����� ��¥�� ���Ͻÿ�.
SELECT
    next_day(hire_date, '�ݿ���')
FROM
    emp
WHERE
    emp_id = 100;


/* *************************************
�Լ� - ��ȯ �Լ� ---���� ���ϴ� Ÿ������ ��ȯ�Ҷ�

#####################################################################################
#				# = to_char() =>	#					#<=to_char()=	#			#
#   Number Ÿ��	#					#  Character Ÿ��	#				#  Date Ÿ��	#
#				# <=to_number()=    #	    			#=to_date()=>	#			#
#####################################################################################

to_xxxx(value, type)

to_char() : ������, ��¥���� ���������� ��ȯ
to_number() : �������� ���������� ��ȯ 
to_date() : �������� ��¥������ ��ȯ

fm99999.999
345.78
00000.000
00345.780

����(format)���� 
���� :
    0, 9 : ���ڰ� �� �ڸ��� ����. (9: ������ �����ڸ��� �������� ä��, 0�� 0���� ä��) - �Ǽ��� ���� �ڸ��� �Ѵ� 0���� ä���.
           fm���� �����ϸ� 9�� ��� ������ ����.
    . : ����/�Ǽ��� ������.
    ,: ������ ����������
    'L', '$' : ��ȭǥ��. L; ������ȭ��ȣ
�Ͻ� :yyyy : ���� 4�ڸ�, yy: ���� 2�ڸ�(2000���), rr: ����2�ڸ�(50�̻�:90���, 50�̸�:2000���)
      mm: �� 2�ڸ�  (11, 05)
      dd: �� 2�ڸ�
      hh24: �ð�(00 ~ 23) 2�ڸ�, hh(01 ~ 12)
      mi: �� 2�ڸ�
      ss: �� 2�ڸ�
      day(����), 
      am �Ǵ� pm : ����/����
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
    dual; --���赵���� ������ �Է� ũ�� ������⶧���� �װŸ� Ȯ���ؼ� fm ���� ���� ����

SELECT
    to_char(1234.567, '00,000.0000')
FROM
    dual;

SELECT
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'),
    to_char(sysdate, 'yyyy"��" mm"��" dd"��" hh24"��"mi"��"ss"��"')
FROM
    dual;

SELECT
    TO_DATE('00/10', 'yy/mm')
FROM
    dual;

-- EMP ���̺��� ����(job)�� "CLERK"�� ���� �������� ID(emp_id), �̸�(name), ����(job), �޿�(salary)�� ��ȸ
--(�޿��� ���� ������ , �� ����ϰ� �տ� $�� �ٿ��� ���.)

SELECT
    emp_id,
    emp_name,
    job,
    to_char(salary, 'fm$999,999.00') "salary"
FROM
    emp
WHERE
    job LIKE '%CLERK%';

-- ���ڿ� '20030503' �� 2003�� 05�� 03�� �� ���.
SELECT
    to_char(TO_DATE('20030503', 'yyyymmdd'), 'yyyy"��" mm"��" dd"��"')
FROM
    dual;

--��¥ : char(8) yyyymmdd
--�Ͻ� : char(15) yyyymmddhhmiss

-- TODO: �μ���(dept_name)�� 'Finance'�� �������� ID(emp_id), �̸�(emp_name)�� �Ի�⵵(hire_date) 4�ڸ��� ����Ͻÿ�. (ex: 2004);
--to_char()

SELECT
    emp_id,
    emp_name,
    to_char(hire_date, 'yyyy')
FROM
    emp
WHERE
    dept_name = 'Finance';
--TODO: �������� 11���� �Ի��� �������� ����ID(emp_id), �̸�(emp_name), �Ի���(hire_date)�� ��ȸ
--to_char()
SELECT
    emp_id,
    emp_name,
    hire_date
FROM
    emp
WHERE
    EXTRACT(MONTH FROM hire_date) = 11;

--TODO: 2006�⿡ �Ի��� ��� ������ �̸�(emp_name)�� �Ի���(yyyy-mm-dd ����)�� �Ի���(hire_date)�� ������������ ��ȸ
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

--TODO: 2004�� 05�� ���� �Ի��� ���� ��ȸ�� �̸�(emp_name)�� �Ի���(hire_date) ��ȸ
SELECT
    emp_name,
    hire_date
FROM
    emp
WHERE
    hire_date > '2004/05/01';


-- TODO: ���ڿ� '20100107232215' �� 2010�� 01�� 07�� 23�� 22�� 15�� �� ���. (dual ���Ժ� ���)

SELECT
    to_char(TO_DATE('20100107232215', 'yyyymmddhh24miss'), 'yyyy"��" mm"��" dd"��" hh24"��" mi"��" ss"��"')
FROM
    dual;

/* *************************************
�Լ� - null ���� �Լ� 
NVL()
NVL2(expr, nn, null) - expr�� null�� �ƴϸ� nn, ���̸� ����°
nullif(ex1, ex2) ���� ������ null, �ٸ��� ex1

************************************* */
SELECT
    nvl(NULL, 0),
    nvl(NULL, '����'),
    nvl(20, 0)
FROM
    dual;

SELECT
    nvl2(NULL, 'null�ƴ�', 'null��'),
    nvl2(30, 'null�ƴ�', 'null��')
FROM
    dual;

SELECT
    nullif(10, 10),
    nullif(10, 20)
FROM
    dual;
-- EMP ���̺��� ���� ID(emp_id), �̸�(emp_name), �޿�(salary), Ŀ�̼Ǻ���(comm_pct)�� ��ȸ. �� Ŀ�̼Ǻ����� NULL�� ������ 0�� ��µǵ��� �Ѵ�..
SELECT
    emp_id,
    emp_name,
    salary,
    nvl(comm_pct, 0)                       comm_pct,
    nvl2(comm_pct, 'Ŀ�̼�����', 'Ŀ�̼Ǿ���')       comm_pct2
FROM
    emp; 

--TODO: EMP ���̺��� ������ ID(emp_id), �̸�(emp_name), ����(job), �μ�(dept_name)�� ��ȸ. �μ��� ���� ��� '�μ��̹�ġ'�� ���.
SELECT
    emp_id,
    emp_name,
    job,
    nvl(dept_name, '�μ��̹�ġ') �μ�
FROM
    emp
ORDER BY
    dept_name DESC;


--TODO: EMP ���̺��� ������ ID(emp_id), �̸�(emp_name), �޿�(salary), Ŀ�̼� (salary * comm_pct)�� ��ȸ. Ŀ�̼��� ���� ������ 0�� ��ȸ�Ƿ� �Ѵ�.
SELECT
    emp_id,
    emp_name,
    salary,
    comm_pct,
    nvl(salary * comm_pct, 0)      Ŀ�̼�,
    salary * nvl(comm_pct, 0)      commision
FROM
    emp;

IF �÷� = 10 THEN 'A'
ELSE IF �÷�=20 THEN 'B'
ELSE IF �÷�=30 THEN 'C'
ELSE 'D'
decode(�÷�, 10, 'A', 
            20, 'B', 
            30,'C', 
            'D') -- ELSE �� �Է� ���� ���� �� NULL �� ��ȯ

case �÷� when 10 then 'A'
         when 20 then 'B'
         when 30 then 'c'
         else 'D'  end

/* *************************************
DECODE�Լ��� CASE ��
decode(�÷�, [�񱳰�, ��°�, ...] , else���) 

case�� �����
case �÷� when �񱳰� then ��°�
              [when �񱳰� then ��°�]
              [else ��°�]
              end
              
case�� ���ǹ� 
case when ����!! then ��°�
       [when ���� then ��°�]
       [else ��°�]
       end
************************************* */
select  decode(dept_name, 'Shipping', '���', 
                          'Sales','����', 
                          'Purchasing', '����', 
                          'Marketing', '������', 
                          null, '�μ�����',
                          dept_name) dept, -- else: ������
        dept_name
from   emp
order by dept_name desc;


select  dept_name,
        case dept_name  when 'Shipping' then '���' 
                        when 'Sales' then '����' 
                        when 'Purchasing' then '����'    
                        else nvl(dept_name,'�μ�����') end "DEPT"
from    emp
order by 1 desc;        


select case when dept_name is null then 'nonono' else dept_name end AA
from emp
order by 1 desc;



--EMP���̺��� �޿��� �޿��� ����� ��ȸ�ϴµ� �޿� ����� 10000�̻��̸� '1���', 10000�̸��̸� '2���' ���� �������� ��ȸ
select salary,
case when salary >=10000 then '1grade'
    else '2grade' end "GRADE"
from emp;

--decode()/case �� �̿��� ����
-- �������� ��� ������ ��ȸ�Ѵ�. �� ������ ����(job)�� 'ST_CLERK', 'IT_PROG', 'PU_CLERK', 'SA_MAN' ������� ������������ �Ѵ�. (������ JOB�� �������)
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

--TODO: EMP ���̺��� ����(job)�� 'AD_PRES'�ų� 'FI_ACCOUNT'�ų� 'PU_CLERK'�� �������� ID(emp_id), �̸�(emp_name), ����(job)�� ��ȸ. 
-- ����(job)�� 'AD_PRES'�� '��ǥ', 'FI_ACCOUNT'�� 'ȸ��', 'PU_CLERK'�� ��� '����'�� ��µǵ��� ��ȸ
select emp_id,emp_name,decode(job,'AD_PRES','��ǥ',
                            'FI_ACCOUNT','ȸ��',
                            'PU_CLERK','����'
                            ,job) from emp
                            
--                            case job when 'AD_PRES' then '��ǥ'
--                                when 'FI_ACCOUNT' then 'ȸ��'
--                                else job end
                            
where job in ('AD_PRES','FI_ACCOUNT','PU_CLERK');


--TODO: EMP ���̺��� �μ��̸�(dept_name)�� �޿� �λ���� ��ȸ. �޿� �λ���� �μ��̸��� 'IT' �̸� �޿�(salary)�� 10%�� 'Shipping' �̸� �޿�(salary)�� 20%�� 'Finance'�̸� 30%�� �������� 0�� ���
-- decode �� case���� �̿��� ��ȸ
select dept_name,decode(dept_name,'IT',salary * 1.1,    -- dept_name,'IT','�λ����' : decode �� ��� ù��° ��ȯ���� ������ Ÿ���� �ȴ�.
                           'Shipping',salary * 1.2,     --                           salary * 1.2 ���� ���ڰ� to_char(salary*1.2)�� �� ��     
                           'Finance',salary * 1.3,
                           0) "�޿��λ��",case dept_name
    WHEN 'IT' THEN
        salary * 1.1 WHEN 'Shipping' THEN SALARY * 1 . 2 WHEN 'Finance' THEN SALARY * 1 . 3 ELSE NVL ( NULL , 0 ) END "�λ�� �޿�" FROM emp order
        by dept_name ;

--TODO: EMP ���̺��� ������ ID(emp_id), �̸�(emp_name), �޿�(salary), �λ�� �޿��� ��ȸ�Ѵ�. 
--�� �޿� �λ����� �޿��� 5000 �̸��� 30%, 5000�̻� 10000 �̸��� 20% 10000 �̻��� 10% �� �Ѵ�.
         SELECT EMP_ID , EMP_NAME , DEPT_NAME , SALARY , CASE WHEN SALARY < 5000 THEN SALARY * 1 . 3 WHEN SALARY BETWEEN
        5000 AND 10000 THEN SALARY * 1 . 2 ELSE SALARY * 1 . 1 END "�λ�� �޿�" FROM EMP ;


