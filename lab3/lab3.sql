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
CREATE table ОТДЕЛЫ
(
	[Название отдела] nvarchar(50) primary key,
	[Количество сотрудников] smallint not null,
	[Предельная норма расхода] money not null
)on FG;

CREATE table ТОВАРЫ
(
	[Название товара] nvarchar(30) primary key,
	Цена money not null,
	Описание nvarchar(100)
)on FG;

CREATE table РАСХОДЫ
(
	[Номер чека] int primary key,
	Дата date not null DEFAULT GETDATE(),
	Отдел nvarchar(50) foreign key references ОТДЕЛЫ([Название отдела]),
	Товар nvarchar(30) foreign key references ТОВАРЫ([Название товара]),
	Количество smallint not null,
	[Потраченная сумма] money not null
) on FG;

ALTER Table ТОВАРЫ DROP Column Описание;
ALTER Table ТОВАРЫ ADD Описание nvarchar(100) not null;
Alter table ТОВАРЫ ADD CONSTRAINT df_constraint Default 'Описание отсутствует' for Описание

Insert into ОТДЕЛЫ([Название отдела], [Количество сотрудников], [Предельная норма расхода])
	Values('Аналитика данных', 20, 5000),
		  ('Безопасность', 10, 6000),
		  ('Разработка', 30, 7000),
		  ('Тестирование', 100, 8000);
Insert into ТОВАРЫ([Название товара], Цена, Описание)
	Values('Вентилятор', 400, 'Чтобы летом было круто'),
		  ('Клавиатура', 40, 'Чтобы печатать можно было'),
		  ('Офисное кресло', 500, default),
		  ('Монитор', 800, 'Чтобы видеть'),
		  ('Стол', 600, 'Чтобы было удобно работать');

Insert into РАСХОДЫ( [Номер чека], Дата,  Отдел, Товар, Количество, [Потраченная сумма])
	Values(1, '2023-09-21', 'Безопасность', 'Вентилятор', 5, 600),
		  (2, '2023-09-22', 'Разработка', 'Монитор', 3, 2400),
		  (3, '2023-09-22', 'Тестирование', 'Клавиатура', 20, 1000),
		  (4, '2023-09-23', 'Разработка', 'Стол', 5, 3000),
		  (5, '2023-09-24', 'Аналитика данных', 'Офисное Кресло', 10, 6000);
		  

	SELECT * From ОТДЕЛЫ;
	Select [Название товара] as рпиоритшт, Описание FROM ТОВАРЫ;
	Select count(*) from РАСХОДЫ;
	Select * from РАСХОДЫ Where Дата >= '2023-09-23';




	Update ОТДЕЛЫ Set [Количество сотрудников] = 67 WHERE [Название отдела] = 'Разработка';
	Delete From РАСХОДЫ WHERE Товар = 'Вентилятор';
	Select * From ОТДЕЛЫ WHERE [Название отдела] = 'Разработка';
	Select * From РАСХОДЫ Where Товар = 'Вентилятор';