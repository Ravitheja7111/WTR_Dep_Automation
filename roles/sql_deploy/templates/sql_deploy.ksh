#!/bin/ksh
source /home/oretail/.profile
sqlplus INTERFACES_STAGING/"esb0rds!123"@RMS_RMSTST01 << EOF > output.txt
@{{ Staging }}/CRE_TAB_JL_SUPPLIER_DISSECTION.sql
exit;
EOF
RETVAL=`grep -E "unknown command|ERROR at|ORA-*" output.txt | wc -l`
if [ $RETVAL -gt 1 ];then
echo "1st SQLPLUS FAILED : $RETVAL"
   exit 1
fi

sqlplus /@RMS_RMSTST01 << EOF > output.txt
 @{{ Staging }}/insert_rtk_errors.sql
exit;
EOF
RETVAL=`grep -E "unknown command|ERROR at|ORA-*" output.txt | wc -l`
if [ $RETVAL -gt 1 ];then
echo "2nd SQLPLUS FAILED : $RETVAL"
   exit 1
fi

sqlplus /@RMS_RMSTST01  << EOF > output.txt
@{{ Staging }}/jl_rms_msup_supplier_validate.pkb
exit;
EOF
RETVAL=`grep -E "unknown command|ERROR at|ORA-*" output.txt | wc -l`
if [ $RETVAL -gt 1 ];then
echo "3rd SQLPLUS FAILED: $RETVAL"
   exit 1
fi

sqlplus /@RMS_RMSTST01 << EOF > output.txt
@{{ Staging }}/JL_SUPP_DISSECTION_VALIDATE.pks
exit;
EOF
RETVAL=`grep -E "unknown command|ERROR at|ORA-*" output.txt | wc -l`
if [ $RETVAL -gt 1 ];then
echo "nth SQLPLUS FAILED : $RETVAL"
   exit 1
fi

sqlplus /@RMS_RMSTST01 << EOF > output.txt
@{{ Staging }}/JL_SUPP_DISSECTION_VALIDATE.pkb 
exit;
EOF
RETVAL=`grep -E "unknown command|ERROR at|ORA-*" output.txt | wc -l`
if [ $RETVAL -gt 1 ];then
echo "nth SQLPLUS FAILED : $RETVAL"
   exit 1
fi
