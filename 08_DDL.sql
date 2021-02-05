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
create table cust
as
select * from customers;

create table cust2
as 
select cust_id, cust_name, address from customers;

create table cust3
as
select * from customers
where 1 = 0; -- False , �÷��鸸 ī��. ���� ������ ī������ �ʴ´�.

select * from cust3;
desc cust3;
-- �߰�
alter table cust3 add(age number default 0 not null, point number);
-- ����
alter table cust3 modify(age number(3)); -- NOT NULL �� ���� �ٸ� ���� ���� x
alter table cust3 modify(cust_email null); -- NOT NULL �÷��� NULL �÷����� ����
alter table cust3 modify(cust_email not null);
-- �÷��� ����
alter table cust3 rename column cust_email to email; -- cust_email --> email ����
-- �÷� ����
alter table cust3 drop column age;

select * from cust;
desc cust;

alter table cust modify(cust_id number(2)); -- -99 ~ 99 --> �̹� id 100 �����ϱ� ������ ���� �߻�
alter table cust3 modify(cust_id number(3)); -- �� ���� ���� �ʱ� ������ ����
alter table cust modify(cust_id number(5)); -- ���� �����Ϳ� ������ ��ġ�� ���� ���(�ø���)���� ���� ���� ����
rollback; -- ����� Ÿ���� ���ư��� ����. rollback/commit[DML��ɾ�]�� ����� �ƴϴ�.

alter cust add (age number(3) not null); -- �̹� �����ϴ� ���̺� �� ���� ���� ������ null�� ä������. ������ not null���� ������ ���� �߻�

--�������� ����
-- �� ���̺��� �������ǵ� ��ȸ
select * from user_constraints;
select * from user_constraints where table_name = 'CUST';

-- �������� �߰�
alter table cust add constraint pk_cust primary key (cust_id);
alter table cust add constraint uk_cust_email unique (cust_email);
alter table cust add constraint ck_cust_gender check (gender in ('M','F'));

-- �������� ����
alter table cust drop constraint ck_cust_gender;
alter table cust drop primary key; -- pk �� �����ϱ� ������


--TODO: emp ���̺��� ī���ؼ� emp2�� ����(Ʋ�� ī��)
create table emp2
as
select * from emp
where 1 = 0;
select * from emp2;

--TODO: gender �÷��� �߰�: type char(1)
alter table emp2 add (gender char(1));
desc emp2;

--TODO: email �÷� �߰�. type: varchar2(100),  not null  �÷�
alter table emp2 add (email varchar2(100) not null);
desc emp2;

--TODO: jumin_num(�ֹι�ȣ) �÷��� �߰�. type: char(14), null ���. ������ ���� ������ �÷�.
alter table emp2 add (jumin_num char(14) null);
alter table emp2 add constraint uk_emp2_jumin_num unique(jumin_num);
desc emp2;
select * from user_constraints where table_name = 'EMP2';

--TODO: emp_id �� primary key �� ����
alter table emp2 add constraint pk_emp2 primary key(emp_id);
select * from user_constraints where table_name = 'EMP2';
  
--TODO: gender �÷��� M, F �����ϵ���  �������� �߰�
alter table emp2 add constraint pk_emp2_gender check(gender in ('M','F'));
select * from user_constraints where table_name = 'EMP2';
 
--TODO: salary �÷��� 0�̻��� ���鸸 ������ �������� �߰�
alter table emp2 add constraint pk_emp2_salary check(salary >= 0);
select * from user_constraints where table_name = 'EMP2';

--TODO: email �÷��� null�� ���� �� �ֵ� �ٸ� ��� ���� ���� ������ ���ϵ��� ���� ���� ����
alter table emp2 add constraint uk_emp2_email unique(email);
select * from user_constraints where table_name = 'EMP2';

--TODO: emp_name �� ������ Ÿ���� varchar2(100) ���� ��ȯ
alter table emp2 modify (emp_name varchar2(100)) ;
desc emp2;

--TODO: job_id�� not null �÷����� ����
alter table emp2 modify (job_id not null);
desc emp2;

--TODO: dept_id�� not null �÷����� ����
alter table emp2 modify (dept_id not null) ;
select * from emp2;
desc emp2;

--TODO: job_id  �� null ��� �÷����� ����
alter table emp2 modify (job_id null) ;
select * from emp2;
desc emp2;

--TODO: dept_id  �� null ��� �÷����� ����
alter table emp2 modify (dept_id null) ;
select * from emp2;
desc emp2;


--TODO: ������ ������ emp2_email_uk ���� ������ ����
alter table emp2 drop constraint UK_EMP2_EMAIL;
select * from user_constraints where table_name = 'EMP2';

--TODO: ������ ������ emp2_salary_ck ���� ������ ����
alter table emp2 drop constraint PK_EMP2_SALARY;
select * from user_constraints where table_name = 'EMP2';

--TODO: primary key �������� ����
alter table emp2 drop primary key;
select * from user_constraints where table_name = 'EMP2';

--TODO: gender �÷�����
alter table emp2 drop column gender;
desc emp2;

--TODO: email �÷� ����
alter table emp2 drop column email;
desc emp2;

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
create sequence dept_id_seq; 

--seq�̸�.nextval()

select dept_id_seq.nextval from dual;
select dept_id_seq.currval from dual;

insert into dept values(dept_id_seq.nextval,'new'||dept_id_seq.currval,'seoul');
select * from dept;
-- 1���� 50���� 10�� �ڵ����� �ϴ� ������
create sequence ex1_seq 
        increment by 10 
        maxvalue 50;

select exl_seq.nextval from dual;

-- 100 ���� 150���� 10�� �ڵ������ϴ� ������
create sequence ex2_seq 
        increment by 10
        start with 100
        maxvalue 150;
        
select ex2_seq.nextval from dual;        



-- 100 ���� 150���� 10�� �ڵ������ϵ� �ִ밪�� �ٴٸ��� ��ȯ�ϴ� ������
-- ��ȯ(cycle) �Ҷ� ����(increment by ���) : minvalue(�⺻��:1)���� ����
-- ��ȯ(cycle) �Ҷ� ����(increment by ����) : maxvalue(�⺻��:-1)���� ����
drop sequence ex3_seq;
create sequence ex3_seq 
        increment by 20
        start with 100
        minvalue 100
        maxvalue 150
        nocache
        cycle;
        
select ex3_seq.nextval from dual;     


-- -1���� -1�� �ڵ� �����ϴ� ������
create sequence ex4_seq
        increment by -1; -- �ڵ����� : start with �⺻�� -1
        
select ex4_seq.nextval from dual;   


-- -1���� -50���� -10�� �ڵ� �����ϴ� ������

create sequence ex5_seq
        increment by -10
        minvalue -50;
        
select ex5_seq.nextval from dual;   

-- 100 ���� -100���� -100�� �ڵ� �����ϴ� ������
create sequence ex6_seq
        increment by -100
        start with 100
        minvalue -100
        maxvalue 100; -- maxvalue :-1(����), 1(����)| ���� : maxvalue >= startvalue, ���� : maxvalue=<startvalue
        
select ex6_seq.nextval from dual; 


-- 15������ -15���� 1�� �����ϴ� ������ �ۼ�
create sequence ex7_seq
        increment by -1
        start with 15
        minvalue -15
        maxvalue 15;
        
select ex7_seq.nextval from dual; 



-- -10 ���� 1�� �����ϴ� ������ �ۼ�

create sequence ex8_seq
        increment by 1
        start with -10
        minvalue -10;
        
select ex8_seq.nextval from dual; 



-- TODO: �μ�ID(dept.dept_id)�� ���� �ڵ����� ��Ű�� sequence�� ����. 10 ���� 10�� �����ϴ� sequence
-- ������ ������ sequence�� ����ؼ�  dept_copy�� 5���� ���� insert.
drop sequence dept_id_seq;
create sequence dept_id_seq
    increment by 10
    start with 10
    minvalue 10;

drop table dept_copy;
create table dept_copy
as
select * from dept
where 1 = 0;

insert into dept_copy values (dept_id_seq.nextval,'������','����');
insert into dept_copy values (dept_id_seq.nextval,'���ź�','����');
insert into dept_copy values (dept_id_seq.nextval,'��ȹ��','����');
select * from dept_copy;

-- TODO: ����ID(emp.emp_id)�� ���� �ڵ����� ��Ű�� sequence�� ����. 10 ���� 1�� �����ϴ� sequence
-- ������ ������ sequence�� ����� emp_copy�� ���� 5�� insert
create sequence emp_id_seq
    start with 10;

drop table emp_copy;
create table emp_copy
as
select * from emp where 1 = 0;

insert into emp_copy values(emp_id_seq.nextval,'KJH',null,null,sysdate,30000,null,null);
insert into emp_copy values(emp_id_seq.nextval,'KJH',null,null,sysdate,30000,null,null);
insert into emp_copy values(emp_id_seq.nextval,'KJH',null,null,sysdate,30000,null,null);
desc emp_copy;

select * from emp_copy;