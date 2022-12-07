#! /usr/bin/env bash
set -eu -o pipefail
_wd=$(pwd)
_path=$(dirname $0 | xargs -i readlink -f {})

#### go-gin
go run main.go -release -addr=:8000 -threads=8

plow http://127.0.0.1:8000/hello --concurrency=256 --duration=30s --timeout=2s

cat <<EOF
Benchmarking http://127.0.0.1:8000/hello for 30s using 256 connection(s).
@ Real-time charts is listening on http://[::]:18888

Summary:
  Elapsed         30s
  Count       3636308
    2xx       3636308
  RPS      121207.080
  Reads    17.801MB/s
  Writes    7.283MB/s

Statistics     Min       Mean     StdDev      Max   
  Latency     51µs      2.108ms   2.412ms  108.114ms
  RPS       110995.74  121209.39  5668.96  131482.92

Latency Percentile:
  P50       P75      P90      P95      P99      P99.9     P99.99 
  1.32ms  2.831ms  4.871ms  6.675ms  11.565ms  18.877ms  28.514ms

Latency Histogram:
  2.035ms   3599274  98.98%
  8.048ms     30892   0.85%
  13.239ms     4382   0.12%
  17.687ms     1190   0.03%
  21.797ms      488   0.01%
  26.43ms        47   0.00%
  30.467ms       25   0.00%
  33.24ms        10   0.00%
EOF

#### rust-actix
cargo run --release -- --release --port=8000 --threads=8

plow http://127.0.0.1:8000/hello --concurrency=256 --duration=30s --timeout=2s

cat <<EOF
Benchmarking http://127.0.0.1:8000/hello for 30s using 256 connection(s).
@ Real-time charts is listening on http://[::]:18888

Summary:
  Elapsed         30s
  Count       7072120
    2xx       7072120
  RPS      235726.808
  Reads    30.574MB/s
  Writes   14.163MB/s

Statistics     Min       Mean    StdDev      Max   
  Latency     44µs     1.081ms     2ms    56.917ms 
  RPS       222117.15  235729.1  9530.01  256866.14

Latency Percentile:
  P50     P75     P90      P95      P99      P99.9     P99.99 
  522µs  893µs  1.948ms  4.408ms  11.284ms  19.444ms  28.624ms

Latency Histogram:
  998µs     6950073  98.27%
  4.06ms      93457   1.32%
  10.221ms    22457   0.32%
  15.386ms     4899   0.07%
  21.745ms      928   0.01%
  27.369ms      258   0.00%
  32.035ms       43   0.00%
  41.284ms        5   0.00%
EOF
