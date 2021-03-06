/*
1. 제품 테이블은 제품_ID 컬럼이 primary key 컬럼으로 그 행을 다른 행과 식별할 때 사용된다.
2. 제품 테이블의 제조사 컬럼은 Not Null(NN) 인 것으로 봐서 null 인 상태일 수가 없다.
3. 고객 테이블에서 다른행과 식별할 때 사용하는 컬럼은 cust_id 이다. 
4. 고객 테이블의 전화번호 컬럼의 데이터 타입은 varchar2 으로 문자열형태 값 15 바이트 저장할 수 있으며 NULL 값을 가질수있다.
5. 고객 테이블의 가입일 컬럼에 대해 4번 처럼 설명해 보시오.
   Date 날짜/시간
6. 주문 테이블은 총 5개 컬럼이 있다. 정수 타입이 3개이고 문자열 타입이 1개 이고 날짜 타입이 1개이다.
7. 고객 테이블과 주문테이블은 서로 관계가 있는 테이블입니다.
    부모테이블은 고객CUSTOMERS 이고 자식 테이블은 주문ORDERS 이다..
    부모테이블의 고객_ID(CUST_ID,PK)컬럼을 자식테이블의 고객_ID(CUST_ID,FK)컬럼이 참조하고 있다.
    고객테이블의 한행의 데이터는 주문테이블의 0~N 행과 관계가 있을 수 있다.
    주문테이블의 한행은 고객테이블의 1 행과 관계가 있을 수 있다.
8. 주문 테이블과 주문_제품 테이블은 서로 관계가 있는 테이블입니다.
    부모 테이블은 주문ORDERS 이고 자식 테이블은 주문제품ORDER_ITEMS이다.
    부모 테이블의 주문_ID(order_ID,PK)컬럼을 자식 테이블의 주문_ID(order_ID,FK)컬럼이 참조하고 있다.
    주문 테이블의 한행의 데이터는 주문_제품 테이블의 0~N 행과 관계가 있을 수 있다.
    주문_제품 테이블의 한행은 주문 테이블의 1행과 관계가 있을 수 있다.
9. 제품과 주문_제품은 서로 관계가 있는 테이블입니다. 
    부모 테이블은 제품PRODUCTS 이고 자식 테이블은  주문제품ORDER_ITEMS 이다.
    부모 테이블의 제품ID(product_id,pk)컬럼을 자식 테이블의 제품ID(product_id,FK)컬럼이 참조하고 있다.
    제품 테이블의 한행의 데이터는 주문_제품 테이블의 0 ~ N 행과 관계가 있을 수 있다.
    주문_제품 테이블의 한행은 제품 테이블의 1행과 관계가 있을 수 있다.
*/

-- TODO: 4개의 테이블에 어떤 값들이 있는지 확인.
select * from products;
select * from customers;
select * from order_items;
select * from orders;

-- TODO: 주문 번호가 1인 주문의 주문자 이름, 주소, 우편번호, 전화번호 조회

select c.cust_name, c.address, c.postal_code, c.phone_number
from customers c join orders ors on c.cust_id = ors.cust_id
where ors.order_id = 1;

-- TODO : 주문 번호가 2인 주문의 주문일, 주문상태, 총금액, 주문고객 이름, 주문고객 이메일 주소 조회
select ors.order_date,ors.order_status,ors.order_total,c.cust_name, c.cust_email
from customers c join orders ors on c.cust_id = ors.cust_id
where ors.order_id = 2;

-- TODO : 고객 ID가 120인 고객의 이름, 성별, 가입일과 지금까지 주문한 주문정보중 주문_ID, 주문일, 총금액을 조회
select c.cust_name, c.gender, c.join_date, c.phone_number ,ors.order_id,ors.order_date,ors.order_total
from customers c LEFT join orders ors on c.cust_id = ors.cust_id
where c.cust_id = 120;

-- TODO : 고객 ID가 110인 고객의 이름, 주소, 전화번호, 그가 지금까지 주문한 주문정보중 주문_ID, 주문일, 주문상태 조회
select c.cust_name, c.address, c.phone_number ,ors.order_id,ors.order_date,ors.order_status
from customers c join orders ors on c.cust_id = ors.cust_id
where c.cust_id = 110;

-- TODO : 고객 ID가 120인 고객의 정보와 지금까지 주문한 주문정보를 모두 조회.
select c.*, ors.*
from customers c left join orders ors on c.cust_id = ors.cust_id
where c.cust_id = 120;
-- TODO : '2017/11/13'(주문날짜) 에 주문된 주문의 주문고객의 고객_ID, 이름, 주문상태, 총금액을 조회

select c.cust_id, c.cust_name,ors.order_status,ors.order_total,ors.order_date
from customers c join orders ors on c.cust_id = ors.cust_id
where ors.order_date = to_date('2017/11/13','yyyy/mm/dd');


-- TODO : 주문상세 ID가 xxxx인 주문제품의 제품이름, 판매가격, 제품가격을 조회.

select p.product_name,ois.sell_price,p.price
from order_items ois join products p on ois.product_id = p.product_id
where ois.order_item_id = 1;

-- TODO : 주문 ID가 4인 주문의 주문 고객의 이름, 주소, 우편번호, 주문일, 주문상태, 총금액, 주문 제품이름, 제조사, 제품가격, 판매가격, 제품수량을 조회.

select c.cust_name, c.address, c.postal_code, ors.order_date, ors.order_status, ors.order_total, p.product_name, p.maker,p.price, ois.sell_price, ois.quantity
from orders ors join order_items ois on ors.order_id = ois.order_id 
                join customers c on ors.cust_id = c.cust_id 
                join products p on ois.product_id = p.product_id
where ors.order_id = 4;


-- TODO : 제품 ID가 200인 제품이 2017년에 몇개 주문되었는지 조회.

select sum(ois.quantity) 주문갯수 --, p.product_id, extract(year from ors.order_date) 제조년도
from order_items ois join products p on ois.product_id = p.product_id 
                     join orders ors on ois.order_id = ors.order_id
where p.product_id = 200
and extract(year from ors.order_date) = 2017;

-- TODO : 제품분류별 총 주문량을 조회
select nvl(sum(ois.quantity),0) "총 주문량", p.category "제품분류별"
from order_items ois right join products p on ois.product_id = p.product_id
group by p.category;


