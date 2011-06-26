#!/bin/bash

echo "tests:"
for file in test-*.scm
do
    echo "$file"
    stk $file
done

