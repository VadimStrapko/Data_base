--- B ---	
	

	use Univer;

	begin transaction 	  
		delete SUBJECT where SUBJECT = '����';
		INSERT into SUBJECT values('����','����������� ���������� ���������������� � ���������','����');
        update SUBJECT set SUBJECT_NAME = '����������� ���������� ���������������� � INTERNET' where  SUBJECT = '����';
	    select SUBJECT_NAME from SUBJECT where PULPIT = '����';
     -------------------------- t1 --------------------
     commit; 
     select SUBJECT_NAME,PULPIT from SUBJECT where PULPIT = '����';
     -------------------------- t2 --------------------
	 		
	delete SUBJECT where SUBJECT = '����';