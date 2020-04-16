spool /home/oretail/pre_check_scripts/rc_all_objects_cmp_body_pub.sql
select 'ALTER '|| OBJECT_TYPE || ' ' || OWNER || '.' || OBJECT_NAME || ' COMPILE BODY;'
 from all_objects dob
 where dob.owner = 'PUBLIC'
 and dob.object_type in ('PACKAGE')
 and dob.GENERATED != 'Y'
 and dob.status='INVALID';
spool off;
@/home/oretail/pre_check_scripts/rc_all_objects_cmp_body_pub.sql