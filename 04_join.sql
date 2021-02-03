/* ****************************************
����(JOIN) �̶�
- 2�� �̻��� ���̺� �ִ� �÷����� ���ļ� ������ ���̺��� ����� ��ȸ�ϴ� ����� ���Ѵ�.
 	- �ҽ����̺� : ���� ���� �о�� �Ѵٰ� �����ϴ� ���̺� - ���� ������ ���̺�
	- Ÿ�����̺� : �ҽ��� ���� �� �ҽ��� ������ ����� �Ǵ� ���̺� - �߰�����, �ΰ�����

- id �� 100�� """����"""�� id.�̸� ���� �μ��̸� �μ���ġ --> �ҽ� ����, Ÿ�� �μ�
- id �� 100�� """�μ�"""�� �̸�, ��ġ, �Ҽ������� �̸�, ���� --> �ҽ� �μ�, Ÿ�� ���� (�θ�/�ڽ� ���� x)
 
- �� ���̺��� ��� ��ĥ���� ǥ���ϴ� ���� ���� �����̶�� �Ѵ�.
    - ���� ���꿡 ���� ��������
        - Equi join , non-equi join
- ������ ����
    - Inner Join 
        - ���� ���̺��� ���� ������ �����ϴ� ��鸸 ��ģ��. 
    - Outer Join
        - ���� ���̺��� ����� ��� ����ϰ� �ٸ� �� ���̺��� ���� ������ �����ϴ� �ุ ��ģ��. ���������� �����ϴ� ���� ���� ��� NULL�� ��ģ��.
        - ���� : Left Outer Join,  Right Outer Join, Full Outer Join
    - Cross Join
        - �� ���̺��� �������� ��ȯ�Ѵ�. 
- ���� ����
    - ANSI ���� ����
        - ǥ�� SQL ����
        - ����Ŭ�� 9i ���� ����.
    - ����Ŭ ���� ����
        - ����Ŭ ���� �����̸� �ٸ� DBMS�� �������� �ʴ´�.
**************************************** */        
        

/* ****************************************
-- inner join : ANSI ���� ����
FROM  ���̺�a (��Ī) INNER JOIN ���̺�b (��Ī) ON �������� 

- inner�� ���� �� �� �ִ�.
**************************************** */
-- ������ ID(emp.emp_id), �̸�(emp.emp_name), �Ի�⵵(emp.hire_date), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ
SELECT
    e.emp_id,
    e.emp_name,
    e.hire_date,
    d.dept_name,
    d.dept_id
FROM
         emp e
    INNER JOIN dept d ON e.dept_id = d.dept_id; -- inner join�� �� ���ǿ� �����ϴ� ����(Not null)�� �ҷ���

-- ������ ID(emp.emp_id)�� 100�� ������ ����_ID(emp.emp_id), �̸�(emp.emp_name), �Ի�⵵(emp.hire_date), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ.
SELECT
    e.emp_id,
    e.emp_name,
    to_char(e.hire_date, 'yyyy"��"') hire_year
FROM
         emp e
    JOIN dept d ON e.dept_id = d.dept_id
WHERE
    e.emp_id = 100;

-- ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), ��������(job.job_title), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ
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


-- �μ�_ID(dept.dept_id)�� 30�� �μ��� �̸�(dept.dept_name), ��ġ(dept.loc), �� �μ��� �Ҽӵ� ������ �̸�(emp.emp_name)�� ��ȸ.
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

-- ������ ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), �޿����(salary_grade.grade) �� ��ȸ. �޿� ��� ������������ ����
SELECT
    e.emp_id,
    e.emp_name,
    e.salary,
    s.grade || '���'
FROM
         emp e
    JOIN salary_grade s ON e.salary BETWEEN s.low_sal AND s.high_sal
ORDER BY
    4;
--TODO 200����(200 ~ 299) ���� ID(emp.emp_id)�� ���� �������� ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ. ����_ID�� ������������ ����.
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

--TODO ����(emp.job_id)�� 'FI_ACCOUNT'�� ������ ID(emp.emp_id), �̸�(emp.emp_name), ����(emp.job_id), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ.  ����_ID�� ������������ ����.
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


--TODO Ŀ�̼Ǻ���(emp.comm_pct)�� �ִ� �������� ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), Ŀ�̼Ǻ���(emp.comm_pct), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ. ����_ID�� ������������ ����.
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

--TODO 'New York'�� ��ġ��(dept.loc) �μ��� �μ�_ID(dept.dept_id), �μ��̸�(dept.dept_name), ��ġ(dept.loc), 
--     �� �μ��� �Ҽӵ� ����_ID(emp.emp_id), ���� �̸�(emp.emp_name), ����(emp.job_id)�� ��ȸ. �μ�_ID �� ������������ ����.
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

--TODO ����_ID(emp.emp_id), �̸�(emp.emp_name), ����_ID(emp.job_id), ������(job.job_title) �� ��ȸ.
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
              
-- TODO: ���� ID �� 200 �� ������ ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), 
--       ��������(job.job_title), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ              
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


-- TODO: 'Shipping' �μ��� �μ���(dept.dept_name), ��ġ(dept.loc), �Ҽ� ������ �̸�(emp.emp_name), ������(job.job_title)�� ��ȸ. 
--       �����̸� ������������ ����
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


-- TODO:  'San Francisco' �� �ٹ�(dept.loc)�ϴ� ������ id(emp.emp_id), �̸�(emp.emp_name), �Ի���(emp.hire_date)�� ��ȸ
--         �Ի����� 'yyyy-mm-dd' �������� ���
SELECT
    e.emp_id,
    e.emp_name,
    to_char(e.hire_date, 'yyyy/mm/dd') hire_date
FROM
         emp e
    JOIN dept d ON e.dept_id = d.dept_id
WHERE
    d.loc = 'San Francisco';


-- TODO �μ��� �޿�(salary)�� ����� ��ȸ. �μ��̸�(dept.dept_name)�� �޿������ ���. �޿� ����� ���� ������ ����.
-- �޿��� , ���������ڿ� $ �� �ٿ� ���.

SELECT
    d.dept_id,
    d.dept_name,
    to_char(round(AVG(salary), 2), '$999,999') salary_���
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

--TODO ������ ID(emp.emp_id), �̸�(emp.emp_name), ������(job.job_title), �޿�(emp.salary), 
--     �޿����(salary_grade.grade), �ҼӺμ���(dept.dept_name)�� ��ȸ. ��� ������������ ����
select  e.emp_id,
        e.emp_name,
        j.job_title,
        e.salary,
        s.grade||'���' grade,
        d.dept_name
from    emp e join job j on e.job_id = j.job_id
              join salary_grade s on e.salary between s.low_sal and s.high_sal
              join dept d on e.dept_id = d.dept_id
order by s.grade;              


--TODO �μ��� �޿������(salary_grade.grade) 1�� �����ִ� �μ��̸�(dept.dept_name)�� 1����� ������ ��ȸ. �������� ���� �μ� ������� ����.
select  d.dept_name,
        count(*) ������
from    emp e join dept d on e.dept_id = d.dept_id
              join salary_grade s on e.salary between s.low_sal and s.high_sal
where  s.grade = 1
group by d.dept_id, d.dept_name
order by 1;


select * from salary_grade;


SELECT
    d.dept_name,
    COUNT(*) ������
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
����Ŭ ���� 
- Join�� ���̺���� from���� �����Ѵ�.
- Join ������ where���� ����Ѵ�. 

###################################################################################### */
-- ������ ID(emp.emp_id), �̸�(emp.emp_name), �Ի�⵵(emp.hire_date), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ
-- �Ի�⵵�� �⵵�� ���
SELECT
    e.emp_id,
    e.emp_name,
    to_char(hire_date, 'yyyy"��"') �Ի�⵵,
    d.dept_name
FROM
    emp   e,
    dept  d
WHERE
    e.emp_id = d.dept_id;


-- ������ ID(emp.emp_id)�� 100�� ������ ����_ID(emp.emp_id), �̸�(emp.emp_name), �Ի�⵵(emp.hire_date), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ
-- �Ի�⵵�� �⵵�� ���
SELECT
    e.emp_id,
    e.emp_name,
    to_char(hire_date, 'yyyy"��"') �Ի�⵵,
    d.dept_name
FROM
    emp   e,
    dept  d
WHERE
        e.emp_id = d.dept_id
    AND e.emp_id = 100;


-- ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), ��������(job.job_title), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ
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


--TODO 200����(200 ~ 299) ���� ID(emp.emp_id)�� ���� �������� ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ. ����_ID�� ������������ ����.
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


--TODO ����(emp.job_id)�� 'FI_ACCOUNT'�� ������ ID(emp.emp_id), �̸�(emp.emp_name), ����(emp.job_id), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ.  ����_ID�� ������������ ����.
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


--TODO Ŀ�̼Ǻ���(emp.comm_pct)�� �ִ� �������� ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), Ŀ�̼Ǻ���(emp.comm_pct), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ. ����_ID�� ������������ ����.

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


--TODO 'New York'�� ��ġ��(dept.loc) �μ��� �μ�_ID(dept.dept_id), �μ��̸�(dept.dept_name), ��ġ(dept.loc), 
--     �� �μ��� �Ҽӵ� ����_ID(emp.emp_id), ���� �̸�(emp.emp_name), ����(emp.job_id)�� ��ȸ. �μ�_ID �� ������������ ����.
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



--TODO ����_ID(emp.emp_id), �̸�(emp.emp_name), ����_ID(emp.job_id), ������(job.job_title) �� ��ȸ.

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

             
-- TODO: ���� ID �� 200 �� ������ ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), 
--       ��������(job.job_title), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ              
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



-- TODO: 'Shipping' �μ��� �μ���(dept.dept_name), ��ġ(dept.loc), �Ҽ� ������ �̸�(emp.emp_name), ������(job.job_title)�� ��ȸ. 
--       �����̸� ������������ ����
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


-- TODO:  'San Francisco' �� �ٹ�(dept.loc)�ϴ� ������ id(emp.emp_id), �̸�(emp.emp_name), �Ի���(emp.hire_date)�� ��ȸ
--         �Ի����� 'yyyy-mm-dd' �������� ���

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


--TODO �μ��� �޿�(salary)�� ����� ��ȸ. �μ��̸�(dept.dept_name)�� �޿������ ���. �޿� ����� ���� ������ ����.
-- �޿��� , ���������ڿ� $ �� �ٿ� ���.
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
    AVG(salary) DESC; -- ���� ��ü�� order by�� ����



--TODO ������ ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), �޿����(salary_grade.grade) �� ��ȸ. ���� id ������������ ����
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

--TODO ������ ID(emp.emp_id), �̸�(emp.emp_name), ������(job.job_title), �޿�(emp.salary), 
--     �޿����(salary_grade.grade), �ҼӺμ���(dept.dept_name)�� ��ȸ. ��� ������������ ����
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


--TODO �μ��� �޿������(salary_grade.grade) 1�� �����ִ� �μ��̸�(dept.dept_name)�� 1����� ������ ��ȸ. �������� ���� �μ� ������� ����.
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
Self ����
- ���������� �ϳ��� ���̺��� �ΰ��� ���̺�ó�� �����ϴ� ��.
**************************************************** */
--������ ID(emp.emp_id), �̸�(emp.emp_name), ����̸�(emp.emp_name)�� ��ȸ
SELECT
    e1.emp_id,
    e1.emp_name    �����̸�,
    e1.salary,
    e2.emp_id,
    e2.emp_name    ����̸�,
    e2.salary
FROM
         emp e1
    JOIN emp e2 ON e1.mgr_id = e2.emp_id;

SELECT
    e1.emp_id,
    e1.emp_name    �����̸�,
    e1.salary,
    e2.emp_id,
    e2.emp_name    ����̸�,
    e2.salary
FROM
    emp  e1,
    emp  e2
WHERE
    e1.mgr_id = e2.emp_id;


-- TODO : EMP ���̺��� ���� ID(emp.emp_id)�� 110�� ������ �޿�(salary)���� ���� �޴� �������� id(emp.emp_id), 
-- �̸�(emp.emp_name), �޿�(emp.salary)�� ���� ID(emp.emp_id) ������������ ��ȸ.
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


--īƼ�� �� : join������ �߸��ؼ� �� ���̺��� ��� ����� cross�� join�Ȱ�
-- 6�� Tables -> join ���� �ּ� 5��
-- N�� Tables -> join ���� �ּ� n-1��
-- ����Ŭ ���ο��� �߻�
SELECT
    *
FROM
    emp   e,
    dept  d;

-- �θ�-�ڽ� ���̺� ���ο��� : �θ� pk �÷� = �ڽ� fk �÷�


/* ****************************************************
�ƿ��� ���� (Outer Join)
- �������̺� �ҽ� ���̺��� ���� ��� ���̰� Ÿ�����̺��� ���� ���ο����� �����ϴ� �͸� ���δ�.

-����� ���� (���� ����� ������ ���� ����� �ص� ���̵���) 
 - �ҽ�(�����ؾ��ϴ����̺�)�� �����̸� left join, �������̸� right join �����̸� full outer join

-ANSI ����
from ���̺�a [LEFT | RIGHT | FULL] OUTER JOIN ���̺�b ON ��������
- OUTER�� ���� ����.

-����Ŭ JOIN ����
- FROM ���� ������ ���̺��� ����
- WHERE ���� ���� ������ �ۼ�
    - Ÿ�� ���̺� (+) �� ���δ�.
    - FULL OUTER JOIN�� �������� �ʴ´�.
**************************************************** */
-- ������ id(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), �μ���(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ. 
-- �μ��� ���� ������ ������ �������� ��ȸ. (�μ������� null). dept_name�� ������������ �����Ѵ�.
SELECT
    e.emp_id,
    e.emp_name,
    e.salary,
    d.dept_name,
    d.loc
FROM
    emp   e
    LEFT JOIN dept  d ON e.dept_id = d.dept_id -- outer ���� ����
--from    dept d right outer
ORDER BY
    dept_name;

-- ����Ŭ����
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

-- ��� ������ id(emp.emp_id), �̸�(emp.emp_name), �μ�_id(emp.dept_id)�� ��ȸ�ϴµ�
-- �μ�_id�� 80 �� �������� �μ���(dept.dept_name)�� �μ���ġ(dept.loc) �� ���� ����Ѵ�. (�μ� ID�� 80�� �ƴϸ� null�� ��������)

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

--����Ŭ ����
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


--TODO: ����_id(emp.emp_id)�� 100, 110, 120, 130, 140�� ������ ID(emp.emp_id), �̸�(emp.emp_name), ������(job.job_title) �� ��ȸ. 
-- �������� ���� ��� '�̹���' ���� ��ȸ
SELECT
    e.emp_id,
    e.emp_name,
    nvl(j.job_title, '�̹���')
FROM
    emp  e
    LEFT JOIN job  j ON e.job_id = j.job_id
WHERE
    e.emp_id IN ( 100, 110, 120, 130, 140 );

--����Ŭ ����
SELECT
    e.emp_id,
    e.emp_name,
    nvl(j.job_title, '�̹���')
FROM
    emp  e,
    job  j
WHERE
        e.job_id = j.job_id (+)
    AND e.emp_id IN ( 100, 110, 120, 130, 140 );

--TODO: �μ��� ID(dept.dept_id), �μ��̸�(dept.dept_name)�� �� �μ��� ���� �������� ���� ��ȸ. 
--      ������ ���� �μ��� 0�� �������� ��ȸ�ϰ� �������� ���� �μ� ������ ��ȸ.

SELECT
    d.dept_id,
    d.dept_name,
    COUNT(e.emp_id) ������ -- �������� pk�÷� count()
FROM
    dept  d
    LEFT JOIN emp   e ON d.dept_id = e.dept_id
GROUP BY (
    d.dept_id,
    d.dept_name
)
ORDER BY
    3;

--����Ŭ ����
SELECT
    d.dept_id,
    d.dept_name,
    COUNT(e.emp_id) ������
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

-- TODO: EMP ���̺��� �μ�_ID(emp.dept_id)�� 90 �� �������� id(emp.emp_id), �̸�(emp.emp_name), ����̸�(emp.emp_name), �Ի���(emp.hire_date)�� ��ȸ. 
-- �Ի����� yyyy-mm-dd �������� ���

SELECT
    e1.emp_id,
    e1.emp_name,
    e2.emp_name,
    to_char(e1.hire_date, 'yyyy-mm-dd') �Ի���
FROM
    emp  e1
    LEFT JOIN emp  e2 ON e1.mgr_id = e2.emp_id
WHERE
    e1.dept_id = 90;

--����Ŭ ����
SELECT
    e1.emp_id,
    e1.emp_name,
    e2.emp_name,
    to_char(e1.hire_date, 'yyyy-mm-dd') �Ի���
FROM
    emp  e1,
    emp  e2
WHERE
        e1.mgr_id = e2.emp_id (+)
    AND e1.dept_id = 90;
-- TODO 2003��~2005�� ���̿� �Ի��� ������ id(emp.emp_id), �̸�(emp.emp_name), ������(job.job_title), �޿�(emp.salary), �Ի���(emp.hire_date),
-- ����̸�(emp.emp_name), ������Ի���(emp.hire_date), �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ.
-- 2003�⿡�� 2005�� ���� �Ի��� ������ ��� �������� ��ȸ�Ѵ�. 

SELECT
    e1.emp_id       ����id,
    e1.emp_name     �����̸�,
    j.job_title     ����������,
    e1.salary       �����޿�,
    e1.hire_date    �����Ի���,
    e2.emp_name     ����̸�,
    e2.hire_date    ����Ի���,
    d.dept_name     �����μ���,
    d.loc           �����μ���ġ,
    d2.dept_name    ���μ���;
--select e1.*, j.*            -------------------�ش� ���̺� ���� ��ü ���
FROM
    emp   e1
    LEFT JOIN job   j ON e1.job_id = j.job_id
    LEFT JOIN emp   e2 ON e1.mgr_id = e2.emp_id
    LEFT JOIN dept  d ON e1.dept_id = d.dept_id    --d: ������ �μ� TB
    LEFT JOIN dept  d2 ON e2.dept_id = d2.dept_id  --d: ����� �μ� TB
WHERE
    EXTRACT(YEAR FROM e1.hire_date) BETWEEN 2003 AND 2005;
SELECT
    e1.emp_id       ����id,
    e1.emp_name     �����̸�,
    j.job_title     ����������,
    e1.salary       �����޿�,
    e1.hire_date    �����Ի���,
    e2.emp_name     ����̸�,
    e2.hire_date    ����Ի���,
    d.dept_name     �����μ���,
    d.loc           �����μ���ġ,
    d2.dept_name    ���μ���
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