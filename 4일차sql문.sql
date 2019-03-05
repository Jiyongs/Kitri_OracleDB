-- ************************** 4���� **************************
-- 2019.02.25

-- <���� �Լ�>
-- [round]
select 1234, 5678, round(1234.5438), round(1234.5438,0),
         round(1234.5438,1), round(1234.5438,-1),
         round(1234.5438,3), round(1234.5438,-3)
from dual;

-- ����� ���, �̸�, �޿�, Ŀ�̼����Ա޿�
-- Ŀ�̼����Ա޿��� 100�� �ڸ����� ǥ��(�ݿø�)
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

-- <���� �Լ�>

-- [lower/upper/initcap/length]
select 'kiTRi', lower('kiTRi'), upper('kiTRi'), initcap('kiTRi'), length('kiTRi')
from dual;

-- [concat] Ǯ���� ����ϱ� ('�� �̸�' ��������)
select employee_id, first_name, last_name,
         concat(first_name || ' ', last_name)
from employees;

select employee_id, first_name, last_name,
         concat(concat(first_name, ' '), last_name)
from employees;

-- [substr] ������ 2��°���� 6���� ���ڸ� ��ȯ�ϱ�
select 'hello oracle !!!', substr('hello oracle !!!', 2, 6)
from dual;

-- [instr] ���ڿ��� o�� ó�� ������ ���� ��ġ, 6��°���� o
select 'hello oracle !!!', instr('hello oracle !!!', 'o'), instr('hello oracle !!!', 'o', 6 )
from dual;

-- ###
-- [substr/instr] a-b���� '-'�� �������� a�� b�� ������ ����ϱ�
-- ��, a �Ǵ� b�� �þ�� ����� ������ �ʾƾ� ��
select '123-456' zipcode, substr('123-456', 1, instr('123-456', '-')-1) zip1, substr('123-456', instr('123-456', '-')+1) zip2
from dual;

-- <��¥ �Լ�>

-- [to_char]
select sysdate, sysdate + 3, sysdate - 3, to_char(sysdate + 3 / 24, 'yyyy-mm-dd hh24:mi:ss')
from dual;

-- [months_between] ���� ��¥�� 70�� ���� ���� ���̸� ����ϱ�
select sysdate, months_between(sysdate, sysdate + 70)
from dual;

-- [next_day] ���� ��¥�κ��� ���� �Ͽ���, ȭ���� ��¥�� ����ϱ�
select sysdate, next_day(sysdate, 1), next_day(sysdate, 3)
from dual;

-- [add_months/last_day] 
select sysdate, add_months(sysdate, 2), last_day(sysdate)
from dual;

-- yy : �⵵ �� �� �� �ڸ� / mm : �� / mon : ���� ���� ��� / month : ���� ���� Ǯ����
select sysdate, to_char(sysdate, 'yyyy yy mm mon month')
from dual;

-- w : �� �� �� �� ���� / ww : 1�� �� �� ����
select sysdate, to_char(sysdate, 'w') || '����', to_char(sysdate, 'ww')
from dual;

-- d : ������ �� �� ��° �� / dd : �Ѵ��� �� ��°�� / ddd : 1�� �� ���° �� / dy : ���� ������ ��� / day : ���� ������ Ǯ����
select sysdate, to_char(sysdate, 'd dd ddd dy day')
from dual;

-- pm hh : ���� ���� �ð� / hh24 : 24�ð� ���� �ð� / mi : �� / ss : ��
select sysdate, to_char(sysdate, 'pm hh hh24 mi  ss')
from dual;

-- �⵵�� �������� �ݿø�
select to_char(sysdate, 'yyyy.mm.dd hh24:mi:ss'),
        to_char(round(sysdate), 'yyyy.mm.dd hh24:mi:ss')
from dual;

-- �ݿø��Ͽ� ��, ��, �⵵, �ð�, �б��� ǥ��
select to_char(sysdate, 'yyyy.mm.dd hh24:mi:ss'),
        to_char(round(sysdate, 'dd'), 'yyyy.mm.dd hh24:mi:ss'),
        to_char(round(sysdate, 'mm'), 'yyyy.mm.dd hh24:mi:ss'),
        to_char(round(sysdate, 'yy'), 'yyyy.mm.dd hh24:mi:ss'),
        to_char(round(sysdate, 'hh'), 'yyyy.mm.dd hh24:mi:ss'),
        to_char(round(sysdate, 'mi'), 'yyyy.mm.dd hh24:mi:ss')
from dual
union
-- ��, ��, �⵵, �ð�, �б��� �߶� ǥ��
select to_char(sysdate, 'yyyy.mm.dd hh24:mi:ss'),
        to_char(trunc(sysdate, 'dd'), 'yyyy.mm.dd hh24:mi:ss'),
        to_char(trunc(sysdate, 'mm'), 'yyyy.mm.dd hh24:mi:ss'),
        to_char(trunc(sysdate, 'yy'), 'yyyy.mm.dd hh24:mi:ss'),
        to_char(trunc(sysdate, 'hh'), 'yyyy.mm.dd hh24:mi:ss'),
        to_char(trunc(sysdate, 'mi'), 'yyyy.mm.dd hh24:mi:ss')
from dual;

-- <��ȯ �Լ�>
-- [�ڵ� ����ȯ] ���� 3�� ���� 5�� ���ϱ� *��� : 8
select '3' + 5
from dual;

-- ���� '123,456.98'�� 3 ���ϱ� *��� : ����
select  '123,456.98' + 3
from dual;

-- [����� ����ȯ] ����->����
-- ��, �Ҽ��� 2° �ڸ����� �ݿø��ϰ�, õ�� �ڸ����� , �� ǥ��
-- ***,***,***.** �������� �̵�, ��ȿ�� ���ڴ� 0���� ä��
select 1123456.789, to_char(1123456.789, '000,000,000.00')
from dual;

-- ��, �Ҽ��� 2° �ڸ����� �ݿø��ϰ�, õ�� �ڸ����� , �� ǥ��
-- $***,***,***.** �������� �̵�, ��ȿ�� ���ڴ� �����
select 1123456.789, to_char(1123456.789, '$999,999,999.99')
from dual;

-- [����� ����ȯ] ����->����
-- ���� '123,456.98'�� 3 ���ϱ� *��� :  123459.98
select  to_number('123,456.98', '000000.00') + 3
from dual;

select sysdate, to_char(sysdate, 'yy.mm.dd'),
                    to_char(sysdate, 'am hh:mi:ss'),
                    to_char(sysdate, 'hh24:mi:ss')
from dual;

select to_char(to_date('200202','yyyymm'),'yyyy/mm/dd hh24:mi:ss') 
    from dual;

-- ###
-- 20190225142154 (����) >> ��¥ >> 3����
-- ��, '2019.02.25 14:21:54' �������� ��� 
-- [step1. ����->����]
select to_char(20190225142154, '00000000000000')
from dual;

-- [step2. ����->��¥]
select to_date(to_char(20190225142154, '00000000000000'), 'yyyymmdd hh24miss')+3
from dual;

-- [step3. ��¥->���ϴ������� ���� *�ú��ʱ���]
select to_char(to_date(to_char(20190225142154, '00000000000000'), 'yyyymmddhh24miss') +3, 'yyyy.mm.dd hh24:mi:ss') 
from dual;

-- <�پ��� �Լ�>
--[nvl2]
select commission_pct, nvl(commission_pct, 0), nvl2(commission_pct, 1, 0)
from employees;

-- [case]
-- ���� ���
-- �޿��� 4000 �̸��� ����� ������
--           10000 �̸��� ����� ��տ���
--           10000 �̻��� ����� ����
-- ���, �̸�, �޿� �������
select employee_id, first_name, salary,
        case
            when salary < 4000 then '������'
            when salary < 10000 then '��տ���'
            else '����'
        end
from employees
order by salary desc;

-- ��� ����
-- 1980�⵵ �Ի� : �ӿ�
-- 1990�⵵ �Ի� : ����
-- 2000�⵵ �Ի� : ���Ի��
-- ���, �̸�, �Ի���, �������
select employee_id, first_name, hire_date,
        case
            when to_number(to_char(hire_date, 'yyyy')) <1990 then '�ӿ�'
            when to_number(to_char(hire_date, 'yyyy')) < 2000 then '����'
            else '���Ի��'
        end
from employees
order by hire_date;

-- to_char(��¥, 'yyyy')�� ��� �����ڷ� ��� O
-- to_char(��¥, 'yyyy')�� �� �����ڷ� ��� X -> to_number()�� ���ڸ� ���ڷ� ��ȯ�ؾ� ��
select employee_id, first_name, hire_date,
        case
            when to_char(hire_date, 'yyyy')+0 <1990 then '�ӿ�'
            when to_char(hire_date, 'yyyy')+0 < 2000 then '����'
            else '���Ի��'
        end
from employees
order by hire_date;

select employee_id, first_name, hire_date,
        case
            when to_char(trunc(hire_date, 'yyyy'),'yyyy') <1990 then '�ӿ�'
            when to_char(hire_date, 'yyyy')+0 < 2000 then '����'
            else '���Ի��'
        end
from employees
order by hire_date;

-- [ASCII] �ܿ� ��!!
-- '0' - 48 / 'A' - 65 / 'a' - 97
-- 
select ascii('0'), ascii('A'), ascii('a')
from dual;

-- [ASCII] ���ڿ��� �� ������ ���� ���� -> ���ڿ��� ASCII �ڵ� ������ ����!
select
        case when 'a' < 'b' then '�۴�'
                else 'ũ��'
        end
from dual;

select
        case when 'abc' < 'acd' then '�۴�'
                else 'ũ��'
        end
from dual;

------------------------------------------------ <���� ���� Ǯ��> ------------------------------------------------

--  Q1. �� ����� �̸�, �μ���ȣ, �޿�, �޿��� ������ ����ϱ�
-- ��, ������ ������ ������ Job_Grades ���̺��� �����Ѵ�.
-- ��, ������ �������� �������� �����Ѵ�.
-- ��, ������ ��Ī�� �ش�(�޿��� ����).
select *
from job_grades;

select last_name, department_id, salary,
        case when salary <2999 then 'A'
                when salary <5999 then 'B'
                when salary <9999 then 'C'
                when salary <14999 then 'D'
                when salary <24999 then 'E'
                else 'F'
        end as "�޿��� ����"
from employees
order by "�޿��� ����";

--  Q2. ���� A�� 2019��02��20�Ϻ��� 2019��07��16�ϱ��� ����� ��, �� �Ⱓ�� ��ĥ���� ���Ͻÿ�
-- ��, ��¥�� 20190220, 20190716 ������ ���ڷκ��� �����Ѵ�.
-- ��, �ָ��� �����Ѵ�
-- ��, ��Ī�� �����Ⱓ
select to_date(to_char(20190716, '00000000'),'yyyymmdd') - to_date(to_char(20190220, '00000000'),'yyyymmdd') + 1 as �����Ⱓ
from dual;

-- ���ǿ�
-- Q3. �μ���(department_name)�� ������ ���ڸ� �����ϰ� ����϶�.
-- �μ���, ���������ڸ� ������ �μ��� ��� �� ����
select department_name, substr(department_name, 1, length(department_name)-1)
from departments;

-- Q4. emp���̺��� sal�� 3000�̸� �̸� c���, 3000���� 3900���� B���
-- 4000 �̻��̸� A������� ����� ��Ÿ�����
-- ���, �̸�(Ǯ����), �޿�, ��޺��� ����)
select employee_id, concat(concat(first_name, ' '), last_name), salary,
        case when salary < 3000 then 'C���'
                when salary <= 3900 then 'B���'
                else 'A���'
        end as ���
from employees
order by ���;

-- �ڱ���
-- Q5. ������� '�̸� ��'(concat�Լ� ���), ����, ����*Ŀ�̼� ��
-- ��, Ŀ�̼��� ���� ��� �ϰ������� 5%����, ���� ��� 0���� �ϰ� ������ ��
-- < || ��� >
select concat(first_name || ' ', last_name), salary, salary+salary*nvl2(commission_pct, 5, 0)
from employees;
-- < ��ø �Լ� ���>
select concat(concat(first_name, ' '), last_name), salary, salary+salary*nvl2(commission_pct, 5, 0)
from employees;

-- ����Ź
-- Q6. ���,�̸�, job_id, �ٹ���Ȳ(��Ī)
--�̱����� ���ϴ� �μ��� ��� "����ٹ�"
--ĳ���ٿ��� ���ϴ� �μ��� ��� "�İ߱ٹ�"
--�������� ���ϴ� �μ��� ��� "�ؿ�����"
--����, �İ�, �ؿ� ������ ����
-- <����� location_id ���>
select country_id, location_id
from locations;
-- <�μ���ȣ�� location_id���>
select department_id, location_id
from departments;
-- <�μ���ȣ�� ����>
-- 10, 50, 60, 90, 110, 190 us
-- 20 ca
-- 80 uk
select employee_id, job_id,
        case when department_id = 20 then '�İ߱ٹ�'
                when department_id = 80 then '�ؿ�����'
                else '����ٹ�'
        end as �ٹ���Ȳ
from employees
order by �ٹ���Ȳ;
        
--Q7. �Ʒ��� ���� ��µǰ� �ڵ带 �ۼ��Ͻÿ�.
--'Ǯ����'�� �μ���ȣ�� �μ��ڵ�� '90''AD'�̴�. 
--�μ��� ����Ҷ��� job_id�� �� �α���(ex)sST,IT,AD)�� ���. ��Ī �μ���ȣ�� �ڵ�
select concat(concat(concat(concat(concat(concat(first_name,' '), last_name), '�� �μ���ȣ�� �μ��ڵ�� '), department_id), substr(job_id,1,2)),'�̴�.')
from employees;

select concat(concat(first_name, ' '), last_name) || '�� �μ���ȣ�� �μ��ڵ�� ' || department_id || substr(job_id,1,2) || '�̴�.'
from employees;

--������ 
--Q8. ��å�̸�, �ִ�޿�, ������ �ҵ�з��� ����Ͻÿ�.-
--�̶� �ִ�޿��� 10000������ ������ ���ҵ�,
--10000�� �ʰ������� 20000������ ������ �߰��ҵ�,
--20000�� �ʰ��ϴ� ������ ��ҵ����� ���Ͽ� ��å�з��� �����, ��å�̸��� �������� �����Ͻÿ�.
--�̶�, ��å�̸��� ��� �빮�ڷ� ǥ���Ͻÿ�.
 select upper(job_title), max_salary, 
        case when max_salary <= 10000 then '���ҵ�'
               when max_salary <= 20000 then '�߰��ҵ�'
               else '��ҵ�'
        end as "������ �ҵ�з�"
from jobs
order by job_title;

--Q9. ���ó�¥�� yymmdd�������� ���ڷ� �ٲ��� ���ڷ� �ٽùٲ� 123456�� ���Ѱ��� ����϶�.
select to_number(to_char(sysdate, 'yymmdd'), 999999) + 123456
from dual;


--������
-- Q10. �ý��۽ð����� 144���ĸ� yyyy mm dd day ���·� ��Ÿ���ּ���. ��Ī�� "������"
select to_char(to_date(to_char(sysdate, 'yyyymmdd'),'yyyymmdd') + 144, 'yyyymmdd day') as ������
from dual;

-- Q11. 2019/07/21 �� 2019�⵵�κ��� �� ��° ���ϱ�?
select to_char(to_date('20190721', 'yyyymmdd'),'ddd')
from dual;
