#!/bin/bash
#
# chkconfig: 35 99 99
# description: Node.js /home/MrKen/kenniu_product/backend_release/bin/www
#

. /etc/rc.d/init.d/functions

# 参考了 https://gist.github.com/nariyu/1211413
# 根据你的实际情况修改以下变量值
USER="MrKen"
DAEMON="/usr/bin/node"
ROOT_DIR="/home/MrKen/kenniu_product/backend_release/"
SERVER="$ROOT_DIR/bin/www"
LOG_FILE="$ROOT_DIR/app.log"
PORT = 2589
LOCK_FILE="/var/lock/subsys/node-server"

do_start()
{
        if [ ! -f "$LOCK_FILE" ] ; then
                echo -n $"Starting $SERVER: "
                runuser -l "$USER" -c "PORT=$PORT $DAEMON $SERVER >> $LOG_FILE &" && echo_success || echo_failure
                RETVAL=$?
                echo
                [ $RETVAL -eq 0 ] && touch $LOCK_FILE
        else
                echo "$SERVER is locked."
                RETVAL=1
        fi
}

do_stop()
{
        echo -n $"Stopping $SERVER: "
        pid=`ps -aefw | grep "$DAEMON $SERVER" | grep -v " grep " | awk '{print $2}'`
        kill -9 $pid > /dev/null 2>&1 && echo_success || echo_failure
        RETVAL=$?
        echo
        [ $RETVAL -eq 0 ] && rm -f $LOCK_FILE
}

case "$1" in
        start)
                do_start
                ;;
        stop)
                do_stop
                ;;
        restart)
                do_stop
                do_start
                ;;
        *)
                echo "Usage: $0 {start|stop|restart}"
                RETVAL=1
esac
