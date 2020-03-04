#!/bin/ksh
source /home/oretail/.profile

read -r -d '' VAR <<- EOM
    CRE_TAB_JL_SUPPLIER_DISSECTION.sql~INTERFACE_STAGING
    insert_rtk_errors.sql~RMS
EOM

for object in $VAR
do
file_name=${object%~*}
echo "file_name:$file_name"
schema=${object#*~}
echo "schema:$schema"
if [ "$schema" == "RMS" ];then
	con_string="/@RMS_RMSTST01"
	else
  		con_string="INTERFACES_STAGING/"esb0rds!123"@RMS_RMSTST01"
fi
echo $file_name
echo $con_string

sqlplus $con_string << EOF >> output.txt
@{{ Staging }}/$file_name
exit;
EOF
RETVAL=`grep -E "unknown command|ERROR at|ORA-*" output.txt | wc -l`
if [ $RETVAL -gt 1 ];then
echo "1st SQLPLUS FAILED : $RETVAL"
   exit 1
fi
done
