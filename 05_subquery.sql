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
where (job_id ,
      dept_id) =
(SELECT
    job_id,
    dept_id
FROM
    emp
WHERE
    emp_id = 115
);


-- ������ �� �޿�(emp.salary)�� ��ü ������ ��� �޿����� ���� 
-- �������� id(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary)�� ��ȸ. �޿�(emp.salary) �������� ����.
select emp_id,
        emp_name,
        salary
from    emp
where   salary < (select avg(salary) from emp)
order by 3 desc;



-- ��ü ������ ��� �޿�(emp.salary) �̻��� �޴� �μ���  �̸�(dept.dept_name), �Ҽ��������� ��� �޿�(emp.salary) ���. 
-- ��ձ޿��� �Ҽ��� 2�ڸ����� ������ ��ȭǥ��($)�� ���� ������ ���

select d.dept_name, to_char(round(avg(e.salary),2),'fm$999,999.99') ��ձ޿�
from emp e join dept d on e.dept_id = d.dept_id
group by d.dept_name
having avg(e.salary) > (select avg(e.salary) from emp e);



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

select emp_id,emp_name,job_id,mgr_id
from emp
where (job_id,mgr_id) = (select job_id,mgr_id from emp where emp_id = 150)
and emp_id <> 150;


-- TODO : EMP ���̺��� ���� �̸���(emp.emp_name)��  'John'�� ������ �߿��� �޿�(emp.salary)�� ���� ���� ������ salary(emp.salary)���� ���� �޴� 
-- �������� id(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary)�� ���� ID(emp.emp_id) ������������ ��ȸ.

select emp_id,emp_name,salary
from emp
where salary > (select max(salary) from emp where emp_name = 'John')
order by 1;
-- TODO: �޿�(emp.salary)�� ���� ���� ������ ���� �μ��� �̸�(dept.dept_name), ��ġ(dept.loc)�� ��ȸ.




-- TODO: �޿�(emp.salary)�� ���� ���� �޴� �������� �̸�(emp.emp_name), �μ���(dept.dept_name), �޿�(emp.salary) ��ȸ. 
--       �޿��� �տ� $�� ���̰� ���������� , �� ���




-- TODO: ��� ����ID(emp.job_id) �� 'ST_CLERK'�� �������� ��� �޿����� ���� �޿��� �޴� �������� ��� ������ ��ȸ. �� ���� ID�� 'ST_CLERK'�� �ƴ� �����鸸 ��ȸ. 



-- TODO: 30�� �μ�(emp.dept_id) �� ��� �޿�(emp.salary)���� �޿��� ���� �������� ��� ������ ��ȸ.



-- TODO: EMP ���̺��� ����(emp.job_id)�� 'IT_PROG' �� �������� ��� �޿� �̻��� �޴� 
-- �������� id(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary)�� �޿� ������������ ��ȸ.





-- TODO: 'IT' �μ�(dept.dept_name)�� �ִ� �޿����� ���� �޴� ������ ID(emp.emp_id), �̸�(emp.emp_name), �Ի���(emp.hire_date), �μ� ID(emp.dept_id), �޿�(emp.salary) ��ȸ
-- �Ի����� "yyyy�� mm�� dd��" �������� ���
-- �޿��� �տ� $�� ���̰� ���������� , �� ���




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

select emp_id,emp_name,job_id,extract(year from hire_date),to_char(salary,'fm$999,999,999')
from emp
where mgr_id in (select emp_id from emp where emp_name = 'Alexander');

-- ���� ID(emp.emp_id)�� 101, 102, 103 �� ������ ���� �޿�(emp.salary)�� ���� �޴� ������ ��� ������ ��ȸ.

select * from emp
where salary > (select max(salary) from emp where emp_id in(101,102,103));

-- ���� ID(emp.emp_id)�� 101, 102, 103 �� ������ �� �޿��� ���� ���� �������� �޿��� ���� �޴� ������ ��� ������ ��ȸ.
select * from emp
where salary > (select min(salary) from emp where emp_id in(101,102,103));

-- TODO : �μ� ��ġ(dept.loc) �� 'New York'�� �μ��� �Ҽӵ� ������ ID(emp.emp_id), �̸�(emp.emp_name), �μ�_id(emp.dept_id) �� sub query�� �̿��� ��ȸ.

select e.emp_id, e.emp_name, d.dept_id, d.loc
from emp e join dept d on e.dept_id = d.dept_id
where d.loc = 'New York';


-- TODO : �ִ� �޿�(job.max_salary)�� 6000������ ������ ����ϴ� ����(emp)�� ��� ������ sub query�� �̿��� ��ȸ.
select * from emp e join job j on e.job_id = j.job_id
where j.max_salary < 6000;


-- TODO: �μ�_ID(emp.dept_id)�� 20�� �μ��� ������ ���� �޿�(emp.salary)�� ���� �޴� �������� ������  sub query�� �̿��� ��ȸ.
select * from emp
where salary > all(select salary from emp where dept_id = 20);


-- TODO: �μ��� �޿��� ����� ���� ���� �μ��� ��� �޿����� ���� ���� �޴� �������� �̸�, �޿�, ������ sub query�� �̿��� ��ȸ




-- TODO: ���� id(job_id)�� 'SA_REP' �� �������� ���� ���� �޿��� �޴� �������� ���� �޿��� �޴� �������� �̸�(emp_name), �޿�(salary), ����(job_id) �� sub query�� �̿��� ��ȸ.




/* ****************************************************************
���(����) ����
������������ ��ȸ���� ���������� ���ǿ��� ����ϴ� ����.
���������� �����ϰ� �� ����� �������� ���������� �������� ���Ѵ�.
* ****************************************************************/
-- �� �μ�����(DEPT) �޿�(emp.salary)�� ���� ���� �޴� �������� id(emp.emp_id), �̸�(emp.emp_name), ����(emp.salary), �ҼӺμ�ID(dept.dept_id) ��ȸ




/* ******************************************************************************************************************
EXISTS, NOT EXISTS ������ (���(����)������ ���� ���ȴ�)
-- ���������� ����� �����ϴ� ���� �����ϴ��� ���θ� Ȯ���ϴ� ����. ������ �����ϴ� ���� �������� ���ุ ������ ���̻� �˻����� �ʴ´�.
**********************************************************************************************************************/


-- ������ �Ѹ��̻� �ִ� �μ��� �μ�ID(dept.dept_id)�� �̸�(dept.dept_name), ��ġ(dept.loc)�� ��ȸ


-- ������ �Ѹ� ���� �μ��� �μ�ID(dept.dept_id)�� �̸�(dept.dept_name), ��ġ(dept.loc)�� ��ȸ


-- �μ�(dept)���� ����(emp.salary)�� 13000�̻��� �Ѹ��̶� �ִ� �μ��� �μ�ID(dept.dept_id)�� �̸�(dept.dept_name), ��ġ(dept.loc)�� ��ȸ




/* ******************************
�ֹ� ���� ���̺�� �̿�.
******************************* */

--TODO: ��(customers) �� �ֹ�(orders)�� �ѹ� �̻� �� ������ ��ȸ.


--TODO: ��(customers) �� �ֹ�(orders)�� �ѹ��� ���� ���� ������ ��ȸ.


--TODO: ��ǰ(products) �� �ѹ��̻� �ֹ��� ��ǰ ���� ��ȸ


--TODO: ��ǰ(products)�� �ֹ��� �ѹ��� �ȵ� ��ǰ ���� ��ȸ


