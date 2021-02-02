/* **************************************************************************
����(Aggregation) �Լ��� GROUP BY, HAVING
************************************************************************** */

/* ************************************************************
�����Լ�, �׷��Լ�, ������ �Լ�
- �μ�(argument)�� �÷�.
  - sum(): ��ü�հ�
  - avg(): ���
  - min(): �ּҰ�
  - max(): �ִ밪
  - stddev(): ǥ������
  - variance(): �л�
  - count(): ����
        - �μ�: 
            - �÷���: null�� ������ ����
            -  *: �� ���(null�� ����)

- count(*) �� �����ϰ� ��� �����Լ��� null�� ���� ����Ѵ�.
- sum, avg, stddev, variance: number Ÿ�Կ��� ��밡��.
- min, max, count :  ��� Ÿ�Կ� �� ��밡��.
************************************************************* */

-- EMP ���̺��� �޿�(salary)�� ���հ�, ���, �ּҰ�, �ִ밪, ǥ������, �л�, ���������� ��ȸ 
SELECT
    SUM(salary)                        "Total Sum",
    round(AVG(salary), 2)              "Average",
    MIN(salary)                        "�ּҰ�",
    MIN(salary)                        "�ּҰ�",
    round(STDDEV(salary), 2)           "std",
    round(VARIANCE(salary), 2)         "Var",
    COUNT(emp_id)                      "Primary Key",
    COUNT(*)                           "�����"
FROM
    emp;


-- EMP ���̺��� ���� �ֱ� �Ի���(hire_date)�� ���� ������ �Ի����� ��ȸ
SELECT
    MAX(hire_date),
    MIN(hire_date)
FROM
    emp;
-- EMP ���̺��� �μ�(dept_name) �� ������ ��ȸ
SELECT
    COUNT(dept_name)
FROM
    emp; -- Null �� ����
-- emp ���̺��� job ������ ���� ��ȸ
SELECT
    COUNT(DISTINCT job)
FROM
    emp;

SELECT DISTINCT
    nvl(dept_name, '�̹�ġ')
FROM
    emp; -- null�� ó�� �� count

--TODO:  Ŀ�̼� ����(comm_pct)�� �ִ� ������ ���� ��ȸ

SELECT
    COUNT(*) ������
FROM
    emp
WHERE
    comm_pct IS NOT NULL;


--TODO: Ŀ�̼� ����(comm_pct)�� ���� ������ ���� ��ȸ
SELECT
    COUNT(*) ������
FROM
    emp
WHERE
    comm_pct IS NOT NULL;
    
--select count(comm_pct) ������ from emp;  count() NULL �� ����   

--TODO: ���� ū Ŀ�̼Ǻ���(comm_pct)�� �� ���� ���� Ŀ�̼Ǻ����� ��ȸ
SELECT
    MAX(comm_pct),
    MIN(comm_pct)
FROM
    emp;

--TODO:  Ŀ�̼� ����(comm_pct)�� ����� ��ȸ. 
--�Ҽ��� ���� 2�ڸ����� ���

SELECT
    round(AVG(comm_pct), 2)
FROM
    emp;

--TODO: ���� �̸�(emp_name) �� ���������� �����Ҷ� ���� ���߿� ��ġ�� �̸��� ��ȸ.

SELECT
    MAX(emp_name)
FROM
    emp;

--TODO: �޿�(salary)���� �ְ� �޿��װ� ���� �޿����� ������ ���

SELECT
    MAX(salary) - MIN(salary)
FROM
    emp;

--TODO: ���� �� �̸�(emp_name)�� ����� ���� ��ȸ.

SELECT
    MAX(length(emp_name))
FROM
    emp;

SELECT
    emp_name
FROM
    emp
WHERE
    length(emp_name) = (
        SELECT
            MAX(length(emp_name))
        FROM
            emp
    ); --subquery
--where length(emp_name) = max(length(emp_name)); where ������ �׷��Լ� ��� �ȵ�

--TODO: EMP ���̺��� �μ�(dept_name)�� �������� �ִ��� ��ȸ. 
-- ���������� ����

SELECT
    COUNT(DISTINCT nvl(dept_name, '�̹���')) �μ�
FROM
    emp; -- NULL ���� ī��Ʈ


/* *****************************************************
group by ��
- Ư�� �÷�(��)�� ������ ���� ������ �� ������ �����÷��� �����ϴ� ����.
	- ��) ������ �޿����. �μ�-������ �޿� �հ�. ���� �������
- ����: group by �÷��� [, �÷���]
	- �÷�: �з���(������, �����) - �μ��� �޿� ���, ���� �޿� �հ�
	- select�� where �� ������ ����Ѵ�.
	- select ������ group by ���� ������ �÷��鸸 �����Լ��� ���� �� �� �ִ�
*******************************************************/

-- ����(job)�� �޿��� ���հ�, ���, �ּҰ�, �ִ밪, ǥ������, �л�, �������� ��ȸ
SELECT
    job, ---- Group by �� ���� ����� �÷� ��, �������� ��ǥ
    SUM(salary)                        sum,
    round(AVG(salary), 2)              avg,
    MIN(salary)                        min,
    MAX(salary)                        max,
    round(STDDEV(salary), 2)           stddev,
    round(VARIANCE(salary), 2)         var,
    COUNT(*)                           "COUNT"
FROM
    emp
GROUP BY
    job; -- select distinct job from emp; 19�� �з� ��.


-- �Ի翬�� �� �������� �޿� ���.
SELECT
    EXTRACT(YEAR FROM hire_date)     "Depending on year",
    round(AVG(salary), 2)            sal_avg
FROM
    emp
GROUP BY
    EXTRACT(YEAR FROM hire_date)
ORDER BY
    1;

-- �μ���(dept_name) �� 'Sales'�̰ų� 'Purchasing' �� �������� ������ (job) �������� ��ȸ

SELECT
    dept_name,
    job,
    COUNT(*) ������
FROM
    emp
WHERE
    dept_name IN ( 'Sales', 'Purchasing' )
GROUP BY
    dept_name,
    job;

-- �μ�(dept_name), ����(job) �� �ִ� ��ձ޿�(salary)�� ��ȸ.
SELECT
    dept_name,
    job,
    MAX(salary)
FROM
    emp
GROUP BY
    dept_name,
    job
ORDER BY
    dept_name;


-- �޿�(salary) ������ �������� ���. �޿� ������ 10000 �̸�,  10000�̻� �� ����.
SELECT
    CASE
        WHEN salary >= 10000 THEN
            '10000�̻�'
        ELSE
            '10000�̸�'
    END �޿����,
    COUNT(*)
FROM
    emp
GROUP BY
    CASE
        WHEN salary >= 10000 THEN
            '10000�̻�'
        ELSE
            '10000�̸�'
    END;



--TODO: �μ���(dept_name) �������� ��ȸ

SELECT
    dept_name,
    COUNT(*)
FROM
    emp
GROUP BY
    dept_name;


--TODO: ������(job) �������� ��ȸ. �������� ���� �ͺ��� ����.

SELECT
    job,
    COUNT(*)
FROM
    emp
GROUP BY
    job
ORDER BY
    2 DESC;

--TODO: �μ���(dept_name), ����(job)�� ������, �ְ�޿�(salary)�� ��ȸ. �μ��̸����� �������� ����.
SELECT
    dept_name,
    job,
    COUNT(*) ������,
    MAX(salary)
FROM
    emp
GROUP BY
    dept_name,
    job
ORDER BY
    dept_name;


--TODO: EMP ���̺��� �Ի翬����(hire_date) �� �޿�(salary)�� �հ��� ��ȸ. 
--(�޿� �հ�� �ڸ������� , �� �����ÿ�. ex: 2,000,000)
SELECT
    EXTRACT(YEAR FROM hire_date)                   year,
    to_char(SUM(salary), 'fmL999,999,999')          "�� �޿�"
FROM
    emp
GROUP BY
    EXTRACT(YEAR FROM hire_date)
ORDER BY
    1;


--TODO: ����(job)�� �Ի�⵵(hire_date)�� ��� �޿�(salary)�� ��ȸ
SELECT
    EXTRACT(YEAR FROM hire_date)     �Ի�⵵,
    job                              ����,
    round(AVG(salary), 2)             "��� �޿�"
FROM
    emp
GROUP BY
    EXTRACT(YEAR FROM hire_date),
    job;


--TODO: �μ���(dept_name) ������ ��ȸ�ϴµ� �μ���(dept_name)�� null�� ���� �����ϰ� ��ȸ.

SELECT
    dept_name,
    COUNT(*)
FROM
    emp
WHERE
    dept_name IS NOT NULL
GROUP BY
    dept_name
ORDER BY
    2 DESC;


--TODO �޿� ������ �������� ���. �޿� ������ 5000 �̸�, 5000�̻� 10000 �̸�, 10000�̻� 20000�̸�, 20000�̻�. 
SELECT
    CASE
        WHEN salary < 5000                  THEN
            '5000�̸�'
        WHEN salary BETWEEN 5000 AND 10000  THEN
            '5000~ 10000'
        ELSE
            '10000�̻�'
    END �޿�,
    COUNT(*)
FROM
    emp
GROUP BY
    CASE
        WHEN salary < 5000                  THEN
            '5000�̸�'
        WHEN salary BETWEEN 5000 AND 10000  THEN
            '5000~ 10000'
        ELSE
            '10000�̻�'
    END;


--group by case when salary < 5000 then '5000�̸�' when salary between 5000 and 10000 then '5000�̻� 10000 �̸�' 

/* **************************************************************
having �� -- Ư�� ������ �׷캰�� ���� ���� �� ��,
- �������� ���� �� ���� ����
- group by ���� order by ���� �´�.
- ����
    having ��������  --�����ڴ� where���� �����ڸ� ����Ѵ�. �ǿ����ڴ� �����Լ�(�� ���)
************************************************************** */
-- �������� 10 �̻��� �μ��� �μ���(dept_name)�� �������� ��ȸ

SELECT
    dept_name,
    COUNT(*)
FROM
    emp
GROUP BY
    dept_name
HAVING
    COUNT(*) >= 10;

SELECT
    dept_name,
    to_char(SUM(salary), 'fm$999,999,999') totsum
FROM
    emp
GROUP BY
    dept_name
HAVING
    COUNT(*) >= 10;

--TODO: 15�� �̻��� �Ի��� �⵵�� (�� �ؿ�) �Ի��� �������� ��ȸ.
SELECT
    EXTRACT(YEAR FROM hire_date) year,
    COUNT(*)
FROM
    emp
GROUP BY
    EXTRACT(YEAR FROM hire_date)
HAVING
    COUNT(*) >= 15;



--TODO: �� ����(job)�� ����ϴ� ������ ���� 10�� �̻��� ����(job)��� ��� �������� ��ȸ
SELECT
    job,
    COUNT(*)
FROM
    emp
GROUP BY
    job
HAVING
    COUNT(*) >= 10;



--TODO: ��� �޿���(salary) $5000�̻��� �μ��� �̸�(dept_name)�� ��� �޿�(salary), �������� ��ȸ
SELECT
    dept_name,
    round(AVG(salary), 2) ��ձ޿�,
    COUNT(*)
FROM
    emp
GROUP BY
    dept_name
HAVING
    AVG(salary) >= 5000
ORDER BY
    2;



--TODO: ��ձ޿��� $5,000 �̻��̰� �ѱ޿��� $50,000 �̻��� �μ��� �μ���(dept_name), ��ձ޿��� �ѱ޿��� ��ȸ
SELECT
    dept_name,
    round(AVG(salary), 2)          ��ձ޿�,
    SUM(salary)                   �ѱ޿�,
    COUNT(*)
FROM
    emp
GROUP BY
    dept_name
HAVING AVG(salary) >= 5000
       AND SUM(salary) >= 50000
ORDER BY
    2;



--TODO ������ 2�� �̻��� �μ����� �̸��� �޿��� ǥ�������� ��ȸ

SELECT
    dept_name,
    round(STDDEV(salary), 2) ǥ������
FROM
    emp
GROUP BY
    dept_name
HAVING
    COUNT(*) >= 2;


/* **************************************************************
- rollup : group by�� Ȯ��.
  - group by�� ���� ������ ��� ��������(�߰����質 ������)�� �κ� ���迡 �߰��ؼ� ��ȸ�Ѵ�.
  - ���� : group by rollup(�÷��� [,�÷���,..])



- grouping(), grouping_id()
  - rollup �̿��� ����� �÷��� �� ���� ���迡 �����ߴ��� ���θ� ��ȯ�ϴ� �Լ�.
  - case/decode�� �̿��� ���̺��� �ٿ� �������� ���� �� �ִ�.
  - ��ȯ��
	- 0 : ������ ���
	- 1 : ���� ���� ���.
 

- grouping() �Լ� 
 - ����: grouping(groupby�÷�)
 - select ���� ���Ǹ� rollup�̳� cube�� �Բ� ����ؾ� �Ѵ�.
 - group by�� �÷��� �����Լ��� ���迡 �����ߴ��� ���θ� ��ȯ
	- ��ȯ�� 0 : ������(�κ������Լ� ���), ��ȯ�� 1: ���� ����(���������� ���)
 - ���� �������� �κ������� ��������� �˷��ִ� �� �� �ִ�. 



- grouping_id
  - ����: grouping_id(groupby �÷�, ..)
  - ������ �÷��� ���迡 ���Ǿ����� ���� 2����(0: ���� ����, 1: ������)�� ��ȯ �ѵ� 10������ ��ȯ�ؼ� ��ȯ�Ѵ�.
 
************************************************************** */
SELECT
    dept_name,
    job,
    COUNT(*) ������
FROM
    emp
GROUP BY
    dept_name,
    job
ORDER BY
    1;
-- EMP ���̺��� ����(job) �� �޿�(salary)�� ��հ� ����� �Ѱ赵 ���̳������� ��ȸ.
SELECT
    decode(GROUPING(job), 0, job, 1, '�����')            job,
    COUNT(*)                                           "������",
    round(AVG(salary), 2)                              avg
FROM
    emp
GROUP BY
    ROLLUP(job);


-- EMP ���̺��� ����(JOB) �� �޿�(salary)�� ��հ� ����� �Ѱ赵 ���̳������� ��ȸ.
-- ���� �÷���  �Ұ質 �Ѱ��̸� '�����'��  �Ϲ� �����̸� ����(job)�� ���
SELECT
    decode(GROUPING_ID(job), 0, job, 1, '�����')            job,
    COUNT(*)                                              "������",
    round(AVG(salary), 2)                                 avg
FROM
    emp
GROUP BY
    ROLLUP(job);



-- EMP ���̺��� �μ�(dept_name), ����(job) �� salary�� �հ�� �������� �Ұ�� �Ѱ谡 �������� ��ȸ
SELECT
    decode(GROUPING_ID(dept_name, job), 0, nvl(dept_name, '�̹�ġ')
                                           || '-'
                                           || job,
           1,
           nvl(dept_name, '�̹�ġ')
           || ' �Ұ�',
           3,
           '�Ѱ�')    "GROUP_ID",
    dept_name,
    job,
    SUM(salary)     "�޿���"
FROM
    emp
GROUP BY
    ROLLUP(dept_name,
           job)
ORDER BY
    2;

--# �Ѱ�/�Ұ� ���� ��� :  �Ѱ�� '�Ѱ�', �߰������ '��' �� ���
--TODO: �μ���(dept_name) �� �ִ� salary�� �ּ� salary�� ��ȸ
SELECT
    decode(GROUPING_ID(dept_name), 0, dept_name, 1, '�Ѱ�') �μ���,
    MAX(salary),
    MIN(salary) -- ���ڿ� ����
FROM
    emp
GROUP BY
    ROLLUP(dept_name);



--TODO: ���_id(mgr_id) �� ������ ���� �Ѱ踦 ��ȸ�Ͻÿ�.
SELECT
    nvl(decode(GROUPING_ID(mgr_id), 1, '�Ѱ�', 0, mgr_id), 'ID X') id,
    COUNT(*)
FROM
    emp
GROUP BY
    ROLLUP(mgr_id);
 

--TODO: �Ի翬��(hire_date�� year)�� �������� ���� ���� �հ� �׸��� �Ѱ谡 ���� ��µǵ��� ��ȸ.
SELECT
    decode(GROUPING_ID(EXTRACT(YEAR FROM hire_date)), 1, '�Ѱ�', 0, EXTRACT(YEAR FROM hire_date))                      year,
    COUNT(*)                                                                                                     ������,
    SUM(salary * 12)                                                                                               �����հ�
FROM
    emp
GROUP BY
    ROLLUP(EXTRACT(YEAR FROM hire_date));

--TODO: �μ���(dept_name), �Ի�⵵�� ��� �޿�(salary) ��ȸ. �μ��� ����� �����谡 ���� �������� ��ȸ
SELECT
    decode(GROUPING_ID(dept_name, EXTRACT(YEAR FROM hire_date)), 3, '�Ѱ�', 0, nvl(dept_name, '�̹���')
                                                                             || '-'
                                                                             || EXTRACT(YEAR FROM hire_date),
           1,
           nvl(dept_name, '�̹���')
           || ': �Ұ�')                     "�μ�||�Ի�⵵",
    round(AVG(salary), 2)          ��ձ޿�
FROM
    emp
GROUP BY
    ROLLUP(dept_name,
           EXTRACT(YEAR FROM hire_date));