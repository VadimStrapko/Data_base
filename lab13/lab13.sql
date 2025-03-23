﻿use UNIVER;


/* ex_1 */
go
create PROCEDURE PSUBJECT 
as
begin
	set nocount on;
	select SUBJECT as код,SUBJECT_NAME as дисциплина, PULPIT as кафедра from SUBJECT;
	declare @q int = (select count(*) from SUBJECT);
	return @q;
end;

go
--DROP PROCEDURE PSUBJECT;

declare @result int = 0;
EXEC @result = PSUBJECT;
print 'Количество строк: ' + cast(@result as varchar(10));

--ex2

ALTER PROCEDURE PSUBJECT 
    @p VARCHAR(20) = NULL,  -- Входной параметр с типом varchar(20) и значением по умолчанию NULL
    @c INT OUTPUT          -- Выходной параметр с типом INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Формируем результирующий набор
    SELECT SUBJECT AS код, SUBJECT_NAME AS дисциплина, PULPIT AS кафедра
    FROM SUBJECT
    WHERE (@p IS NULL OR PULPIT = @p);

    -- Устанавливаем значение выходного параметра @c
    SELECT @c = COUNT(*)
    FROM SUBJECT
    WHERE (@p IS NULL OR PULPIT = @p);

    -- Возвращаем значение общего количества строк в таблице SUBJECT
    RETURN (SELECT COUNT(*) FROM SUBJECT);
END;
go

declare @result varchar(20), @c int = 0;
EXEC @result = PSUBJECT @p = 'ИСиТ', @c = @c output;
print 'Количество строк: ' + @result;
print 'Общее количество дисциплин: ' + cast(@c as varchar(10));

/* ex_3 */
create table #SUBJECTS
(
	s1 char(10) not null,
	s2 varchar(100) not null,
	s3 char(20) not null
);

go
create PROCEDURE Pr3 @sub varchar(20)
as
begin
set nocount on;
	select SUBJECT,SUBJECT_NAME, PULPIT from SUBJECT where PULPIT = @sub;
	declare @q int = (select count(*) from SUBJECT);
	return @q;
end;
go

insert #SUBJECTS exec Pr3 @sub = 'ИСиТ';

/*declare @i int = 0;
exec @i = Pr3 @sub = 'ÈÑèÒ';
print @i;*/

select * from #SUBJECTS;

drop procedure Pr3;
drop table #SUBJECTS;

/* ex_4 */
go
create PROCEDURE PAUDITORIUM_INSERT
			     @a char(20), @n varchar(50), @c int = 0, @t char(10)
as 
declare @res int = 1;
begin try
	insert into AUDITORIUM(AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_CAPACITY, AUDITORIUM_TYPE)
	VALUES (@a, @n, @c, @t);
return @res;
end try
begin catch
	print 'Ошибка: ' + cast(error_number() as varchar(6));
	print 'Сообщение: ' + error_message();
	return -1;
end catch

declare @rc int;
exec @rc = PAUDITORIUM_INSERT @a = '405-4', @n = '405-4', @c = 65, @t = 'ËÊ';
print @rc;

--drop procedure PAUDITORIUM_INSERT;

/* ex_5 */
go
create procedure SUBJECT_REPORT @p char(10)
as
declare @rc int = 0;
DECLARE @subject char(35), @subjects char(500) = '';
begin try
	DECLARE discpipline CURSOR for select SUBJECT.SUBJECT_NAME from SUBJECT where SUBJECT.PULPIT = @p;
	OPEN discpipline;
	FETCH discpipline into @subject;
	print 'Дисциплины кафеды ' + @p + ' : ';
	while @@FETCH_STATUS = 0
		begin
			set @subjects = RTRIM(@subject) +', ' +  @subjects;
			set @rc = @rc + 1;
			FETCH  discpipline into @subject;
		end;
		print @subjects;
	CLOSE discpipline;

	if(@rc = 0)
	begin
		raiserror('ошибка в параметрах', 11, 1);
		return -1;
	end;

	else
	begin
		return @rc;
	end;
end try

begin catch
	print 'Ошибка: ' + cast(error_number() as varchar(6));
	print 'Сообщение: ' + error_message();
	return -1;
end catch;

declare @res2 int;
exec @res2 = SUBJECT_REPORT @p= 'ИСиТ';
print 'Резульат работы процедуры: ' + cast(@res2 as varchar(10));

drop procedure SUBJECT_REPORT;
deallocate  discpipline;


/* ex_6 */
go
create procedure PAUDITORIUM_INSERTX 
				 @a char(20), @n varchar(50), @c int = 0, @t char(10), @tn varchar(50)
as
declare @ret int = 1;

	begin try
		set transaction isolation level SERIALIZABLE;
		begin tran
			insert into AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME)
			VALUES (@t, @tn);
			EXEC PAUDITORIUM_INSERT @a=@a,@n=@n,@c=@c,@t=@t;
			commit tran;
			return @ret;
		end try

		begin catch
			print 'Ошибка: ' + cast(error_number() as varchar(6));
			print 'Сообщение: ' + error_message();
			rollback tran;
			return -1;
		end catch;

DECLARE @paud int = 0;
EXEC @paud = PAUDITORIUM_INSERTX @a='993-1',@n='993-1',@c=99,@t='ЛК-Б', @tn ='Лекционная для айти';
DELETE AUDITORIUM where AUDITORIUM_NAME='993-1';
DROP PROCEDURE PAUDITORIUM_INSERTX;