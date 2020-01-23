spool  /tmp/db.txt append ;
select SYSTIMESTAMP from dual;
show user;
select * from global_name;
@{{ destDir }}/MFQUEUE_CHECK.sql;
@{{ destDir }}/RIB_TOPIC_CHECK.sql;
spool off;
exit;

