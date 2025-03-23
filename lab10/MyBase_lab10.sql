use KHAT_MyBase;
--use TEMPDB;

/* ex_1 */
exec sp_helpindex 'РАСХОДЫ'
exec sp_helpindex 'ОТДЕЛЫ'
exec sp_helpindex 'ТОВАРЫ' 

CREATE INDEX #index1 on РАСХОДЫ([Потраченная сумма] asc);
DROP INDEX #index1 on РАСХОДЫ
--
SELECT * FROM РАСХОДЫ where [Потраченная сумма] between 150 and 5000 order by [Потраченная сумма];
checkpoint;  
DBCC DROPCLEANBUFFERS;  

/* ex_2 */
CREATE INDEX #index2 on РАСХОДЫ([Потраченная сумма],[Номер чека]);
DROP INDEX #index2 on Выдача_кредитов
--
SELECT * FROM РАСХОДЫ where [Потраченная сумма] between 150 and 5000 order by [Потраченная сумма];
checkpoint;  
DBCC DROPCLEANBUFFERS;  

/* ex_3 */
CREATE INDEX #index3 on РАСХОДЫ([Потраченная сумма]) INCLUDE([Номер чека])
DROP INDEX #index3 on Выдача_кредитов
--
SELECT * FROM РАСХОДЫ where [Потраченная сумма] between 150 and 5000 order by [Потраченная сумма];
checkpoint;  
DBCC DROPCLEANBUFFERS;  

/* ex_4 */
CREATE INDEX #index4 on РАСХОДЫ([Потраченная сумма]) where([Потраченная сумма] >= 150 and [Потраченная сумма] <= 2000)
DROP INDEX #index4 on Выдача_кредитов
--
SELECT * FROM РАСХОДЫ where [Потраченная сумма] between 150 and 5000 order by [Потраченная сумма];
checkpoint;  
DBCC DROPCLEANBUFFERS; 