-- ************************** 6일차 **************************
-- 2019.02.27

-- [non-equi join] 모든 사원의 사번, 이름, 급여, 급여등급
select e.employee_id, e.first_name, e.salary, jg.grade_level
from employees e, job_grades jg
where e.salary between jg.lowest_sal and jg.highest_sal;

-- [outer join] 모든 사원의 사번, 이름, 부서번호, 부서이름
-- 단 부서가 미지정일 경우(=null), 부서이름을 '대기발령중'으로 출력
-- 만족하지 않는 데이터가 존재하는 테이블에 (+)를 붙이면, 만족하지 않는 값들도 가져옴
select e.employee_id, e.first_name, d.department_id, nvl(d.department_name,'대기발령중')
from employees e, departments d
where e.department_id = d.department_id(+);

-- [outer join] 모든 사원의 사번, 이름, 상관사번, 상관이름
-- 단, 상관이 없을 경우 상관이름에 '사장'으로 출력
select e.employee_id, e.first_name, m.employee_id, nvl(m.first_name,'사장')
from employees e, employees m
where e.manager_id = m.employee_id(+)
order by e.employee_id;

-- 모든 사원의 사번, 이름, 상관사번, 상관이름, 부서이름
-- 단, 상관이 없을 경우 상관이름에 '사장'으로 출력
-- 단, 부서가 없을 경우 부서이름에 '대기발령중'으로 출력
select e.employee_id, e.first_name, m.employee_id, nvl(m.first_name,'사장'), nvl(d.department_name, '대기발령중')
from employees e, employees m, departments d
where e.manager_id = m.employee_id(+)
            and e.department_id = d.department_id(+)
order by e.employee_id;

----------------------------- < ANSI Join > ------------------------------
-- [ANSI : cross join]
-- 조건 없는 join (=cartecian product)
select *
from employees cross join departments;

-- [ANSI : inner join]
-- 동등 조건을 이용한 join (=equi)
select e.first_name, d.department_name
from employees e inner join departments d
using(department_id)
where department_id =50;

-- [ANSI : natural join]
-- 두 테이블의 동일한 속성값을 모두 join
-- 동일한 속성값이 하나일 때 사용해야 오류가 덜함
-- 각 테이블의 고유 속성값만 select할 때만 사용하는 것이 좋음
select e.first_name, d.department_name
from employees e natural join departments d
where department_id =50;

-- [조인 테이블이 3개인 경우]
-- [oracle equi join]
-- 'Seattle'에 근무하는 사원의 사번, 이름, 부서이름, 도시
select e.employee_id, e.first_name, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
            and d.location_id = l.location_id
            and l.city = 'Seattle';
            
-- [ansi inner join]
-- join 조건마다 on을 써야함
select e.employee_id, e.first_name, d.department_name, l.city
from employees e join departments d on e.department_id = d.department_id
                          join locations l on d.location_id = l.location_id
where l.city = 'Seattle';


-- 모든 사원의 사번, 이름, 부서번호, 부서이름(대기발령중)
-- *사원을 기준으로
-- [outer join]
select e.employee_id, e.first_name, e.department_id, nvl(d.department_name,'대기발령중')
from employees e, departments d
where e.department_id = d.department_id(+);

-- [ANSI join]
select e.employee_id, e.first_name, e.department_id, nvl(d.department_name,'대기발령중')
from employees e left outer join departments d
on e.department_id = d.department_id;

-- 모든 부서에 근무하는 사원의 사번, 이름(사원없음), 부서번호, 부서이름
-- *부서를 기준으로
-- *모든 000에 ~하는 : 000에 (+)를 붙임
-- [outer join]
select e.employee_id, nvl(e.first_name,'사원없음'), d.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;

-- [ANSI join]
select e.employee_id, nvl(e.first_name,'사원없음'), d.department_id, d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id;


-- 회사에 근무하는 사원의 사번, 이름(사원없음), 부서번호, 부서이름(대기발령중)
-- 모든 부서 & 모든 사원
-- [outer join]
-- *오라클은 불가능 ... union이나 subquery 사용해야 함
select e.employee_id, nvl(e.first_name,'사원없음'), d.department_id, nvl(d.department_name, '대기발령중')
from employees e, departments d
where e.department_id(+) = d.department_id
            and e.department_id = d.department_id(+);
            
-- [ANSI join]
-- *ANSI는 가능
select e.employee_id, nvl(e.first_name,'사원없음'), d.department_id, nvl(d.department_name, '대기발령중')
from employees e full outer join departments d
on e.department_id = d.department_id
            and e.department_id = d.department_id;

------------------------------------------------ <조별 문제 풀이> ------------------------------------------------
-- Q1. 모든 부서에 근무하는 사원의 이름, 직책이름, 부서이름
-- 단, 부서가 미지정인 경우, 부서이름은 '미지정'으로 출력
-- 결과 : 20행
select e.first_name, j.job_title, nvl(d.department_name,'미지정')
from employees e, jobs j, departments d
where e.job_id = j.job_id
            and e.department_id = d.department_id(+);

-- Q2. 모든 사원의 사번, 이름, 경력 중 당시직책이름
-- 단, 경력이 없는 사원의 경우, 당시직책이름은 '경력 없음'으로 출력
-- 결과 : 23행
select e.employee_id, e.first_name, nvl(j.job_title, '경력 없음')
from employees e, job_history jh, jobs j
where e.employee_id = jh.employee_id(+)
            and jh.job_id = j.job_id(+)
order by e.employee_id;

-- Q3. inner join 사용할것, 매니저아이디가 100번인 사원의 사번, 이름, 부서이름
select e.employee_id, e.first_name, d.department_name
from employees e join departments d
on e.department_id = d.department_id
where e.manager_id = 100;

-- Q4. inner join 사용할것, Washington 주에 위치한 부서의 부서번호와 부서이름 
select d.department_id, d.department_name
from departments d join locations l
on d.location_id = l.location_id
where lower(l.state_province) = lower('Washington');

-- Q5. ANSI 조인을 사용하여 'accounting' 부서 소속 사원의 이름과 입사일을 출력하세요.
-- 단, 입사일은 년도만 표기 하시오.
select e.first_name, to_char(e.hire_date,'yyyy')
from employees e join departments d
on e.department_id = d.department_id
where lower(d.department_name) = lower('accounting');

-- Q6. ANSI 조인을 사용하여 토론토에서 근무하는 사원의 이름과 급여를 출력하세요.
select e.first_name, e.salary
from employees e join departments d on e.department_id = d.department_id
                            join locations l on d.location_id = l.location_id
where lower(l.city) = lower('toronto');

-- Q7. 모든 사원들에게 설선물 세트를 배송하려한다.
--ansi join을 이용하여사원들의 지역에 따른 우편번호를 알아내시오.
--모든 사원들의 사번, 이름, 부서 이름, 우편번호

-- Q8. 위에서 사용한 것과 다른 형식의 ansi join 을 이용하여
--모든 사원들의 사번, 이름, 부서 이름, 우편번호
--부서가 따로 없는 경우 '대기발령중', 우편번호가 없을경우 '자택수령' 으로 표시한다.


-- Q9. 모든 직원의 이름, 연봉, 직책이름, 연봉 수준
-- 단, 연봉이 높은 순으로 정렬하라
select e.first_name, e.salary, j.job_title, jg.grade_level
from employees e, jobs j, job_grades jg
where e.job_id=j.job_id
and e.salary between jg. lowest_sal and highest_sal
order by salary desc;

-- Q10. 모든 사원의 이름, 부서이름, 도시, 나라이름, 대륙이름 출력(join을 이용해서 출력)
select e. first_name, d.department_name, l.city, c.country_name, r.region_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
join countries c
on l.country_id=c.country_id
join regions r
on c.region_id=r.region_id;