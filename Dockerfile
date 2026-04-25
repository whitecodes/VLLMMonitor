FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 基础依赖
RUN apt-get update && apt-get install -y \
    wget curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 安装 Prometheus
RUN wget https://github.com/prometheus/prometheus/releases/latest/download/prometheus-3.2.1.linux-amd64.tar.gz \
    && tar xvf prometheus-*.tar.gz \
    && mv prometheus-*/prometheus /usr/local/bin/ \
    && mv prometheus-*/promtool /usr/local/bin/ \
    && rm -rf prometheus-*

# 安装 Grafana
RUN wget https://dl.grafana.com/oss/release/grafana_11.0.0_amd64.deb \
    && apt-get update && apt-get install -y ./grafana_11.0.0_amd64.deb \
    && rm grafana_11.0.0_amd64.deb

# 配置目录
RUN mkdir -p /etc/prometheus /var/lib/prometheus \
    /etc/grafana/provisioning

COPY prometheus.yml.tpl /etc/prometheus/
COPY grafana /etc/grafana/
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 3000 9090

ENTRYPOINT ["/entrypoint.sh"]