#!/bin/bash
case $1 in
"start")
    echo '----- 启动 prometheus -----'
    nohup /opt/module/prometheus-2.29.1/prometheus --web.enable-admin-api --web.enable-lifecycle --config.file=/opt/module/prometheus-2.29.1/prometheus.yml > /opt/module/prometheus-2.29.1/prometheus.log 2>&1 &
    echo '----- 启动 pushgateway -----'
    nohup /opt/module/pushgateway-1.4.1/pushgateway --web.listen-address :9091 > /opt/module/pushgateway-1.4.1/pushgateway.log 2>&1 &
    echo '----- 启动 alertmanager -----'
    nohup /opt/module/alertmanager-0.23.0/alertmanager --config.file=/opt/module/alertmanager-0.23.0/alertmanager.yml > /opt/module/alertmanager-0.23.0/alertmanager.log 2>&1 &
    echo '----- 启动 grafana -----'
    nohup /opt/module/grafana-v9.5.15/bin/grafana-server --homepath /opt/module/grafana-v9.5.15 web > /opt/module/grafana-v9.5.15/grafana.log 2>&1 &
;;
"stop")
    echo '----- 停止 grafana -----'
    pgrep -f grafana | xargs kill
    echo '----- 停止 alertmanager -----'
    pgrep -f alertmanager | xargs kill
    echo '----- 停止 pushgateway -----'
    pgrep -f pushgateway | xargs kill
    echo '----- 停止 prometheus -----'
    pgrep -f prometheus | xargs kill
;;
"status")
    echo -e "\n===== Prometheus 进程 ====="
    ps -ef | grep prometheus | grep -v grep
    echo -e "\n===== Pushgateway 进程 ====="
    ps -ef | grep pushgateway | grep -v grep
    echo -e "\n===== Alertmanager 进程 ====="
    ps -ef | grep alertmanager | grep -v grep
    echo -e "\n===== Grafana 进程 ====="
    ps -ef | grep grafana | grep -v grep
    echo -e "\n===== 端口监听检查 ====="
    ss -tlnp | grep -E "9090|9091|9093|3000"
;;

"restart")
    echo "===== 正在停止所有监控组件 ====="
    $0 stop
    sleep 2
    echo "===== 等待2秒，准备启动 ====="
    $0 start
;;
*)
    echo "用法：$0 {start|stop|restart|status}"
;;

esac