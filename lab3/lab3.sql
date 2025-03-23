DROP database KHAT_MyBase;

USE master;
go
create database KHAT_MyBase on primary
(name = 'KHAT_MyBase_mdf', filename = 'D:\study\4_sem\BD\lab3\KHAT_MyBase_mdf.mdf',
size = 10240Kb, maxsize=UNLIMITED, filegrowth = 1024Kb),
(name = 'KHAT_MyBase_ndf', filename = 'D:\study\4_sem\BD\lab3\KHAT_MyBase_ndf.ndf',
size = 10240Kb, maxsize=1Gb, filegrowth = 25%),
filegroup FG
(name = 'KHAT_MyBase_fg1_1', filename = 'D:\study\4_sem\BD\lab3\KHAT_MyBase_fg1_1.ndf',
size = 10240Kb, maxsize=1Gb, filegrowth = 25%),
(name = 'KHAT_MyBase_fg1_2', filename = 'D:\study\4_sem\BD\lab3\KHAT_MyBase_fg1_2.ndf',
size = 10240Kb, maxsize=1Gb, filegrowth = 25%)
log on
(name = 'KHAT_MyBase_log', filename = 'D:\study\4_sem\BD\lab3\KHAT_MyBase_log.ldf',
size = 10240Kb, maxsize=2048Gb, filegrowth = 10%)

use KHAT_MyBase
CREATE table ������
(
	[�������� ������] nvarchar(50) primary key,
	[���������� �����������] smallint not null,
	[���������� ����� �������] money not null
)on FG;

CREATE table ������
(
	[�������� ������] nvarchar(30) primary key,
	���� money not null,
	�������� nvarchar(100)
)on FG;

CREATE table �������
(
	[����� ����] int primary key,
	���� date not null DEFAULT GETDATE(),
	����� nvarchar(50) foreign key references ������([�������� ������]),
	����� nvarchar(30) foreign key references ������([�������� ������]),
	���������� smallint not null,
	[����������� �����] money not null
) on FG;

ALTER Table ������ DROP Column ��������;
ALTER Table ������ ADD �������� nvarchar(100) not null;
Alter table ������ ADD CONSTRAINT df_constraint Default '�������� �����������' for ��������

Insert into ������([�������� ������], [���������� �����������], [���������� ����� �������])
	Values('��������� ������', 20, 5000),
		  ('������������', 10, 6000),
		  ('����������', 30, 7000),
		  ('������������', 100, 8000);
Insert into ������([�������� ������], ����, ��������)
	Values('����������', 400, '����� ����� ���� �����'),
		  ('����������', 40, '����� �������� ����� ����'),
		  ('������� ������', 500, default),
		  ('�������', 800, '����� ������'),
		  ('����', 600, '����� ���� ������ ��������');

Insert into �������( [����� ����], ����,  �����, �����, ����������, [����������� �����])
	Values(1, '2023-09-21', '������������', '����������', 5, 600),
		  (2, '2023-09-22', '����������', '�������', 3, 2400),
		  (3, '2023-09-22', '������������', '����������', 20, 1000),
		  (4, '2023-09-23', '����������', '����', 5, 3000),
		  (5, '2023-09-24', '��������� ������', '������� ������', 10, 6000);
		  

	SELECT * From ������;
	Select [�������� ������] as ���������, �������� FROM ������;
	Select count(*) from �������;
	Select * from ������� Where ���� >= '2023-09-23';




	Update ������ Set [���������� �����������] = 67 WHERE [�������� ������] = '����������';
	Delete From ������� WHERE ����� = '����������';
	Select * From ������ WHERE [�������� ������] = '����������';
	Select * From ������� Where ����� = '����������';