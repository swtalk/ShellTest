GREP_CRITERIA=$(date +"%Y:%H:%M" -d -1minute)
TODAY=`date "+%Y%m%d"`
FILE='/home1/irteam/logs/apache/access.log'

function monitor_loop
{
cat $FILE.$TODAY | grep $GREP_CRITERIA | awk '{print $9}' | sort -rn | uniq -c |

#Swap key value (variable)
while read key value;
do
        echo ""$value"_STATUS $key"
done
}

while true
do
monitor_loop
sleep 60
done
