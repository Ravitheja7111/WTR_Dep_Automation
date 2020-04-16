spool /home/oretail/pre_check_scripts/rc_all_objects_pub.sql
select 'ALTER '|| OWNER || ' ' || OBJECT_TYPE || ' ' || OBJECT_NAME || ' COMPILE;'
  from all_objects dob
  where dob.owner = 'PUBLIC'
  and dob.object_type in ('SYNONYM','MATERIALIZED VIEW')
  and dob.GENERATED != 'Y'
  and dob.status='INVALID';
spool off;
@/home/oretail/pre_check_scripts/rc_all_objects_pub.sql