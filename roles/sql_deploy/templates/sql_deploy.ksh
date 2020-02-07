#!/bin/ksh
source /home/oretail/.profile
sqlplus /@RMS_rmsdev01  << EOF
set verify off;
show user;
@{{ Staging }}/batch_jlsellingretailau.ksh
@{{ Staging }}/jl_insert_rebates_rtk_errors.sql
@{{ Staging }}/jl_create_rebate_navigation.sql
@{{ Staging }}/jl_rebate_sequence_seq.sql
@{{ Staging }}/jl_insert_rebate_codehead_detail.sql
@{{ Staging }}/jl_marketing_rebate_create_table.sql
@{{ Staging }}/jl_marketing_rebate_h_create_table.sql
@{{ Staging }}/jl_marketing_rebates_sql_s.pls
@{{ Staging }}/jl_marketing_rebates_sql_b.pls
exit;
EOF
sqlplus INTERFACES_STAGING/"1Nt3rF43ces!" @RMS_RMSPRE01 << EOF
set verify off;
show user;
@{{ Staging }}/jl_marketing_rebate_interface_cre.sql
@{{ Staging }}/jl_marketing_rebate_intrfc_h_cre.sql
@{{ Staging }}/jl_mr_project_intf_cre.sql
exit;
EOF
sqlplus /@RMS_rmsdev01  << EOF
set verify off;
show user;
@{{ Staging }}/jl_rebate_config_cre.sql
@{{ Staging }}/jl_rebate_config_insert.sql
@{{ Staging }}/jl_marketrebate.sql
@{{ Staging }}/jl_marketrebate.ksh
@{{ Staging }}/jl_arch_prg_general_dtl_insert_gen_module_cod2998.sql
@{{ Staging }}/jl_arch_prg_general_dtl_insert_ints_module_cod2998.sql
@{{ Staging }}/jl_marketing_rebate_audit_cre.sql
@{{ Staging }}/jl_marketing_rebate_aiudr.sql
@{{ Staging }}/jl_marketing_rebate_grant_synonym.sql
@{{ Staging }}/jl_buying_role_rms_nav_cod_2998.sql
exit;
EOF
