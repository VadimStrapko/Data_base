

--1--

Create database KR;

use KR;

CREATE TABLE STUDENT(
	IDST int primary key,
	IDGROUP int  check(IDGROUP > 0 AND IDGROUP <= 10) not null,
	NAME varchar(50) not null,
	BDAY date not null
);

Create table SESSIA
(
	SUBJ nvarchar(50) not null,
	IDST int foreign key references STUDENT,
	PDATE date not null,
	NOTE tinyint default(0)
);

INSERT INTO STUDENT values 
(1, 5, 'Хатченок Дмитрий Николаевич', '2004-09-21'),
(2, 6, 'Страпко Вадим Юрьевич', '2004-07-20'),
(3, 4, 'Ткачев Георгий Александрович', '2004-07-14'),
(4, 5, 'Верчук Родион Харитонович', '2005-06-09')


INSERT INTO SESSIA values
('ОаИП', 3, '2023-06-18', default),
('АиСД', 2, '2024-01-16', 6),
('КСИС', 4, '2024-01-12', 7),
('КПО', 2, '2023-06-05', 3);

select PDATE, SUBJ, NAME, NOTE
from STUDENT inner join SESSIA
on STUDENT.IDST = SESSIA.IDST
WHERE NOTE between 5 and 7



--2--

SELECT COUNT(case 
			when NOTE = 5 then '5'
			when NOTE = 6 then '6'
			when NOTE = 7 then '7'
			else 'другая оценка'
			end) as [Количество оценок]
FROM (
  SELECT PDATE, SUBJ, NAME, NOTE
  FROM STUDENT INNER JOIN SESSIA
  ON STUDENT.IDST = SESSIA.IDST
) AS filtered_data
WHERE NOTE BETWEEN 5 AND 7
GROUP BY case 
			when NOTE = 5 then '5'
			when NOTE = 6 then '6'
			when NOTE = 7 then '7'
			else 'другая оценка'
			end;