spool {{ destDir }}/table_count.log ;
select SYSTIMESTAMP from dual;
show user;
select * from global_name;
@{{ destDir }}/RIB_TOPIC_CHECK.sql;
spool off;
exit;

