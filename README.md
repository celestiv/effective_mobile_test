# Тестовое задание на вакансию в компанию Effective Mobile

## Как запустить

- скопировать файл `process_monitor_test.sh` в директорию `/usr/local/bin`

`sudo cp process_monitor_test.sh /usr/local/bin`

- выдать этому файлу право на исполнение

`sudo chmod +x process_monitor_test.sh`

- скопировать файлы сервис и таймер в директорию `/etc/systemd/system/`

`sudo cp monitor_test.service /etc/systemd/system/`

`sudo cp monitor_test.timer /etc/systemd/system/`

- перезапустить демона systemd, чтобы применить изменения в сервисах

`sudo systemctl daemon-reload`

- Включить автозапуск для сервиса

`sudo systemctl enable monitor_test.timer`

`sudo systemctl start monitor_test.timer`

- открыть файл с логами, чтобы убедиться, что сервис работает как нужно

`sudo tail -f /var/log/monitoring.log`
