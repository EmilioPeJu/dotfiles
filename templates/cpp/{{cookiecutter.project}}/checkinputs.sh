#!/bin/bash
EXEC="{{cookiecutter.project}}.out"
for file in "in"*; do
	suffix="${file#in}"
	echo "Testing $file"
	cat "$file" | ./${EXEC}	> "current$suffix"
	if [[ -f "out$suffix" ]]; then
		cmp "current$suffix" "out$suffix"
		if [[ $? -ne 0 ]]; then
			echo "FAILED"
			meld "current$suffix" "out$suffix"
			break
		else
			echo "PASSED"
		fi
	else
		cat "current$suffix"
	fi
done
