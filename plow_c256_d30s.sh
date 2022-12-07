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
  Count       7074918
    2xx       7074918
  RPS      235823.033
  Reads    32.835MB/s
  Writes   14.169MB/s

Statistics     Min       Mean     StdDev      Max   
  Latency     42µs      1.081ms   1.999ms  61.281ms 
  RPS       220121.45  235821.54  9680.49  258116.35

Latency Percentile:
  P50     P75     P90     P95      P99      P99.9     P99.99 
  524µs  897µs  1.956ms  4.37ms  11.088ms  19.581ms  29.202ms

Latency Histogram:
  945µs     6801448  96.13%
  3.042ms    214031   3.03%
  7.704ms     42312   0.60%
  12.522ms    13732   0.19%
  17.881ms     2494   0.04%
  24.894ms      693   0.01%
  30.268ms      160   0.00%
  51.63ms        48   0.00%
EOF
