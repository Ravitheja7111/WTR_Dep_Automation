#!/bin/ksh
source /home/oretail/.profile

VAR=`cat deploy_list.txt`

echo "var:$VAR"
echo "line:"
while IFS= read -r line; do
    echo "Line: $line"
    file_name=${line%~*}
    echo "file_name:$file_name"
    schema=${line#*~}
    echo "schema:$schema"
    if [ "$schema" == "RMS" ];then
	   con_string="/@RMS_RMSTST01"
	   else
  		con_string="INTERFACES_STAGING/"esb0rds!123"@RMS_RMSTST01"
    fi
    echo $file_name
    echo $con_string
sqlplus $con_string << EOF >> `date '+%Y-%m-%d'`_$file_name.log
@{{ Staging }}/$file_name
exit;
EOF
RETVAL=`grep -E "unknown command|unable to open file|ERROR at|ORA-*" output.txt | wc -l`
if [ $RETVAL -gt 1 ];then
echo "1st SQLPLUS FAILED : $RETVAL"
   exit 1
fi 	
done <<< "$VAR"