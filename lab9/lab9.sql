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
declare @������������������� int = (select count(*) from AUDITORIUM),
		@���������������� int = (select SUM(AUDITORIUM_CAPACITY) from AUDITORIUM),
		@������������������ int = (select cast(avg(AUDITORIUM_CAPACITY) as int) from AUDITORIUM);

declare @����������������������� int = (select count(*) from AUDITORIUM	where AUDITORIUM_CAPACITY < @������������������);
declare @�������������������� float = cast(cast(@����������������������� as float) / cast(@������������������� as float) * 100 as float);

if @���������������� > 200
begin
select @������������������� �������������������, @���������������� ����������������, @������������������ ������������������, 
	   @����������������������� �����������������������, @�������������������� ��������������������;
end
else if @���������������� > 200 print '����� ����������� ���������: ' + cast(@���������������� as varchar(10))
else print '����� ����������� ���������' + cast(@���������������� as varchar(10));

--ex3--
print '-------------3-----------------';
print '����� ������������ ����� = ' + cast(@@ROWCOUNT as varchar(10));
print '������ SQL Server = ' + cast(@@VERSION as varchar(300));
print '��������� ������������� ��������, ����������� �������� �������� ����������� = ' + cast(@@SPID as varchar(300));
print '��� ��������� ������ = ' + cast(@@ERROR as varchar(30));
print '��� ������� = ' + cast(@@SERVERNAME as varchar(30));
print '������� ����������� ���������� = ' + cast(@@trancount as varchar(30));
print '�������� ���������� ���������� ����� ��������������� ������ = ' + cast(@@FETCH_STATUS as varchar(30));
print '������� ����������� ������� �����-���� = ' + cast(@@NESTLEVEL as varchar(30));

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
DECLARE @full_name varchar(100) = '�������� ������� ����������';

set @full_name = (select substring(@full_name, 1, charindex(' ', @full_name)) +
								 substring(@full_name, charindex(' ', @full_name)+1, 1) + '.' +
								 substring(@full_name, charindex(' ', @full_name, charindex(' ', @full_name)+1)+1,1)+'.');
print '����������� ���: ' + @full_name;

/*---------------------*/
DECLARE @next_month int = MONTH(GETDATE()) + 1;
select * from STUDENT where MONTH(STUDENT.BDAY) = @next_month;

/*---------------------*/
select CASE 
							when DATEPART(weekday,PDATE) = 1 then '�����������'
							when DATEPART(weekday,PDATE) = 2 then '�������'
							when DATEPART(weekday,PDATE) = 3 then '�����'
							when DATEPART(weekday,PDATE) = 4 then '�������'
							when DATEPART(weekday,PDATE) = 5 then '�������'
							when DATEPART(weekday,PDATE) = 6 then '�������'
							when DATEPART(weekday,PDATE) = 7 then '�����������'
						end
from PROGRESS where SUBJECT = '��'

--ex5--
print '------------5---------------';
DECLARE @averageMark float(4), @coun int;

set @averageMark = (select avg(NOTE) from PROGRESS);
set @coun = (select count(NOTE) from PROGRESS);

if @averageMark < 5
begin
print '������� ������ ������ 5'
end

else if @averageMark > 5
begin
print '������� ������ ������ 5'
end

print '���������� ������ = '+ cast(@coun as varchar);

--ex6--

select	PROGRESS.IDSTUDENT,PROGRESS.SUBJECT, case	
			when AVG(PROGRESS.NOTE) = 4 then '������ ���� 4'
			when AVG(PROGRESS.NOTE)	between 5 and 6 then '������ �����������������'
			when AVG(PROGRESS.NOTE) between 7 and 8 then '������ ������'
			when AVG(PROGRESS.NOTE) between 9 and 10 then '������ �������'
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
			values(rand() * 1000, '�����))');
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
print '��� ��������� ������: ' + cast(ERROR_NUMBER() as varchar(10))
print '��������� �� ������: ' + ERROR_MESSAGE()
print '����� ������ � �������: ' + cast(ERROR_LINE() as varchar(10))
print '��� ��������� ��� NULL: ' + ERROR_PROCEDURE()
print '������� ����������� ������: ' + cast(cast(ERROR_SEVERITY() as int) as varchar(10))
print '����� ������: ' + cast(cast(ERROR_STATE() as int) as varchar(10))
end catch
