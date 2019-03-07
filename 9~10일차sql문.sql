-- **************************9~10���� **************************
-- 2019.03.05 - 03.06

-- ****** <DDL, Data Definition Langauge> ******

-- [create] : ���̺� �����ϱ�

-- 'ȸ��' Table (�ʼ�)
-- �̸�               VARCHAR2(30)  *�ߺ��� ����
-- ���̵�            VARCHAR2(16)
-- ��й�ȣ         VARCHAR2(16)
-- ����               NUMBER(3)
-- �̸��� ���̵�  VARCHAR2(30)
-- �̸��� ������  VARCHAR2(30)
-- ������            DATE
create table member
(
    name varchar2(30) not null,
    id varchar2(16),
    pass varchar2(16) not null,
    age number(3) check (age < 150),
    emailid varchar2(30),
    emaildomain varchar2(30),
    joindate date default sysdate,
    constraint member_id_pk primary key (id)  --������� �̸��� �׻� '���̺��_�Ӽ���_������׾��'
);

-- [drop] : member ���̺� �����
drop table member;

-- 'ȸ�� ������' Table
-- ���̵�                VARCHAR2(16)    *�ĺ��ڷ�, ȸ��T�� ���̵�� ���� ���� ����
-- �����ȣ             VARCHAR2(5)     *NUMBER��, 01234�� ��� 1234�� ������ ����
-- �Ϲ��ּ�             VARCHAR2(100)
-- ���ּ�             VARCHAR2(100)
-- ��ȭ��ȣ1 (010)    VARCHAR2(3)
-- ��ȭ��ȣ2 (1234)  VARCHAR2(4)
-- ��ȭ��ȣ3 (5678)  VARCHAR2(4)
create table member_detail
(
    id varchar2(16),
    zipcode varchar2(5),
    address varchar2(100),
    address_detail varchar2(100),
    tel1 varchar2(3),
    tel2 varchar2(4),
    tel3 varchar2(4),
    constraint member_detail_id_fk foreign key (id) references member(id)
);

-- [���̺� ����] : ��ü(����+����) ����
create table emp_all
as
select * from employees;

select *
from emp_all;

-- [���̺� ����] : ������ ����
create table emp_blank
as
select * from employees
where 1=0;

select *
from emp_blank;

-- [���̺� ����] : ���纻 ���̺��� �Ӽ��� ���� ����
create table emp_50
as
select e.employee_id eid, e.first_name name, e.salary sal, d.department_name dname
from employees e, departments d
where e.department_id = d.department_id
and e.department_id = 50;

select *
from emp_50;


-- ****** <DML, Data Manipulation Langauge> ******

-- [insert] : ���̺� �� �����ϱ�
-- �Ӽ� ������ ���� ����
insert into member
values ('������', 'shzy232', '1234', 25, 'shzy232', 'naver.com', sysdate);

-- �Ӽ� ������ ���Ƿ� �����Ͽ� ����
insert into member(id, name, age, pass, emailid, emaildomain, joindate)
values ('hong', 'ȫ�浿', 25, '123', 'java2', 'naver.com', sysdate);

insert into member_detail
values ('shzy232', '12345', '����Ư���� ������ ���ϵ� 123����', 'ŰƮ������ 101ȣ', '010', '1234', '4567');

insert into member_detail (id, tel1, tel2, tel3, address, address_detail)
values ('hong', '010', '9534', '1234', '����Ư���� �������� 544����', '�������� 102ȣ');

insert into member_detail (zipcode)
values ('67891');

-- ���� ���� �� ���� ����
-- **��, ����� Ȯ���ϱ� ���� select������ ��� ���� ����ؾ� �� (dual ���)
insert all
        into member(id, name, age, pass, emailid, emaildomain, joindate)
        values ('oracle', '����Ŭ', 30, 'a12345678', 'oracle', 'oracle.com', sysdate)
        into member_detail (id, zipcode, address, address_detail, tel1, tel2, tel3)
        values ('oracle', '12345', '����� ���α� ���ε����з� 34���� ����Ŭ ���� 1��', '4�� ����Ŭ������ 4������',  '010', '1234', '5678')
select * from dual;

-- [���̺� �� Ȯ��]
-- member ���̺� + member_detail ���̺�
select *
from member m, member_detail d
where m.id = d.id;

-- member ���̺�
select *
from member;

-- member_detail ���̺�
select *
from member_detail;

-- [��ü ���̺� ��� ����] (�������� ���̺� ����)
select * from tab;

-- [drop�� ���̺��� ���� ����]
purge recyclebin;

select *
from emp_blank;

-- [���������� ����] ����� 80�� ������� emp_blank ���̺� ����
insert into emp_blank
select *
from employees
where department_id = 80;

select *
from emp_blank;

-- 100�� ����� ���, �̸�, ��å, �μ���ȣ
-- emp_blank ����
insert into emp_blank(employee_id, first_name, last_name, job_id, department_id, email, hire_date)
select employee_id, first_name, last_name,  job_id, department_id, email, hire_date
from employees
where employee_id = 100;


-- [update] : ���̺� �� ����
-- ������ �Ӽ����� 1��
-- id�� oracle2�� ����� ��й�ȣ�� 9876���� ����
update member
set pass=9876
where id = 'oracle2';
-- ������ �Ӽ����� ���� �� (�޸� ���)
-- id�� java2�� ����� ��й�ȣ�� ���̸� ����
update member
set pass=1234, age =25
where id = 'java2';

-- [update/����������]
-- id�� java2�� ����� ��й�ȣ�� 1234��, ���̸� id�� oracle�� ����� ���� ����
update member
set pass=1234, age =(select age
                                from member
                                where id = 'oracle')
where id = 'java2';

select * 
from member;

select * from member;
select * from member_detail;
    

-- [delete] : ���̺� �� ����
-- ���� ���Ἲ�� ��Ű�� ���� ���� ���� : �����ϴ� ���̺�(�ܷ�Ű) - �����Ǵ� ���̺�(�⺻Ű)
delete member_detail
where id = 'oracle';

delete member
where id = 'oracle';

-- [merge] : ���̺� �� ����
create table product
(
    pid number,
    pname varchar2(10),
    cnt number,
    price number,
    constraint product_pid_pk primary key (pid)
);

insert into product (pid, pname, cnt, price)
        values (100, '�����', 100, 1500);
insert into product (pid, pname, cnt, price)
        values (200, '����Ĩ', 80, 2700);
insert into product (pid, pname, cnt, price)
        values (300, '������', 120, 1000);

select *
from product;

-- ��ǰ�ڵ尡 400�� �ڰ�ġ(1200) 150�� �԰�
-- 1) select�ؼ� ��ǰ�ڵ� = 400�� ��ǰ ���� ���� Ȯ��
-- 2) if(��ǰ�ڵ�=400) update
--     else insert
merge into product
using dual  -- product �ڽ��� �����ϴ� ���̹Ƿ� �����̺� dual�� �����
on (pid=400)
when matched then
    update set cnt = cnt + 150 --product�� �����ϴ� ���̹Ƿ� ���̺� ���� �ʿ� X
when not matched then
    insert (pid, pname, cnt, price)
    values (400, '�ڰ�ġ', 150, 1200);

-- ��ǰ�ڵ尡 100�� �����(1500) 50�� �԰�
merge into product
using dual
on (pid=100)
when matched then
    update set cnt = cnt + 50
when not matched then
    insert (pid, pname, cnt, price)
    values (100, '�����', 50, 1500);

-- [commit] : ���̺� �� ����
commit;

-- [rollback] : ���� commit �ǵ�����
rollback;

-------------------------------------
select *
from product;

update product
set cnt = 200
where pid = 100;

insert into product
values (101, '������', 150, 1500);

insert into product
values (102, '�����', 250, 1500);

insert into product
values (103, '����', 55, 1500);

savepoint a;

insert into product
values (104, '�ѿ��', 58, 1500);

insert into product
values (105, '�ѵ���', 120, 1500);

savepoint b;

insert into product
values (106, '������', 120, 1500);

insert into product
values (107, '������', 220, 1500);

rollback to b;


-- [sequence ����]
-- 1���� �����ϰ�, 1�� �����Ѵ�
create sequence product_pid_seq
start with 1 increment by 1;

create sequence product_pid_seq3
start with 1 increment by 1;

-- [sequence ����]
insert into product (pid, pname, cnt, price)
values (product_pid_seq2.nextval, '�̸�', 10, 1000);

-- ���� ������ ���
select product_pid_seq.nextval
from dual;

select product_pid_seq3.nextval
from dual;

-- �������� �𸣸�, �̷������� �ؾ� ��
select max(pid) + 1
from product2;

select product_pid_seq.currval, product_pid_seq.nextval, product_pid_seq.nextval
from dual;

select product_pid_seq.currval
from dual;

rollback;

select * from product;

commit;