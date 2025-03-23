use KHAT_MyBase;

--ex1--
SELECT ISNULL(�������.�����, '���') as �����, ������.����, SUM(�������.����������) as [����������], SUM(�������.[����������� �����]) as [���������]
from ������� inner join ������
on �������.����� = ������.[�������� ������]
WHERE ����� in ('����������', '����')
GROUP BY ROLLUP (�����, ����);



--ex2--
SELECT ISNULL(�������.�����, '���') as �����, ������.����, SUM(�������.����������) as [����������], SUM(�������.[����������� �����]) as [���������]
from ������� inner join ������
on �������.����� = ������.[�������� ������]
WHERE ����� in ('����������', '����')
GROUP BY CUBE (�����, ����);


--ex3--

select �����, SUM(����������)[����������], SUM([����������� �����])[���������]
from �������
where ����� in ('��������� ������', '����������')
group by �����


select �����, SUM(����������)[����������], SUM([����������� �����])[���������]
from �������
where ����� = '����������'
group by �����


select �����, SUM(����������)[����������], SUM([����������� �����])[���������]
from �������
where ����� in ('��������� ������', '����������')
group by �����
UNION
select �����, SUM(����������)[����������], SUM([����������� �����])[���������]
from �������
where ����� = '����������'
group by �����

select �����, SUM(����������)[����������], SUM([����������� �����])[���������]
from �������
where ����� in ('��������� ������', '����������')
group by �����
UNION ALL
select �����, SUM(����������)[����������], SUM([����������� �����])[���������]
from �������
where ����� = '����������'
group by �����

--ex4--
select �����, SUM(����������)[����������], SUM([����������� �����])[���������]
from �������
where ����� in ('��������� ������', '����������')
group by �����
INTERSECT
select �����, SUM(����������)[����������], SUM([����������� �����])[���������]
from �������
where ����� = '����������'
group by �����

--ex5

select �����, SUM(����������)[����������], SUM([����������� �����])[���������]
from �������
where ����� in ('��������� ������', '����������')
group by �����
EXCEPT
select �����, SUM(����������)[����������], SUM([����������� �����])[���������]
from �������
where ����� = '����������'
group by �����