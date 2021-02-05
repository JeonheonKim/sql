/* ***********************************************************************************
DDL - Database�� ��ü�� �����Ѵ�.
- ���� -create
- ���� -alter
- ���� -drop

���̺� ����
- ����
create table ���̺� �̸�(
  �÷� ����
)

�������� ���� 
- �÷� ���� ���� [NOT NULL],[default]
    - �÷� ������ ���� ����
- ���̺� ���� ����
    - �÷� �����ڿ� ���� ����

- �⺻ ���� : constraint ���������̸� ��������Ÿ��
- ���̺� ���� ���� ��ȸ
    - USER_CONSTRAINTS ��ųʸ� �信�� ��ȸ
    
���̺� ����
- ����
DROP TABLE ���̺��̸� [CASCADE CONSTRAINTS]
*********************************************************************************** */
CREATE TABLE parent_tb (
    no        NUMBER
        CONSTRAINT pk_parent_tb PRIMARY KEY,  -- �÷� ���� ����
    name      NVARCHAR2(30) NOT NULL,
    birthday  DATE DEFAULT sysdate, -- �⺻�� ����:insert�� ���� ���� ������ �⺻�� ����
    email     VARCHAR2(100)
        CONSTRAINT uk_parent_tb_email UNIQUE, -- unique��������: �ߺ��� �� �����ȵ� (null ����)
    gender    CHAR(1) NOT NULL
        CONSTRAINT ck_parent_tb_gender CHECK ( gender IN ( 'M', 'F' ) ) -- check �������� : ���� ���� ��������[����� ����]
);

DESC parent_tb;

INSERT INTO parent_tb VALUES (
    1,
    'ȫ�浿',
    '2000/01/01',
    'a@a.com',
    'M'
);

INSERT INTO parent_tb (
    no,
    name,
    gender
) VALUES (
    2,
    '�̼���',
    'M'
); -- ������ default ��, �̸��� null �� ���
INSERT INTO parent_tb VALUES (
    3,
    'ȫ�浿',
    NULL,
    'b@a.com',
    'M'
); -- ��������� null�� ������ default ���� �ƴ϶� null�� insert �� �ȴ�.
INSERT INTO parent_tb VALUES (
    4,
    'ȫ�浿',
    NULL,
    'b@a.com',
    'M'
); -- �����߻��� ���������� �̸��� ���ؼ� � �κп� ������ �߻��ߴ��� Ȯ�� �� �� �ִ�. 
INSERT INTO parent_tb VALUES (
    5,
    '�迵��',
    NULL,
    'c@a.com',
    'm'
);

SELECT
    *
FROM
    parent_tb;

CREATE TABLE child_tb (
    no         NUMBER, --pk
    jumin_num  CHAR(14) NOT NULL, --uk
    age        NUMBER(3) DEFAULT 0, -- ck 10 ~ 90
    parent_no  NUMBER, -- parent_tb �����ϴ� fk
    CONSTRAINT pk_child_tb PRIMARY KEY ( no ), -- (�÷���)
    CONSTRAINT uk_child_tb_jumin_num UNIQUE ( jumin_num ),
    CONSTRAINT ck_child_tb_age CHECK ( age BETWEEN 10 AND 90 ),
    CONSTRAINT fk_child_tb_parent_tb FOREIGN KEY ( parent_no )
        REFERENCES parent_tb ( no )
);


/* ************************************************************************************
ALTER : ���̺� ����

�÷� ���� ����

- �÷� �߰�
  ALTER TABLE ���̺��̸� ADD (�߰��� �÷����� [, �߰��� �÷�����])
  - �ϳ��� �÷��� �߰��� ��� ( ) �� ��������

- �÷� ����
  ALTER TABLE ���̺��̸� MODIFY (�������÷���  ���漳�� [, �������÷���  ���漳��])
	- �ϳ��� �÷��� ������ ��� ( )�� ���� ����
	- ����/���ڿ� �÷��� ũ�⸦ �ø� �� �ִ�.
		- ũ�⸦ ���� �� �ִ� ��� : ���� ���� ���ų� ��� ���� ���̷��� ũ�⺸�� ���� ���
	- �����Ͱ� ��� NULL�̸� ������Ÿ���� ������ �� �ִ�. (�� CHAR<->VARCHAR2 �� ����.)

- �÷� ����	
  ALTER TABLE ���̺��̸� DROP COLUMN �÷��̸� [CASCADE CONSTRAINTS]
    - CASCADE CONSTRAINTS : �����ϴ� �÷��� Primary Key�� ��� �� �÷��� �����ϴ� �ٸ� ���̺��� Foreign key ������ ��� �����Ѵ�.
	- �ѹ��� �ϳ��� �÷��� ���� ����.
	
  ALTER TABLE ���̺��̸� SET UNUSED (�÷��� [, ..])
  ALTER TABLE ���̺��̸� DROP UNUSED COLUMNS
	- SET UNUSED ������ �÷��� �ٷ� �������� �ʰ� ���� ǥ�ø� �Ѵ�. 
	- ������ �÷��� ����� �� ������ ���� ��ũ���� ����� �ִ�. �׷��� �ӵ��� ������.
	- DROP UNUSED COLUMNS �� SET UNUSED�� �÷��� ��ũ���� �����Ѵ�. 

- �÷� �̸� �ٲٱ�
  ALTER TABLE ���̺��̸� RENAME COLUMN �����̸� TO �ٲ��̸�;

**************************************************************************************  
���� ���� ���� ����
-�������� �߰�
  ALTER TABLE ���̺�� ADD CONSTRAINT �������� ����

- �������� ����
  ALTER TABLE ���̺�� DROP CONSTRAINT ���������̸�
  PRIMARY KEY ����: ALTER TABLE ���̺�� DROP PRIMARY KEY [CASCADE]
	- CASECADE : �����ϴ� Primary Key�� Foreign key ���� �ٸ� ���̺��� Foreign key ������ ��� �����Ѵ�.

- NOT NULL <-> NULL ��ȯ�� �÷� ������ ���� �Ѵ�.
   - ALTER TABLE ���̺�� MODIFY (�÷��� NOT NULL),  - ALTER TABLE ���̺�� MODIFY (�÷��� NULL)  
************************************************************************************ */
-- customers ī���ؼ� cust
-- select ��� set�� ���̺�� ���� (Not null�� ������ �������� ī�� �ȵ�.)
CREATE TABLE cust
    AS
        SELECT
            *
        FROM
            customers;

CREATE TABLE cust2
    AS
        SELECT
            cust_id,
            cust_name,
            address
        FROM
            customers;

CREATE TABLE cust3
    AS
        SELECT
            *
        FROM
            customers
        WHERE
            1 = 0; -- False , �÷��鸸 ī��. ���� ������ ī������ �ʴ´�.

SELECT
    *
FROM
    cust3;

DESC cust3;
-- �߰�
ALTER TABLE cust3 ADD (
    age    NUMBER DEFAULT 0 NOT NULL,
    point  NUMBER
);
-- ����
ALTER TABLE cust3 MODIFY (
    age NUMBER(3)
); -- NOT NULL �� ���� �ٸ� ���� ���� x
ALTER TABLE cust3 MODIFY (
    cust_email null
); -- NOT NULL �÷��� NULL �÷����� ����
ALTER TABLE cust3 MODIFY (
    cust_email NOT NULL
);
-- �÷��� ����
ALTER TABLE cust3 RENAME COLUMN cust_email TO email; -- cust_email --> email ����
-- �÷� ����
ALTER TABLE cust3 DROP COLUMN age;

SELECT
    *
FROM
    cust;

DESC cust;

ALTER TABLE cust MODIFY (
    cust_id NUMBER(2)
); -- -99 ~ 99 --> �̹� id 100 �����ϱ� ������ ���� �߻�
ALTER TABLE cust3 MODIFY (
    cust_id NUMBER(3)
); -- �� ���� ���� �ʱ� ������ ����
ALTER TABLE cust MODIFY (
    cust_id NUMBER(5)
); -- ���� �����Ϳ� ������ ��ġ�� ���� ���(�ø���)���� ���� ���� ����
ROLLBACK; -- ����� Ÿ���� ���ư��� ����. rollback/commit[DML��ɾ�]�� ����� �ƴϴ�.

alter cust ADD (
    age NUMBER(3) NOT NULL
); -- �̹� �����ϴ� ���̺� �� ���� ���� ������ null�� ä������. ������ not null���� ������ ���� �߻�

--�������� ����
-- �� ���̺��� �������ǵ� ��ȸ
SELECT
    *
FROM
    user_constraints;

SELECT
    *
FROM
    user_constraints
WHERE
    table_name = 'CUST';

-- �������� �߰�
ALTER TABLE cust ADD CONSTRAINT pk_cust PRIMARY KEY ( cust_id );

ALTER TABLE cust ADD CONSTRAINT uk_cust_email UNIQUE ( cust_email );

ALTER TABLE cust
    ADD CONSTRAINT ck_cust_gender CHECK ( gender IN ( 'M', 'F' ) );

-- �������� ����
ALTER TABLE cust DROP CONSTRAINT ck_cust_gender;

ALTER TABLE cust DROP PRIMARY KEY; -- pk �� �����ϱ� ������


--TODO: emp ���̺��� ī���ؼ� emp2�� ����(Ʋ�� ī��)
CREATE TABLE emp2
    AS
        SELECT
            *
        FROM
            emp
        WHERE
            1 = 0;

SELECT
    *
FROM
    emp2;

--TODO: gender �÷��� �߰�: type char(1)
ALTER TABLE emp2 ADD (
    gender CHAR(1)
);

DESC emp2;

--TODO: email �÷� �߰�. type: varchar2(100),  not null  �÷�
ALTER TABLE emp2 ADD (
    email VARCHAR2(100) NOT NULL
);

DESC emp2;

--TODO: jumin_num(�ֹι�ȣ) �÷��� �߰�. type: char(14), null ���. ������ ���� ������ �÷�.
ALTER TABLE emp2 ADD (
    jumin_num CHAR(14) NULL
);

ALTER TABLE emp2 ADD CONSTRAINT uk_emp2_jumin_num UNIQUE ( jumin_num );

DESC emp2;

SELECT
    *
FROM
    user_constraints
WHERE
    table_name = 'EMP2';

--TODO: emp_id �� primary key �� ����
ALTER TABLE emp2 ADD CONSTRAINT pk_emp2 PRIMARY KEY ( emp_id );

SELECT
    *
FROM
    user_constraints
WHERE
    table_name = 'EMP2';
  
--TODO: gender �÷��� M, F �����ϵ���  �������� �߰�
ALTER TABLE emp2
    ADD CONSTRAINT pk_emp2_gender CHECK ( gender IN ( 'M', 'F' ) );

SELECT
    *
FROM
    user_constraints
WHERE
    table_name = 'EMP2';
 
--TODO: salary �÷��� 0�̻��� ���鸸 ������ �������� �߰�
ALTER TABLE emp2 ADD CONSTRAINT pk_emp2_salary CHECK ( salary >= 0 );

SELECT
    *
FROM
    user_constraints
WHERE
    table_name = 'EMP2';

--TODO: email �÷��� null�� ���� �� �ֵ� �ٸ� ��� ���� ���� ������ ���ϵ��� ���� ���� ����
ALTER TABLE emp2 ADD CONSTRAINT uk_emp2_email UNIQUE ( email );

SELECT
    *
FROM
    user_constraints
WHERE
    table_name = 'EMP2';

--TODO: emp_name �� ������ Ÿ���� varchar2(100) ���� ��ȯ
ALTER TABLE emp2 MODIFY (
    emp_name VARCHAR2(100)
);

DESC emp2;

--TODO: job_id�� not null �÷����� ����
ALTER TABLE emp2 MODIFY (
    job_id NOT NULL
);

DESC emp2;

--TODO: dept_id�� not null �÷����� ����
ALTER TABLE emp2 MODIFY (
    dept_id NOT NULL
);

SELECT
    *
FROM
    emp2;

DESC emp2;

--TODO: job_id  �� null ��� �÷����� ����
ALTER TABLE emp2 MODIFY (
    job_id null
);

SELECT
    *
FROM
    emp2;

DESC emp2;

--TODO: dept_id  �� null ��� �÷����� ����
ALTER TABLE emp2 MODIFY (
    dept_id null
);

SELECT
    *
FROM
    emp2;

DESC emp2;


--TODO: ������ ������ emp2_email_uk ���� ������ ����
ALTER TABLE emp2 DROP CONSTRAINT uk_emp2_email;

SELECT
    *
FROM
    user_constraints
WHERE
    table_name = 'EMP2';

--TODO: ������ ������ emp2_salary_ck ���� ������ ����
ALTER TABLE emp2 DROP CONSTRAINT pk_emp2_salary;

SELECT
    *
FROM
    user_constraints
WHERE
    table_name = 'EMP2';

--TODO: primary key �������� ����
ALTER TABLE emp2 DROP PRIMARY KEY;

SELECT
    *
FROM
    user_constraints
WHERE
    table_name = 'EMP2';

--TODO: gender �÷�����
ALTER TABLE emp2 DROP COLUMN gender;

DESC emp2;

--TODO: email �÷� ����
ALTER TABLE emp2 DROP COLUMN email;

DESC emp2;

/* **************************************************************************************************************
������ : SEQUENCE
- �ڵ������ϴ� ���ڸ� �����ϴ� ����Ŭ ��ü
- ���̺� �÷��� �ڵ������ϴ� ������ȣ�� ������ ����Ѵ�.
	- �ϳ��� �������� ���� ���̺��� �����ϸ� �߰��� �� ������ �� �� �ִ�.

���� ����
CREATE SEQUENCE sequence�̸�
	[INCREMENT BY n]	
	[START WITH n]                		  
	[MAXVALUE n | NOMAXVALUE]   
	[MINVALUE n | NOMINVALUE]	
	[CYCLE | NOCYCLE(�⺻)]		
	[CACHE n | NOCACHE]		  

- INCREMENT BY n: ����ġ ����. ������ 1
- START WITH n: ���� �� ����. ������ 0
	- ���۰� ������
	 - ����: MINVALUE ���� ũĿ�� ���� ���̾�� �Ѵ�.
	 - ����: MAXVALUE ���� �۰ų� ���� ���̾�� �Ѵ�.
- MAXVALUE n: �������� ������ �� �ִ� �ִ밪�� ����
- NOMAXVALUE : �������� ������ �� �ִ� �ִ밪�� ���������� ��� 10^27 �� ��. ���������� ��� -1�� �ڵ����� ����. 
- MINVALUE n :�ּ� ������ ���� ����
- NOMINVALUE :�������� �����ϴ� �ּҰ��� ���������� ��� 1, ���������� ��� -(10^26)���� ����
- CYCLE �Ǵ� NOCYCLE : �ִ�/�ּҰ����� ������ ��ȯ�� �� ����. NOCYCLE�� �⺻��(��ȯ�ݺ����� �ʴ´�.)
- CACHE|NOCACHE : ĳ�� ��뿩�� ����.(����Ŭ ������ �������� ������ ���� �̸� ��ȸ�� �޸𸮿� ����) NOCACHE�� �⺻��(CACHE�� ������� �ʴ´�. )


������ �ڵ������� ��ȸ
 - sequence�̸�.nextval  : ���� ����ġ ��ȸ
 - sequence�̸�.currval  : ���� �������� ��ȸ


������ ����
ALTER SEQUENCE ������ �������̸�
	[INCREMENT BY n]	               		  
	[MAXVALUE n | NOMAXVALUE]   
	[MINVALUE n | NOMINVALUE]	
	[CYCLE | NOCYCLE(�⺻)]		
	[CACHE n | NOCACHE]	

������ �����Ǵ� ������ ������ �޴´�. (�׷��� start with ���� ��������� �ƴϴ�.)	  


������ ����
DROP SEQUENCE sequence�̸�
	
************************************************************************************************************** */

-- 1���� 1�� �ڵ������ϴ� ������
CREATE SEQUENCE dept_id_seq; 

--seq�̸�.nextval()

SELECT
    dept_id_seq.NEXTVAL
FROM
    dual;

SELECT
    dept_id_seq.CURRVAL
FROM
    dual;

INSERT INTO dept VALUES (
    dept_id_seq.NEXTVAL,
    'new' || dept_id_seq.CURRVAL,
    'seoul'
);

SELECT
    *
FROM
    dept;
-- 1���� 50���� 10�� �ڵ����� �ϴ� ������
CREATE SEQUENCE ex1_seq INCREMENT BY 10 MAXVALUE 50;

SELECT
    exl_seq.NEXTVAL
FROM
    dual;

-- 100 ���� 150���� 10�� �ڵ������ϴ� ������
CREATE SEQUENCE ex2_seq INCREMENT BY 10 START WITH 100 MAXVALUE 150;

SELECT
    ex2_seq.NEXTVAL
FROM
    dual;        



-- 100 ���� 150���� 10�� �ڵ������ϵ� �ִ밪�� �ٴٸ��� ��ȯ�ϴ� ������
-- ��ȯ(cycle) �Ҷ� ����(increment by ���) : minvalue(�⺻��:1)���� ����
-- ��ȯ(cycle) �Ҷ� ����(increment by ����) : maxvalue(�⺻��:-1)���� ����
DROP SEQUENCE ex3_seq;

CREATE SEQUENCE ex3_seq INCREMENT BY 20 START WITH 100 MINVALUE 100 MAXVALUE 150 NOCACHE CYCLE;

SELECT
    ex3_seq.NEXTVAL
FROM
    dual;     


-- -1���� -1�� �ڵ� �����ϴ� ������
CREATE SEQUENCE ex4_seq INCREMENT BY - 1; -- �ڵ����� : start with �⺻�� -1

SELECT
    ex4_seq.NEXTVAL
FROM
    dual;   


-- -1���� -50���� -10�� �ڵ� �����ϴ� ������

CREATE SEQUENCE ex5_seq INCREMENT BY - 10 MINVALUE - 50;

SELECT
    ex5_seq.NEXTVAL
FROM
    dual;   

-- 100 ���� -100���� -100�� �ڵ� �����ϴ� ������
CREATE SEQUENCE ex6_seq INCREMENT BY - 100 START WITH 100 MINVALUE - 100 MAXVALUE 100; -- maxvalue :-1(����), 1(����)| ���� : maxvalue >= startvalue, ���� : maxvalue=<startvalue

SELECT
    ex6_seq.NEXTVAL
FROM
    dual; 


-- 15������ -15���� 1�� �����ϴ� ������ �ۼ�
CREATE SEQUENCE ex7_seq INCREMENT BY - 1 START WITH 15 MINVALUE - 15 MAXVALUE 15;

SELECT
    ex7_seq.NEXTVAL
FROM
    dual; 



-- -10 ���� 1�� �����ϴ� ������ �ۼ�

CREATE SEQUENCE ex8_seq INCREMENT BY 1 START WITH - 10 MINVALUE - 10;

SELECT
    ex8_seq.NEXTVAL
FROM
    dual; 



-- TODO: �μ�ID(dept.dept_id)�� ���� �ڵ����� ��Ű�� sequence�� ����. 10 ���� 10�� �����ϴ� sequence
-- ������ ������ sequence�� ����ؼ�  dept_copy�� 5���� ���� insert.
DROP SEQUENCE dept_id_seq;

CREATE SEQUENCE dept_id_seq INCREMENT BY 10 START WITH 10 MINVALUE 10;

DROP TABLE dept_copy;

CREATE TABLE dept_copy
    AS
        SELECT
            *
        FROM
            dept
        WHERE
            1 = 0;

INSERT INTO dept_copy VALUES (
    dept_id_seq.NEXTVAL,
    '������',
    '����'
);

INSERT INTO dept_copy VALUES (
    dept_id_seq.NEXTVAL,
    '���ź�',
    '����'
);

INSERT INTO dept_copy VALUES (
    dept_id_seq.NEXTVAL,
    '��ȹ��',
    '����'
);

SELECT
    *
FROM
    dept_copy;

-- TODO: ����ID(emp.emp_id)�� ���� �ڵ����� ��Ű�� sequence�� ����. 10 ���� 1�� �����ϴ� sequence
-- ������ ������ sequence�� ����� emp_copy�� ���� 5�� insert
CREATE SEQUENCE emp_id_seq START WITH 10;

DROP TABLE emp_copy;

CREATE TABLE emp_copy
    AS
        SELECT
            *
        FROM
            emp
        WHERE
            1 = 0;

INSERT INTO emp_copy VALUES (
    emp_id_seq.NEXTVAL,
    'KJH',
    NULL,
    NULL,
    sysdate,
    30000,
    NULL,
    NULL
);

INSERT INTO emp_copy VALUES (
    emp_id_seq.NEXTVAL,
    'KJH',
    NULL,
    NULL,
    sysdate,
    30000,
    NULL,
    NULL
);

INSERT INTO emp_copy VALUES (
    emp_id_seq.NEXTVAL,
    'KJH',
    NULL,
    NULL,
    sysdate,
    30000,
    NULL,
    NULL
);

DESC emp_copy;

SELECT
    *
FROM
    emp_copy;