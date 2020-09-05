#!/bin/bash
#enter input encoding here
FROM_ENCODING="ISO-8859-1"
#output encoding(UTF-8)
TO_ENCODING="UTF-8//TRANSLIT"
#convert
CONVERT=" iconv  -f   $FROM_ENCODING  -t   $TO_ENCODING"
mkdir ../src/iso-encoded

#loop to convert multiple files 
for  file  in  ../src/*.lat; do
	isutf8 -q ${file} > /dev/null
	OUT=$?
	if [ $OUT -eq 1 ];then
		$CONVERT   "$file"   -o  "${file}.utf8"
		mv $file ../src/iso-encoded/
		mv ${file}.utf8 ${file}
	fi
done
exit 0

