#! /usr/bin/env bash
set -eu -o pipefail
_wd=$(pwd)
_path=$(dirname $0 | xargs -i readlink -f {})

#### go-fasthttp
go run main.go -addr=:8000 -threads=8

plow http://127.0.0.1:8000/hello --concurrency=512 --duration=30s --timeout=2s

cat <<EOF
Benchmarking http://127.0.0.1:8000/hello for 30s using 512 connection(s).
@ Real-time charts is listening on http://[::]:18888

Summary:
  Elapsed         30s
  Count       4246205
    2xx       4246205
  RPS      141537.119
  Reads    21.192MB/s
  Writes    8.505MB/s

Statistics     Min       Mean     StdDev      Max   
  Latency     33µs      3.612ms   5.104ms  442.676ms
  RPS       136635.14  141538.81  2883.41  147708.58

Latency Percentile:
  P50      P75      P90      P95       P99      P99.9    P99.99 
  305µs  5.053ms  9.521ms  13.177ms  18.723ms  28.01ms  49.956ms

Latency Histogram:
  724µs     2497439  58.82%
  7.378ms   1646530  38.78%
  11.977ms    78180   1.84%
  16.921ms    18364   0.43%
  22.606ms     4828   0.11%
  27.481ms      707   0.02%
  32.77ms       144   0.00%
  37.614ms       13   0.00%
EOF

#### go-gin
go run main.go -release -addr=:8000 -threads=8

plow http://127.0.0.1:8000/hello --concurrency=512 --duration=30s --timeout=2s

cat <<EOF
Benchmarking http://127.0.0.1:8000/hello for 30s using 512 connection(s).
@ Real-time charts is listening on http://[::]:18888

Summary:
  Elapsed         30s
  Count       4235571
    2xx       4235571
  RPS      141185.549
  Reads    18.716MB/s
  Writes    8.484MB/s

Statistics     Min       Mean     StdDev      Max   
  Latency     47µs      3.621ms   3.612ms  139.387ms
  RPS       134474.42  141182.13  3881.74  149657.96

Latency Percentile:
  P50        P75      P90      P95      P99      P99.9     P99.99 
  2.716ms  5.054ms  7.391ms  9.585ms  17.505ms  29.211ms  66.872ms

Latency Histogram:
  3.381ms   4058082  95.81%
  7.315ms    140207   3.31%
  13.602ms    28659   0.68%
  21.291ms     6527   0.15%
  29.895ms     1813   0.04%
  35.373ms      245   0.01%
  45.292ms       37   0.00%
  48.952ms        1   0.00%
EOF

#### rust-actix
cargo run --release -- --release --port=8000 --threads=8

plow http://127.0.0.1:8000/hello --concurrency=512 --duration=30s --timeout=2s

cat <<EOF
Benchmarking http://127.0.0.1:8000/hello for 30s using 512 connection(s).
@ Real-time charts is listening on http://[::]:18888

Summary:
  Elapsed         30s
  Count       6755806
    2xx       6755806
  RPS      225165.814
  Reads    31.351MB/s
  Writes   13.529MB/s

Statistics     Min       Mean     StdDev      Max   
  Latency     42µs      2.267ms   3.196ms  104.294ms
  RPS       215149.79  225124.89  6959.68  238954.1 

Latency Percentile:
  P50        P75     P90     P95      P99      P99.9     P99.99 
  1.183ms  2.282ms  5.62ms  9.18ms  15.174ms  26.181ms  41.452ms

Latency Histogram:
  1.831ms   6174174  91.39%
  4.812ms    402647   5.96%
  9.552ms    124068   1.84%
  14.697ms    42813   0.63%
  19.779ms     9253   0.14%
  24.551ms     2023   0.03%
  31.46ms       721   0.01%
  39.928ms      107   0.00%
EOF
