spool /home/oretail/pre_check_scripts/rc_dba_objects_cmp_pkg_pub.sql
select 'ALTER '|| OBJECT_TYPE || ' ' || OWNER || '.' || OBJECT_NAME || ' COMPILE PACKAGE;'
 from dba_objects dob
 where dob.owner = 'PUBLIC'
 and dob.object_type in ('PACKAGE')
 and dob.GENERATED != 'Y'
 and dob.status='INVALID';
spool off;
@/home/oretail/pre_check_scripts/rc_dba_objects_cmp_pkg_pub.sql