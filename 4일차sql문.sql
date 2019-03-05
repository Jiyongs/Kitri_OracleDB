-- ************************** 4일차 **************************
-- 2019.02.25

-- <숫자 함수>
-- [round]
select 1234, 5678, round(1234.5438), round(1234.5438,0),
         round(1234.5438,1), round(1234.5438,-1),
         round(1234.5438,3), round(1234.5438,-3)
from dual;

-- 사원의 사번, 이름, 급여, 커미션포함급여
-- 커미션포함급여는 100의 자리수로 표현(반올림)
select employee_id, last_name, salary, salary+salary*nvl(commission_pct,0), round(salary+salary*nvl(commission_pct,0),-2)
from employees;

-- [trunc]
select 1234, 5678, trunc(1234.5438), trunc(1234.5438,0),
         trunc(1234.5438,1), trunc(1234.5438,-1),
         trunc(1234.5438,3), trunc(1234.5438,-3)
from dual;

-- [floor]
select 1234, 5678, floor(1234.5438)
from dual;

-- [mod]
select mod(5,3)
from dual;

-- [abs]
select abs(5), abs(-5), abs(+5)
from dual;

-- <문자 함수>

-- [lower/upper/initcap/length]
select 'kiTRi', lower('kiTRi'), upper('kiTRi'), initcap('kiTRi'), length('kiTRi')
from dual;

-- [concat] 풀네임 출력하기 ('성 이름' 형식으로)
select employee_id, first_name, last_name,
         concat(first_name || ' ', last_name)
from employees;

select employee_id, first_name, last_name,
         concat(concat(first_name, ' '), last_name)
from employees;

-- [substr] 문자의 2번째부터 6개의 문자를 반환하기
select 'hello oracle !!!', substr('hello oracle !!!', 2, 6)
from dual;

-- [instr] 문자에서 o가 처음 나오는 절대 위치, 6번째부터 o
select 'hello oracle !!!', instr('hello oracle !!!', 'o'), instr('hello oracle !!!', 'o', 6 )
from dual;

-- ###
-- [substr/instr] a-b에서 '-'를 기준으로 a와 b로 나누어 출력하기
-- 단, a 또는 b가 늘어나도 결과가 변하지 않아야 함
select '123-456' zipcode, substr('123-456', 1, instr('123-456', '-')-1) zip1, substr('123-456', instr('123-456', '-')+1) zip2
from dual;

-- <날짜 함수>

-- [to_char]
select sysdate, sysdate + 3, sysdate - 3, to_char(sysdate + 3 / 24, 'yyyy-mm-dd hh24:mi:ss')
from dual;

-- [months_between] 현재 날짜와 70일 후의 개월 차이를 출력하기
select sysdate, months_between(sysdate, sysdate + 70)
from dual;

-- [next_day] 현재 날짜로부터 다음 일요일, 화요일 날짜를 출력하기
select sysdate, next_day(sysdate, 1), next_day(sysdate, 3)
from dual;

-- [add_months/last_day] 
select sysdate, add_months(sysdate, 2), last_day(sysdate)
from dual;

-- yy : 년도 중 끝 두 자리 / mm : 월 / mon : 영어 달의 약어 / month : 영어 달의 풀네임
select sysdate, to_char(sysdate, 'yyyy yy mm mon month')
from dual;

-- w : 한 달 중 몇 주차 / ww : 1년 중 몇 주차
select sysdate, to_char(sysdate, 'w') || '주차', to_char(sysdate, 'ww')
from dual;

-- d : 일주일 중 몇 번째 날 / dd : 한달중 몇 번째날 / ddd : 1년 중 몇번째 날 / dy : 영어 요일의 약어 / day : 영어 요일의 풀네임
select sysdate, to_char(sysdate, 'd dd ddd dy day')
from dual;

-- pm hh : 오후 기준 시간 / hh24 : 24시간 기준 시간 / mi : 분 / ss : 초
select sysdate, to_char(sysdate, 'pm hh hh24 mi  ss')
from dual;

-- 년도를 기준으로 반올림
select to_char(sysdate, 'yyyy.mm.dd hh24:mi:ss'),
        to_char(round(sysdate), 'yyyy.mm.dd hh24:mi:ss')
from dual;

-- 반올림하여 일, 월, 년도, 시간, 분까지 표현
select to_char(sysdate, 'yyyy.mm.dd hh24:mi:ss'),
        to_char(round(sysdate, 'dd'), 'yyyy.mm.dd hh24:mi:ss'),
        to_char(round(sysdate, 'mm'), 'yyyy.mm.dd hh24:mi:ss'),
        to_char(round(sysdate, 'yy'), 'yyyy.mm.dd hh24:mi:ss'),
        to_char(round(sysdate, 'hh'), 'yyyy.mm.dd hh24:mi:ss'),
        to_char(round(sysdate, 'mi'), 'yyyy.mm.dd hh24:mi:ss')
from dual
union
-- 일, 월, 년도, 시간, 분까지 잘라서 표현
select to_char(sysdate, 'yyyy.mm.dd hh24:mi:ss'),
        to_char(trunc(sysdate, 'dd'), 'yyyy.mm.dd hh24:mi:ss'),
        to_char(trunc(sysdate, 'mm'), 'yyyy.mm.dd hh24:mi:ss'),
        to_char(trunc(sysdate, 'yy'), 'yyyy.mm.dd hh24:mi:ss'),
        to_char(trunc(sysdate, 'hh'), 'yyyy.mm.dd hh24:mi:ss'),
        to_char(trunc(sysdate, 'mi'), 'yyyy.mm.dd hh24:mi:ss')
from dual;

-- <변환 함수>
-- [자동 형변환] 문자 3과 숫자 5를 더하기 *결과 : 8
select '3' + 5
from dual;

-- 문자 '123,456.98'과 3 더하기 *결과 : 오류
select  '123,456.98' + 3
from dual;

-- [명시적 형변환] 숫자->문자
-- 단, 소수점 2째 자리까지 반올림하고, 천의 자리마다 , 를 표시
-- ***,***,***.** 형식으로 뽑되, 무효한 숫자는 0으로 채움
select 1123456.789, to_char(1123456.789, '000,000,000.00')
from dual;

-- 단, 소수점 2째 자리까지 반올림하고, 천의 자리마다 , 를 표시
-- $***,***,***.** 형식으로 뽑되, 무효한 숫자는 비워둠
select 1123456.789, to_char(1123456.789, '$999,999,999.99')
from dual;

-- [명시적 형변환] 문자->숫자
-- 문자 '123,456.98'과 3 더하기 *결과 :  123459.98
select  to_number('123,456.98', '000000.00') + 3
from dual;

select sysdate, to_char(sysdate, 'yy.mm.dd'),
                    to_char(sysdate, 'am hh:mi:ss'),
                    to_char(sysdate, 'hh24:mi:ss')
from dual;

select to_char(to_date('200202','yyyymm'),'yyyy/mm/dd hh24:mi:ss') 
    from dual;

-- ###
-- 20190225142154 (숫자) >> 날짜 >> 3일후
-- 단, '2019.02.25 14:21:54' 형식으로 출력 
-- [step1. 숫자->문자]
select to_char(20190225142154, '00000000000000')
from dual;

-- [step2. 문자->날짜]
select to_date(to_char(20190225142154, '00000000000000'), 'yyyymmdd hh24miss')+3
from dual;

-- [step3. 날짜->원하는형태의 문자 *시분초까지]
select to_char(to_date(to_char(20190225142154, '00000000000000'), 'yyyymmddhh24miss') +3, 'yyyy.mm.dd hh24:mi:ss') 
from dual;

-- <다양한 함수>
--[nvl2]
select commission_pct, nvl(commission_pct, 0), nvl2(commission_pct, 1, 0)
from employees;

-- [case]
-- 연봉 등급
-- 급여가 4000 미만인 사원은 저연봉
--           10000 미만인 사원은 평균연봉
--           10000 이상인 사원은 고연봉
-- 사번, 이름, 급여 연봉등급
select employee_id, first_name, salary,
        case
            when salary < 4000 then '저연봉'
            when salary < 10000 then '평균연봉'
            else '고연봉'
        end
from employees
order by salary desc;

-- 사원 구분
-- 1980년도 입사 : 임원
-- 1990년도 입사 : 평사원
-- 2000년도 입사 : 신입사원
-- 사번, 이름, 입사일, 사원구분
select employee_id, first_name, hire_date,
        case
            when to_number(to_char(hire_date, 'yyyy')) <1990 then '임원'
            when to_number(to_char(hire_date, 'yyyy')) < 2000 then '평사원'
            else '신입사원'
        end
from employees
order by hire_date;

-- to_char(날짜, 'yyyy')에 산술 연산자로 계산 O
-- to_char(날짜, 'yyyy')에 비교 연산자로 계산 X -> to_number()로 문자를 숫자로 변환해야 함
select employee_id, first_name, hire_date,
        case
            when to_char(hire_date, 'yyyy')+0 <1990 then '임원'
            when to_char(hire_date, 'yyyy')+0 < 2000 then '평사원'
            else '신입사원'
        end
from employees
order by hire_date;

select employee_id, first_name, hire_date,
        case
            when to_char(trunc(hire_date, 'yyyy'),'yyyy') <1990 then '임원'
            when to_char(hire_date, 'yyyy')+0 < 2000 then '평사원'
            else '신입사원'
        end
from employees
order by hire_date;

-- [ASCII] 외울 것!!
-- '0' - 48 / 'A' - 65 / 'a' - 97
-- 
select ascii('0'), ascii('A'), ascii('a')
from dual;

-- [ASCII] 문자열의 비교 연산자 연산 가능 -> 문자열의 ASCII 코드 값으로 비교함!
select
        case when 'a' < 'b' then '작다'
                else '크다'
        end
from dual;

select
        case when 'abc' < 'acd' then '작다'
                else '크다'
        end
from dual;

------------------------------------------------ <조별 문제 풀이> ------------------------------------------------

--  Q1. 각 사원의 이름, 부서번호, 급여, 급여별 레벨을 출력하기
-- 단, 레벨의 종류와 기준은 Job_Grades 테이블을 참고한다.
-- 단, 레벨을 기준으로 오름차순 정렬한다.
-- 단, 레벨에 별칭을 준다(급여별 레벨).
select *
from job_grades;

select last_name, department_id, salary,
        case when salary <2999 then 'A'
                when salary <5999 then 'B'
                when salary <9999 then 'C'
                when salary <14999 then 'D'
                when salary <24999 then 'E'
                else 'F'
        end as "급여별 레벨"
from employees
order by "급여별 레벨";

--  Q2. 강의 A가 2019년02월20일부터 2019년07월16일까지 실행될 때, 총 기간이 며칠인지 구하시오
-- 단, 날짜는 20190220, 20190716 형태의 숫자로부터 시작한다.
-- 단, 주말도 포함한다
-- 단, 별칭은 수강기간
select to_date(to_char(20190716, '00000000'),'yyyymmdd') - to_date(to_char(20190220, '00000000'),'yyyymmdd') + 1 as 수강기간
from dual;

-- 김의연
-- Q3. 부서명(department_name)의 마지막 글자를 제외하고 출력하라.
-- 부서명, 마지막글자를 제외한 부서명 출력 및 정렬
select department_name, substr(department_name, 1, length(department_name)-1)
from departments;

-- Q4. emp테이블에서 sal이 3000미만 이면 c등급, 3000에서 3900이하 B등급
-- 4000 이상이면 A등급으로 등급을 나타내어라
-- 사번, 이름(풀네임), 급여, 등급별로 정렬)
select employee_id, concat(concat(first_name, ' '), last_name), salary,
        case when salary < 3000 then 'C등급'
                when salary <= 3900 then 'B등급'
                else 'A등급'
        end as 등급
from employees
order by 등급;

-- 박광규
-- Q5. 사원들의 '이름 성'(concat함수 사용), 연봉, 연봉*커미션 값
-- 단, 커미션이 있을 경우 일괄적으로 5%적용, 없을 경우 0으로 일괄 적용할 것
-- < || 사용 >
select concat(first_name || ' ', last_name), salary, salary+salary*nvl2(commission_pct, 5, 0)
from employees;
-- < 중첩 함수 사용>
select concat(concat(first_name, ' '), last_name), salary, salary+salary*nvl2(commission_pct, 5, 0)
from employees;

-- 노정탁
-- Q6. 사번,이름, job_id, 근무상황(별칭)
--미국에서 일하는 부서일 경우 "본사근무"
--캐나다에서 일하는 부서일 경우 "파견근무"
--영국에서 일하는 부서일 경우 "해외출장"
--본사, 파견, 해외 순으로 정렬
-- <나라와 location_id 출력>
select country_id, location_id
from locations;
-- <부서번호와 location_id출력>
select department_id, location_id
from departments;
-- <부서번호별 나라>
-- 10, 50, 60, 90, 110, 190 us
-- 20 ca
-- 80 uk
select employee_id, job_id,
        case when department_id = 20 then '파견근무'
                when department_id = 80 then '해외출장'
                else '본사근무'
        end as 근무상황
from employees
order by 근무상황;
        
--Q7. 아래와 같이 출력되게 코드를 작성하시오.
--'풀네임'의 부서번호와 부서코드는 '90''AD'이다. 
--부서를 명시할때는 job_id의 앞 두글자(ex)sST,IT,AD)로 명시. 별칭 부서번호와 코드
select concat(concat(concat(concat(concat(concat(first_name,' '), last_name), '의 부서번호와 부서코드는 '), department_id), substr(job_id,1,2)),'이다.')
from employees;

select concat(concat(first_name, ' '), last_name) || '의 부서번호와 부서코드는 ' || department_id || substr(job_id,1,2) || '이다.'
from employees;

--이종영 
--Q8. 직책이름, 최대급여, 직무별 소득분류를 출력하시오.-
--이때 최대급여가 10000이하인 직무는 저소득,
--10000은 초과하지만 20000이하인 직무는 중간소득,
--20000을 초과하는 직무는 고소득으로 정하여 직책분류를 만들고, 직책이름을 기준으로 정렬하시오.
--이때, 직책이름은 모두 대문자로 표기하시오.
 select upper(job_title), max_salary, 
        case when max_salary <= 10000 then '저소득'
               when max_salary <= 20000 then '중간소득'
               else '고소득'
        end as "직무별 소득분류"
from jobs
order by job_title;

--Q9. 오늘날짜를 yymmdd형식으로 문자로 바꾼후 숫자로 다시바꿔 123456을 더한값을 출력하라.
select to_number(to_char(sysdate, 'yymmdd'), 999999) + 123456
from dual;


--김형섭
-- Q10. 시스템시간기준 144일후를 yyyy mm dd day 형태로 나타내주세요. 별칭은 "수료일"
select to_char(to_date(to_char(sysdate, 'yyyymmdd'),'yyyymmdd') + 144, 'yyyymmdd day') as 수료일
from dual;

-- Q11. 2019/07/21 은 2019년도로부터 몇 번째 날일까?
select to_char(to_date('20190721', 'yyyymmdd'),'ddd')
from dual;
