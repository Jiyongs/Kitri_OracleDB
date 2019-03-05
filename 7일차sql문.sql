-- ************************** 7���� **************************
-- 2019.02.28

-- [sub query] �μ��̸��� 'IT'�� ������ �ٹ��ϴ� ����� ���, �̸�, �޿�
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

-- [sub query] 'Seattle'�� �ٹ��ϴ� ����� ���, �̸�, �޿�
-- ��ø ������ ���� ��µ� ���� 2�� �̻��� ���� ��, '='�� �ƴ� 'in'�� ����Ѵ�!
select employee_id, first_name, salary
from employees
where department_id in (select department_id
                                    from departments
                                    where location_id = (select location_id
                                                                    from locations
                                                                    where city = 'Seattle'));

-- <inline view>
-- from������ ���Ǵ� ���������� ��������� ������ ���̺�
-- ���������� �����ϴ� ���̺� X

-- �Ʒ��� ���, �̷����� ���� �񱳿��� inline view�� �� ȿ����
-- ������ȣ : 1700�� �μ����� ���ϴ� �����
-- ���, �̸�, �μ���ȣ, �μ��̸�

-- [join]
select e.employee_id, e.first_name, e.department_id, d.department_name
from employees e, departments d            -- 160���� data
where e.department_id = d.department_id -- 19
            and d.location_id = 1700;            -- 6

-- [inline view]
select e.employee_id, e.first_name, e.department_id
from employees e, (select department_id, department_name  -- 80�� datd
                            from departments
                            where location_id = 1700) d
where e.department_id = d.department_id;                          -- 6��

-- [sub query]
-- 'Kevin' ���� �޿��� ���� �޴� ����� ���, �̸�, �޿�
select employee_id, first_name, salary
from employees
where salary > (select salary
                        from employees
                        where first_name = 'Kevin');
                        
-- 50�� �μ��� �ִ� ����麸�� �޿��� ���� �޴� ����� ���, �̸�, �޿�
select employee_id, first_name, salary
from employees
where salary > all (select salary
                         from employees
                         where department_id = 50) ;

-- �μ��� �ٹ��ϴ� ��� ������� ��� �޿����� ���� �޴� ����� ���, �̸�, �޿�
select employee_id, first_name, salary
from employees
where salary > (select avg(salary)
                      from employees
                      where department_id is not null);
                      
-- �μ���ȣ : 20���� ������� ��� �޿����� ũ��,
-- �μ���(department�� �ִ� manager_id)�� ������� �μ���ȣ�� 20���� �ƴ� �����
-- ���, �̸�, �޿�, �μ���ȣ
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

-- [select�� ����]
-- 20�� �μ��� ��ձ޿�
-- 50�� �μ��� �޿�����
-- 80�� �μ��� �ο���
-- ����� ���� ��, ���� �÷��� ������������ select���� ���� ����
select (select avg(salary) from employees where department_id = 20) avg20,
        (select sum(salary) from employees where department_id = 50) sum50,
        (select count(employee_id) from employees where department_id = 80) count80
from dual;

-- ��� ����� ���, �̸�, �޿�, ���, �μ��̸�
-- ��, A�� 1���, B�� 2���, ..., F�� 6���
--  ������Ʈ�� ����Ʈ�� ���� ��� �̾Ƴ�������� ����
-- [from���� ����������]
select e.employee_id, e.first_name, e.salary, jg.grade_level, d.department_name
from employees e, departments d, (select case when grade_level = 'A' then '1���'
                                                                    when grade_level = 'B' then '2���'
                                                                    when grade_level = 'C' then '3���'
                                                                    when grade_level = 'D' then '4���'
                                                                    when grade_level = 'E' then '5���'
                                                                    when grade_level = 'F' then '6���'
                                                              end grade_level, lowest_sal, highest_sal
                                                    from job_grades) jg
where e.department_id = d.department_id
and e.salary between jg.lowest_sal and jg.highest_sal
order by employee_id;

-- [select���� ����������]
select e.employee_id, e.first_name, e.salary,
        decode((select grade_level
                    from job_grades
                    where e.salary between lowest_sal and highest_sal),
                                                                                             'A', '1���',
                                                                                             'B', '2���',
                                                                                             'C', '3���',
                                                                                             'D', '4���',
                                                                                             'E', '5���',
                                                                                             '6���') ���,
        d.department_name
from employees e, departments d
where e.department_id = d.department_id
order by ���;

