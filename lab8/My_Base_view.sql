use KHAT_MyBase;
--ex1----

create view [��������� ������]
as select ����, �����, [����������� �����]
from Khat_MyBase.dbo.�������;

select * from [��������� ������];
drop view [��������� ������];


--ex2--

create view [������������ ������]
as select ����, [�������� ������], [���������� �����������]
from KHAT_MyBase.dbo.������ inner join KHAT_MyBase.dbo.�������
on KHAT_MyBase.dbo.������.[�������� ������] = KHAT_MyBase.dbo.�������.�����;

select * from [������������ ������];
drop view [������������ ������];
 
--ex3--
create view [������ �� �]
as select [�������� ������], ����
from KHAT_MyBase.dbo.������
where [�������� ������] like '�%';

select * from [������ �� �];
select * from KHAT_MyBase.dbo.������;
insert [������ �� �] values ('������������ ����', 20);
insert [������ �� �] values ('�������', 1486);
update [������ �� �] set [�������� ������] = '������� ������������' where [�������� ������] = '�������';

--ex4---

create view [���� �� 3000]
as select *
from KHAT_MyBase.dbo.�������
where [����������� �����] >= 3000 WITH CHECK OPTION;

select * from [���� �� 3000];
drop view [���� �� 3000];

insert [���� �� 3000] values(1, '2023-09-28', '����������', '������������ ����', 15, 300);

--ex5--

create view [������� ����]
as select top 3 *
from KHAT_MyBase.dbo.�������
Order by [����������� �����] desc;

select * from [������� ����];
drop view [������� ����];

--ex6--

alter view [������������ ������] with schemabinding
as select r.����, o.[�������� ������], o.[���������� �����������]
from KHAT_MyBase.dbo.������ o inner join KHAT_MyBase.dbo.������� r
on o.[�������� ������] = r.�����;

alter view [��������� ������] with schemabinding
as select ����, �����, [����������� �����]
from dbo.�������;

select * from [������������ ������];
drop view [������������ ������];

