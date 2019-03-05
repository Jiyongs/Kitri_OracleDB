-- ************************** 2일차 **************************
-- 2019.02.21
-- 모든 사원의 모든 정보를 검색
select *
from employees;

-- 사원의 사번, 이름(first_name), 급여를 검색
select employee_id, first_name, salary
from employees;

-- 회사에 존재하는 부서번호, 부서이름을 검색
select department_id, department_name
from departments;

-- [distinct] 회사의 부서번호를 검색    *employees 기준    *중복제거
select distinct department_id
from employees;

-- [산술] 시험용 테이블(dual)에 산술 연산 결과를 출력
select 1+1, 10-5, 2*10, 10/3
from dual;

-- [산술] 사번, 이름, 급여, 200 인상된 급여를 검색
select employee_id, first_name, salary, salary+200
from employees;

-- [산술] 사번, 이름, 급여, 커미션포함급여를 검색  *커미션=null 은 0으로 처리
select employee_id, first_name, salary, salary+salary*NVL(commission_pct,0)
from employees;

-- [alias] 사번, 이름, 급여를 검색   *별칭으로 출력
select employee_id 사번,  first_name 이름, salary 급여
from employees;

select employee_id as 사번,  first_name as "이름", salary "급여 200"
from employees;

select employee_id 사번, first_name 이름, salary 급여, nvl(commission_pct,0) 커미션 , salary+salary*NVL(commission_pct,0) "인상 후 급여"
from employees;

-- [연결연산자] 사번, 풀네임 검색     *이름과 성 사이에 공백 추가
select employee_id 사번, first_name || ' ' || last_name 이름
from employees;

-- [연결연산자] "사번이 n번인 사원의 이름은 000입니다"형식으로 출력 (info)
select '사번이 ' || employee_id || '번인 사원의 이름은 ' || first_name || ' ' || last_name || '입니다.'
from employees;

------------------------------------------------ <조별 문제 풀이> ------------------------------------------------
-- 1. **(이름)의 메일주소는**이고 핸드폰번호는**이다. 다음과 같이 출력하기 column이름은 연락처
select last_name || '의 메일주소는' || email || '이고 핸드폰번호는' || phone_number || '이다.' 연락처
from employees;

-- 2. **(국가) **(지역)주 **(도시)시 **(주소)의 우편번호는 **이다. 다음과 같이 출력하기 column이름은 우편번호
select country_id || ' ' || state_province || '시 ' || street_address || '의 우편주소는 ' || postal_code || '이다.' 우편번호
from locations;

-- 3. "000 사원 - 이메일 : 000@gamil.com / 전화번호 : ***.***.****" 형식으로 출력  *이름은 '이름 성' 형식
select first_name || ' ' || last_name || ' 사원 - 이메일 : ' || email || '@gmail.com / 전화번호 : ' || phone_number
from employees;

-- 4. "도로 주소, 도시명, 주이름, 국가ID" 형식으로 출력하세요 (Column명은 '주소')
select street_address || ', ' || city || ', ' || state_province || ', ' || country_id 주소
from locations;

-- 5."full name"의 직업은 "job_id"이며 입사날짜는 "hire_date"이다. 
select first_name || ' ' || last_name || '의 직업은 ' || job_id || '이며 입사날짜는 ' || hire_date || '이다.'
from employees;

-- 6. "우편번호 - 도시 - 주소"  형태로 출력해주세요.
select postal_code || ' - ' || city || ' - ' || street_address
from locations;

-- 7. 와싱턴 시애틀에 위치한 지사의 우편번호는 98199이다.(별칭 : Post code)
select state_province || ' ' || city || '에 위치한 지사의 우편번호는 ' || postal_code || '이다.' as "Post code"
from locations;

-- 8. 이름(풀네임)의 급여는 10% 인상되어 ??이다. (별칭 : 급여인상)
select first_name || ' ' || last_name || '의 급여는 ' || nvl(commission_pct,0)*100 || '% 인상되어' || salary*commission_pct || '이다.' as 급여인상
from employees;

-- 9. ** 사원님의 급여는 ** 입니다.  별칭 = 급여 내역
select last_name || '의 급여는 ' || salary || '입니다.' as 급여내역
from employees;

-- 10. 사원번호가 ??인 사람의 직책은 ??이며 입사일은 ??, 퇴사일은 ??입니다. 별칭 = 입퇴사자 정보
select '사원번호가 ' || employee_id || '인 사람의 직책은 ' || job_id || '이며 입사일은 ' || start_date || ', 퇴사일은 ' || end_date || '입니다.' as 프로젝트
from job_history;


-- ************************** 3일차 **************************
-- 2019.02.22

-- [where] 급여가 5000 이상인 사원의 사번, 이름, 급여, 부서번호
select employee_id, last_name, salary, department_id
from employees
where salary >= 5000;

-- [where] 사번이 100번인 사원의 사번, 이름, 부서번호
select employee_id, last_name, department_id
from employees
where employee_id = 100;

-- [lower] 근무도시가 Seattle인 지역의 지역번호, 우편번호, 도시
Select Location_Id, Postal_Code, City
From Locations
Where lower(city) = 'seattle';

-- [and] 급여를 5000이상 10000미만을 받는 사원의 사번, 이름, 급여, 부서번호
select employee_id, first_name, salary, department_id
from employees
where salary>=5000 and salary<10000;

select employee_id, first_name, salary, department_id
from employees
where salary between 5000 and 9999;

-- [and] 부서번호가 50인 사원들 중 급여가 5000이상인 사원의 사번, 이름, 급여, 부서번호
select employee_id, first_name, salary, department_id
from employees
where department_id=50 and salary>=5000;

-- [between] 급여를 5000이상 12000이하을 받는 사원의 사번, 이름, 급여, 부서번호
select employee_id, first_name, salary, department_id
from employees
where salary between 5000 and 12000;

-- [is (not) null] 커미션을 받는 사원의 사번, 이름, 급여, 커미션포함급여
select employee_id, first_name, salary, salary+salary*commission_pct
from employees
where commission_pct>0;

select employee_id, first_name, salary, salary+salary*commission_pct
from employees
where commission_pct is not null;

-- [in] 근무부서가 50, 60, 80인 사원의 사번, 이름, 부서번호
select employee_id, first_name, department_id
from employees
where department_id =50 or department_id=60 or department_id = 80;

select employee_id, first_name, department_id
from employees
where department_id in (50, 60, 80);

-- [in] 근무부서가 50, 60, 80이 아닌 사원의 사번, 이름, 부서번호
select employee_id, first_name, department_id
from employees
where department_id!=50 and department_id!=60 and department_id != 80;

select employee_id, first_name, department_id
from employees
where department_id not in (50, 60, 80);

-- [any] 급여가 3000 이상 이거나, 8000 이상 이거나, 5000 이상인 사원의 사번, 이름, 급여
select employee_id, first_name, salary
from employees
where salary >= 3000 or salary >= 8000 or salary >= 5000;

select employee_id, first_name, salary
from employees
where salary >= any(3000, 8000, 5000);

-- [all] 급여가 3000이상이고 8000이상이고 5000이상인 사람의 사번, 이름, 급여
select employee_id, first_name, salary
from employees
where salary >= 3000 and salary >= 8000 and salary >= 5000;

select employee_id, first_name, salary
from employees
where salary >= all(3000, 8000, 5000);

-- [시간] 현재 시간, 3일 후, 3시간 후, 3분 후, 3초 후
select sysdate, to_char(sysdate,'yy.mm.dd hh24:mi:ss') "현재 시간",
to_char(sysdate+3,'yy.mm.dd hh24:mi:ss') "3일 후",
to_char(sysdate + 3/24,'yy.mm.dd hh24:mi:ss') "3시간 후",
to_char(sysdate + 3/24/60,'yy.mm.dd hh24:mi:ss') "3분 후",
to_char(sysdate + 3/24/60/60,'yy.mm.dd hh24:mi:ss') "3초 후"
from dual;

-- [like] 이름이 S로 시작하는 사원의 사번, 이름
select employee_id, first_name
from employees
where first_name like 'S%';

-- [like] 이름에 e를 포함하는 사원의 사번, 이름
select employee_id, first_name
from employees
where first_name like '%e%';

-- [like] 이름이 y로 끝나는 사람의 사번, 이름
select employee_id, first_name
from employees
where first_name like '%y';

-- [like] 이름에서 끝에서 세 번쨰가 e인 사원의 사번, 이름
select employee_id, first_name
from employees
where first_name like '%e__';

-- [!=/^=/<>] 부서번호가 50이 아닌 사원의 사번, 이름, 부서번호
select employee_id, first_name, department_id
from employees
where department_id != 50;

select employee_id, first_name, department_id
from employees
where department_id ^= 50;

select employee_id, first_name, department_id
from employees
where department_id <> 50;

-- [order by] 모든 사원의 사번, 이름, 급여
-- 단, 급여순 정렬
select employee_id, first_name, salary
from employees
order by salary desc;

-- [order by] 부서번호, 사번, 이름, 급여
-- 부서별 + 급여순으로 정렬
select department_id, first_name, salary
from employees
order by department_id, salary desc;

-- [order by/alias] 부서번호, 사번, 이름, 급여
-- 부서별 + 급여순으로 정렬  *별칭 이용
select department_id did, first_name, salary sal
from employees
order by did, sal desc;

-- [종합문제] 근무도시가 'Seattle'인 사원의 사번, 이름, 부서번호

-- [Locations] … 'Location_id' … [Departments] … 'Department_id' … [Employees]
-- 1) locations 테이블에서 city가 Seattle인 location_id를 검색 : Seattle의 location_id=1700
select location_id, city
from locations
where city='Seattle';
-- 2) departments 테이블에서 location_id가 1700인 department_id를 검색 : 80
select department_id
from departments
where location_id = 1700;
-- 3) employees 테이블에서 department_id가 80인 사원의 사번, 이름, 부서번호를 검색
select employee_id, first_name, department_id
from employees
where department_id in(10,90,110,190);


------------------------------------------------ <조별 문제 풀이> ------------------------------------------------
-- Q1. 관리자 ID가 124번이며, 급여가 2500 이상 3500 미만인 사원의 (이름, 급여, 관리자 ID)를 출력하세요.
-- 단, 급여가 높은 순으로 정렬
select last_name, salary, manager_id
from employees
where manager_id=124 and salary>=2500 and salary <3500
order by salary desc;

-- Q2. 관리자 ID가 100이고 이름의 2번째가 'o'인 사원의 (이름, 커미션, 커미션 적용 후 급여)를 출력하세요.  *커미션이 null인 경우 0으로 대체하여 계산 및 출력
-- 단, 커미션 적용 후 급여가 높은 순으로 정렬
select last_name, nvl(commission_pct,0), salary+salary*nvl(commission_pct,0)
from employees
where manager_id=100
order by salary+salary*nvl(commission_pct,0) desc;

-- Q3. 관리자가 지정되지 않은 사원의 (이름)을 출력하세요. *이름 형식 : [성 이름]
select first_name || ' ' || last_name
from employees
where manager_id is null;

-- Q4. 최대 급여와 최소 임금의 차가 5000 이상인 직급의 (이름, 최대 급여, 최소 급여, 급여의 차이)을 출력하세요.
-- 단, 급여의 차이가 큰 순으로 정렬하세요.
select job_title, max_salary, min_salary, max_salary-min_salary
from jobs
where (max_salary-min_salary) >= 5000
order by (max_salary-min_salary) desc;

-- Q5. 현재 시간, 3일 후, 3시간 후, 3분 후, 3초 후를 출력하세요 *각각에 별칭 지정(현재 시간, 3일 후 ~)
-- 단, 출력 형식은 '년도-월-일 시:분:초'
select sysdate, to_char(sysdate,'yy.mm.dd hh24:mi:ss') "현재 시간",
to_char(sysdate+3,'yy.mm.dd hh24:mi:ss') "3일 후",
to_char(sysdate + 3/24,'yy.mm.dd hh24:mi:ss') "3시간 후",
to_char(sysdate + 3/24/60,'yy.mm.dd hh24:mi:ss') "3분 후",
to_char(sysdate + 3/24/60/60,'yy.mm.dd hh24:mi:ss') "3초 후"
from dual;

