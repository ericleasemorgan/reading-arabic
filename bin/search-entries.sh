#!/usr/bin/env bash

# configure
WORDS=('إشتغل ب … على' 'اجتمع ' 'اقام ب' 'اقول' 'البيت المقدس' 'المقدسي' 'انتقل الى ' 'انطاكية' 'بغداد' 'بلاد الروم' 'حدثني' 'حلب' 'خدم' 'خدمة' 'دمشق' 'دمشقي' 'رملة' 'سافر من ... الى' 'عرض ل' 'فسطاط' 'قال' 'قاهرة' 'مقيما ب' 'مولده و منشو ب')

CORPUS='./txt'

# process each word
for WORD in "${WORDS[@]}"; do

	echo "$WORD"
	echo "==================="
	echo
	
	# process each file in the corpus
	find $CORPUS -type f | while read FILE; do
	
		# search
		RESULTS=$( grep "$WORD" $FILE )
		
		# output, conditionally
		if [[ $RESULTS ]]; then 
		
			echo $FILE
			echo $RESULTS
			echo
		
		fi
		
	done
	
	echo
	
done
