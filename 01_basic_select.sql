/* *************************************

Select �⺻ ���� - ������, �÷� ��Ī

Select [distinct] c1,c2 -> Read c1, c2 , If you need to read all columns, you can use Asterisk(*)
                �÷��� ��Ī : ��Ī�� ��ȸ����� ������ �÷��� �̸�, ��Ī�� " "�� ���� �� �ִ�.(������ �� ��� �ݵ�� " " ���) 
                distinct�� ����[simialr to Set operation on Python], �ߺ��� ��ȸ����� �ϳ��ุ �����ش�.
from the name of table
*************************************** */
--EMP ���̺��� ��� �÷��� ��� �׸��� ��ȸ.
SELECT
    emp_id,
    emp_name,
    job,
    mgr_id,
    hire_date,
    salary,
    comm_pct,
    dept_name
FROM
    emp;   

--EMP ���̺��� ���� ID(emp_id), ���� �̸�(emp_name), ����(job) �÷��� ���� ��ȸ.
SELECT
    emp_id,
    emp_name,
    job
FROM
    emp;        

--EMP ���̺��� ����(job) � ����� �����Ǿ����� ��ȸ. - ������ ���� �ϳ����� ��ȸ�ǵ��� ó��.
SELECT DISTINCT
    job
FROM
    emp;

--EMP ���̺��� �μ���(dept_name)�� � ����� �����Ǿ����� ��ȸ - ������ ���� �ϳ����� ��ȸ�ǵ��� ó��.
SELECT DISTINCT
    dept_name
FROM
    emp;

SELECT DISTINCT
    emp_name,
    job
FROM
    emp;
--EMP ���̺��� emp_id�� ����ID, emp_name�� �����̸�, hire_date�� �Ի���, salary�� �޿�, dept_name�� �ҼӺμ� ��Ī���� ��ȸ�Ѵ�.
SELECT
    emp_id     AS ����id,
    emp_name   AS "���� �̸�",
    hire_date  �Ի���,
    salary     �޿�,
    dept_name  �ҼӺμ�
FROM
    emp; --��Ī default: emp_id emp_id, (������ �� ��� �ݵ�� " " ���)

/* 
������ 
 ������ �� �÷��� ��� ���鿡 �Ϸ������� ����ȴ�.
 ���� �÷��� ������ ��ȸ�� �� �ִ�.

- ������� : + - * /
*** �ǿ����� �� null�� ������ ����� ������ null.
 > null : ���� ����. �𸣴� ��(������ null�� ���°� �ƴ϶� �𸣴� ��)
 *** dataŸ�� �� +/- ���� : day(��)�� +/- ���ó�¥ +5 : 5�� �� ��¥
 
- ���Ῥ���� : ���ڿ��� ���̴� ������, || => ���Ÿ���� �� ���� �� �ִ�.
 
- �÷� + �� : �÷��� ��簪�� ���Ѵ�.
- �÷� * �÷� : 
*/
SELECT
    10  num1,
    20  num2
FROM
    dual; -- dummy table - select �� from �� ����� ���� ��ġ

SELECT
    10 + 20,
    20 - 5,
    5 * 3,
    10 / 2,
    mod(10, 3)
FROM
    dual;

SELECT
    'ȫ�浿' || '��',
    30000 || '��' ����,
    5000 || 2,
    NULL + 100,
    NULL || '����'
FROM
    dual;

--sysdate:��������� �Ͻø� ��ȯ
SELECT
    sysdate,
    sysdate + 3  "3 days later",
    sysdate - 5  "5 days ago"
FROM
    emp;

SELECT
    salary,
    salary -- ������ �÷��� ������ ��ȸ ����
FROM
    emp;

--EMP ���̺��� ������ �̸�(emp_name), �޿�(salary) �׸���  �޿� + 1000 �� ���� ��ȸ.
SELECT
    emp_name,
    salary,
    salary + 1000 "1000�޷� �λ�"
FROM
    emp;


--EMP ���̺��� �Ի���(hire_date)�� �Ի��Ͽ� 10���� ���� ��¥�� ��ȸ.
SELECT
    hire_date,
    hire_date + 10 "�Ի� 10�� ��"
FROM
    emp;

-- TODO: EMP ���̺��� ����(job)�� � ����� �����Ǿ����� ��ȸ - ������ ���� �ϳ����� ��ȸ�ǵ��� ó��

SELECT DISTINCT
    job
FROM
    emp;

--TODO: EMP ���̺��� ������ ID(emp_id), �̸�(emp_name), �޿�(salary), Ŀ�̼�_PCT(comm_pct), �޿��� Ŀ�̼�_PCT�� ���� ���� ��ȸ.
SELECT
    emp_id,
    emp_name,
    salary,
    comm_pct,
    salary * comm_pct
FROM
    emp;


--TODO:  EMP ���̺��� �޿�(salary)�� �������� ��ȸ. (���ϱ� 12)
SELECT
    salary * 12
FROM
    emp;


--TODO: EMP ���̺��� �����̸�(emp_name)�� �޿�(salary)�� ��ȸ. �޿� �տ� $�� �ٿ� ��ȸ.
SELECT
    emp_name,
    '$' || salary
FROM
    emp;



--TODO: EMP ���̺��� �Ի���(hire_date) 30����, �Ի���, �Ի��� 30�� �ĸ� ��ȸ
SELECT
    hire_date - 30  "30�� ��",
    hire_date       �Ի���,
    hire_date + 30  "30�� ��"
FROM
    emp;






/* *************************************
Where ���� �̿��� ��[�ϳ��� ������/�� ����� ���� ����] �� ����

************************************* */
SELECT
    * --Columns
FROM
    emp -- Table
-- where (salary > 15000) and (salary <20000); 
--where salary BETWEEN 10000 and 150000;
--where emp_id in (100,120,150,400); -- 400 �� �����Ƿ� ã�� ����
--where emp_name like 'R%'; -- R�� �����ϴ� ��� ��ȸ
WHERE
    comm_pct IS NOT NULL;


-- �̸��� ȫ�� �� ��� name like 'ȫ%' >> % : 0 ~ N�� ��� ����
-- name like 'ȫ_' >> _ : 1���� ��� ���� ex) ��___ 4����, ��_% 2 ~ 4����

--EMP ���̺��� ����_ID(emp_id)�� 110�� ������ �̸�(emp_name)�� �μ���(dept_name)�� ��ȸ
SELECT
    emp_id    ����,
    emp_name  "������ �̸�",
    dept_name
FROM
    emp
WHERE
    emp_id = 110;

 
--EMP ���̺��� 'Sales' �μ��� ������ ���� �������� ID(emp_id), �̸�(emp_name), �μ���(dept_name)�� ��ȸ.
SELECT
    emp_id,
    emp_name,
    dept_name
FROM
    emp
WHERE
    dept_name != 'Sales';

--EMP ���̺��� �޿�(salary)�� $10,000�� �ʰ��� ������ ID(emp_id), �̸�(emp_name)�� �޿�(salary)�� ��ȸ
SELECT
    emp_id,
    emp_name,
    salary
FROM
    emp
WHERE
    salary > 10000;

--EMP ���̺��� Ŀ�̼Ǻ���(comm_pct)�� 0.2~0.3 ������ ������ ID(emp_id), �̸�(emp_name), Ŀ�̼Ǻ���(comm_pct)�� ��ȸ.
SELECT
    emp_id,
    emp_name,
    comm_pct
FROM
    emp
WHERE
    comm_pct BETWEEN 0.2 AND 0.3;        
--where comm_pct >= 0,2 and comm_pct <=0.3;

--EMP ���̺��� Ŀ�̼��� �޴� ������ �� Ŀ�̼Ǻ���(comm_pct)�� 0.2~0.3 ���̰� �ƴ� ������ ID(emp_id), �̸�(emp_name), Ŀ�̼Ǻ���(comm_pct)�� ��ȸ.
SELECT
    emp_id,
    emp_name,
    comm_pct
FROM
    emp
WHERE
    comm_pct NOT BETWEEN 0.2 AND 0.3;   
--where comm_pct < 0.2 or comm_pct > 0.3;

--EMP ���̺��� ����(job)�� 'IT_PROG' �ų� 'ST_MAN' �� ������  ID(emp_id), �̸�(emp_name), ����(job)�� ��ȸ.
SELECT
    emp_id,
    emp_name,
    job
FROM
    emp
WHERE
    job IN ( 'IT_PROG', 'ST_MAN' );        
--where job ='IT_PROG' or job='ST_MAN';



--EMP ���̺��� ����(job)�� 'IT_PROG' �� 'ST_MAN' �� �ƴ� ������  ID(emp_id), �̸�(emp_name), ����(job)�� ��ȸ.
SELECT
    emp_id,
    emp_name,
    job
FROM
    emp
WHERE
    job NOT IN ( 'IT_PROG', 'ST_MAN' );



--EMP ���̺��� ���� �̸�(emp_name)�� S�� �����ϴ� ������  ID(emp_id), �̸�(emp_name)
--EMP ���̺��� ���� �̸�(emp_name)�� S�� �������� �ʴ� ������  ID(emp_id), �̸�(emp_name)
--EMP ���̺��� ���� �̸�(emp_name)�� en���� ������ ������  ID(emp_id), �̸�(emp_name)�� ��ȸ

SELECT
    emp_id,
    emp_name
FROM
    emp
WHERE
-- ~~   ������ �� , %~~
-- ~~ �����ϴ� �� , ~~%
-- ~~ �����ϴ� �� , %~~%
    emp_name LIKE '%en'; 
--where emp_name not like 'S%'; 

--EMP ���̺��� ���� �̸�(emp_name)�� �� ��° ���ڰ� ��e���� ��� ����� �̸��� ��ȸ

SELECT
    emp_name
FROM
    emp
WHERE
    emp_name LIKE '__e%'; -- 

-- EMP ���̺��� ������ �̸��� '%' �� ���� ������ ID(emp_id), �����̸�(emp_name) ��ȸ
SELECT
    emp_id,
    emp_name
FROM
    emp
WHERE
    emp_name LIKE '%$%%' ESCAPE '$';



--EMP ���̺��� �μ���(dept_name)�� null�� ������ ID(emp_id), �̸�(emp_name), �μ���(dept_name)�� ��ȸ.

SELECT
    emp_id,
    emp_name,
    dept_name
FROM
    emp
WHERE
    dept_name IS NULL;


--�μ���(dept_name) �� NULL�� �ƴ� ������ ID(emp_id), �̸�(emp_name), �μ���(dept_name) ��ȸ
SELECT
    emp_id,
    emp_name,
    dept_name
FROM
    emp
WHERE
    dept_name IS NOT NULL;

--TODO: EMP ���̺��� ����(job)�� 'IT_PROG'�� �������� ��� �÷��� �����͸� ��ȸ. 

SELECT
    *
FROM
    emp
WHERE
    job = 'IT_PROG';

--TODO: EMP ���̺��� ����(job)�� 'IT_PROG'�� �ƴ� �������� ��� �÷��� �����͸� ��ȸ. 
SELECT
    *
FROM
    emp
WHERE
    job != 'IT_PROG';


--TODO: EMP ���̺��� �̸�(emp_name)�� 'Peter'�� �������� ��� �÷��� �����͸� ��ȸ
SELECT
    *
FROM
    emp
WHERE
    emp_name = 'Peter';


--TODO: EMP ���̺��� �޿�(salary)�� $10,000 �̻��� ������ ID(emp_id), �̸�(emp_name)�� �޿�(salary)�� ��ȸ
SELECT
    emp_id,
    emp_name,
    salary
FROM
    emp
WHERE
    salary >= 10000;


--TODO: EMP ���̺��� �޿�(salary)�� $3,000 �̸��� ������ ID(emp_id), �̸�(emp_name)�� �޿�(salary)�� ��ȸ
SELECT
    emp_id,
    emp_name,
    salary
FROM
    emp
WHERE
    salary < 3000;


--TODO: EMP ���̺��� �޿�(salary)�� $3,000 ������ ������ ID(emp_id), �̸�(emp_name)�� �޿�(salary)�� ��ȸ
SELECT
    emp_id,
    emp_name,
    salary
FROM
    emp
WHERE
    salary < 3000;


--TODO: �޿�(salary)�� $4,000���� $8,000 ���̿� ���Ե� �������� ID(emp_id), �̸�(emp_name)�� �޿�(salary)�� ��ȸ
SELECT
    emp_id,
    emp_name,
    salary
FROM
    emp
WHERE
    salary BETWEEN 4000 AND 8000;


--TODO: �޿�(salary)�� $4,000���� $8,000 ���̿� ���Ե��� �ʴ� ��� ��������  ID(emp_id), �̸�(emp_name), �޿�(salary)�� ǥ��
SELECT
    emp_id,
    emp_name,
    salary
FROM
    emp
WHERE
    salary NOT BETWEEN 4000 AND 8000;


--TODO: EMP ���̺��� 2007�� ���� �Ի��� ��������  ID(emp_id), �̸�(emp_name), �Ի���(hire_date)�� ��ȸ.
SELECT
    emp_id,
    emp_name,
    salary
FROM
    emp
WHERE
    salary BETWEEN 4000 AND 8000;


--TODO: EMP ���̺��� 2004�⿡ �Ի��� �������� ID(emp_id), �̸�(emp_name), �Ի���(hire_date)�� ��ȸ.

SELECT
    emp_id,
    emp_name,
    hire_date
FROM
    emp
WHERE
    hire_date > '2004/01/01';

--TODO: EMP ���̺��� 2005�� ~ 2007�� ���̿� �Ի�(hire_date)�� �������� ID(emp_id), �̸�(emp_name), ����(job), �Ի���(hire_date)�� ��ȸ.
SELECT
    emp_id,
    emp_name,
    hire_date
FROM
    emp
WHERE
    hire_date BETWEEN '2005/01/01' AND '2007/12/31';


--TODO: EMP ���̺��� ������ ID(emp_id)�� 110, 120, 130 �� ������  ID(emp_id), �̸�(emp_name), ����(job)�� ��ȸ

SELECT
    emp_id,
    emp_name,
    job
FROM
    emp
WHERE
    emp_id IN ( 110, 120, 130 );

--TODO: EMP ���̺��� �μ�(dept_name)�� 'IT', 'Finance', 'Marketing' �� �������� ID(emp_id), �̸�(emp_name), �μ���(dept_name)�� ��ȸ.
SELECT
    emp_id,
    emp_name,
    dept_name
FROM
    emp
WHERE
    dept_name IN ( 'IT', 'Finance', 'Marketing' );


--TODO: EMP ���̺��� 'Sales' �� 'IT', 'Shipping' �μ�(dept_name)�� �ƴ� �������� ID(emp_id), �̸�(emp_name), �μ���(dept_name)�� ��ȸ.
SELECT
    emp_id,
    emp_name,
    dept_name
FROM
    emp
WHERE
    dept_name NOT IN ( 'IT', 'Finance', 'Marketing' );


--TODO: EMP ���̺��� �޿�(salary)�� 17,000, 9,000,  3,100 �� ������ ID(emp_id), �̸�(emp_name), ����(job), �޿�(salary)�� ��ȸ.
SELECT
    emp_id,
    emp_name,
    job,
    salary
FROM
    emp
WHERE
    salary IN ( 17000, 9000, 3100 );


--TODO EMP ���̺��� ����(job)�� 'SA'�� �� ������ ID(emp_id), �̸�(emp_name), ����(job)�� ��ȸ

SELECT
    emp_id,
    emp_name,
    job
FROM
    emp
WHERE
    job LIKE '%SA%';

--TODO: EMP ���̺��� ����(job)�� 'MAN'�� ������ ������ ID(emp_id), �̸�(emp_name), ����(job)�� ��ȸ

SELECT
    emp_id,
    emp_name,
    job
FROM
    emp
WHERE
    job LIKE '%MAN';


--TODO. EMP ���̺��� Ŀ�̼��� ����(comm_pct�� null��) ��� ������ ID(emp_id), �̸�(emp_name), �޿�(salary) �� Ŀ�̼Ǻ���(comm_pct)�� ��ȸ
SELECT
    emp_id,
    emp_name,
    salary,
    comm_pct
FROM
    emp
WHERE
    comm_pct IS NULL;

    

--TODO: EMP ���̺��� Ŀ�̼��� �޴� ��� ������ ID(emp_id), �̸�(emp_name), �޿�(salary) �� Ŀ�̼Ǻ���(comm_pct)�� ��ȸ

SELECT
    emp_id,
    emp_name,
    salary,
    comm_pct
FROM
    emp
WHERE
    comm_pct IS NOT NULL;

--TODO: EMP ���̺��� ������ ID(mgr_id) ���� ������ ID(emp_id), �̸�(emp_name), ����(job), �ҼӺμ�(dept_name)�� ��ȸ

SELECT
    emp_id,
    emp_name,
    job,
    dept_name,
    mgr_id
FROM
    emp
WHERE
    mgr_id IS NULL;


--TODO : EMP ���̺��� ����(salary * 12) �� 200,000 �̻��� �������� ��� ������ ��ȸ.

SELECT
    *
FROM
    emp
WHERE
    salary * 12 >= 200000;


/* *************************************
 WHERE ������ �������� ���
 AND OR
 
 �� and �� -> ��: ��ȸ ��� ��
 ���� or ���� -> ����: ��ȸ ��� ���� �ƴ�.
 
 ���� �켱���� : and > or
 
 where ����1 and ����2 or ����3
 1. ���� 1 and ����2
 2. 1��� or ����3
 
 or�� ���� �Ϸ��� where ����1 and (����2 or ����3)
 
 
 
 **************************************/
-- EMP ���̺��� ����(job)�� 'SA_REP' �̰� �޿�(salary)�� $9,000 �� ������ ������ ID(emp_id), �̸�(emp_name), ����(job), �޿�(salary)�� ��ȸ.
SELECT
    emp_id,
    emp_name,
    job,
    salary
FROM
    emp
WHERE
        job = 'SA_REP'
    AND salary > 9000;



-- EMP ���̺��� ����(job)�� 'FI_ACCOUNT' �ų� �޿�(salary)�� $8,000 �̻����� ������ ID(emp_id), �̸�(emp_name), ����(job), �޿�(salary)�� ��ȸ.
SELECT
    emp_id,
    emp_name,
    job,
    salary
FROM
    emp
WHERE
    job = 'FI_ACCOUNT'
    OR salary >= 9000;


--TODO: EMP ���̺��� �μ�(dept_name)�� 'Sales��'�� ����(job)�� 'SA_MAN' �̰� �޿��� $13,000 ������ 
--      ������ ID(emp_id), �̸�(emp_name), ����(job), �޿�(salary), �μ�(dept_name)�� ��ȸ

SELECT
    emp_id,
    emp_name,
    job,
    salary,
    dept_name
FROM
    emp
WHERE
        dept_name = 'Sales'
    AND job = 'SA_MAN'
    AND salary <= 13000;

--TODO: EMP ���̺��� ����(job)�� 'MAN'�� ���� ������ �߿��� �μ�(dept_name)�� 'Shipping' �̰� 2005������ �Ի��� 
--      ��������  ID(emp_id), �̸�(emp_name), ����(job), �Ի���(hire_date), �μ�(dept_name)�� ��ȸ

SELECT
    emp_id,
    emp_name,
    job,
    hire_date,
    dept_name
FROM
    emp
WHERE
        dept_name = 'Shipping'
    AND ( job LIKE '%MAN%'
          AND hire_date >= '2005/01/01' );

--TODO: EMP ���̺��� �Ի�⵵�� 2004���� ������� �޿��� $20,000 �̻��� 
--      �������� ID(emp_id), �̸�(emp_name), �Ի���(hire_date), �޿�(salary)�� ��ȸ.
SELECT
    emp_id,
    emp_name,
    hire_date,
    salary
FROM
    emp
WHERE
    ( hire_date BETWEEN '2004/01/01' AND '2004/12/31' )
    OR salary >= 20000;


--TODO : EMP ���̺���, �μ��̸�(dept_name)��  'Executive'�� 'Shipping' �̸鼭 �޿�(salary)�� 6000 �̻��� ����� ��� ���� ��ȸ. 

SELECT
    *
FROM
    emp
WHERE
    dept_name IN ( 'Executive', 'Shipping' )
    AND salary >= 6000;

--TODO: EMP ���̺��� ����(job)�� 'MAN'�� ���� ������ �߿��� �μ��̸�(dept_name)�� 'Marketing' �̰ų� 'Sales'�� 
--      ������ ID(emp_id), �̸�(emp_name), ����(job), �μ�(dept_name)�� ��ȸ

SELECT
    emp_id,
    emp_name,
    job,
    dept_name
FROM
    emp
WHERE
    job LIKE '%MAN%'
    AND dept_name IN ( 'Marketing', 'Sales' );



--TODO: EMP ���̺��� ����(job)�� 'MAN'�� ���� ������ �� �޿�(salary)�� $10,000 ������ �ų� 2008�� ���� �Ի��� 
--      ������ ID(emp_id), �̸�(emp_name), ����(job), �Ի���(hire_date), �޿�(salary)�� ��ȸ
SELECT
    emp_id,
    emp_name,
    job,
    hire_date,
    salary
FROM
    emp
WHERE
    job LIKE '%MAN%'
    AND ( salary <= 10000
          OR hire_date > '2008/01/01' );
--�Ͻ�: ���� < �̷�

/* *************************************
order by�� �̿��� ����
- select���� ���� �������� ���� ����.
- order by ���ı����÷� ���Ĺ�� [, ���ı����÷� ���Ĺ��,...]
- ���ı����÷�
	- �÷��̸�.
	- select���� ����� ����.
	- ��Ī�� ���� ��� ��Ī.
- ���Ĺ��
	- asc : �������� (�⺻-��������)
	- desc : ��������
- ���ڿ�: ���� < �빮�� < �ҹ��� < �ѱ� <null
- date : ���� < �̷�	

NULL ��
ASC : ������.  order by �÷��� asc nulls first
DESC : ó��.   order by �÷��� desc nulls last
-- nulls first, nulls last ==> ����Ŭ ����.

************************************* */

-- �������� ��ü ������ ���� ID(emp_id)�� ū ������� ������ ��ȸ

SELECT
    *
FROM
    emp
ORDER BY
    emp_id DESC;

-- �������� id(emp_id), �̸�(emp_name), ����(job), �޿�(salary)�� 
-- ����(job) ������� (A -> Z) ��ȸ�ϰ� ����(job)�� ���� ��������  �޿�(salary)�� ���� ������� 2�� �����ؼ� ��ȸ.

SELECT
    emp_id    id,
    emp_name  name,
    job       work,
    salary    money
FROM
    emp
ORDER BY
    3,
    4 DESC; --select �� ���� 3,4��°
--ORDER BY work,money DESC; --�÷� ��Ī����


--�μ����� �μ���(dept_name)�� ������������ ������ ��ȸ�Ͻÿ�.



--TODO: �޿�(salary)�� $5,000�� �Ѵ� ������ ID(emp_id), �̸�(emp_name), �޿�(salary)�� �޿��� ���� �������� ��ȸ
SELECT
    emp_id,
    emp_name,
    salary
FROM
    emp
WHERE
    salary > 5000
ORDER BY
    3 DESC;



--TODO: �޿�(salary)�� $5,000���� $10,000 ���̿� ���Ե��� �ʴ� ��� ������  ID(emp_id), �̸�(emp_name), �޿�(salary)�� �̸�(emp_name)�� ������������ ����
SELECT
    emp_id,
    emp_name,
    salary
FROM
    emp
WHERE
    salary NOT BETWEEN 5000 AND 10000
ORDER BY
    emp_name;

--TODO: EMP ���̺��� ������ ID(emp_id), �̸�(emp_name), ����(job), �Ի���(hire_date)�� �Ի���(hire_date) ��(��������)���� ��ȸ.
SELECT
    emp_id,
    emp_name,
    job,
    hire_date
FROM
    emp
order by 4;

--TODO: EMP ���̺��� ID(emp_id), �̸�(emp_name), �޿�(salary), �Ի���(hire_date)�� �޿�(salary) ������������ �����ϰ� �޿�(salary)�� ���� ���� �Ի���(hire_date)�� ������ ������ ����.
SELECT
    emp_id,
    emp_name,
    hire_date,
    salary
FROM
    emp
order by 4, 3;

select dept_name
from emp
--order by dept_name desc nulls last;
order by dept_name nulls first;
