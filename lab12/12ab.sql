--- B ---	
	

	use Univer;

	begin transaction 	  
		delete SUBJECT where SUBJECT = 'СТПИ';
		INSERT into SUBJECT values('СТПИ','Современные технологии программирования в интернете','ИСиТ');
        update SUBJECT set SUBJECT_NAME = 'Современные технологии программирования в INTERNET' where  SUBJECT = 'СТПИ';
	    select SUBJECT_NAME from SUBJECT where PULPIT = 'ИСиТ';
     -------------------------- t1 --------------------
     commit; 
     select SUBJECT_NAME,PULPIT from SUBJECT where PULPIT = 'ИСиТ';
     -------------------------- t2 --------------------
	 		
	delete SUBJECT where SUBJECT = 'СТПИ';