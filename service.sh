#!/system/bin/sh

MODDIR=${0%/*}

until [[ $(getprop sys.boot_completed) -eq 1 ]]
do
    sleep 2
done

sh $MODDIR/clean.sh

# Kill exist crond process
crond_pid="$(ps -ef | grep -v 'grep' | grep 'crond' | grep 'file-cleaner' | awk '{print $2}')"
if [[ ! -z "${crond_pid}" ]]; then
    for kill_pid in ${crond_pid}; do
        kill -9 ${kill_pid}
    done
fi

# Create crond config file, and start cron task.
echo "#!/system/bin/sh" > $MODDIR/cron.d/root
echo "*/1 * * * * sh \"$MODDIR/clean.sh\"" >> $MODDIR/cron.d/root
crond -c $MODDIR/cron.d