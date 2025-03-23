use KHAT_MyBase;
--ex1----

create view [Купленные товары]
as select Дата, Товар, [Потраченная сумма]
from Khat_MyBase.dbo.РАСХОДЫ;

select * from [Купленные товары];
drop view [Купленные товары];


--ex2--

create view [Закупившиеся отделы]
as select Дата, [Название отдела], [Количество сотрудников]
from KHAT_MyBase.dbo.ОТДЕЛЫ inner join KHAT_MyBase.dbo.РАСХОДЫ
on KHAT_MyBase.dbo.ОТДЕЛЫ.[Название отдела] = KHAT_MyBase.dbo.РАСХОДЫ.Отдел;

select * from [Закупившиеся отделы];
drop view [Закупившиеся отделы];
 
--ex3--
create view [Товары на С]
as select [Название товара], Цена
from KHAT_MyBase.dbo.ТОВАРЫ
where [Название товара] like 'С%';

select * from [Товары на С];
select * from KHAT_MyBase.dbo.ТОВАРЫ;
insert [Товары на С] values ('Компьютерная мышь', 20);
insert [Товары на С] values ('Самокат', 1486);
update [Товары на С] set [Название товара] = 'Телефон стационарный' where [Название товара] = 'Самокат';

--ex4---

create view [Чеки от 3000]
as select *
from KHAT_MyBase.dbo.РАСХОДЫ
where [Потраченная сумма] >= 3000 WITH CHECK OPTION;

select * from [Чеки от 3000];
drop view [Чеки от 3000];

insert [Чеки от 3000] values(1, '2023-09-28', 'Разработка', 'Компьютерная мышь', 15, 300);

--ex5--

create view [Большие чеки]
as select top 3 *
from KHAT_MyBase.dbo.РАСХОДЫ
Order by [Потраченная сумма] desc;

select * from [Большие чеки];
drop view [Большие чеки];

--ex6--

alter view [Закупившиеся отделы] with schemabinding
as select r.Дата, o.[Название отдела], o.[Количество сотрудников]
from KHAT_MyBase.dbo.ОТДЕЛЫ o inner join KHAT_MyBase.dbo.РАСХОДЫ r
on o.[Название отдела] = r.Отдел;

alter view [Купленные товары] with schemabinding
as select Дата, Товар, [Потраченная сумма]
from dbo.РАСХОДЫ;

select * from [Закупившиеся отделы];
drop view [Закупившиеся отделы];

