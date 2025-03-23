use KHAT_MyBase;

/* ex_1 */
print 'Задание 1';
DECLARE expenses CURSOR for select [Номер чека] from РАСХОДЫ where Отдел like 'Тестирование';
--deallocate  expenses;

DECLARE @check char(35), @checkes char(500) = '';
OPEN expenses;
FETCH expenses into @check;
print 'Чеки отдела Тестирование';
while @@FETCH_STATUS = 0
	begin
		set @checkes = RTRIM(@check) +', ' +  @checkes;
		FETCH  expenses into @check;
	end;
	print @checkes;
CLOSE expenses;
/* ex_2 */

print 'Задание 2';
DECLARE expenses CURSOR LOCAL for select [Номер чека] from РАСХОДЫ where Отдел like 'Тестирование';
--deallocate  expenses;

DECLARE @check2 char(35), @checkes2 char(500) = '';
OPEN expenses;
FETCH expenses into @check2;
print 'Чеки отдела Тестирование';
    set @checkes2 = RTRIM(@check2) +', ' +  @checkes2;
	print @checkes2;
go
DECLARE @check2 char(35), @checkes2 char(500) = '';
FETCH expenses into @check2;
		set @checkes2 = RTRIM(@check2) +', ' +  @checkes2;
	print @checkes2;
CLOSE expenses;
go
DECLARE expenses_global CURSOR GLOBAL for select [Номер чека] from РАСХОДЫ where Отдел like 'Тестирование';
--deallocate  expenses_global;

DECLARE @check char(35), @checkes char(500) = '';
OPEN expenses_global;
FETCH expenses_global into @check;
print 'Чеки отдела Тестирование';
    set @checkes = RTRIM(@check) +', ' +  @checkes;
	print @checkes;
go
DECLARE @check char(35), @checkes char(500) = '';
FETCH expenses_global into @check;
		set @checkes = RTRIM(@check) +', ' +  @checkes;
	print @checkes;
CLOSE expenses_global;

/* ex_3 */
INSERT into ТОВАРЫ values ('Книга', 1000, 'чтобы было что почитать');
select * from ТОВАРЫ;

DECLARE goods CURSOR STATIC for select [Название товара] from ТОВАРЫ where Цена >=1000;
--deallocate  goods;

DECLARE @good char(10), @iter int = 1;
open goods;
print 'Количество строк: ' + cast(@@CURSOR_ROWS as varchar(5));
DELETE ТОВАРЫ where [Название товара] like 'Книга';
FETCH goods into @good;
while @@FETCH_STATUS = 0
	begin
		print cast(@iter as varchar(5)) + '. Товар ' + rtrim(@good);
		set @iter += 1;
		FETCH goods into @good;
	end;
CLOSE goods;
go
INSERT into ТОВАРЫ values ('Книга', 1000, 'чтобы было что почитать');

DECLARE goods_dynamic CURSOR DYNAMIC for select [Название товара] from ТОВАРЫ where Цена >=1000;
--deallocate  goods_dynamic;

DECLARE @good char(10), @iter int = 1;
open goods_dynamic;
print 'Количество строк: ' + cast(@@CURSOR_ROWS as varchar(5));
DELETE ТОВАРЫ where [Название товара] like 'Книга';
FETCH goods_dynamic into @good;
while @@FETCH_STATUS = 0
	begin
		print cast(@iter as varchar(5)) + '. Товар ' + rtrim(@good);
		set @iter += 1;
		FETCH goods_dynamic into @good;
	end;
CLOSE goods_dynamic;
go

--ex4

DECLARE @id int, @date date, @otdel char(50), @good char(50), @count int, @spent money, @number varchar(100);
DECLARE expenses4 CURSOR LOCAL DYNAMIC SCROLL for select ROW_NUMBER() over (order by [Номер чека]) Номер,
	* from РАСХОДЫ;
--deallocate expenses4;
OPEN expenses4;

FETCH expenses4 into @number, @id, @date, @otdel ,@good, @count, @spent;
print 'Первая выбранная строка: ' + CHAR(10) +
'Номер записи: ' + rtrim(@number) +
'. ID: '+ rtrim(@id)  +
'. Дата: '+ rtrim(@date) +
'. Отдел: ' + rtrim(@otdel) +
'. Товар: '  + rtrim(@good) + 
'. Количество: ' + rtrim(@count) + 
'. Потрачено ' + rtrim(@spent);

FETCH LAST from expenses4 into  @number, @id, @date, @otdel ,@good, @count, @spent;
print 'Последняя строка: ' + CHAR(10) +
'Номер записи: ' + rtrim(@number) +
'. ID: '+ rtrim(@id)  +
'. Дата: '+ rtrim(@date) +
'. Отдел: ' + rtrim(@otdel) +
'. Товар: '  + rtrim(@good) + 
'. Количество: ' + rtrim(@count) + 
'. Потрачено ' + rtrim(@spent);

FETCH RELATIVE -1 from expenses4 into  @number, @id, @date, @otdel ,@good, @count, @spent;
print 'Первая до предыдущей строка: ' + CHAR(10) +
'Номер записи: ' + rtrim(@number) +
'. ID: '+ rtrim(@id)  +
'. Дата: '+ rtrim(@date) +
'. Отдел: ' + rtrim(@otdel) +
'. Товар: '  + rtrim(@good) + 
'. Количество: ' + rtrim(@count) + 
'. Потрачено ' + rtrim(@spent);

FETCH ABSOLUTE 2 from expenses4 into  @number, @id, @date, @otdel ,@good, @count, @spent;
print 'Вторая с начала строка: ' + CHAR(10) +
'Номер записи: ' + rtrim(@number) +
'. ID: '+ rtrim(@id)  +
'. Дата: '+ rtrim(@date) +
'. Отдел: ' + rtrim(@otdel) +
'. Товар: '  + rtrim(@good) + 
'. Количество: ' + rtrim(@count) + 
'. Потрачено ' + rtrim(@spent);

FETCH RELATIVE 1 from expenses4 into  @number, @id, @date, @otdel ,@good, @count, @spent;
print 'Первая после предыдущей строка: ' + CHAR(10)+
'Номер записи: ' + rtrim(@number) +
'. ID: '+ rtrim(@id)  +
'. Дата: '+ rtrim(@date) +
'. Отдел: ' + rtrim(@otdel) +
'. Товар: '  + rtrim(@good) + 
'. Количество: ' + rtrim(@count) + 
'. Потрачено ' + rtrim(@spent);


FETCH RELATIVE -3 from expenses4 into  @number, @id, @date, @otdel ,@good, @count, @spent;
print 'Третья с конца строка: ' + CHAR(10) +
'Номер записи: ' + rtrim(@number) +
'. ID: '+ rtrim(@id)  +
'. Дата: '+ rtrim(@date) +
'. Отдел: ' + rtrim(@otdel) +
'. Товар: '  + rtrim(@good) + 
'. Количество: ' + rtrim(@count) + 
'. Потрачено ' + rtrim(@spent);
close expenses4;

--ex5
use master;
CREATE TABLE #EXAMPLE
(
	ID int identity(1,1),
	WORD varchar(100)
);

INSERT INTO #EXAMPLE values ('Яблоко'),('Груша'),('Апельсин'),('Мандарин'),('Вишня'),('Клубника'),('Клюква');


DECLARE @id varchar(10), @word varchar(100);
DECLARE CURRENT_OF_CURSROR CURSOR LOCAL DYNAMIC
	for SELECT * from #EXAMPLE FOR UPDATE;
OPEN CURRENT_OF_CURSROR
fetch CURRENT_OF_CURSROR into @id,@word;
print @id + '-' + @word;
DELETE #EXAMPLE where CURRENT OF CURRENT_OF_CURSROR;
fetch  CURRENT_OF_CURSROR into @id,@word;
UPDATE #EXAMPLE set WORD += ' - updated' where CURRENT OF CURRENT_OF_CURSROR;
print @id + '-' + @word;
close CURRENT_OF_CURSROR;

OPEN CURRENT_OF_CURSROR
while(@@FETCH_STATUS = 0)
	begin
		fetch CURRENT_OF_CURSROR into @id,@word;
		print @id + '-' + @word;
	end;
close CURRENT_OF_CURSROR;

DROP TABLE #EXAMPLE;


--ex6

insert into ТОВАРЫ values
('Лодка', 10000, 'qqq'),
('Яхта', 150000, 'qqq'),
('Титаник', 130000, 'qqq'),
('Танк', 100000, 'qqq');

DECLARE newCursor CURSOR for SELECT [Название товара], Цена from ТОВАРЫ for update;
--deallocate newCursor;
DECLARE @name varchar(300), @cost int;

OPEN newCursor;
fetch newCursor into @name, @cost;
if(@cost >= 10000)
			begin
				DELETE ТОВАРЫ where CURRENT OF newCursor;
			end;
print @name + ' - '+ Convert(varchar, @cost) ;
While (@@FETCH_STATUS = 0)
	begin
		fetch newCursor into @name, @cost;
		print @name + ' - '+ Convert(varchar, @cost) ;
		if(@cost >= 10000)
			begin
				DELETE ТОВАРЫ where CURRENT OF newCursor;
			end;
			if(@name = 'Клавиатура')
			begin
			UPDATE ТОВАРЫ set Цена = Цена + 1 where current of newCursor;
			end;
	end;
CLOSE newCursor;