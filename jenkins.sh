#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
docker build -t test .
docker run -v $DIR:/shared test /bin/bash -c "/shared/test.sh"  > test_result.txt 
if [ -f ./last_test_result.txt ];
then
	if diff ./test_result.txt ./last_test_result.txt >/dev/null ; then
	  echo "Success: results are reproduced" 
	  cp test_result.txt last_test_result.txt 
	  RC=0
	else
	  echo "Failure: results are not reproduced" 
	  RC=1
	fi
else
	RC=0
fi
#git add last_test_result.txt 
#git commit -m "new result"
#git push
