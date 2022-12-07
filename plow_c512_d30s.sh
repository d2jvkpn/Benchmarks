#! /usr/bin/env bash
set -eu -o pipefail
_wd=$(pwd)
_path=$(dirname $0 | xargs -i readlink -f {})

#### go-gin
go run main.go -release -addr=:8000 -threads=8

plow http://127.0.0.1:8000/hello --concurrency=512 --duration=30s --timeout=2s

cat <<EOF
Benchmarking http://127.0.0.1:8000/hello for 30s using 512 connection(s).
@ Real-time charts is listening on http://[::]:18888

Summary:
  Elapsed         30s
  Count       3712392
    2xx       3712392
  RPS      123746.241
  Reads    18.174MB/s
  Writes    7.436MB/s

Statistics     Min       Mean    StdDev      Max   
  Latency     54µs     4.131ms   3.979ms  167.166ms
  RPS       116237.26  123934.2  3684.43  130069.42

Latency Percentile:
  P50       P75      P90      P95       P99      P99.9     P99.99 
  3.167ms  5.88ms  8.542ms  10.704ms  18.476ms  30.718ms  98.813ms

Latency Histogram:
  3.957ms   3648271  98.27%
  12.148ms    54105   1.46%
  21.376ms     6795   0.18%
  28.685ms     2554   0.07%
  34.188ms      592   0.02%
  39.68ms        55   0.00%
  43.355ms       12   0.00%
  57.307ms        8   0.00%
EOF

#### rust-actix
cargo run --release -- --release --port=8000 --threads=8

plow http://127.0.0.1:8000/hello --concurrency=512 --duration=30s --timeout=2s

cat <<EOF
Benchmarking http://127.0.0.1:8000/hello for 30s using 512 connection(s).
@ Real-time charts is listening on http://[::]:18888

Summary:
  Elapsed         30s
  Count       6637920
    2xx       6637920
  RPS      221244.814
  Reads    30.805MB/s
  Writes   13.294MB/s

Statistics     Min       Mean     StdDev      Max   
  Latency     48µs      2.307ms   3.23ms   86.119ms 
  RPS       206164.04  221231.18  7672.26  238174.39

Latency Percentile:
  P50        P75      P90      P95      P99      P99.9     P99.99 
  1.213ms  2.336ms  5.728ms  9.332ms  15.504ms  26.543ms  39.481ms

Latency Histogram:
  2.027ms   6320426  95.22%
  5.963ms    236940   3.57%
  11.543ms    60144   0.91%
  17.12ms     15897   0.24%
  23.954ms     3239   0.05%
  33.131ms     1100   0.02%
  39.078ms      172   0.00%
  45.773ms        2   0.00%
EOF
