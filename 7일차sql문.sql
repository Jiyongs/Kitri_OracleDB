-- ************************** 7일차 **************************
-- 2019.02.28

-- [sub query] 부서이름이 'IT'인 곳에서 근무하는 사원의 사번, 이름, 급여
-- [join]
select e.employee_id, e.first_name, e.salary
from employees e, departments d
where e.department_id = d.department_id
            and lower(d.department_name) = lower('IT');
-- [sub query]
select employee_id, first_name, salary
from employees
where department_id = (select department_id
                                    from departments
                                    where department_name = 'IT');

-- [sub query] 'Seattle'에 근무하는 사원의 사번, 이름, 급여
-- 중첩 쿼리를 통해 출력된 값이 2개 이상의 행일 때, '='이 아닌 'in'을 사용한다!
select employee_id, first_name, salary
from employees
where department_id in (select department_id
                                    from departments
                                    where location_id = (select location_id
                                                                    from locations
                                                                    where city = 'Seattle'));

-- <inline view>
-- from절에서 사용되는 서브쿼리로 만들어지는 가상의 테이블
-- 물리적으로 존재하는 테이블 X

-- 아래의 경우, 이론적인 성능 비교에서 inline view가 더 효율적
-- 지역번호 : 1700인 부서에서 일하는 사원의
-- 사번, 이름, 부서번호, 부서이름

-- [join]
select e.employee_id, e.first_name, e.department_id, d.department_name
from employees e, departments d            -- 160건의 data
where e.department_id = d.department_id -- 19
            and d.location_id = 1700;            -- 6

-- [inline view]
select e.employee_id, e.first_name, e.department_id
from employees e, (select department_id, department_name  -- 80건 datd
                            from departments
                            where location_id = 1700) d
where e.department_id = d.department_id;                          -- 6건

-- [sub query]
-- 'Kevin' 보다 급여를 많이 받는 사원의 사번, 이름, 급여
select employee_id, first_name, salary
from employees
where salary > (select salary
                        from employees
                        where first_name = 'Kevin');
                        
-- 50번 부서에 있는 사원들보다 급여를 많이 받는 사원의 사번, 이름, 급여
select employee_id, first_name, salary
from employees
where salary > all (select salary
                         from employees
                         where department_id = 50) ;

-- 부서에 근무하는 모든 사원들의 평균 급여보다 많이 받는 사원의 사번, 이름, 급여
select employee_id, first_name, salary
from employees
where salary > (select avg(salary)
                      from employees
                      where department_id is not null);
                      
-- 부서번호 : 20번인 사원들의 평균 급여보다 크고,
-- 부서장(department에 있는 manager_id)인 사원으로 부서번호가 20번이 아닌 사원의
-- 사번, 이름, 급여, 부서번호
select distinct e20.employee_id, e20.first_name, e20.salary, d.department_id
from (
        select employee_id, first_name, salary
        from employees
        where salary > (select avg(salary)
                               from employees
                               where department_id = 20
                               )
        ) e20, departments d
where e20.employee_id = d.manager_id
and d.department_id != 20;

-- [select절 서브]
-- 20번 부서의 평균급여
-- 50번 부서의 급여총합
-- 80번 부서의 인원수
-- 결과가 단일 행, 단일 컬럼인 서브쿼리만을 select문에 선언 가능
select (select avg(salary) from employees where department_id = 20) avg20,
        (select sum(salary) from employees where department_id = 50) sum50,
        (select count(employee_id) from employees where department_id = 80) count80
from dual;

-- 모든 사원의 사번, 이름, 급여, 등급, 부서이름
-- 단, A는 1등급, B는 2등급, ..., F는 6등급
--  웹사이트의 포인트에 따른 등급 뽑아내기용으로 사용됨
-- [from절의 서브쿼리문]
select e.employee_id, e.first_name, e.salary, jg.grade_level, d.department_name
from employees e, departments d, (select case when grade_level = 'A' then '1등급'
                                                                    when grade_level = 'B' then '2등급'
                                                                    when grade_level = 'C' then '3등급'
                                                                    when grade_level = 'D' then '4등급'
                                                                    when grade_level = 'E' then '5등급'
                                                                    when grade_level = 'F' then '6등급'
                                                              end grade_level, lowest_sal, highest_sal
                                                    from job_grades) jg
where e.department_id = d.department_id
and e.salary between jg.lowest_sal and jg.highest_sal
order by employee_id;

-- [select절의 서브쿼리문]
select e.employee_id, e.first_name, e.salary,
        decode((select grade_level
                    from job_grades
                    where e.salary between lowest_sal and highest_sal),
                                                                                             'A', '1등급',
                                                                                             'B', '2등급',
                                                                                             'C', '3등급',
                                                                                             'D', '4등급',
                                                                                             'E', '5등급',
                                                                                             '6등급') 등급,
        d.department_name
from employees e, departments d
where e.department_id = d.department_id
order by 등급;

