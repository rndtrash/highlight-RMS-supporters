#!/usr/bin/env bash
rm rms-supporters.txt
touch rms-supporters.txt

FOLDER="api-supporters"
bash github-api/github-api-fetch.sh $FOLDER "rms-support-letter/rms-support-letter.github.io"
#github-api-fetch.sh has to have been executed, and if it failed try again later
if [ -f $FOLDER/exit-everything ]; then
    exit
fi

#3 WAYS of obtaining the github accounts
#WAY By clonning the repository
#if the letter repository has not been cloned, it clones it, else pulls

if [ -d "./rms-support-letter.github.io" ]
then
	cd rms-support-letter.github.io
	git pull
	cd ..
else
	git clone https://github.com/rms-support-letter/rms-support-letter.github.io
fi

#goes in the repository to get the yaml filenames and get their URLs from them
cd ./rms-support-letter.github.io/_data/signed/
touch ../list0 && ls > ../list0
cd ..
sed -i 's/.yaml//g' list0
awk '$0="https://github.com/"$0' list0 > list1
cat ../../rms-supporters.txt list1 > list2
mv list2 ../../$FOLDER/apclone
rm list0 list1
cd ../../$FOLDER

#WAY From the rendered html of the Support Letter
curl "https://rms-support-letter.github.io/" | grep "      <a href=\"https://github.com" > apicurl0
cat apicurl0 | cut -c 13- > apicurl1
sed -i 's/\">.*//' apicurl1

#Merging and deduplication
cat apoutput apicurl1 apclone > ap
sort -u ap > ../rms-supporters.txt
#rm api*
cd ..
