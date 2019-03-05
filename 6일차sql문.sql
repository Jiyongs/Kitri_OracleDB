-- ************************** 6���� **************************
-- 2019.02.27

-- [non-equi join] ��� ����� ���, �̸�, �޿�, �޿����
select e.employee_id, e.first_name, e.salary, jg.grade_level
from employees e, job_grades jg
where e.salary between jg.lowest_sal and jg.highest_sal;

-- [outer join] ��� ����� ���, �̸�, �μ���ȣ, �μ��̸�
-- �� �μ��� �������� ���(=null), �μ��̸��� '���߷���'���� ���
-- �������� �ʴ� �����Ͱ� �����ϴ� ���̺� (+)�� ���̸�, �������� �ʴ� ���鵵 ������
select e.employee_id, e.first_name, d.department_id, nvl(d.department_name,'���߷���')
from employees e, departments d
where e.department_id = d.department_id(+);

-- [outer join] ��� ����� ���, �̸�, ������, ����̸�
-- ��, ����� ���� ��� ����̸��� '����'���� ���
select e.employee_id, e.first_name, m.employee_id, nvl(m.first_name,'����')
from employees e, employees m
where e.manager_id = m.employee_id(+)
order by e.employee_id;

-- ��� ����� ���, �̸�, ������, ����̸�, �μ��̸�
-- ��, ����� ���� ��� ����̸��� '����'���� ���
-- ��, �μ��� ���� ��� �μ��̸��� '���߷���'���� ���
select e.employee_id, e.first_name, m.employee_id, nvl(m.first_name,'����'), nvl(d.department_name, '���߷���')
from employees e, employees m, departments d
where e.manager_id = m.employee_id(+)
            and e.department_id = d.department_id(+)
order by e.employee_id;

----------------------------- < ANSI Join > ------------------------------
-- [ANSI : cross join]
-- ���� ���� join (=cartecian product)
select *
from employees cross join departments;

-- [ANSI : inner join]
-- ���� ������ �̿��� join (=equi)
select e.first_name, d.department_name
from employees e inner join departments d
using(department_id)
where department_id =50;

-- [ANSI : natural join]
-- �� ���̺��� ������ �Ӽ����� ��� join
-- ������ �Ӽ����� �ϳ��� �� ����ؾ� ������ ����
-- �� ���̺��� ���� �Ӽ����� select�� ���� ����ϴ� ���� ����
select e.first_name, d.department_name
from employees e natural join departments d
where department_id =50;

-- [���� ���̺��� 3���� ���]
-- [oracle equi join]
-- 'Seattle'�� �ٹ��ϴ� ����� ���, �̸�, �μ��̸�, ����
select e.employee_id, e.first_name, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
            and d.location_id = l.location_id
            and l.city = 'Seattle';
            
-- [ansi inner join]
-- join ���Ǹ��� on�� �����
select e.employee_id, e.first_name, d.department_name, l.city
from employees e join departments d on e.department_id = d.department_id
                          join locations l on d.location_id = l.location_id
where l.city = 'Seattle';


-- ��� ����� ���, �̸�, �μ���ȣ, �μ��̸�(���߷���)
-- *����� ��������
-- [outer join]
select e.employee_id, e.first_name, e.department_id, nvl(d.department_name,'���߷���')
from employees e, departments d
where e.department_id = d.department_id(+);

-- [ANSI join]
select e.employee_id, e.first_name, e.department_id, nvl(d.department_name,'���߷���')
from employees e left outer join departments d
on e.department_id = d.department_id;

-- ��� �μ��� �ٹ��ϴ� ����� ���, �̸�(�������), �μ���ȣ, �μ��̸�
-- *�μ��� ��������
-- *��� 000�� ~�ϴ� : 000�� (+)�� ����
-- [outer join]
select e.employee_id, nvl(e.first_name,'�������'), d.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;

-- [ANSI join]
select e.employee_id, nvl(e.first_name,'�������'), d.department_id, d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id;


-- ȸ�翡 �ٹ��ϴ� ����� ���, �̸�(�������), �μ���ȣ, �μ��̸�(���߷���)
-- ��� �μ� & ��� ���
-- [outer join]
-- *����Ŭ�� �Ұ��� ... union�̳� subquery ����ؾ� ��
select e.employee_id, nvl(e.first_name,'�������'), d.department_id, nvl(d.department_name, '���߷���')
from employees e, departments d
where e.department_id(+) = d.department_id
            and e.department_id = d.department_id(+);
            
-- [ANSI join]
-- *ANSI�� ����
select e.employee_id, nvl(e.first_name,'�������'), d.department_id, nvl(d.department_name, '���߷���')
from employees e full outer join departments d
on e.department_id = d.department_id
            and e.department_id = d.department_id;

------------------------------------------------ <���� ���� Ǯ��> ------------------------------------------------
-- Q1. ��� �μ��� �ٹ��ϴ� ����� �̸�, ��å�̸�, �μ��̸�
-- ��, �μ��� �������� ���, �μ��̸��� '������'���� ���
-- ��� : 20��
select e.first_name, j.job_title, nvl(d.department_name,'������')
from employees e, jobs j, departments d
where e.job_id = j.job_id
            and e.department_id = d.department_id(+);

-- Q2. ��� ����� ���, �̸�, ��� �� �����å�̸�
-- ��, ����� ���� ����� ���, �����å�̸��� '��� ����'���� ���
-- ��� : 23��
select e.employee_id, e.first_name, nvl(j.job_title, '��� ����')
from employees e, job_history jh, jobs j
where e.employee_id = jh.employee_id(+)
            and jh.job_id = j.job_id(+)
order by e.employee_id;

-- Q3. inner join ����Ұ�, �Ŵ������̵� 100���� ����� ���, �̸�, �μ��̸�
select e.employee_id, e.first_name, d.department_name
from employees e join departments d
on e.department_id = d.department_id
where e.manager_id = 100;

-- Q4. inner join ����Ұ�, Washington �ֿ� ��ġ�� �μ��� �μ���ȣ�� �μ��̸� 
select d.department_id, d.department_name
from departments d join locations l
on d.location_id = l.location_id
where lower(l.state_province) = lower('Washington');

-- Q5. ANSI ������ ����Ͽ� 'accounting' �μ� �Ҽ� ����� �̸��� �Ի����� ����ϼ���.
-- ��, �Ի����� �⵵�� ǥ�� �Ͻÿ�.
select e.first_name, to_char(e.hire_date,'yyyy')
from employees e join departments d
on e.department_id = d.department_id
where lower(d.department_name) = lower('accounting');

-- Q6. ANSI ������ ����Ͽ� ����信�� �ٹ��ϴ� ����� �̸��� �޿��� ����ϼ���.
select e.first_name, e.salary
from employees e join departments d on e.department_id = d.department_id
                            join locations l on d.location_id = l.location_id
where lower(l.city) = lower('toronto');

-- Q7. ��� ����鿡�� ������ ��Ʈ�� ����Ϸ��Ѵ�.
--ansi join�� �̿��Ͽ�������� ������ ���� �����ȣ�� �˾Ƴ��ÿ�.
--��� ������� ���, �̸�, �μ� �̸�, �����ȣ

-- Q8. ������ ����� �Ͱ� �ٸ� ������ ansi join �� �̿��Ͽ�
--��� ������� ���, �̸�, �μ� �̸�, �����ȣ
--�μ��� ���� ���� ��� '���߷���', �����ȣ�� ������� '���ü���' ���� ǥ���Ѵ�.


-- Q9. ��� ������ �̸�, ����, ��å�̸�, ���� ����
-- ��, ������ ���� ������ �����϶�
select e.first_name, e.salary, j.job_title, jg.grade_level
from employees e, jobs j, job_grades jg
where e.job_id=j.job_id
and e.salary between jg. lowest_sal and highest_sal
order by salary desc;

-- Q10. ��� ����� �̸�, �μ��̸�, ����, �����̸�, ����̸� ���(join�� �̿��ؼ� ���)
select e. first_name, d.department_name, l.city, c.country_name, r.region_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
join countries c
on l.country_id=c.country_id
join regions r
on c.region_id=r.region_id;