#!/usr/bin/env bash

#Obtaining all the pages of contributors using the github API

#if github places limits on your fetch (message: API rate limit exceeded), modify the range and fetch what is missing after a couple of hours using >make api
#currently there are about 60 pages of contributors




mkdir api
cd api
rm exit-everything

i=1

fetch(){
    VARI='https://api.github.com/repos/rms-support-letter/rms-support-letter.github.io/contributors?per_page=90&anon=1&page='$i
    curl -H "Accept: application/vnd.github.v3+json" $VARI > $VARO


    #check if retrieved file is still valid
    if cmp -s $VARO ../github-api-limit-reached;then
           printf "Github API limit reached, re run >make after some hours"
           touch exit-everything
           exit
    fi

    #if the retrieved file is empty, no further fetch in needed
    if cmp -s $VARO ../github-api-empty;then
        exit
    fi
}

for j in {1..100}
do
    i=$j
    VARO='api'$i
    #when re runned it skips the fetch of pages already downloaded
    if [ -f $VARO ]; then
        #when re runned it re fetches each page if previously it had API limit error
       if cmp -s $VARO ../github-api-limit-reached; then
           fetch
        # when encounters an empty page, it fetches it again to see if it still is empty, and also fetches the previous one that could have grown
       elif cmp -s $VARO ../github-api-empty; then
           fetch
           i=$i-1
           fetch
       else
           continue
       fi
    else
        fetch
    fi
done
