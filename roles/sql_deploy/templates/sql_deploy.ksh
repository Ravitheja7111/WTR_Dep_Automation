#!/bin/ksh
source /home/oretail/.profile

VAR=`cat /home/oretail/deploy_list.txt`

echo "var:$VAR"
echo "line:"
log_file_name=output_`date +%Y-%m-%d`.log
log_time=_`date +%X`
if [ -f "$log_file_name" ]; then
 `mv $log_file_name "$log_file_name$log_time"`
fi 
while IFS= read -r line; do
    echo "Line: $line"
    file_name=${line%~*}
    echo "file_name:$file_name"
    schema=${line#*~}
    echo "schema:$schema"
    if [ "$schema" == "RMS" ];then
	   con_string="{{ rms_schema }}"
	   else
  		con_string="{{ intr_schema }}"
    fi
    echo $file_name
    echo $con_string
    echo "sqlplus $con_string << EOF >> $log_file_name"
sqlplus $con_string << EOF >> $log_file_name
@{{ Staging }}/$file_name;
commit;
exit;
EOF
RETVAL=`grep -E "unknown command|unable to open file|ERROR at|ORA-*|*error*" $log_file_name | wc -l`
if [ $RETVAL -gt 0 ];then
echo "1st SQLPLUS FAILED : $RETVAL"
   exit 1
fi 	
done <<< "$VAR"
