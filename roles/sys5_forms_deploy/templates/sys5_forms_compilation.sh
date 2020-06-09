#!/bin/bash
#source /home/rmsapp/.profile
forms_file={{ form_file_path }}/forms.txt
sed -i 's/\r//g' $forms_file

#Exporting variables
cd /u01/app/rmsapp
. ./forms_exec_profile

db_name=`echo $ORACLE_SID`
export PATH
ORACLE_TERM=vt220
export ORACLE_TERM
TERM=vt220
export TERM
ORACLE_PATH=/u01/app/retail_home/RMS_FORMS/base/forms/src
cd $ORACLE_PATH
echo "UP is $UP"
echo "All variables have been exported successfully"

log_name=""$db_name"_$(date +"%Y-%m-%d-%T")"
forms_dep_logs={{ staging_base }}/forms_dep_logs/$log_name
mkdir -p $forms_dep_logs
forms_dep_files={{ form_file_path }}

########## FMB files compilation ##################
for form_name in `cat "$forms_file"`
do
    form_log="$form_name".log
    frm_name=`echo $form_name | cut -d '.' -f1`
    frm_ext=`echo $form_name | cut -d '.' -f2`
    if [ $frm_ext == fmb ];then
        cp -p $forms_dep_files/$form_name $ORACLE_PATH
        chmod 777 $ORACLE_PATH/$form_name
        echo "copied $form_name to $ORACLE_PATH ========================================================="
		$ORACLE_PATH/frmcmp_batch.sh userid=$UP batch=no module=$ORACLE_PATH/$form_name output_file=$ORACLE_PATH/"$frm_name".fmx  module_type=form compile_all=yes window_state=minimize
        form_com="$frm_name".fmx
		#Check if compiled form .fmx file available in src and ready to move to bin
        if [ -e $ORACLE_PATH/$form_com ];then
            echo "$form_com has been generated"
            chmod -R 777 $ORACLE_PATH/$form_com
            echo "Permission has been changed for $form_com" >> $forms_dep_logs/$form_log
            mv $ORACLE_PATH/$form_com $ORACLE_PATH/../bin
            cd $ORACLE_PATH/../bin
            if [ -e $form_com ];then
                echo "$form_com has been moved to bin" >> $forms_dep_logs/$form_log
            else
                echo "$form_com has not been moved to bin properly" >> $forms_dep_logs/$form_log
            fi
        else
            echo "Form compilation has been failed " >> $forms_dep_logs/$form_log
            exit -1
        fi
    elif [ $frm_ext == mmb ];then
		form_log="$form_name".log
		cp -p $forms_dep_files/$form_name $ORACLE_PATH
		chmod 777 $ORACLE_PATH/$form_name
		echo "copied $form_name to $ORACLE_PATH ========================================================="
		$ORACLE_PATH/frmcmp_batch.sh userid=$UP batch=no module=$ORACLE_PATH/$form_name  output_file=$ORACLE_PATH/"$frm_name".mmx module_type=menu compile_all=yes window_state=minimize
		form_com="$frm_name".mmx
		#Check if compiled form .fmx file available in src and ready to move to bin
		if [ -e $ORACLE_PATH/$form_com ];then
			echo "$form_com has been generated"
			chmod -R 777 $ORACLE_PATH/$form_com
			echo "Permission has been changed for $form_com" >> $forms_dep_logs/$form_log
			mv $ORACLE_PATH/$form_com $ORACLE_PATH/../bin
			cd $ORACLE_PATH/../bin
			if [ -e $form_com ];then
					echo "$form_com has been moved to bin" >> $forms_dep_logs/$form_log
			else
					echo "$form_com has not been moved to bin properly" >> $forms_dep_logs/$form_log
			fi
		else
			echo "Form compilation has been failed " >> $forms_dep_logs/$form_log
			exit -1
		fi
        elif [ $frm_ext == pll ];then
            form_log="$form_name".log
            cp -p $forms_dep_files/$form_name $ORACLE_PATH
            chmod 777 $ORACLE_PATH/$form_name
            echo "copied $form_name to $ORACLE_PATH ========================================================="
            $ORACLE_PATH/frmcmp_batch.sh userid=$UP batch=no module=$ORACLE_PATH/$form_name  output_file=$ORACLE_PATH/"$frm_name".plx module_type=library compile_all=yes window_state=minimize
            form_com="$frm_name".plx
            #Check if compiled form .fmx file available in src and ready to move to bin
            if [ -e $ORACLE_PATH/$form_com ];then
                echo "$form_com has been generated"
                chmod -R 777 $ORACLE_PATH/$form_com
                echo "Permission has been changed for $form_com" >> $forms_dep_logs/$form_log
                mv $ORACLE_PATH/$form_com $ORACLE_PATH/../bin
                cd $ORACLE_PATH/../bin
                if [ -e $form_com ];then
                    echo "$form_com has been moved to bin" >> $forms_dep_logs/$form_log
                else
                    echo "$form_com has not been moved to bin properly" >> $forms_dep_logs/$form_log
                fi
            else
                echo "Form compilation has been failed " >> $forms_dep_logs/$form_log
                exit -1
            fi
            else
                echo "Form extensions are mis matched " >> $forms_dep_logs/$form_log
    fi
done
