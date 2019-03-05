-- ************************** 2���� **************************
-- 2019.02.21
-- ��� ����� ��� ������ �˻�
select *
from employees;

-- ����� ���, �̸�(first_name), �޿��� �˻�
select employee_id, first_name, salary
from employees;

-- ȸ�翡 �����ϴ� �μ���ȣ, �μ��̸��� �˻�
select department_id, department_name
from departments;

-- [distinct] ȸ���� �μ���ȣ�� �˻�    *employees ����    *�ߺ�����
select distinct department_id
from employees;

-- [���] ����� ���̺�(dual)�� ��� ���� ����� ���
select 1+1, 10-5, 2*10, 10/3
from dual;

-- [���] ���, �̸�, �޿�, 200 �λ�� �޿��� �˻�
select employee_id, first_name, salary, salary+200
from employees;

-- [���] ���, �̸�, �޿�, Ŀ�̼����Ա޿��� �˻�  *Ŀ�̼�=null �� 0���� ó��
select employee_id, first_name, salary, salary+salary*NVL(commission_pct,0)
from employees;

-- [alias] ���, �̸�, �޿��� �˻�   *��Ī���� ���
select employee_id ���,  first_name �̸�, salary �޿�
from employees;

select employee_id as ���,  first_name as "�̸�", salary "�޿� 200"
from employees;

select employee_id ���, first_name �̸�, salary �޿�, nvl(commission_pct,0) Ŀ�̼� , salary+salary*NVL(commission_pct,0) "�λ� �� �޿�"
from employees;

-- [���Ῥ����] ���, Ǯ���� �˻�     *�̸��� �� ���̿� ���� �߰�
select employee_id ���, first_name || ' ' || last_name �̸�
from employees;

-- [���Ῥ����] "����� n���� ����� �̸��� 000�Դϴ�"�������� ��� (info)
select '����� ' || employee_id || '���� ����� �̸��� ' || first_name || ' ' || last_name || '�Դϴ�.'
from employees;

------------------------------------------------ <���� ���� Ǯ��> ------------------------------------------------
-- 1. **(�̸�)�� �����ּҴ�**�̰� �ڵ�����ȣ��**�̴�. ������ ���� ����ϱ� column�̸��� ����ó
select last_name || '�� �����ּҴ�' || email || '�̰� �ڵ�����ȣ��' || phone_number || '�̴�.' ����ó
from employees;

-- 2. **(����) **(����)�� **(����)�� **(�ּ�)�� �����ȣ�� **�̴�. ������ ���� ����ϱ� column�̸��� �����ȣ
select country_id || ' ' || state_province || '�� ' || street_address || '�� �����ּҴ� ' || postal_code || '�̴�.' �����ȣ
from locations;

-- 3. "000 ��� - �̸��� : 000@gamil.com / ��ȭ��ȣ : ***.***.****" �������� ���  *�̸��� '�̸� ��' ����
select first_name || ' ' || last_name || ' ��� - �̸��� : ' || email || '@gmail.com / ��ȭ��ȣ : ' || phone_number
from employees;

-- 4. "���� �ּ�, ���ø�, ���̸�, ����ID" �������� ����ϼ��� (Column���� '�ּ�')
select street_address || ', ' || city || ', ' || state_province || ', ' || country_id �ּ�
from locations;

-- 5."full name"�� ������ "job_id"�̸� �Ի糯¥�� "hire_date"�̴�. 
select first_name || ' ' || last_name || '�� ������ ' || job_id || '�̸� �Ի糯¥�� ' || hire_date || '�̴�.'
from employees;

-- 6. "�����ȣ - ���� - �ּ�"  ���·� ������ּ���.
select postal_code || ' - ' || city || ' - ' || street_address
from locations;

-- 7. �ͽ��� �þ�Ʋ�� ��ġ�� ������ �����ȣ�� 98199�̴�.(��Ī : Post code)
select state_province || ' ' || city || '�� ��ġ�� ������ �����ȣ�� ' || postal_code || '�̴�.' as "Post code"
from locations;

-- 8. �̸�(Ǯ����)�� �޿��� 10% �λ�Ǿ� ??�̴�. (��Ī : �޿��λ�)
select first_name || ' ' || last_name || '�� �޿��� ' || nvl(commission_pct,0)*100 || '% �λ�Ǿ�' || salary*commission_pct || '�̴�.' as �޿��λ�
from employees;

-- 9. ** ������� �޿��� ** �Դϴ�.  ��Ī = �޿� ����
select last_name || '�� �޿��� ' || salary || '�Դϴ�.' as �޿�����
from employees;

-- 10. �����ȣ�� ??�� ����� ��å�� ??�̸� �Ի����� ??, ������� ??�Դϴ�. ��Ī = ������� ����
select '�����ȣ�� ' || employee_id || '�� ����� ��å�� ' || job_id || '�̸� �Ի����� ' || start_date || ', ������� ' || end_date || '�Դϴ�.' as ������Ʈ
from job_history;


-- ************************** 3���� **************************
-- 2019.02.22

-- [where] �޿��� 5000 �̻��� ����� ���, �̸�, �޿�, �μ���ȣ
select employee_id, last_name, salary, department_id
from employees
where salary >= 5000;

-- [where] ����� 100���� ����� ���, �̸�, �μ���ȣ
select employee_id, last_name, department_id
from employees
where employee_id = 100;

-- [lower] �ٹ����ð� Seattle�� ������ ������ȣ, �����ȣ, ����
Select Location_Id, Postal_Code, City
From Locations
Where lower(city) = 'seattle';

-- [and] �޿��� 5000�̻� 10000�̸��� �޴� ����� ���, �̸�, �޿�, �μ���ȣ
select employee_id, first_name, salary, department_id
from employees
where salary>=5000 and salary<10000;

select employee_id, first_name, salary, department_id
from employees
where salary between 5000 and 9999;

-- [and] �μ���ȣ�� 50�� ����� �� �޿��� 5000�̻��� ����� ���, �̸�, �޿�, �μ���ȣ
select employee_id, first_name, salary, department_id
from employees
where department_id=50 and salary>=5000;

-- [between] �޿��� 5000�̻� 12000������ �޴� ����� ���, �̸�, �޿�, �μ���ȣ
select employee_id, first_name, salary, department_id
from employees
where salary between 5000 and 12000;

-- [is (not) null] Ŀ�̼��� �޴� ����� ���, �̸�, �޿�, Ŀ�̼����Ա޿�
select employee_id, first_name, salary, salary+salary*commission_pct
from employees
where commission_pct>0;

select employee_id, first_name, salary, salary+salary*commission_pct
from employees
where commission_pct is not null;

-- [in] �ٹ��μ��� 50, 60, 80�� ����� ���, �̸�, �μ���ȣ
select employee_id, first_name, department_id
from employees
where department_id =50 or department_id=60 or department_id = 80;

select employee_id, first_name, department_id
from employees
where department_id in (50, 60, 80);

-- [in] �ٹ��μ��� 50, 60, 80�� �ƴ� ����� ���, �̸�, �μ���ȣ
select employee_id, first_name, department_id
from employees
where department_id!=50 and department_id!=60 and department_id != 80;

select employee_id, first_name, department_id
from employees
where department_id not in (50, 60, 80);

-- [any] �޿��� 3000 �̻� �̰ų�, 8000 �̻� �̰ų�, 5000 �̻��� ����� ���, �̸�, �޿�
select employee_id, first_name, salary
from employees
where salary >= 3000 or salary >= 8000 or salary >= 5000;

select employee_id, first_name, salary
from employees
where salary >= any(3000, 8000, 5000);

-- [all] �޿��� 3000�̻��̰� 8000�̻��̰� 5000�̻��� ����� ���, �̸�, �޿�
select employee_id, first_name, salary
from employees
where salary >= 3000 and salary >= 8000 and salary >= 5000;

select employee_id, first_name, salary
from employees
where salary >= all(3000, 8000, 5000);

-- [�ð�] ���� �ð�, 3�� ��, 3�ð� ��, 3�� ��, 3�� ��
select sysdate, to_char(sysdate,'yy.mm.dd hh24:mi:ss') "���� �ð�",
to_char(sysdate+3,'yy.mm.dd hh24:mi:ss') "3�� ��",
to_char(sysdate + 3/24,'yy.mm.dd hh24:mi:ss') "3�ð� ��",
to_char(sysdate + 3/24/60,'yy.mm.dd hh24:mi:ss') "3�� ��",
to_char(sysdate + 3/24/60/60,'yy.mm.dd hh24:mi:ss') "3�� ��"
from dual;

-- [like] �̸��� S�� �����ϴ� ����� ���, �̸�
select employee_id, first_name
from employees
where first_name like 'S%';

-- [like] �̸��� e�� �����ϴ� ����� ���, �̸�
select employee_id, first_name
from employees
where first_name like '%e%';

-- [like] �̸��� y�� ������ ����� ���, �̸�
select employee_id, first_name
from employees
where first_name like '%y';

-- [like] �̸����� ������ �� ������ e�� ����� ���, �̸�
select employee_id, first_name
from employees
where first_name like '%e__';

-- [!=/^=/<>] �μ���ȣ�� 50�� �ƴ� ����� ���, �̸�, �μ���ȣ
select employee_id, first_name, department_id
from employees
where department_id != 50;

select employee_id, first_name, department_id
from employees
where department_id ^= 50;

select employee_id, first_name, department_id
from employees
where department_id <> 50;

-- [order by] ��� ����� ���, �̸�, �޿�
-- ��, �޿��� ����
select employee_id, first_name, salary
from employees
order by salary desc;

-- [order by] �μ���ȣ, ���, �̸�, �޿�
-- �μ��� + �޿������� ����
select department_id, first_name, salary
from employees
order by department_id, salary desc;

-- [order by/alias] �μ���ȣ, ���, �̸�, �޿�
-- �μ��� + �޿������� ����  *��Ī �̿�
select department_id did, first_name, salary sal
from employees
order by did, sal desc;

-- [���չ���] �ٹ����ð� 'Seattle'�� ����� ���, �̸�, �μ���ȣ

-- [Locations] �� 'Location_id' �� [Departments] �� 'Department_id' �� [Employees]
-- 1) locations ���̺��� city�� Seattle�� location_id�� �˻� : Seattle�� location_id=1700
select location_id, city
from locations
where city='Seattle';
-- 2) departments ���̺��� location_id�� 1700�� department_id�� �˻� : 80
select department_id
from departments
where location_id = 1700;
-- 3) employees ���̺��� department_id�� 80�� ����� ���, �̸�, �μ���ȣ�� �˻�
select employee_id, first_name, department_id
from employees
where department_id in(10,90,110,190);


------------------------------------------------ <���� ���� Ǯ��> ------------------------------------------------
-- Q1. ������ ID�� 124���̸�, �޿��� 2500 �̻� 3500 �̸��� ����� (�̸�, �޿�, ������ ID)�� ����ϼ���.
-- ��, �޿��� ���� ������ ����
select last_name, salary, manager_id
from employees
where manager_id=124 and salary>=2500 and salary <3500
order by salary desc;

-- Q2. ������ ID�� 100�̰� �̸��� 2��°�� 'o'�� ����� (�̸�, Ŀ�̼�, Ŀ�̼� ���� �� �޿�)�� ����ϼ���.  *Ŀ�̼��� null�� ��� 0���� ��ü�Ͽ� ��� �� ���
-- ��, Ŀ�̼� ���� �� �޿��� ���� ������ ����
select last_name, nvl(commission_pct,0), salary+salary*nvl(commission_pct,0)
from employees
where manager_id=100
order by salary+salary*nvl(commission_pct,0) desc;

-- Q3. �����ڰ� �������� ���� ����� (�̸�)�� ����ϼ���. *�̸� ���� : [�� �̸�]
select first_name || ' ' || last_name
from employees
where manager_id is null;

-- Q4. �ִ� �޿��� �ּ� �ӱ��� ���� 5000 �̻��� ������ (�̸�, �ִ� �޿�, �ּ� �޿�, �޿��� ����)�� ����ϼ���.
-- ��, �޿��� ���̰� ū ������ �����ϼ���.
select job_title, max_salary, min_salary, max_salary-min_salary
from jobs
where (max_salary-min_salary) >= 5000
order by (max_salary-min_salary) desc;

-- Q5. ���� �ð�, 3�� ��, 3�ð� ��, 3�� ��, 3�� �ĸ� ����ϼ��� *������ ��Ī ����(���� �ð�, 3�� �� ~)
-- ��, ��� ������ '�⵵-��-�� ��:��:��'
select sysdate, to_char(sysdate,'yy.mm.dd hh24:mi:ss') "���� �ð�",
to_char(sysdate+3,'yy.mm.dd hh24:mi:ss') "3�� ��",
to_char(sysdate + 3/24,'yy.mm.dd hh24:mi:ss') "3�ð� ��",
to_char(sysdate + 3/24/60,'yy.mm.dd hh24:mi:ss') "3�� ��",
to_char(sysdate + 3/24/60/60,'yy.mm.dd hh24:mi:ss') "3�� ��"
from dual;

