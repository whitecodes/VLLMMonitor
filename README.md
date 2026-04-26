# VllmMonitor

`VllmMonitor` 是一个单容器监控镜像，容器内同时运行：

- Prometheus（`9090`）
- Grafana（`3000`）

用于采集并展示 vLLM 暴露的 Prometheus 指标。

## 快速开始

1. 准备可访问的 vLLM 指标地址（例如 `localhost:8000` 或 `192.168.1.10:8000`）。
2. 启动容器：

```bash
docker run -d \
  --name vllm-monitor \
  -p 3000:3000 \
  -p 9090:9090 \
  -e VLLM_HOST=localhost:8000 \
  <your-image>:latest
```

3. 打开 Grafana：

- `http://localhost:3000`

Prometheus 可直接访问：

- `http://localhost:9090`

## 环境变量

### `VLLM_HOST`

- 作用：指定 Prometheus 抓取的 vLLM 指标目标地址。
- 格式：`host:port`
- 默认值：`localhost:8000`
- 示例：
  - `localhost:8000`
  - `127.0.0.1:8000`
  - `vllm:8000`
  - `192.168.1.10:8000`

## 常见启动示例

### 监控本机 vLLM（默认）

```bash
docker run -d \
  --name vllm-monitor \
  -p 3000:3000 \
  -p 9090:9090 \
  -e VLLM_HOST=localhost:8000 \
  <your-image>:latest
```

### 监控局域网/远程主机 vLLM

```bash
docker run -d \
  --name vllm-monitor \
  -p 3000:3000 \
  -p 9090:9090 \
  -e VLLM_HOST=192.168.1.10:8000 \
  <your-image>:latest
```
