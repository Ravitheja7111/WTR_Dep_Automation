#!/bin/ksh
source /home/oretail/.profile
sqlplus /@RMS_rmsdev01  @{{ Staging }}/dml_code_detail_cod-5718.sql > output.txt
RETVAL=`egrep 'unknown command || ERROR at || ORA-*' output.txt | wc -l`
if [ $RETVAL -gt 1 ];then
echo "1st SQLPLUS FAILED : $RETVAL"
   exit 1
fi

sqlplus /@RMS_rmsdev01  @{{ Staging }}/jl_suprebateboxi.sql > output.txt
RETVAL=`egrep 'unknown command || ERROR at || ORA-*' output.txt | wc -l`
if [ $RETVAL -gt 1 ];then
echo "2nd SQLPLUS FAILED : $RETVAL"
   exit 1
fi

sqlplus /@RMS_rmsdev01  @{{ Staging }}/jl_suprebateextract.sql > output.txt
RETVAL=`egrep 'unknown command || ERROR at || ORA-*' output.txt | wc -l`
if [ $RETVAL -gt 1 ];then
echo "3rd SQLPLUS FAILED: $RETVAL"
   exit 1
fi

sqlplus /@RMS_rmsdev01  @{{ Staging }}/jl_suprebatetdmarx.sql > output.txt
RETVAL=`egrep 'unknown command || ERROR at || ORA-*' output.txt | wc -l`
if [ $RETVAL -gt 1 ];then
echo "nth SQLPLUS FAILED : $RETVAL"
   exit 1
fi

exit;
