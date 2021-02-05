/* **************************************************************************
��������(Sub Query)
- ����(insert, delete, update, select)�ȿ��� select ������ ����ϴ� ��.
- ���� ���� - ��������

���������� ���Ǵ� ��
 - select��, from��, where��, having��
 
���������� ����
- ��� ������ ���Ǿ������� ���� ����
    - ��Į�� �������� - select ���� ���. �ݵ�� �������� ����� 1�� 1��(�� �ϳ�-��Į��) 0���� ��ȸ�Ǹ� null�� ��ȯ
    - �ζ��� �� - from ���� ���Ǿ� ���̺��� ������ �Ѵ�.
�������� ��ȸ��� ����� ���� ����
    - ������ �������� - ���������� ��ȸ��� ���� ������ ��.
    - ������ �������� - ���������� ��ȸ��� ���� �������� ��.
���� ��Ŀ� ���� ����
    - ����(�񿬰�) �������� - ���������� ���������� �÷��� ������ �ʴ´�. ���������� ����� ���� ���������� �����ϴ� ������ �Ѵ�.
    - ���(����) �������� - ������������ ���������� �÷��� ����Ѵ�. 
                            ���������� ���� ����Ǿ� ������ �����͸� ������������ ������ �´��� Ȯ���ϰ��� �Ҷ� �ַ� ����Ѵ�.

- ���������� �ݵ�� ( ) �� ������� �Ѵ�.
************************************************************************** */
--������ ��������

-- ����_ID(emp.emp_id)�� 120���� ������ ���� ����(emp.job_id)���� 
-- ������ id(emp_id),�̸�(emp.emp_name), ����(emp.job_id), �޿�(emp.salary) ��ȸ
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


-- ����_id(emp.emp_id)�� 115���� ������ ���� ����(emp.job_id)�� �ϰ� ���� �μ�(emp.dept_id)�� ���� �������� ��ȸ�Ͻÿ�.

-- pair ��� ��������
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


-- ������ �� �޿�(emp.salary)�� ��ü ������ ��� �޿����� ���� 
-- �������� id(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary)�� ��ȸ. �޿�(emp.salary) �������� ����.
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



-- ��ü ������ ��� �޿�(emp.salary) �̻��� �޴� �μ���  �̸�(dept.dept_name), �Ҽ��������� ��� �޿�(emp.salary) ���. 
-- ��ձ޿��� �Ҽ��� 2�ڸ����� ������ ��ȭǥ��($)�� ���� ������ ���

SELECT
    d.dept_name,
    to_char(round(AVG(e.salary), 2), 'fm$999,999.99') ��ձ޿�
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



-- TODO: ������ ID(emp.emp_id)�� 145�� �������� ���� ������ �޴� �������� �̸�(emp.emp_name)�� �޿�(emp.salary) ��ȸ.
-- �޿��� ū ������� ��ȸ
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


-- TODO: ������ ID(emp.emp_id)�� 150�� ������ ���� ����(emp.job_id)�� �ϰ� ���� ���(emp.mgr_id)�� ���� �������� 
-- id(emp.emp_id), �̸�(emp.emp_name), ����(emp.job_id), ���(emp.mgr_id) �� ��ȸ

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


-- TODO : EMP ���̺��� ���� �̸���(emp.emp_name)��  'John'�� ������ �߿��� �޿�(emp.salary)�� ���� ���� ������ salary(emp.salary)���� ���� �޴� 
-- �������� id(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary)�� ���� ID(emp.emp_id) ������������ ��ȸ.

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
-- TODO: �޿�(emp.salary)�� ���� ���� ������ ���� �μ��� �̸�(dept.dept_name), ��ġ(dept.loc)�� ��ȸ.

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


-- TODO: �޿�(emp.salary)�� ���� ���� �޴� �������� �̸�(emp.emp_name), �μ���(dept.dept_name), �޿�(emp.salary) ��ȸ. 
--       �޿��� �տ� $�� ���̰� ���������� , �� ���

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



-- TODO: ��� ����ID(emp.job_id) �� 'ST_CLERK'�� �������� ��� �޿����� ���� �޿��� �޴� �������� ��� ������ ��ȸ. �� ���� ID�� 'ST_CLERK'�� �ƴ� �����鸸 ��ȸ. 

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
    AND ( job_id != 'ST_CLERK' -- JOB_ID �� NULL �� �� ������. 
          OR job_id IS NULL ); -- OR �����ڷ� NULL�� �� ����.


-- TODO: 30�� �μ�(emp.dept_id) �� ��� �޿�(emp.salary)���� �޿��� ���� �������� ��� ������ ��ȸ.

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


-- TODO: EMP ���̺��� ����(emp.job_id)�� 'IT_PROG' �� �������� ��� �޿� �̻��� �޴� 
-- �������� id(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary)�� �޿� ������������ ��ȸ.

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


-- TODO: 'IT' �μ�(dept.dept_name)�� �ִ� �޿����� ���� �޴� ������ ID(emp.emp_id), �̸�(emp.emp_name), �Ի���(emp.hire_date), �μ� ID(emp.dept_id), �޿�(emp.salary) ��ȸ
-- �Ի����� "yyyy�� mm�� dd��" �������� ���
-- �޿��� �տ� $�� ���̰� ���������� , �� ���

SELECT
    emp_id,
    emp_name,
    to_char(hire_date, 'yyyy"��" mm"��" dd"��"') hire_date,
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
 ������ ��������
 - ���������� ��ȸ ����� �������� ���
 - where�� ������ ������
	- in
	- �񱳿����� any : ��ȸ�� ���� �� �ϳ��� ���̸� �� (where �÷� > any(��������) )
	- �񱳿����� all : ��ȸ�� ���� ��ο� ���̸� �� (where �÷� > all(��������) )
------------------------------------------------*/
--'Alexander' �� �̸�(emp.emp_name)�� ���� ������(emp.mgr_id)�� 
-- ���� �������� ID(emp_id), �̸�(emp_name), ����(job_id), �Ի�⵵(hire_date-�⵵�����), �޿�(salary)�� ��ȸ
-- �޿��� �տ� $�� ���̰� ���������� , �� ���

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

-- ���� ID(emp.emp_id)�� 101, 102, 103 �� ������ ���� �޿�(emp.salary)�� ���� �޴� ������ ��� ������ ��ȸ.

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

-- ���� ID(emp.emp_id)�� 101, 102, 103 �� ������ �� �޿��� ���� ���� �������� �޿��� ���� �޴� ������ ��� ������ ��ȸ.
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

-- TODO : �μ� ��ġ(dept.loc) �� 'New York'�� �μ��� �Ҽӵ� ������ ID(emp.emp_id), �̸�(emp.emp_name), �μ�_id(emp.dept_id) �� sub query�� �̿��� ��ȸ.

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

-- TODO : �ִ� �޿�(job.max_salary)�� 6000������ ������ ����ϴ� ����(emp)�� ��� ������ sub query�� �̿��� ��ȸ.

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

-- TODO: �μ�_ID(emp.dept_id)�� 20�� �μ��� ������ ���� �޿�(emp.salary)�� ���� �޴� �������� ������  sub query�� �̿��� ��ȸ.
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


-- TODO: �μ��� �޿��� ����� ���� ���� �μ��� ��� �޿����� ���� ���� �޴� �������� �̸�, �޿�, ������ sub query�� �̿��� ��ȸ
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

-- TODO: ���� id(job_id)�� 'SA_REP' �� �������� ���� ���� �޿��� �޴� �������� ���� �޿��� �޴� �������� �̸�(emp_name), �޿�(salary), ����(job_id) �� sub query�� �̿��� ��ȸ.

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


-- �������� ���� ���� : subquery ���� -> subquery �������� ������ main ������ ����.
/* ****************************************************************
���(����) ����
������������ ��ȸ���� ���������� ���ǿ��� ����ϴ� ����.
���������� �����ϰ� �� ����� �������� ���������� �������� ���Ѵ�.
* ****************************************************************/
-- �� �μ�����(DEPT) �޿�(emp.salary)�� ���� ���� �޴� �������� id(emp.emp_id), �̸�(emp.emp_name), ����(emp.salary), �ҼӺμ�ID(dept.dept_id) ��ȸ
select  e.emp_id,
        e.emp_name,
        e.salary,
        nvl(to_char(e.dept_id),'�̹���') �μ�
from    emp e
where   salary = (select max(salary) from emp where nvl(dept_id,0) = nvl(e.dept_id,0))
order by 4;


/* ******************************************************************************************************************
EXISTS, NOT EXISTS ������ (���(����)������ ���� ���ȴ�)
-- ���������� ����� �����ϴ� ���� �����ϴ��� ���θ� Ȯ���ϴ� ����. ������ �����ϴ� ���� �������� ���ุ ������ ���̻� �˻����� �ʴ´�.

������ ���̺�(��, ��� - �θ�) -Transaction(����) ���̺�(�ֹ�, �뿩 - �ڽ�)
-- �������̺��� ������ ���̺��� ���� �����ǰ� �ִ���(ExISTS) ������(NOT EXISTS)
-- �� �߿� (�ѹ��̻�) �ֹ��� ��
**********************************************************************************************************************/


-- ������ �Ѹ��̻� �ִ� �μ��� �μ�ID(dept.dept_id)�� �̸�(dept.dept_name), ��ġ(dept.loc)�� ��ȸ

select  d.dept_id,
        d.dept_name,
        d.loc
from dept d
where EXISTS (select * from emp e where e.dept_id = d.dept_id); -- column �� �߿� x , where ���� ���� ������ Ȯ��

select * from dept
where dept_id in (select distinct dept_id from emp)
order by 1; -- ��ü������ �� ��, �������� ���� Table ��� �� ��ĵ �� ��� ���,
            -- but EXISTS �� break ������ ����, �� �ϳ��� ���� �ϸ� �ٷ� ���

-- ������ �Ѹ� ���� �μ��� �μ�ID(dept.dept_id)�� �̸�(dept.dept_name), ��ġ(dept.loc)�� ��ȸ

select  d.dept_id,
        d.dept_name,
        d.loc
from    dept d
where   NOT EXISTS (select * from emp e where e.dept_id = d.dept_id);

-- �μ�(dept)���� ����(emp.salary)�� 13000�̻��� �Ѹ��̶� �ִ� �μ��� �μ�ID(dept.dept_id)�� �̸�(dept.dept_name), ��ġ(dept.loc)�� ��ȸ

select  *
from    dept d
where exists (select * from emp e where e.dept_id = d.dept_id and salary >= 13000); 



/* ******************************
�ֹ� ���� ���̺�� �̿�.
******************************* */

--TODO: ��(customers) �� �ֹ�(orders)�� �ѹ� �̻� �� ������ ��ȸ.
select *
from customers c
where exists (select * from orders o where o.cust_id = c.cust_id);
--TODO: ��(customers) �� �ֹ�(orders)�� �ѹ��� ���� ���� ������ ��ȸ.
select *
from customers c
where not exists (select * from orders o where o.cust_id = c.cust_id);

--TODO: ��ǰ(products) �� �ѹ��̻� �ֹ��� ��ǰ ���� ��ȸ
select *
from products p
where exists (select * from order_items oi where oi.product_id = p.product_id);


--TODO: ��ǰ(products)�� �ֹ��� �ѹ��� �ȵ� ��ǰ ���� ��ȸ