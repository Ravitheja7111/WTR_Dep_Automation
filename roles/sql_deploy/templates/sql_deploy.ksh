#!/bin/ksh
source /home/oretail/.profile
sqlplus INTERFACES_STAGING/"esb0rds!123"@RMS_RMSTST01  @{{ Staging }}/CRE_TAB_JL_SUPPLIER_DISSECTION.sql > output.txt
RETVAL=`egrep 'unknown command || ERROR at || ORA-*' output.txt | wc -l`
if [ $RETVAL -gt 1 ];then
echo "1st SQLPLUS FAILED : $RETVAL"
   exit 1
fi

sqlplus /@RMS_rmsdev01  @{{ Staging }}/insert_rtk_errors.sql > output.txt
RETVAL=`egrep 'unknown command || ERROR at || ORA-*' output.txt | wc -l`
if [ $RETVAL -gt 1 ];then
echo "2nd SQLPLUS FAILED : $RETVAL"
   exit 1
fi

sqlplus /@RMS_rmsdev01  @{{ Staging }}/jl_rms_msup_supplier_validate.pkb > output.txt
RETVAL=`egrep 'unknown command || ERROR at || ORA-*' output.txt | wc -l`
if [ $RETVAL -gt 1 ];then
echo "3rd SQLPLUS FAILED: $RETVAL"
   exit 1
fi

sqlplus /@RMS_rmsdev01  @{{ Staging }}/JL_SUPP_DISSECTION_VALIDATE.pks > output.txt
RETVAL=`egrep 'unknown command || ERROR at || ORA-*' output.txt | wc -l`
if [ $RETVAL -gt 1 ];then
echo "nth SQLPLUS FAILED : $RETVAL"
   exit 1
fi

sqlplus /@RMS_rmsdev01  @{{ Staging }}/JL_SUPP_DISSECTION_VALIDATE.pkb > output.txt
RETVAL=`egrep 'unknown command || ERROR at || ORA-*' output.txt | wc -l`
if [ $RETVAL -gt 1 ];then
echo "nth SQLPLUS FAILED : $RETVAL"
   exit 1
fi

exit;
