/* *********************************************************************
DML - �����͸� �ٷ�� sql��
    - insert : ���� (Create)
    - select : ��ȸ (Read, Retrieve)
    - update : ���� (Update)
    - delete : ���� (Delete)

INSERT �� - �� �߰�
����
 - �����߰� :
   - INSERT INTO ���̺�� (�÷� [, �÷�]) VALUES (�� [, ��[])
   - ��� �÷��� ���� ���� ��� �÷� ���������� ���� �� �� �ִ�.

 - ��ȸ����� INSERT �ϱ� (subquery �̿�)
   - INSERT INTO ���̺�� (�÷� [, �÷�])  SELECT ����
	- INSERT�� �÷��� ��ȸ��(subquery) �÷��� ������ Ÿ���� �¾ƾ� �Ѵ�.
	- ��� �÷��� �� ���� ��� �÷� ������ ������ �� �ִ�.
	
  
************************************************************************ */
DESC dept; -- table ���� ��ȸ
INSERT INTO dept (
    dept_id,
    dept_name,
    loc
) VALUES (
    1000,
    '��ȹ��',
    '����'
);

INSERT INTO dept (
    dept_id,
    dept_name,
    loc
) VALUES (
    1100,
    '���ź�',
    '�λ�'
);

COMMIT;

INSERT INTO dept (
    dept_id,
    dept_name,
    loc
) VALUES (
    1200,
    '��ȹ��',
    '����'
);

INSERT INTO dept (
    dept_id,
    dept_name,
    loc
) VALUES (
    1300,
    '��ȹ��',
    '����'
);

INSERT INTO dept (
    dept_id,
    dept_name,
    loc
) VALUES (
    1400,
    '��ȹ��',
    '����'
);

COMMIT; -- commit�� �ϱ� �������� �ӽ÷� ó���� ����. commit ���� ó��
ROLLBACK; --insert/update/delete �ϱ� ��(������ commit) ���·� ������

SELECT
    *
FROM
    dept;

DESC emp;

INSERT INTO emp VALUES (
    1000,
    'ȫ�浿',
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
    '�̼���',
    '2000/01/05',
    6000
);

INSERT INTO emp VALUES (
    1200,
    '�ڿ���',
    'FI_ACCOUNT',
    NULL,
    '2020/01/02',
    7000,
    NULL,
    10
);

INSERT INTO emp VALUES (
    1300,
    '�ڿ���',
    'FI_ACCOUNT',
    NULL,
    TO_DATE('2020/01', 'yyyy/mm'),
    7000,
    NULL,
    10
);

-- INSERT ERRORS
-- �̹� �ִ� PK���� ����
INSERT INTO emp VALUES (
    1000,
    '�迵��',
    'FI_ACCOUNT',
    100,
    '2021/01/06',
    5000,
    0.1,
    20
);
-- Not null �÷��� Null�� ���� �� ����.
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
-- emp�� job_id �� FK column -> �θ����̺��� PK�÷�(job_Id)�� �ִ� ���� ���� �� �ִ�.
INSERT INTO emp VALUES (
    1600,
    '�迵��',
    'ȸ��',
    100,
    '2021/01/06',
    5000,
    0.1,
    20
);
-- �÷� ������ Ÿ���� ũ�⺸�� �� ū ���� �ִ� ��� ����
INSERT INTO emp VALUES (
    1700,
    '�迵���迵���迵��',
    'FI_ACCOUNT',
    100,
    '2021/01/06',
    5000,
    0.1,
    20
);

INSERT INTO emp VALUES (
    1000000,
    '�迵���迵���迵��',
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
--TODO: �μ��� ������ �޿��� ���� ��� ���̺� ����. 
--      ��ȸ����� insert. ����: �հ�, ���, �ִ�, �ּ�, �л�, ǥ������
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
UPDATE : ���̺��� �÷��� ���� ����
UPDATE ���̺��
SET    ������ �÷� = ������ ��  [, ������ �÷� = ������ ��]
[WHERE ��������]

 - UPDATE: ������ ���̺� ����
 - SET: ������ �÷��� ���� ����
 - WHERE: ������ ���� ����. 
************************************************************************ */



-- ���� ID�� 200�� ������ �޿��� 5000���� ����
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

-- ���� ID�� 200�� ������ �޿��� 10% �λ��� ������ ����.
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

-- �μ� ID�� 100�� ������ Ŀ�̼� ������ 0.2�� salary�� 3000�� ���� ������, ���_id�� 100 ����.
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

-- TODO: �μ� ID�� 100�� �������� �޿��� 100% �λ�
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


-- TODO: IT �μ��� �������� �޿��� 3�� �λ�
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
-- TODO: EMP2 ���̺��� ��� �����͸� MGR_ID�� NULL�� HIRE_DATE �� �����Ͻ÷� COMM_PCT�� 0.5�� ����.
UPDATE emp
SET
    mgr_id = NULL,
    hire_date = sysdate,
    comm_pct = 0.5;

SELECT
    *
FROM
    emp;
-- TODO: COMM_PCT �� 0.3�̻��� �������� COMM_PCT�� NULL �� ����.
UPDATE emp
SET
    comm_pct = NULL;
where COMM_PCT >= 0.3;
select * from emp;
rollback;

-- TODO: ��ü ��ձ޿����� ���� �޴� �������� �޿��� 50% �λ�.
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
DELETE : ���̺��� ���� ����
���� 
 - DELETE FROM ���̺�� [WHERE ��������]
   - WHERE: ������ ���� ����
************************************************************************ */
-- �μ����̺��� �μ�_ID�� 200�� �μ� ����
 DELETE FROM DEPT WHERE DEPT_ID = 200 ; SELECT * FROM DEPT ORDER BY 1 ;

-- �μ����̺��� �μ�_ID�� 10�� �μ� ����
 SELECT * FROM EMP WHERE DEPT_ID = 10 ;
DELETE FROM EMP WHERE DEPT_ID = 10 ; ROLLBACK ; SELECT * FROM EMP ;
-- TODO: �μ� ID�� ���� �������� ����
 SELECT * FROM EMP WHERE DEPT_ID IS NULL ; DELETE FROM EMP WHERE
DEPT_ID IS NULL ;
-- TODO: ��� ����(emp.job_id)�� 'SA_MAN'�̰� �޿�(emp.salary) �� 12000 �̸��� �������� ����.
 DELETE FROM EMP WHERE JOB_ID = 'SA_MAN' AND SALARY < 12000 ;


-- TODO: comm_pct �� null�̰� job_id �� IT_PROG�� �������� ����
 DELETE FROM EMP WHERE COMM_PCT IS NULL AND JOB_ID =
'IT_PROG' ;


-- TODO: job_id�� CLERK�� �� ������ �ϴ� ������ ����
 DELETE FROM EMP WHERE JOB_ID LIKE '%CLERK%' ; COMMIT ;

