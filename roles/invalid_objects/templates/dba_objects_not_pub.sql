spool /home/oretail/pre_check_scripts/rc_dba_objects_not_pub.sql
select 'ALTER '||'OBJECT_TYPE'||OWNER||'.'||OBJECT_NAME||' COMPILE';
  from dba_objects dob
  where dob.owner <> 'PUBLIC'
  and dob.object_type in ('SYNONYM','MATERIALIZED VIEW')
  and dob.GENERATED != 'Y'
  and dob.status='INVALID';
spool off;
@/home/oretail/pre_check_scripts/rc_dba_objects_not_pub.sql
