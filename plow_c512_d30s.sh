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
  Count       6652717
    2xx       6652717
  RPS      221751.500
  Reads    28.761MB/s
  Writes   13.324MB/s

Statistics     Min       Mean     StdDev      Max   
  Latency     47µs      2.301ms   3.288ms   125.8ms 
  RPS       209157.12  221745.29  7954.56  238946.04

Latency Percentile:
  P50       P75      P90      P95      P99      P99.9     P99.99 
  1.185ms  2.25ms  5.745ms  9.351ms  16.017ms  26.818ms  40.849ms

Latency Histogram:
  1.982ms   6363963  95.66%
  7.32ms     223314   3.36%
  15.229ms    57987   0.87%
  22.564ms     6463   0.10%
  30.694ms      749   0.01%
  36.812ms      164   0.00%
  46.224ms       35   0.00%
  54.986ms       42   0.00%
EOF
