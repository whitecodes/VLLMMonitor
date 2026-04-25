#!/bin/bash
set -e

# 默认值
VLLM_HOST=${VLLM_HOST:-localhost:8000}

echo "Using VLLM_HOST=$VLLM_HOST"

# 渲染 prometheus 配置
envsubst < /etc/prometheus/prometheus.yml.tpl > /etc/prometheus/prometheus.yml

# 启动 Prometheus
prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus \
  --web.listen-address=0.0.0.0:9090 &

# 启动 Grafana
/usr/sbin/grafana-server \
  --homepath=/usr/share/grafana \
  --config=/etc/grafana/grafana.ini &

wait