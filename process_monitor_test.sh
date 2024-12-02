#!/bin/bash

PROCESS_NAME="test"
LOG_FILE="/var/log/monitoring.log"
MONITORING_URL="https://test.com/monitoring/test/api"
PREV_PID_FILE="/tmp/test_prev_pid"

CURRENT_PID=$(pgrep "$PROCESS_NAME")

if [[ -n "$CURRENT_PID" ]]; then
    if [[ ! -f $LOG_FILE ]]; then
        touch $LOG_FILE
        chown :$USER $LOG_FILE
    fi

    if [[ -f "$PREV_PID_FILE" ]]; then
        PREV_PID=$(cat "$PREV_PID_FILE")
        if [[ "$CURRENT_PID" != "$PREV_PID" ]]; then
            echo "$(date +'%Y-%m-%d %H:%M:%S') - Процесс $PROCESS_NAME перезапущен. Новый PID: $CURRENT_PID" >> "$LOG_FILE"
        fi
    fi

    echo "$CURRENT_PID" > "$PREV_PID_FILE"

    url_try_output=$(curl -fsS --connect-timeout 5 --max-time 10 "$MONITORING_URL" -o /dev/null)
    if [[ $url_try_output ]]; then
        echo "$(date +'%Y-%m-%d %H:%M:%S') - Сервер мониторинга $MONITORING_URL недоступен." >> "$LOG_FILE"
    fi
else
    [[ -f "$PREV_PID_FILE" ]] && rm -f "$PREV_PID_FILE"
fi
