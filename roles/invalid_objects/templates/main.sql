show user;
select * from global_name;
@{{ destDir }}/all_objects_pub.sql;
@{{ destDir }}/dba_objects_pub.sql;
@{{ destDir }}/all_objects_not_pub.sql;
@{{ destDir }}/dba_objects_not_pub.sql;
exit;

