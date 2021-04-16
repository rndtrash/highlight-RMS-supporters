#!/usr/bin/env bash
#3 WAYS of obtaining the github accounts

#WAY By clonning the repository
#if the letter repository has not been cloned it does so, else pulls
rm rms-supporters.txt
touch rms-supporters.txt
mkdir api

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
mv list2 ../../api/apclone
rm list0 list1
cd ../../api

#WAY Through the Github API
#Obtaining all the pages of contributors using the API

#if github places limits on your fetch (message: API rate limit exceeded), modify the range and fetch what is missing after a couple of hours
#currently there are about 60 pages of contributors
for i in {1..70}
do
    VARI='https://api.github.com/repos/rms-support-letter/rms-support-letter.github.io/contributors?per_page=90&anon=1&page='$i
    VARO='api'$i
    curl -H "Accept: application/vnd.github.v3+json" $VARI > $VARO
done

#API contributors
echo here2
cat api* | grep "\"login\"" >> aplogin0
cat aplogin0 | cut -c 15- > aplogin1
sed -i 's/\",//' aplogin1
awk '$0="https://github.com/"$0' aplogin1 > aplogin2

#API anonymous contributors
cat api* | grep "noreply.github" >> apnoreply0
cat apnoreply0 | cut -c 15- > apnoreply1
sed -i 's/@users.noreply.github.com\",//' apnoreply1
sed -i 's/*+//' apnoreply1
sed -i 's/^[^+]*+//' apnoreply1
awk '$0="https://github.com/"$0' apnoreply1 > apnoreply2

#WAY From the rendered html of the Support Letter
curl "https://rms-support-letter.github.io/" | grep "      <a href=\"https://github.com" > apicurl0
cat apicurl0 | cut -c 13- > apicurl1
sed -i 's/\">.*//' apicurl1

#Merging and deduplication
cat aplogin2 apnoreply2 apicurl1 apclone > ap
sort -u ap > ../rms-supporters.txt
#rm api*
cd ..
