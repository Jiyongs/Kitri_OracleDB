-- ************************** 5일차 **************************
-- 2019.02.26

-- <함수>
-- [decode]
-- 사번, 이름, 부서번호, 직원유형
-- 직원유형
-- 부서번호 60이면 개발자
--              90이면 임원진
--              나머지 비개발자
select employee_id, first_name, department_id,
        decode(department_id, 60, '개발자',
                                        90, '임원진',
                                             '비개발자') as 직원유형
from employees
order by department_id;

-- <그룹 함수>
-- [count/
-- 회사의 총 사원 수, 급여총합, 급여평균, 최고급여, 최저급여
select count(employee_id), sum(salary), avg(salary), max(salary), min(salary)
from employees;

-- 평균급여보다 많이 받는 사원의 사번, 이름, 급여
select employee_id, first_name, salary
from employees
where salary > (select avg(salary) from employees);

-- <Join>

-- cartesian join(=cross join)
select *
from employees, departments;

-- equi join (=natural join)
-- [join] 사번, 이름, 부서번호, 부서이름
-- employees, departments (공통 : department_id)
-- 테이블 개수 - 1개의 조인 조건 필수임!
select e.employee_id, e.first_name, d.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
order by e.employee_id;

-- [join] 'seattle'에 근무하는 사원의 사번, 이름, 부서이름, 도시이름 (조인 3개)
-- 마지막 조건에서 둘 다 lower를 쓰는 것은, 검색하려는 값(오른쪽)을 입력값으로 받았을 때를 대비하기 위함!
select e.employee_id, e.first_name, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
            and d.location_id = l.location_id
            and lower(l.city) = lower('seattle');

-- [join] 'asia'에 근무하는 사원의 사번, 이름, 부서이름, 도시이름 (조인 5개)
select employee_id, first_name, department_name, city
from employees e, departments d, locations l, countries c, regions r
where e.department_id = d.department_id
            and d.location_id = l.location_id
            and l.country_id = c.country_id
            and c.region_id = r.region_id
            and lower(r.region_name) = lower('asia');    
        
-- [join] 10, 80, 90번 부서에 근무중인 사원의 사번, 이름, 직책이름, 부서이름
-- *현재 근무중인 사원을 구하는 것이므로 where절의 마지막 줄에서 e가 가진 department_id를 사용해야 한다!
select e.employee_id, e.first_name, j.job_title, d.department_name
from employees e, jobs j, departments d
where e.job_id = j.job_id
            and e.department_id = d.department_id
            and e.department_id in (10, 80, 90);

-- #####
-- [join] 사번 = 200인 사원의 근무 이력
-- 사번, 이름, 당시직책 이름, 당시부서 이름, 근무개월(소수2자리까지 반올림)
-- *where절의 마지막 employee_id는 job_history의 것을 사용해야 함!
-- ex) 퇴사한 사람이 경력증명서를 뽑아달라고 했을 때, 퇴사한 사원은 employees에 없음
select e.employee_id, e.first_name, j.job_title, d.department_name
            , to_char(round(months_between(jh.end_date,jh.start_date),2), '999.99')
from employees e, job_history jh, departments d, jobs j
where e.employee_id = jh.employee_id
            and jh.department_id = d.department_id
            and jh.job_id = j.job_id
            and jh.employee_id = 200;
            
-- [self join]
-- 모든 사원의 부서이름, 사번, 이름, 매니저 사번, 매니저 이름
-- *e : 모든 사원의 값 / ee : 매니저의 값
-- *e.manager_id : 모든 사원의 매니저 사번 / ee.employee_id : 모든 사원의 사번
select d.department_id, e.employee_id, e.first_name, ee.employee_id, ee.first_name
from departments d, employees e, employees ee
where d.department_id = e.department_id
                and e.manager_id = ee.employee_id;

------------------------------------------------ <조별 문제 풀이> ------------------------------------------------
-- Q1. 이름이 'pat'인 사원의 매니저이름, 회사 주소를 출력하기
-- 단, 주소 형식은 [대륙명 나라명 주이름 도시 도로주소]
select ee.first_name, r.region_name || ' ' || c.country_name || ' ' || l.state_province || ' ' || l.city || l.street_address
from employees e, employees ee, departments d, locations l, countries c, regions r
where e.manager_id = ee.employee_id
            and lower(e.first_name) = 'pat'
            and e.department_id = d.department_id
            and d.location_id = l.location_id
            and l.country_id = c.country_id
            and c.region_id = r.region_id;
            
-- Q2. 경력이 1개 이상인 사원의 사번, 이름, 근무 기간(년수), 당시 직책 이름을 출력하기
-- 단, 사번별로 정렬
select jh.employee_id, e.first_name, to_number(to_char(jh.end_date,'yyyy'))-to_number(to_char(jh.start_date,'yyyy')), j.job_title
from employees e, job_history jh, jobs j
where e.employee_id = jh.employee_id
            and jh.job_id = j.job_id
order by jh.employee_id;



-- ************************** 6일차 **************************
-- 2019.02.27

-- 직책id = 'SA_REP'인 사원의 사번, 이름, 직책이름, 부서이름
-- 단, 부서가 없는 경우 '대기발령'
select e.employee_id, e.first_name, j.job_title, d.department_name
from employees e, departments d, jobs j
where e.job_id = j.job_id
            and d.department_id in (e.department_id, null)
            and lower(e.job_id) = lower('SA_REP');
