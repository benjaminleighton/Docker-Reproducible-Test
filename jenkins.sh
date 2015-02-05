#!/bin/bash
./test.sh > new_sha.out
if [ -f ./last_sha.out ];
then
	if diff ./new_sha.out ./last_sha.out >/dev/null ; then
	  echo "Success: results are reproduced" 
	  RC=0
	else
	  echo "Failure: results are not reproduced" 
	  RC=1
	fi
else
	RC=0
fi
mv new_sha.out last_sha.out
git add last_sha.out
git commit -m "new result"
git push
