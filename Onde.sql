set lines 500 pages 500
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
SELECT SUBSTR(GLOBAL_NAME,1,10) 	ONDE
     , SUBSTR(INSTANCE_NAME,1,10)	INSTANCIA
     , SUBSTR(USER,1,10)        	QUEM
     ,SUBSTR(HOST_NAME,1,15)    	SERVIDOR
	 ,SUBSTR(UTL_INADDR.get_host_address,1,15)	IP
     ,SUBSTR(STATUS,1,8)               STATUS
 	 , startup_time			STARTUP
     , sysdate				AGORA
	 , SUBSTR(version,1,10)				"VERSAO"
  FROM GLOBAL_NAME, V$INSTANCE;