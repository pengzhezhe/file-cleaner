#!/system/bin/sh
MODDIR=${0%/*}
LOGDIR=$MODDIR/logs

# Running the clean process only when the screen on.
if [[ $(dumpsys window policy | grep "mInputRestricted" | cut -d= -f2) == "false" ]]; then
    
    # Create the log folder
    if [[ ! -d $LOGDIR ]]; then
        mkdir -p $LOGDIR
    fi

    # Create the log file.
    if [[ ! -f $MODDIR/logs/$(date +%Y-%m-%d) ]]; then
        touch $MODDIR/logs/$(date +%Y-%m-%d)
    fi

    # Read config file
    source $MODDIR/files.conf
   
    # Delete the files and folders in the configuration file. And wirte the deleted file or folder name to the log file.
    for i in $files
    do
        if [[ -d $i ]]; then
            rm -rf $i
            echo "$(date +%H:%M:%S):Delete folder: $i" >> $MODDIR/logs/$(date +%Y-%m-%d)
        elif [[ -f $i ]]; then
            rm -f $i
            echo "$(date +%H:%M:%S):Delete file: $i" >> $MODDIR/logs/$(date +%Y-%m-%d)
        fi
    done
fi