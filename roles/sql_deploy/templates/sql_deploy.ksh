#!/bin/ksh
source /home/oretail/.profile

VAR="JL_PROCESS_XITEMUDACRE_MSG.PKB~RMS"

while IFS= read -r line; do
    file_name=${line%~*}
    schema=${line#*~}
     if [ "$schema" == "RMS" ];then
	   con_string="/@RMS_RMSTST01"
	   else
  		con_string="INTERFACES_STAGING/"esb0rds!123"@RMS_RMSTST01"
    fi
sqlplus $con_string << EOF >> output.txt
@{{ Staging }}/$file_name
exit;
EOF
RETVAL=`grep -E "unknown command|ERROR at|ORA-*" output.txt | wc -l`
if [ $RETVAL -gt 1 ];then
echo "1st SQLPLUS FAILED : $RETVAL"
   exit 1
fi         
done <<< "$VAR"



