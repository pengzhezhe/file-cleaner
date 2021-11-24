#!/system/bin/sh

MODDIR=${0%/*}
function PROCESS()
{
    ps -ef | grep "clean.sh" | grep -v grep | wc -l
}

until [[ $(getprop sys.boot_completed) -eq 1 ]]
do
    sleep 2
done

until [[ $(PROCESS) -ne 0 ]]
do
    nohup sh $MODDIR/clean.sh &
    sleep 5
done