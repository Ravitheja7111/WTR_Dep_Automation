#!/bin/sh

rm -f dbobjects.txt batches.txt forms.txt templates.txt
for i in `cat release.txt`
do
	#file=`echo $i | cut -d '.' -f1`
	ext=`echo $i | cut -d '.' -f2`
	file_ext=`echo $ext | tr '[:upper:]' '[:lower:]'` 
	if [ $file_ext == 'sql' ] || [ $file_ext == 'pkb' ] || [ $file_ext == 'pks' ] || [ $file_ext == 'pls' ];then
		includefile=`echo $i|awk -F"/" '{print $NF}'`
		echo $includefile >> dbobjects.txt
		elif [ $file_ext == 'pc' ] || [ $file_ext == 'mk' ];then
			includefile=`echo $i`
			echo $includefile >> batches.txt
			elif [ $file_ext == 'sh' ] || [ $file_ext == 'ksh' ];then
				includefile=`echo $i`
				echo $includefile >> batches.txt
				elif [ $file_ext == 'fmb' ] ||[ $file_ext == 'mmb' ] || [ $file_ext == 'pll' ];then
					includefile=`echo $i`
					echo $includefile >> forms.txt
					else
						[ $file_ext == 'csv' ] ||[ $file_ext == 'xlsx' ] || [ $file_ext == 'ods' ]
						includefile=`echo $i`
						echo $includefile >> templates.txt
				
	fi
done



