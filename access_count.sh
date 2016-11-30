#!/bin/bash
GREP_CRITERIA=$(date +"%Y:%H:%M" -d -1minute)
TODAY=`date "+%y%m%d"`
FILE='/home1/irteam/logs/apache/access.log'
FILE1='/home1/irteam/logs/apache/access_ssl.log'

function http_monitor_loop
{

ret=$(cat $FILE.$TODAY | grep $GREP_CRITERIA | awk '{print $9}' | grep $1 | wc -l)
echo $ret

}


function https_monitor_loop
{

ret1=$(cat $FILE1.$TODAY | grep $GREP_CRITERIA | awk '{print $9}' | grep $1 | wc -l)
echo $ret1

}

        for i in 200 404 500 502
        do
                        var1=$(http_monitor_loop "$i")
                        echo "HTTP_CODE_$i $var1"
        done

        for j in 200 404 500 502
        do
                        var2=$(https_monitor_loop "$j")
                        echo "HTTPS_CODE_$j $var2"
        done


출력 결과 

HTTP_CODE_200 662
HTTP_CODE_404 0
HTTP_CODE_500 0
HTTP_CODE_502 0
HTTPS_CODE_200 745
HTTPS_CODE_404 0
HTTPS_CODE_500 0
HTTPS_CODE_502 0
