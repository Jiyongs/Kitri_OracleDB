-- **************************9���� **************************
-- 2019.03.05

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

-- [update] : ���̺� �� ����

-- [delete] : ���̺� �� ����

-- [merge] : ���̺� �� ����



commit;

