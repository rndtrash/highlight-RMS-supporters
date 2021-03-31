#!/usr/bin/env bash

if [ -d "./rms-support-letter.github.io" ]
then
	cd rms-support-letter.github.io
	git pull
	cd ..
else
	git clone https://github.com/rms-support-letter/rms-support-letter.github.io
fi

cd ./rms-support-letter.github.io/_data/signed/
touch ../list0 && ls > ../list0
cd ..
sed -i 's/.yaml//g' list0
awk '$0="https://github.com/"$0' list0 > list1
cat ../../rms-supporters.txt list1 > list2
sort -u list2 > list3
mv list3 ../../rms-supporters.txt
rm list0 list1 list2
