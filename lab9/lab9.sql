use Univer;

--ex1--

DECLARE @ch char = 'Hello',
		@vch varchar  = 'Goodbye',
		@t time,
		@i int,
		@si smallint,
		@ti tinyint,
		@num numeric(12,5);

SET @t = '20:31';
SET @i = 12345678;
SET @si = 32222;
SET @ti = 255;
SET @num = 12.234;

PRINT 'SMALLINT: ' + cast(@si as varchar(10)) + ', TINYINT: '
+ cast(@ti as varchar(10)) + ', NUMERIC: ' + cast(@num as varchar(10));

SELECT @ch ch, @vch vch, @i i, @t t;

--ex2--
declare @ оличествојудиторий int = (select count(*) from AUDITORIUM),
		@ќбща€¬местимость int = (select SUM(AUDITORIUM_CAPACITY) from AUDITORIUM),
		@—редн€€¬местимость int = (select cast(avg(AUDITORIUM_CAPACITY) as int) from AUDITORIUM);

declare @ оличествоћеньше—редней int = (select count(*) from AUDITORIUM	where AUDITORIUM_CAPACITY < @—редн€€¬местимость);
declare @ѕроцентћеньше—редней float = cast(cast(@ оличествоћеньше—редней as float) / cast(@ оличествојудиторий as float) * 100 as float);

if @ќбща€¬местимость > 200
begin
select @ оличествојудиторий  оличествојудиторий, @ќбща€¬местимость ќбща€¬местимость, @—редн€€¬местимость —редн€€¬местимость, 
	   @ оличествоћеньше—редней  оличествоћеньше—редней, @ѕроцентћеньше—редней ѕроцентћеньше—редней;
end
else if @ќбща€¬местимость > 200 print 'ќбща€ вместимость аудиторий: ' + cast(@ќбща€¬местимость as varchar(10))
else print 'ќбща€ вместимость аудиторий' + cast(@ќбща€¬местимость as varchar(10));

--ex3--
print '-------------3-----------------';
print '„исло обработанный строк = ' + cast(@@ROWCOUNT as varchar(10));
print 'верси€ SQL Server = ' + cast(@@VERSION as varchar(300));
print '—истемный идентификатор процесса, назначенный сервером текущему подключению = ' + cast(@@SPID as varchar(300));
print ' од последней ошибки = ' + cast(@@ERROR as varchar(30));
print 'им€ сервера = ' + cast(@@SERVERNAME as varchar(30));
print 'уровень вложенности транзакции = ' + cast(@@trancount as varchar(30));
print 'проверка результата считывани€ строк результирующего набора = ' + cast(@@FETCH_STATUS as varchar(30));
print 'уровень вложенности текущей проце-дуры = ' + cast(@@NESTLEVEL as varchar(30));

--ex4--

print '------------4------------------';
DECLARE @t2 int = 45, 
		@z float(10),
		@x int = 52;

if @t2 > @x
begin
set @z = power(sin(@t2),2);
print 'Z = '+cast(@z as varchar(15));
end

else if @t2 < @x
begin
set @z = 4 * (@t2 + @x);
print 'Z = '+cast(@z as varchar(15));
end

else if @t2 = @x
begin
set @z = 1 - exp(@x-2);
print 'Z = '+cast(@z as varchar(15));
end

/*---------------------*/
DECLARE @full_name varchar(100) = 'ћакейчик “ать€на Ћеонидовна';

set @full_name = (select substring(@full_name, 1, charindex(' ', @full_name)) +
								 substring(@full_name, charindex(' ', @full_name)+1, 1) + '.' +
								 substring(@full_name, charindex(' ', @full_name, charindex(' ', @full_name)+1)+1,1)+'.');
print '—окращенное ‘»ќ: ' + @full_name;

/*---------------------*/
DECLARE @next_month int = MONTH(GETDATE()) + 1;
select * from STUDENT where MONTH(STUDENT.BDAY) = @next_month;

/*---------------------*/
select CASE 
							when DATEPART(weekday,PDATE) = 1 then 'ѕонедельник'
							when DATEPART(weekday,PDATE) = 2 then '¬торник'
							when DATEPART(weekday,PDATE) = 3 then '—реда'
							when DATEPART(weekday,PDATE) = 4 then '„етверг'
							when DATEPART(weekday,PDATE) = 5 then 'ѕ€тница'
							when DATEPART(weekday,PDATE) = 6 then '—уббота'
							when DATEPART(weekday,PDATE) = 7 then '¬оскресенье'
						end
from PROGRESS where SUBJECT = ' √'

--ex5--
print '------------5---------------';
DECLARE @averageMark float(4), @coun int;

set @averageMark = (select avg(NOTE) from PROGRESS);
set @coun = (select count(NOTE) from PROGRESS);

if @averageMark < 5
begin
print '—редн€€ оценка больше 5'
end

else if @averageMark > 5
begin
print '—редн€€ оценка меньше 5'
end

print ' оличество оценок = '+ cast(@coun as varchar);

--ex6--

select	PROGRESS.IDSTUDENT,PROGRESS.SUBJECT, case	
			when AVG(PROGRESS.NOTE) = 4 then 'ќценка ниже 4'
			when AVG(PROGRESS.NOTE)	between 5 and 6 then 'ќценка удовлетворительно'
			when AVG(PROGRESS.NOTE) between 7 and 8 then 'ќценка хорошо'
			when AVG(PROGRESS.NOTE) between 9 and 10 then 'ќценка отлично'
			end

from PROGRESS
group by idstudent, SUBJECT

--ex7--
CREATE TABLE #TEMP1
		(
			ID int identity(1,1),
			RANDOM_NUMBER int,
			TEXT nvarchar(50)
		);

DECLARE  @iter int = 0;
WHILE @iter < 10
	begin
	INSERT #TEMP1(RANDOM_NUMBER, TEXT)
			values(rand() * 1000, '“екст))');
	SET @iter = @iter + 1;
	end
SELECT * from #TEMP1;
DROP TABLE #TEMP1;

--ex8--

print '--------8------------';
DECLARE @par int = 1
print @par+1
print @par+2
RETURN
print @par+3


--ex9--

declare @dat date = '1995-03-11';
begin try
Select 1/0
end try
begin catch
print ' од последней ошибки: ' + cast(ERROR_NUMBER() as varchar(10))
print '—ообщение об ошибке: ' + ERROR_MESSAGE()
print 'Ќомер строки с ошибкой: ' + cast(ERROR_LINE() as varchar(10))
print '»м€ процедуры или NULL: ' + ERROR_PROCEDURE()
print '”ровень серьезности ошибки: ' + cast(cast(ERROR_SEVERITY() as int) as varchar(10))
print 'ћетка ошибки: ' + cast(cast(ERROR_STATE() as int) as varchar(10))
end catch
