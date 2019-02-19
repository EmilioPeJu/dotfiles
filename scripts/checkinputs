#!/bin/bash
EXEC="$(find -name '*.out' -printf '%T+ %p\n' | sort -r \
    | head -n 1 | cut -d ' ' -f 2)"
echo "Testing binary $EXEC"
for file in "in"??; do
    suffix="${file#in}"
    echo "input file: $file"
    cat "$file" | ./${EXEC}  > "current$suffix"
    if [[ -f "out$suffix" ]]; then
        cmp "current$suffix" "out$suffix"
        if [[ $? -ne 0 ]]; then
            echo "FAILED"
            diff "current$suffix" "out$suffix"
            break
        else
            echo "PASSED"
        fi
    else
        cat "current$suffix"
    fi
done
