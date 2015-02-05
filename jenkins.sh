#!/bin/bash
set -e
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
docker build -t test .
docker run -v $DIR:/shared test /bin/bash -c "/shared/test.sh"  > test_result.txt 
if [ -f ./last_test_result.txt ];
then
	if diff ./test_result.txt ./last_test_result.txt >/dev/null ; then
	  echo "Success: results are reproduced" 
	  cp test_result.txt last_test_result.txt 
          git add last_test_result.txt 
	  git commit -m "new result"
	  git push
	  exit 0
	else
	  echo "Failure: results are not reproduced" 
	  exit 1 
	fi
else
        git add last_test_result.txt 
	git commit -m "new result"
	git push
        exit 0	
fi
