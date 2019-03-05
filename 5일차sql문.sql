-- ************************** 5���� **************************
-- 2019.02.26

-- <�Լ�>
-- [decode]
-- ���, �̸�, �μ���ȣ, ��������
-- ��������
-- �μ���ȣ 60�̸� ������
--              90�̸� �ӿ���
--              ������ �񰳹���
select employee_id, first_name, department_id,
        decode(department_id, 60, '������',
                                        90, '�ӿ���',
                                             '�񰳹���') as ��������
from employees
order by department_id;

-- <�׷� �Լ�>
-- [count/
-- ȸ���� �� ��� ��, �޿�����, �޿����, �ְ�޿�, �����޿�
select count(employee_id), sum(salary), avg(salary), max(salary), min(salary)
from employees;

-- ��ձ޿����� ���� �޴� ����� ���, �̸�, �޿�
select employee_id, first_name, salary
from employees
where salary > (select avg(salary) from employees);

-- <Join>

-- cartesian join(=cross join)
select *
from employees, departments;

-- equi join (=natural join)
-- [join] ���, �̸�, �μ���ȣ, �μ��̸�
-- employees, departments (���� : department_id)
-- ���̺� ���� - 1���� ���� ���� �ʼ���!
select e.employee_id, e.first_name, d.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
order by e.employee_id;

-- [join] 'seattle'�� �ٹ��ϴ� ����� ���, �̸�, �μ��̸�, �����̸� (���� 3��)
-- ������ ���ǿ��� �� �� lower�� ���� ����, �˻��Ϸ��� ��(������)�� �Է°����� �޾��� ���� ����ϱ� ����!
select e.employee_id, e.first_name, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
            and d.location_id = l.location_id
            and lower(l.city) = lower('seattle');

-- [join] 'asia'�� �ٹ��ϴ� ����� ���, �̸�, �μ��̸�, �����̸� (���� 5��)
select employee_id, first_name, department_name, city
from employees e, departments d, locations l, countries c, regions r
where e.department_id = d.department_id
            and d.location_id = l.location_id
            and l.country_id = c.country_id
            and c.region_id = r.region_id
            and lower(r.region_name) = lower('asia');    
        
-- [join] 10, 80, 90�� �μ��� �ٹ����� ����� ���, �̸�, ��å�̸�, �μ��̸�
-- *���� �ٹ����� ����� ���ϴ� ���̹Ƿ� where���� ������ �ٿ��� e�� ���� department_id�� ����ؾ� �Ѵ�!
select e.employee_id, e.first_name, j.job_title, d.department_name
from employees e, jobs j, departments d
where e.job_id = j.job_id
            and e.department_id = d.department_id
            and e.department_id in (10, 80, 90);

-- #####
-- [join] ��� = 200�� ����� �ٹ� �̷�
-- ���, �̸�, �����å �̸�, ��úμ� �̸�, �ٹ�����(�Ҽ�2�ڸ����� �ݿø�)
-- *where���� ������ employee_id�� job_history�� ���� ����ؾ� ��!
-- ex) ����� ����� ��������� �̾ƴ޶�� ���� ��, ����� ����� employees�� ����
select e.employee_id, e.first_name, j.job_title, d.department_name
            , to_char(round(months_between(jh.end_date,jh.start_date),2), '999.99')
from employees e, job_history jh, departments d, jobs j
where e.employee_id = jh.employee_id
            and jh.department_id = d.department_id
            and jh.job_id = j.job_id
            and jh.employee_id = 200;
            
-- [self join]
-- ��� ����� �μ��̸�, ���, �̸�, �Ŵ��� ���, �Ŵ��� �̸�
-- *e : ��� ����� �� / ee : �Ŵ����� ��
-- *e.manager_id : ��� ����� �Ŵ��� ��� / ee.employee_id : ��� ����� ���
select d.department_id, e.employee_id, e.first_name, ee.employee_id, ee.first_name
from departments d, employees e, employees ee
where d.department_id = e.department_id
                and e.manager_id = ee.employee_id;

------------------------------------------------ <���� ���� Ǯ��> ------------------------------------------------
-- Q1. �̸��� 'pat'�� ����� �Ŵ����̸�, ȸ�� �ּҸ� ����ϱ�
-- ��, �ּ� ������ [����� ����� ���̸� ���� �����ּ�]
select ee.first_name, r.region_name || ' ' || c.country_name || ' ' || l.state_province || ' ' || l.city || l.street_address
from employees e, employees ee, departments d, locations l, countries c, regions r
where e.manager_id = ee.employee_id
            and lower(e.first_name) = 'pat'
            and e.department_id = d.department_id
            and d.location_id = l.location_id
            and l.country_id = c.country_id
            and c.region_id = r.region_id;
            
-- Q2. ����� 1�� �̻��� ����� ���, �̸�, �ٹ� �Ⱓ(���), ��� ��å �̸��� ����ϱ�
-- ��, ������� ����
select jh.employee_id, e.first_name, to_number(to_char(jh.end_date,'yyyy'))-to_number(to_char(jh.start_date,'yyyy')), j.job_title
from employees e, job_history jh, jobs j
where e.employee_id = jh.employee_id
            and jh.job_id = j.job_id
order by jh.employee_id;



-- ************************** 6���� **************************
-- 2019.02.27

-- ��åid = 'SA_REP'�� ����� ���, �̸�, ��å�̸�, �μ��̸�
-- ��, �μ��� ���� ��� '���߷�'
select e.employee_id, e.first_name, j.job_title, d.department_name
from employees e, departments d, jobs j
where e.job_id = j.job_id
            and d.department_id in (e.department_id, null)
            and lower(e.job_id) = lower('SA_REP');
