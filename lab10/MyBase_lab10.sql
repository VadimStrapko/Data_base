use KHAT_MyBase;
--use TEMPDB;

/* ex_1 */
exec sp_helpindex '�������'
exec sp_helpindex '������'
exec sp_helpindex '������' 

CREATE INDEX #index1 on �������([����������� �����] asc);
DROP INDEX #index1 on �������
--
SELECT * FROM ������� where [����������� �����] between 150 and 5000 order by [����������� �����];
checkpoint;  
DBCC DROPCLEANBUFFERS;  

/* ex_2 */
CREATE INDEX #index2 on �������([����������� �����],[����� ����]);
DROP INDEX #index2 on ������_��������
--
SELECT * FROM ������� where [����������� �����] between 150 and 5000 order by [����������� �����];
checkpoint;  
DBCC DROPCLEANBUFFERS;  

/* ex_3 */
CREATE INDEX #index3 on �������([����������� �����]) INCLUDE([����� ����])
DROP INDEX #index3 on ������_��������
--
SELECT * FROM ������� where [����������� �����] between 150 and 5000 order by [����������� �����];
checkpoint;  
DBCC DROPCLEANBUFFERS;  

/* ex_4 */
CREATE INDEX #index4 on �������([����������� �����]) where([����������� �����] >= 150 and [����������� �����] <= 2000)
DROP INDEX #index4 on ������_��������
--
SELECT * FROM ������� where [����������� �����] between 150 and 5000 order by [����������� �����];
checkpoint;  
DBCC DROPCLEANBUFFERS; 