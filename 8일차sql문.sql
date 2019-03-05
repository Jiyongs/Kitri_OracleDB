-- **************************8���� **************************
-- 2019.03.04

-- �μ���ȣ�� 50 �Ǵ� 90�� ����� (8 - �� �� salary>=10000�� ����� 3��)
-- �޿��� 10000 �̻��� ����� (7)
-- ���, �̸�, �޿�, �μ���ȣ

-- [union : �ߺ��� ����]
-- ��� : 13��
select employee_id, first_name, salary, department_id
from employees
where department_id in (50, 90)
union
select employee_id, first_name, salary, department_id
from employees
where salary >= 10000;

-- [union : �ߺ��� ����]
-- ��� : 15��
select employee_id, first_name, salary, department_id
from employees
where department_id in (50, 90)
union all
select employee_id, first_name, salary, department_id
from employees
where salary >= 10000;

-- [intersect : �� ���� ������� �����ո� ��ȯ]
-- ��� : 3��
select employee_id, first_name, salary, department_id
from employees
where department_id in (50, 90)
intersect
select employee_id, first_name, salary, department_id
from employees
where salary >= 10000;

-- [intersect : ù ��° ������� �� ��° ����� ��]
-- ��� : 5��
select employee_id, first_name, salary, department_id
from employees
where department_id in (50, 90)
minus
select employee_id, first_name, salary, department_id
from employees
where salary >= 10000;

-- <Group by>

-- [group by] �μ��� �޿� ����, ��ձ޿�, �����, �ִ�޿�, �ּұ޿�
select sum(salary), avg(salary), count(employee_id), max(salary), min(salary)
from employees
group by department_id;

-- [group by/having] ��� �޿��� 5000 ������ �μ���
-- �μ��� �޿� ����, ��ձ޿�, �����, �ִ�޿�, �ּұ޿�
select sum(salary), avg(salary), count(employee_id), max(salary), min(salary)
from employees
group by department_id
having avg(salary) <= 5000;

-- [gropu by/��������]
-- *�μ��� ��� ��ձ޿����� ���� ����� ������� �� (���� �ľ� �߿�)
-- ��� �μ��� ��ձ޿����� ���� �޴� �����
-- ���, �̸� �޿�
select employee_id, first_name, salary
from employees
where salary > all (select avg(salary)
                            from employees
                            group by department_id);

-- [group by/��������/join]
-- �μ��� �ְ�޿��� �޴� �����
-- �μ��̸�, ���, �̸�, �޿�
-- *�μ� �������� ����
select d.department_name, e.employee_id, e.first_name, e.salary
from employees e, (select department_id, max(salary) msal
                            from employees
                            group by department_id) m, departments d
where e.department_id = m.department_id
            and e.salary = m.msal
            and e.department_id = d.department_id;

-- <rownum>
-- : �� ��ȣ
-- : <, <= (�۴�) �񱳴� ����������, >, >= (ũ��) �񱳴� �Ұ���
--  -> because �۴��� �ּҰ��� 1�� ������������, ũ���� �ִ밪�� �����ϹǷ� �Ұ����ϴ�.
select rownum, employee_id, salary
from employees;

-- �Ұ���
select rownum, employee_id, salary
from employees
where rownum <= 10
and rownum >5;

-- ###
-- [TOP N Query] : ������ �� ����� �̱�
-- ����, ���, �̸�, �޿�, �Ի���,  �μ��̸�
-- �޿��� ���� (*��������)
-- �� ������ �� 5�� ���
-- 2�������� ����Ͻÿ� (*6~10�� ���������, ���� �ƴ� ���ڴ� 2�ۿ� ���ٰ� ����)
-- �Ի��� : 1980���, 1990���, 2000��� ...
-- �˾ƾ� �� �� : rownum ���, select�� �������, case

-- [�� ���] : �Ի��뿡 trunc ���, �������� ���� ���� ��ȿ����
select r.ro, r.employee_id, r.first_name, r.salary, r.�Ի���, nvl(d.department_name,'������')
from departments d, (select rownum ro, sal.department_id, sal.employee_id, sal.first_name, sal.salary, �Ի���
                                from (select department_id, employee_id, first_name, salary, trunc(to_char(hire_date,'yyyy'),-1) || '���' �Ի���
                                        from employees
                                        order by salary desc) sal) r
where r.ro between 1+5*(&pages-1) and 5 *(&pages)
        and r.department_id = d.department_id(+)
order by r.salary desc;

-- [������ ���] : �Ի��뿡 case�� ���, �������� ���� ȿ����
select b.m ranking, b.employee_id, b.first_name, b.salary,
         case when to_char(hire_date,'yyyy') like '198%'
                        then '1980���'
                when to_char(hire_date,'yyyy') like '199%'
                        then '1990���'
                else '2000���'
        end �Ի���
       , d.department_name
from (select rownum m, a.*
        from (select employee_id, first_name, hire_date, salary, department_id
                from employees
                order by salary desc) a
                where rownum <= &page *5 ) b, departments d
where b.department_id = d.department_id(+) 
and b.m > 1+(&page * 5 - 5)
order by ranking;

-- ***** rank(), over() �̿�
select ro.�޿�����, e.employee_id, e.first_name, e.salary, trunc(to_char(e.hire_date,'yyyy'),-1) || '���' �Ի���, d.department_name
from employees e, (select rank() over(order by salary desc) �޿�����, employee_id
                            from employees) ro
        , departments d
where e.employee_id = ro.employee_id
and e.department_id = d.department_id(+)
and �޿����� between 1+(&page * 5 - 5) and (&page * 5);

