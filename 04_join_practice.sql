/*
1. ��ǰ ���̺��� ��ǰ_ID �÷��� primary key �÷����� �� ���� �ٸ� ��� �ĺ��� �� ���ȴ�.
2. ��ǰ ���̺��� ������ �÷��� Not Null(NN) �� ������ ���� null �� ������ ���� ����.
3. �� ���̺��� �ٸ���� �ĺ��� �� ����ϴ� �÷��� cust_id �̴�. 
4. �� ���̺��� ��ȭ��ȣ �÷��� ������ Ÿ���� varchar2 ���� ���ڿ����� �� 15 ����Ʈ ������ �� ������ NULL ���� �������ִ�.
5. �� ���̺��� ������ �÷��� ���� 4�� ó�� ������ ���ÿ�.
   Date ��¥/�ð�
6. �ֹ� ���̺��� �� 5�� �÷��� �ִ�. ���� Ÿ���� 3���̰� ���ڿ� Ÿ���� 1�� �̰� ��¥ Ÿ���� 1���̴�.
7. �� ���̺�� �ֹ����̺��� ���� ���谡 �ִ� ���̺��Դϴ�.
    �θ����̺��� ��CUSTOMERS �̰� �ڽ� ���̺��� �ֹ�ORDERS �̴�..
    �θ����̺��� ��_ID(CUST_ID,PK)�÷��� �ڽ����̺��� ��_ID(CUST_ID,FK)�÷��� �����ϰ� �ִ�.
    �����̺��� ������ �����ʹ� �ֹ����̺��� 0~N ��� ���谡 ���� �� �ִ�.
    �ֹ����̺��� ������ �����̺��� 1 ��� ���谡 ���� �� �ִ�.
8. �ֹ� ���̺�� �ֹ�_��ǰ ���̺��� ���� ���谡 �ִ� ���̺��Դϴ�.
    �θ� ���̺��� �ֹ�ORDERS �̰� �ڽ� ���̺��� �ֹ���ǰORDER_ITEMS�̴�.
    �θ� ���̺��� �ֹ�_ID(order_ID,PK)�÷��� �ڽ� ���̺��� �ֹ�_ID(order_ID,FK)�÷��� �����ϰ� �ִ�.
    �ֹ� ���̺��� ������ �����ʹ� �ֹ�_��ǰ ���̺��� 0~N ��� ���谡 ���� �� �ִ�.
    �ֹ�_��ǰ ���̺��� ������ �ֹ� ���̺��� 1��� ���谡 ���� �� �ִ�.
9. ��ǰ�� �ֹ�_��ǰ�� ���� ���谡 �ִ� ���̺��Դϴ�. 
    �θ� ���̺��� ��ǰPRODUCTS �̰� �ڽ� ���̺���  �ֹ���ǰORDER_ITEMS �̴�.
    �θ� ���̺��� ��ǰID(product_id,pk)�÷��� �ڽ� ���̺��� ��ǰID(product_id,FK)�÷��� �����ϰ� �ִ�.
    ��ǰ ���̺��� ������ �����ʹ� �ֹ�_��ǰ ���̺��� 0 ~ N ��� ���谡 ���� �� �ִ�.
    �ֹ�_��ǰ ���̺��� ������ ��ǰ ���̺��� 1��� ���谡 ���� �� �ִ�.
*/

-- TODO: 4���� ���̺� � ������ �ִ��� Ȯ��.
select * from products;
select * from customers;
select * from order_items;
select * from orders;

-- TODO: �ֹ� ��ȣ�� 1�� �ֹ��� �ֹ��� �̸�, �ּ�, �����ȣ, ��ȭ��ȣ ��ȸ

select c.cust_name, c.address, c.postal_code, c.phone_number
from customers c join orders ors on c.cust_id = ors.cust_id
where ors.order_id = 1;

-- TODO : �ֹ� ��ȣ�� 2�� �ֹ��� �ֹ���, �ֹ�����, �ѱݾ�, �ֹ��� �̸�, �ֹ��� �̸��� �ּ� ��ȸ
select ors.order_date,ors.order_status,ors.order_total,c.cust_name, c.cust_email
from customers c join orders ors on c.cust_id = ors.cust_id
where ors.order_id = 2;

-- TODO : �� ID�� 120�� ���� �̸�, ����, �����ϰ� ���ݱ��� �ֹ��� �ֹ������� �ֹ�_ID, �ֹ���, �ѱݾ��� ��ȸ
select c.cust_name, c.gender, c.join_date, c.phone_number ,ors.order_id,ors.order_date,ors.order_total
from customers c LEFT join orders ors on c.cust_id = ors.cust_id
where c.cust_id = 120;

-- TODO : �� ID�� 110�� ���� �̸�, �ּ�, ��ȭ��ȣ, �װ� ���ݱ��� �ֹ��� �ֹ������� �ֹ�_ID, �ֹ���, �ֹ����� ��ȸ
select c.cust_name, c.address, c.phone_number ,ors.order_id,ors.order_date,ors.order_status
from customers c join orders ors on c.cust_id = ors.cust_id
where c.cust_id = 110;

-- TODO : �� ID�� 120�� ���� ������ ���ݱ��� �ֹ��� �ֹ������� ��� ��ȸ.
select c.*, ors.*
from customers c left join orders ors on c.cust_id = ors.cust_id
where c.cust_id = 120;
-- TODO : '2017/11/13'(�ֹ���¥) �� �ֹ��� �ֹ��� �ֹ����� ��_ID, �̸�, �ֹ�����, �ѱݾ��� ��ȸ

select c.cust_id, c.cust_name,ors.order_status,ors.order_total,ors.order_date
from customers c join orders ors on c.cust_id = ors.cust_id
where ors.order_date = to_date('2017/11/13','yyyy/mm/dd');


-- TODO : �ֹ��� ID�� xxxx�� �ֹ���ǰ�� ��ǰ�̸�, �ǸŰ���, ��ǰ������ ��ȸ.

select p.product_name,ois.sell_price,p.price
from order_items ois join products p on ois.product_id = p.product_id
where ois.order_item_id = 1;

-- TODO : �ֹ� ID�� 4�� �ֹ��� �ֹ� ���� �̸�, �ּ�, �����ȣ, �ֹ���, �ֹ�����, �ѱݾ�, �ֹ� ��ǰ�̸�, ������, ��ǰ����, �ǸŰ���, ��ǰ������ ��ȸ.

select c.cust_name, c.address, c.postal_code, ors.order_date, ors.order_status, ors.order_total, p.product_name, p.maker,p.price, ois.sell_price, ois.quantity
from orders ors join order_items ois on ors.order_id = ois.order_id 
                join customers c on ors.cust_id = c.cust_id 
                join products p on ois.product_id = p.product_id
where ors.order_id = 4;


-- TODO : ��ǰ ID�� 200�� ��ǰ�� 2017�⿡ � �ֹ��Ǿ����� ��ȸ.

select sum(ois.quantity) �ֹ����� --, p.product_id, extract(year from ors.order_date) �����⵵
from order_items ois join products p on ois.product_id = p.product_id 
                     join orders ors on ois.order_id = ors.order_id
where p.product_id = 200
and extract(year from ors.order_date) = 2017;

-- TODO : ��ǰ�з��� �� �ֹ����� ��ȸ
select nvl(sum(ois.quantity),0) "�� �ֹ���", p.category "��ǰ�з���"
from order_items ois right join products p on ois.product_id = p.product_id
group by p.category;


