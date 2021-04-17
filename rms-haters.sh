#!/usr/bin/env bash
rm rms-haters.txt
touch rms-haters.txt

FOLDER="api-haters"
bash github-api/github-api-fetch.sh $FOLDER "rms-open-letter/rms-open-letter.github.io"
#github-api-fetch.sh has to have been executed, and if it failed try again later
if [ -f $FOLDER/exit-everything ]; then
    exit
fi

cd $FOLDER
sort -u apoutput > ../rms-haters.txt
cd ..
