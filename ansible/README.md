# Ansible 自动化部署平台

基于 Ansible Roles 的多节点中间件自动化部署实践。

## 项目结构
- `site.yml`：主控剧本，统筹调用各个角色。
- `deploy.sh`：一键部署/检查状态脚本。
- `roles/nginx`：自动配置官方源，安装 Nginx 并管理服务状态。
- `roles/docker`：自动配置阿里云源，安装 Docker CE、Compose，并配置镜像加速。
- `roles/tomcat`：自动安装 JDK，解压 Tomcat，使用 Jinja2 模板注入 JVM 参数，采用 systemd 托管服务。

## 使用方法
1. 配置 `/etc/ansible/hosts`。
2. 一键部署：`./deploy.sh deploy`
3. 状态检查：`./deploy.sh check`
