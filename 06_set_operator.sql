/* **********************************************************************************************
���� ������ (���� ����)
- �� �̻��� select ����� ������ �ϴ� ����.
- ����
 select��  ���տ����� select�� [���տ����� select�� ...] [order by �����÷� ���Ĺ��]

-������
  - UNION: �� select ����� �ϳ��� �����Ѵ�. �� �ߺ��Ǵ� ���� �����Ѵ�. (������)
  - UNION ALL : �� select ����� �ϳ��� �����Ѵ�. �ߺ��Ǵ� ���� �����Ѵ�. (������)
  - INTERSECT: �� select ����� ������ ����ุ �����Ѵ�. (������)
  - MINUS: ���� ��ȸ������� ������ ��ȸ����� ���� �ุ �����Ѵ�. (������)
   
 - ��Ģ
  - ������ select ���� �÷� ���� ���ƾ� �Ѵ�. 
  - ������ select ���� �÷��� Ÿ���� ���ƾ� �Ѵ�.
  - ���� ����� �÷��̸��� ù��° ���� select���� ���� ������.
  - order by ���� ������ �������� ���� �� �ִ�.
  - UNION ALL�� ������ ������ ������ �ߺ��Ǵ� ���� �����Ѵ�.
*************************************************************************************************/
SELECT
    emp_id,
    emp_name
FROM
    emp
WHERE
    dept_id IN ( 10, 20, 30, 40 )
UNION
SELECT
    dept_id,
    to_char(salary)
FROM
    emp
WHERE
    salary > 15000
ORDER BY
    1;

SELECT
    *
FROM
    emp
WHERE
    dept_id IN ( 10, 20 )
UNION ALL
SELECT
    *
FROM
    emp
WHERE
    dept_id IN ( 20, 30 );

SELECT
    *
FROM
    emp
WHERE
    dept_id IN ( 10, 20 )
UNION
SELECT
    *
FROM
    emp
WHERE
    dept_id IN ( 20, 30 ); -- �ߺ� ����

-- �ߺ��� ���� ��ȸ -> Union all // union �� �ߺ��Ȱ��� �ִ��� �ѹ� �� Ȯ���ϴ� ������ ����.
SELECT
    *
FROM
    emp
WHERE
    dept_id IN ( 10, 20 )
UNION
SELECT
    *
FROM
    emp
WHERE
    dept_id IN ( 30, 40 ); -- �ߺ�

SELECT
    *
FROM
    emp
WHERE
    dept_id IN ( 10, 20 )
MINUS -- ������
SELECT
    *
FROM
    emp
WHERE
    dept_id IN ( 20, 40 )
UNION ALL
SELECT
    *
FROM
    emp
WHERE
    salary > 10000;
-- emp ���̺��� salary �ִ밪�� salary �ּҰ�, salary ��հ� ��ȸ
SELECT
    MAX(salary)                   �ִ밪,
    MIN(salary)                   �ּҰ�,
    round(AVG(salary), 2)         "salary ��հ�"
FROM
    emp;

SELECT
    'Max',
    MAX(salary) �޿�����
FROM
    emp
UNION ALL
SELECT
    'Min',
    MIN(salary)
FROM
    emp
UNION ALL
SELECT
    'AVG',
    round(AVG(salary), 2)
FROM
    emp;

-- emp ���̺��� ������(emp.job_id) �޿� �հ�� ��ü ������ �޿��հ踦 ��ȸ.
SELECT
    decode(GROUPING_ID(job_id), 1, '�Ѱ�', 0, job_id) job_id,
    SUM(salary)
FROM
    emp
GROUP BY
    ROLLUP(job_id);

SELECT
    job_id,
    SUM(salary) �޿���
FROM
    emp
GROUP BY
    job_id
UNION ALL
SELECT
    '�Ѱ�',
    SUM(salary)
FROM
    emp;


--�ѱ� ������ ���� ǰ�� ��ŷ
DROP TABLE export_rank;

CREATE TABLE export_rank (
    year     CHAR(4) NOT NULL,
    ranking  NUMBER(2) NOT NULL,
    item     VARCHAR2(60) NOT NULL
);

INSERT INTO export_rank VALUES (
    1990,
    1,
    '�Ƿ�'
);

INSERT INTO export_rank VALUES (
    1990,
    2,
    '�ݵ�ü'
);

INSERT INTO export_rank VALUES (
    1990,
    3,
    '����'
);

INSERT INTO export_rank VALUES (
    1990,
    4,
    '������'
);

INSERT INTO export_rank VALUES (
    1990,
    5,
    '�����ؾ籸�����׺�ǰ'
);

INSERT INTO export_rank VALUES (
    1990,
    6,
    '��ǻ��'
);

INSERT INTO export_rank VALUES (
    1990,
    7,
    '������'
);

INSERT INTO export_rank VALUES (
    1990,
    8,
    'ö����'
);

INSERT INTO export_rank VALUES (
    1990,
    9,
    '�����弶������'
);

INSERT INTO export_rank VALUES (
    1990,
    10,
    '�ڵ���'
);

INSERT INTO export_rank VALUES (
    2000,
    1,
    '�ݵ�ü'
);

INSERT INTO export_rank VALUES (
    2000,
    2,
    '��ǻ��'
);

INSERT INTO export_rank VALUES (
    2000,
    3,
    '�ڵ���'
);

INSERT INTO export_rank VALUES (
    2000,
    4,
    '������ǰ'
);

INSERT INTO export_rank VALUES (
    2000,
    5,
    '�����ؾ籸�����׺�ǰ'
);

INSERT INTO export_rank VALUES (
    2000,
    6,
    '������ű��'
);

INSERT INTO export_rank VALUES (
    2000,
    7,
    '�ռ�����'
);

INSERT INTO export_rank VALUES (
    2000,
    8,
    'ö����'
);

INSERT INTO export_rank VALUES (
    2000,
    9,
    '�Ƿ�'
);

INSERT INTO export_rank VALUES (
    2000,
    10,
    '������'
);

INSERT INTO export_rank VALUES (
    2018,
    1,
    '�ݵ�ü'
);

INSERT INTO export_rank VALUES (
    2018,
    2,
    '������ǰ'
);

INSERT INTO export_rank VALUES (
    2018,
    3,
    '�ڵ���'
);

INSERT INTO export_rank VALUES (
    2018,
    4,
    '���ǵ��÷��̹׼���'
);

INSERT INTO export_rank VALUES (
    2018,
    5,
    '�ռ�����'
);

INSERT INTO export_rank VALUES (
    2018,
    6,
    '�ڵ�����ǰ'
);

INSERT INTO export_rank VALUES (
    2018,
    7,
    'ö����'
);

INSERT INTO export_rank VALUES (
    2018,
    8,
    '�����ؾ籸�����׺�ǰ'
);

INSERT INTO export_rank VALUES (
    2018,
    9,
    '������ű��'
);

INSERT INTO export_rank VALUES (
    2018,
    10,
    '��ǻ��'
);

--�⵵�� ���� ǰ�� ��ŷ
DROP TABLE import_rank;

CREATE TABLE import_rank (
    year     CHAR(4) NOT NULL,
    ranking  NUMBER(2) NOT NULL,
    item     VARCHAR2(60) NOT NULL
);

INSERT INTO import_rank VALUES (
    1990,
    1,
    '����'
);

INSERT INTO import_rank VALUES (
    1990,
    2,
    '�ݵ�ü'
);

INSERT INTO import_rank VALUES (
    1990,
    3,
    '������ǰ'
);

INSERT INTO import_rank VALUES (
    1990,
    4,
    '������ȭ�б��'
);

INSERT INTO import_rank VALUES (
    1990,
    5,
    '����'
);

INSERT INTO import_rank VALUES (
    1990,
    6,
    '��ǻ��'
);

INSERT INTO import_rank VALUES (
    1990,
    7,
    'ö����'
);

INSERT INTO import_rank VALUES (
    1990,
    8,
    '�װ���׺�ǰ'
);

INSERT INTO import_rank VALUES (
    1990,
    9,
    '�����'
);

INSERT INTO import_rank VALUES (
    1990,
    10,
    '��������м���'
);

INSERT INTO import_rank VALUES (
    2000,
    1,
    '����'
);

INSERT INTO import_rank VALUES (
    2000,
    2,
    '�ݵ�ü'
);

INSERT INTO import_rank VALUES (
    2000,
    3,
    '��ǻ��'
);

INSERT INTO import_rank VALUES (
    2000,
    4,
    '������ǰ'
);

INSERT INTO import_rank VALUES (
    2000,
    5,
    'õ������'
);

INSERT INTO import_rank VALUES (
    2000,
    6,
    '�ݵ�ü���������'
);

INSERT INTO import_rank VALUES (
    2000,
    7,
    '�����׹��'
);

INSERT INTO import_rank VALUES (
    2000,
    8,
    '������ű��'
);

INSERT INTO import_rank VALUES (
    2000,
    9,
    'ö����'
);

INSERT INTO import_rank VALUES (
    2000,
    10,
    '����ȭ�п���'
);

INSERT INTO import_rank VALUES (
    2018,
    1,
    '����'
);

INSERT INTO import_rank VALUES (
    2018,
    2,
    '�ݵ�ü'
);

INSERT INTO import_rank VALUES (
    2018,
    3,
    'õ������'
);

INSERT INTO import_rank VALUES (
    2018,
    4,
    '������ǰ'
);

INSERT INTO import_rank VALUES (
    2018,
    5,
    '�ݵ�ü���������'
);

INSERT INTO import_rank VALUES (
    2018,
    6,
    '��ź'
);

INSERT INTO import_rank VALUES (
    2018,
    7,
    '��ǻ��'
);

INSERT INTO import_rank VALUES (
    2018,
    8,
    '����ȭ�п���'
);

INSERT INTO import_rank VALUES (
    2018,
    9,
    '�ڵ���'
);

INSERT INTO import_rank VALUES (
    2018,
    10,
    '������ű��'
);

COMMIT;

SELECT
    *
FROM
    export_rank;

SELECT
    *
FROM
    import_rank;

--TODO:  2018��(year) ����(export_rank)�� ����(import_rank)�� ���ÿ� ������ ǰ��(item)�� ��ȸ
-- ���ʿ� �ִ� ��. insersect
SELECT
    item
FROM
    export_rank
WHERE
    year = 2018
INTERSECT
SELECT
    item
FROM
    import_rank
WHERE
    year = 2018;


--TODO:  2018��(export_rank.year) �ֿ� ���� ǰ��(export_rank.item)�� 2000�⿡�� ���� ǰ�� ��ȸ
-- 2018-2000
SELECT
    item
FROM
    export_rank
WHERE
    year = 2018
MINUS
SELECT
    item
FROM
    export_rank
WHERE
    year = 2000;

--TODO: 1990 ����(export_rank)�� ����(import_rank) ��ŷ�� ���Ե�  ǰ��(item)���� ���ļ� ��ȸ. �ߺ��� ǰ�� �������� ��ȸ
--union all
SELECT
    item
FROM
    export_rank
WHERE
    year = 1990
UNION ALL
SELECT
    item
FROM
    import_rank
WHERE
    year = 1990;
--TODO: 1990 ����(export_rank)�� ����(import_rank) ��ŷ�� ���Ե�  ǰ��(item)���� ���ļ� ��ȸ. �ߺ��� ǰ���� �ȳ������� ��ȸ
--union
SELECT
    item
FROM
    export_rank
WHERE
    year = 1990
UNION
SELECT
    item
FROM
    import_rank
WHERE
    year = 1990;

--TODO: 1990��� 2018���� ���� �ֿ� ���� ǰ��(export_rank.item) ��ȸ
-- intersect
SELECT
    item
FROM
    export_rank
WHERE
    year = 1990
INTERSECT
SELECT
    item
FROM
    export_rank
WHERE
    year = 2018;


--TODO: 1990�� �ֿ� ���� ǰ��(export_rank.item)�� 2018��� 2000�⿡�� ���� ǰ�� ��ȸ
--1990 - 2018 - 2000
SELECT
    item
FROM
    export_rank
WHERE
    year = 1990
MINUS
SELECT
    item
FROM
    export_rank
WHERE
    year = 2018
MINUS
SELECT
    item
FROM
    export_rank
WHERE
    year = 2000;
--TODO: 2000�� ����ǰ����(import_rank.item) 2018�⿡�� ���� ǰ���� ��ȸ.
-- 2000 - 2018
SELECT
    item
FROM
    import_rank
WHERE
    year = 2000
MINUS
SELECT
    item
FROM
    import_rank
WHERE
    year = 2018;