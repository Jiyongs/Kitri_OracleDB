-- **************************9~10일차 **************************
-- 2019.03.05 - 03.06

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

-- [전체 테이블 목록 보기] (휴지통의 테이블도 있음)
select * from tab;

-- [drop한 테이블의 영구 삭제]
purge recyclebin;

select *
from emp_blank;

-- [서브쿼리를 삽입] 사번이 80인 사원들을 emp_blank 테이블에 삽입
insert into emp_blank
select *
from employees
where department_id = 80;

select *
from emp_blank;

-- 100번 사원의 사번, 이름, 직책, 부서번호
-- emp_blank 삽입
insert into emp_blank(employee_id, first_name, last_name, job_id, department_id, email, hire_date)
select employee_id, first_name, last_name,  job_id, department_id, email, hire_date
from employees
where employee_id = 100;


-- [update] : 테이블 값 수정
-- 변경할 속성값이 1개
-- id가 oracle2인 사람의 비밀번호를 9876으로 변경
update member
set pass=9876
where id = 'oracle2';
-- 변경할 속성값이 여러 개 (콤마 사용)
-- id가 java2인 사람의 비밀번호와 나이를 변경
update member
set pass=1234, age =25
where id = 'java2';

-- [update/서브쿼리문]
-- id가 java2인 사람의 비밀번호를 1234로, 나이를 id가 oracle인 사람과 같게 변경
update member
set pass=1234, age =(select age
                                from member
                                where id = 'oracle')
where id = 'java2';

select * 
from member;

select * from member;
select * from member_detail;
    

-- [delete] : 테이블 값 삭제
-- 참조 무결성을 지키기 위한 삭제 순서 : 참조하는 테이블(외래키) - 참조되는 테이블(기본키)
delete member_detail
where id = 'oracle';

delete member
where id = 'oracle';

-- [merge] : 테이블 값 병합
create table product
(
    pid number,
    pname varchar2(10),
    cnt number,
    price number,
    constraint product_pid_pk primary key (pid)
);

insert into product (pid, pname, cnt, price)
        values (100, '새우깡', 100, 1500);
insert into product (pid, pname, cnt, price)
        values (200, '꼬북칩', 80, 2700);
insert into product (pid, pname, cnt, price)
        values (300, '빼빼로', 120, 1000);

select *
from product;

-- 상품코드가 400인 자갈치(1200) 150개 입고
-- 1) select해서 상품코드 = 400인 상품 존재 여부 확인
-- 2) if(상품코드=400) update
--     else insert
merge into product
using dual  -- product 자신을 병합하는 것이므로 빈테이블 dual을 사용함
on (pid=400)
when matched then
    update set cnt = cnt + 150 --product를 병합하는 것이므로 테이블 기입 필요 X
when not matched then
    insert (pid, pname, cnt, price)
    values (400, '자갈치', 150, 1200);

-- 상품코드가 100인 새우깡(1500) 50개 입고
merge into product
using dual
on (pid=100)
when matched then
    update set cnt = cnt + 50
when not matched then
    insert (pid, pname, cnt, price)
    values (100, '새우깡', 50, 1500);

-- [commit] : 테이블 값 저장
commit;

-- [rollback] : 이전 commit 되돌리기
rollback;

-------------------------------------
select *
from product;

update product
set cnt = 200
where pid = 100;

insert into product
values (101, '조개깡', 150, 1500);

insert into product
values (102, '문어깡', 250, 1500);

insert into product
values (103, '고래깡', 55, 1500);

savepoint a;

insert into product
values (104, '한우깡', 58, 1500);

insert into product
values (105, '한돈깡', 120, 1500);

savepoint b;

insert into product
values (106, '버섯깡', 120, 1500);

insert into product
values (107, '차돌깡', 220, 1500);

rollback to b;


-- [sequence 생성]
-- 1부터 시작하고, 1씩 증가한다
create sequence product_pid_seq
start with 1 increment by 1;

create sequence product_pid_seq3
start with 1 increment by 1;

-- [sequence 적용]
insert into product (pid, pname, cnt, price)
values (product_pid_seq2.nextval, '이름', 10, 1000);

-- 다음 시퀀스 출력
select product_pid_seq.nextval
from dual;

select product_pid_seq3.nextval
from dual;

-- 시퀀스를 모르면, 이런식으로 해야 함
select max(pid) + 1
from product2;

select product_pid_seq.currval, product_pid_seq.nextval, product_pid_seq.nextval
from dual;

select product_pid_seq.currval
from dual;

rollback;

select * from product;

commit;