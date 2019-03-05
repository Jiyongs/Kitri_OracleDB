-- **************************8일차 **************************
-- 2019.03.04

-- 부서번호가 50 또는 90인 사원과 (8 - 이 중 salary>=10000인 사람이 3명)
-- 급여가 10000 이상인 사원의 (7)
-- 사번, 이름, 급여, 부서번호

-- [union : 중복을 제거]
-- 결과 : 13명
select employee_id, first_name, salary, department_id
from employees
where department_id in (50, 90)
union
select employee_id, first_name, salary, department_id
from employees
where salary >= 10000;

-- [union : 중복을 포함]
-- 결과 : 15명
select employee_id, first_name, salary, department_id
from employees
where department_id in (50, 90)
union all
select employee_id, first_name, salary, department_id
from employees
where salary >= 10000;

-- [intersect : 두 질의 결과값의 교집합만 반환]
-- 결과 : 3명
select employee_id, first_name, salary, department_id
from employees
where department_id in (50, 90)
intersect
select employee_id, first_name, salary, department_id
from employees
where salary >= 10000;

-- [intersect : 첫 번째 결과에서 두 번째 결과를 뺌]
-- 결과 : 5명
select employee_id, first_name, salary, department_id
from employees
where department_id in (50, 90)
minus
select employee_id, first_name, salary, department_id
from employees
where salary >= 10000;

-- <Group by>

-- [group by] 부서별 급여 총합, 평균급여, 사원수, 최대급여, 최소급여
select sum(salary), avg(salary), count(employee_id), max(salary), min(salary)
from employees
group by department_id;

-- [group by/having] 평균 급여가 5000 이하인 부서의
-- 부서별 급여 총합, 평균급여, 사원수, 최대급여, 최소급여
select sum(salary), avg(salary), count(employee_id), max(salary), min(salary)
from employees
group by department_id
having avg(salary) <= 5000;

-- [gropu by/서브쿼리]
-- *부서별 모든 평균급여보다 높은 사람을 뽑으라는 뜻 (문제 파악 중요)
-- 모든 부서의 평균급여보다 많이 받는 사원의
-- 사번, 이름 급여
select employee_id, first_name, salary
from employees
where salary > all (select avg(salary)
                            from employees
                            group by department_id);

-- [group by/서브쿼리/join]
-- 부서별 최고급여를 받는 사원의
-- 부서이름, 사번, 이름, 급여
-- *부서 미지정은 제외
select d.department_name, e.employee_id, e.first_name, e.salary
from employees e, (select department_id, max(salary) msal
                            from employees
                            group by department_id) m, departments d
where e.department_id = m.department_id
            and e.salary = m.msal
            and e.department_id = d.department_id;

-- <rownum>
-- : 행 번호
-- : <, <= (작다) 비교는 가능하지만, >, >= (크다) 비교는 불가능
--  -> because 작다의 최소값은 1로 정해져있지만, 크다의 최대값은 무한하므로 불가능하다.
select rownum, employee_id, salary
from employees;

-- 불가능
select rownum, employee_id, salary
from employees
where rownum <= 10
and rownum >5;

-- ###
-- [TOP N Query] : 위에서 몇 등까지 뽑기
-- 순위, 사번, 이름, 급여, 입사년대,  부서이름
-- 급여순 순위 (*내림차순)
-- 한 페이지 당 5명씩 출력
-- 2페이지를 출력하시오 (*6~10등 출력이지만, 내가 아는 숫자는 2밖에 없다고 가정)
-- 입사년대 : 1980년대, 1990년대, 2000년대 ...
-- 알아야 할 것 : rownum 사용, select의 실행순서, case

-- [내 방법] : 입사년대에 trunc 사용, 서브쿼리 순서 조금 비효율적
select r.ro, r.employee_id, r.first_name, r.salary, r.입사년대, nvl(d.department_name,'미지정')
from departments d, (select rownum ro, sal.department_id, sal.employee_id, sal.first_name, sal.salary, 입사년대
                                from (select department_id, employee_id, first_name, salary, trunc(to_char(hire_date,'yyyy'),-1) || '년대' 입사년대
                                        from employees
                                        order by salary desc) sal) r
where r.ro between 1+5*(&pages-1) and 5 *(&pages)
        and r.department_id = d.department_id(+)
order by r.salary desc;

-- [선생님 방법] : 입사년대에 case문 사용, 서브쿼리 순서 효율적
select b.m ranking, b.employee_id, b.first_name, b.salary,
         case when to_char(hire_date,'yyyy') like '198%'
                        then '1980년대'
                when to_char(hire_date,'yyyy') like '199%'
                        then '1990년대'
                else '2000년대'
        end 입사년대
       , d.department_name
from (select rownum m, a.*
        from (select employee_id, first_name, hire_date, salary, department_id
                from employees
                order by salary desc) a
                where rownum <= &page *5 ) b, departments d
where b.department_id = d.department_id(+) 
and b.m > 1+(&page * 5 - 5)
order by ranking;

-- ***** rank(), over() 이용
select ro.급여순위, e.employee_id, e.first_name, e.salary, trunc(to_char(e.hire_date,'yyyy'),-1) || '년대' 입사년대, d.department_name
from employees e, (select rank() over(order by salary desc) 급여순위, employee_id
                            from employees) ro
        , departments d
where e.employee_id = ro.employee_id
and e.department_id = d.department_id(+)
and 급여순위 between 1+(&page * 5 - 5) and (&page * 5);

