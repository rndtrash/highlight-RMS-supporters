#!/usr/bin/env bash


#Obtaining all the pages of contributors using the github API

#STRING ARGUMENTS
#first: folder name
#second: <owner>/<repository>

mkdir $1
cd $1
URL=$2
#global counter
i=1

#flag for other scripts if fetch failed
rm exit-everything

fetch(){
    VARI='https://api.github.com/repos/'$URL
    VARI=$VARI'/contributors?per_page=90&anon=1&page='$i
    curl -H "Accept: application/vnd.github.v3+json" $VARI > $VARO

    #check if retrieved file is still valid
   if (grep -q 'API rate limit exceeded' "$VARO" || [ ! -s $VARO ] );then
   #if (grep -q 'API rate limit exceeded' "$VARO" || cmp -s $VARO ../github-api/vacum);then
           printf "\n\n\n\n\n"
           printf "Github API download limit reached, attempt\n      \$ make\nagain after some hours\n\nthe full fetch requires this several times\nwhen its done you will no longer see this message"
           printf "\n\n\n\n\n"
           #check the existance of this file from other scripts to see if its fine to continue, if it exists its not
           touch exit-everything
           exit
    fi

    #if the retrieved file is empty, no further fetch in needed
    if cmp -s $VARO ../github-api/empty;then
        bash ../github-api/github-api-scrap.sh
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
       if grep -q 'API rate limit exceeded' "$VARO"; then
           fetch
        # when encounters an empty page, it fetches it again to see if it still is empty, and also fetches the previous one that could have grown
       elif cmp -s $VARO ../github-api/empty; then
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
bash ../github-api/github-api-scrap.sh
