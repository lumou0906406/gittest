#!/bin/bash
ACTION=$1

if [ "$ACTION" == "deploy" ]; then
    echo ">>> 开始执行自动化部署 <<<"
    ansible-playbook site.yml
elif [ "$ACTION" == "check" ]; then
    echo ">>> 正在检查目标节点中间件状态 <<<"
    ansible monitor_nodes -m shell -a "echo -n 'Nginx状态: '; systemctl is-active nginx; echo -n 'Docker状态: '; systemctl is-active docker; echo -n 'Tomcat进程数: '; ps -ef | grep tomcat | grep -v grep | wc -l"
else
    echo "用法: ./deploy.sh {deploy|check}"
fi
