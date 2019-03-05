-- **************************9일차 **************************
-- 2019.03.05

-- ****** <DDL, Data Definition Langauge> ******

-- [create] : 테이블 생성하기

-- '회원' Table (필수)
-- 이름               VARCHAR2(30)  *중복값 제한
-- 아이디            VARCHAR2(16)
-- 비밀번호         VARCHAR2(16)
-- 나이               NUMBER(3)
-- 이메일 아이디  VARCHAR2(30)
-- 이메일 도메인  VARCHAR2(30)
-- 가입일            DATE
create table member
(
    name varchar2(30) not null,
    id varchar2(16),
    pass varchar2(16) not null,
    age number(3) check (age < 150),
    emailid varchar2(30),
    emaildomain varchar2(30),
    joindate date default sysdate,
    constraint member_id_pk primary key (id)  --제약사항 이름은 항상 '테이블명_속성명_제약사항약어'
);

-- [drop] : member 테이블 지우기
drop table member;

-- '회원 상세정보' Table
-- 아이디                VARCHAR2(16)    *식별자로, 회원T의 아이디와 같은 값을 가짐
-- 우편번호             VARCHAR2(5)     *NUMBER면, 01234인 경우 1234로 잡히기 떄문
-- 일반주소             VARCHAR2(100)
-- 상세주소             VARCHAR2(100)
-- 전화번호1 (010)    VARCHAR2(3)
-- 전화번호2 (1234)  VARCHAR2(4)
-- 전화번호3 (5678)  VARCHAR2(4)
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

-- [테이블 복사] : 전체(내용+구조) 복사
create table emp_all
as
select * from employees;

select *
from emp_all;

-- [테이블 복사] : 구조만 복사
create table emp_blank
as
select * from employees
where 1=0;

select *
from emp_blank;

-- [테이블 복사] : 복사본 테이블의 속성명 따로 지정
create table emp_50
as
select e.employee_id eid, e.first_name name, e.salary sal, d.department_name dname
from employees e, departments d
where e.department_id = d.department_id
and e.department_id = 50;

select *
from emp_50;


-- ****** <DML, Data Manipulation Langauge> ******

-- [insert] : 테이블 값 삽입하기
-- 속성 순서에 따라 삽입
insert into member
values ('신지영', 'shzy232', '1234', 25, 'shzy232', 'naver.com', sysdate);

-- 속성 순서를 임의로 지정하여 삽입
insert into member(id, name, age, pass, emailid, emaildomain, joindate)
values ('hong', '홍길동', 25, '123', 'java2', 'naver.com', sysdate);

insert into member_detail
values ('shzy232', '12345', '서울특별시 강동구 강일동 123번지', '키트리빌라 101호', '010', '1234', '4567');

insert into member_detail (id, tel1, tel2, tel3, address, address_detail)
values ('hong', '010', '9534', '1234', '서울특별시 영등포구 544번지', '디컨빌라 102호');

insert into member_detail (zipcode)
values ('67891');

-- 여러 행을 한 번에 삽입
-- **단, 결과를 확인하기 위해 select문으로 모든 값을 출력해야 함 (dual 사용)
insert all
        into member(id, name, age, pass, emailid, emaildomain, joindate)
        values ('oracle', '오라클', 30, 'a12345678', 'oracle', 'oracle.com', sysdate)
        into member_detail (id, zipcode, address, address_detail, tel1, tel2, tel3)
        values ('oracle', '12345', '서울시 구로구 구로디지털로 34번길 오라클 벨리 1차', '4층 오라클연구소 4강의장',  '010', '1234', '5678')
select * from dual;

-- [테이블 값 확인]
-- member 테이블 + member_detail 테이블
select *
from member m, member_detail d
where m.id = d.id;

-- member 테이블
select *
from member;

-- member_detail 테이블
select *
from member_detail;

-- [update] : 테이블 값 수정

-- [delete] : 테이블 값 삭제

-- [merge] : 테이블 값 병합



commit;

