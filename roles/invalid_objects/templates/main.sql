show user;
select * from global_name;
@{{ destDir }}/all_objects_pub.sql;
@{{ destDir }}/all_objects_not_pub.sql;
@{{ destDir }}/dba_objects_pub.sql;
@{{ destDir }}/dba_objects_not_pub.sql;
@{{ destDir }}/all_objects_cmp_body_not_pub.sql
@{{ destDir }}/all_objects_cmp_pkg_pub.sql
@{{ destDir }}/all_objects_cmp_body_pub.sql
@{{ destDir }}/all_objects_cmp_pkg_not_pub.sql
@{{ destDir }}/dba_objects_cmp_body_not_pub.sql
@{{ destDir }}/dba_objects_cmp_pkg_not_pub.sql
@{{ destDir }}/dba_objects_cmp_body_pub.sql
@{{ destDir }}/dba_objects_cmp_pkg_pub.sql
exit;

