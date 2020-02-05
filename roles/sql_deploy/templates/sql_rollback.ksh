#!/bin/ksh
sqlplus /@RMS_rmsdev01  << EOF >/tmp/logs/rms_rollback.log
set verify off;
show user;
@{{ Staging }}/jl_rollback_3749.sql
@{{ Staging }}/Jl_rms_msup_barcode_validate.pkb
@{{ Staging }}/jl_insert_rest_cntl_backout.sql
@{{ Staging }}/jl_insert_rest_pgm_sts_backout.sql
@{{ Staging }}/jl_rollback_rebate_rtk_errors.sql
@{{ Staging }}/jl_rollback_rebate_navigation.sql 
@{{ Staging }}/jl_rollback_rebate_codehead_detail.sql
exit;
EOF
sqlplus INTERFACES_STAGING/"1Nt3rF43ces!" @RMS_RMSPRE01 << EOF >/tmp/logs/intr_stg_rollback.log
set verify off;
show user;
@{{ Staging }}/jl_marketing_rebate_interface_rollback.sql
exit;
EOF
sqlplus /@RMS_rmsdev01  << EOF >>/tmp/logs/rms_rollback.log
set verify off;
show user;
@{{ Staging }}/jl_marketing_rebate_rollback.sql
@{{ Staging }}/jl_arch_prg_general_dtl_rollback_cod2998.sql
exit;
EOF
sqlplus INTERFACES_STAGING/"1Nt3rF43ces!" @RMS_RMSPRE01 << EOF >>/tmp/logs/intr_stg_rollback.log
set verify off;
show user;
@{{ Staging }}/jl_mr_intf_rollback.sql
exit;
EOF
sqlplus /@RMS_rmsdev01  << EOF >>/tmp/logs/rms_rollback.log
set verify off;
show user;
@{{ Staging }}/jl_buying_role_rms_nav_cod_2998_rollback.sql
exit;
EOF
