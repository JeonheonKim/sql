--���� �ּ�
/*
block �ּ�
���̺� : ȸ��(member)
�Ӽ�
id : varchar2(10), primary key
passward : varchar2(10) not null(ȸ�����Խ� �ʼ� �Է»���)
name : nvarchar2(50) not null
point :  number(7) nullable
join_data(������) : date not null
*/
-- ����: control + enter
create table member(
    id varchar2(10) PRIMARY key,
    password VARCHAR2(10) not null,
    name nvarchar2(50) not null,
    point number(7),
    join_date date not null
);    

select * from tab;

-- delete table
drop table member;

--������ �� �߰�
INSERT into member(id, password, name,point,join_date)
    Values ('id-1','abcde', 'ȫ�浿',10000,'2020/10/05');
-- insert values into all columns
INSERT into member VALUES ('id-2','11111','�ڿ���',19999,'2010/05/07');
-- PK ���� : not null & unique
INSERT into member VALUES ('id-2','11111','�ڿ���',19999,'2010/05/07');
INSERT into member VALUES ('id-3','11111','�ڿ���',null,'2010/05/07'); -- Name Not null

SELECT
    *
FROM member;



