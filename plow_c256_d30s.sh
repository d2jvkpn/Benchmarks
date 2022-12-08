#! /usr/bin/env bash
set -eu -o pipefail
_wd=$(pwd)
_path=$(dirname $0 | xargs -i readlink -f {})

#### go-fasthttp
go run main.go -addr=:8000 -threads=8

plow http://127.0.0.1:8000/hello --concurrency=256 --duration=30s --timeout=2s

cat <<EOF
Benchmarking http://127.0.0.1:8000/hello for 30s using 256 connection(s).
@ Real-time charts is listening on http://[::]:18888

Summary:
  Elapsed         30s
  Count       4384108
    2xx       4384108
  RPS      146136.731
  Reads    21.881MB/s
  Writes    8.781MB/s

Statistics     Min       Mean    StdDev      Max   
  Latency     32µs     1.749ms   2.384ms  183.985ms
  RPS       142337.54  146129.1  1698.06  148714.19

Latency Percentile:
  P50      P75      P90      P95      P99     P99.9     P99.99 
  172µs  2.511ms  4.746ms  6.526ms  9.489ms  14.211ms  19.611ms

Latency Histogram:
  1.189ms   3852087  87.86%
  5.689ms    512729  11.70%
  8.342ms     16646   0.38%
  10.428ms     1886   0.04%
  13.09ms       612   0.01%
  15.337ms      111   0.00%
  17.307ms       29   0.00%
  20.087ms        8   0.00%
EOF

#### go-gin
go run main.go -release -addr=:8000 -threads=8

plow http://127.0.0.1:8000/hello --concurrency=256 --duration=30s --timeout=2s

cat <<EOF
Benchmarking http://127.0.0.1:8000/hello for 30s using 256 connection(s).
@ Real-time charts is listening on http://[::]:18888

Summary:
  Elapsed         30s
  Count       4368838
    2xx       4368838
  RPS      145627.807
  Reads    19.305MB/s
  Writes    8.750MB/s

Statistics     Min       Mean     StdDev      Max   
  Latency     43µs      1.754ms   2.045ms  95.341ms 
  RPS       135656.07  145762.45  5406.25  153321.38

Latency Percentile:
  P50        P75      P90      P95      P99      P99.9     P99.99 
  1.081ms  2.324ms  4.046ms  5.518ms  10.004ms  16.925ms  23.692ms

Latency Histogram:
  1.558ms   4105022  93.96%
  3.652ms    198451   4.54%
  6.967ms     51009   1.17%
  11.287ms    10381   0.24%
  15.864ms     2557   0.06%
  20.058ms     1348   0.03%
  22.972ms       66   0.00%
  27.597ms        4   0.00%
EOF

#### rust-actix
cargo run --release -- --release --port=8000 --threads=8

plow http://127.0.0.1:8000/hello --concurrency=256 --duration=30s --timeout=2s

cat <<EOF
Benchmarking http://127.0.0.1:8000/hello for 30s using 256 connection(s).
@ Real-time charts is listening on http://[::]:18888

Summary:
  Elapsed         30s
  Count       7225570
    2xx       7225570
  RPS      240845.546
  Reads    33.534MB/s
  Writes   14.471MB/s

Statistics     Min       Mean     StdDev     Max   
  Latency     40µs      1.059ms   1.954ms  65.382ms
  RPS       228242.68  240842.84  8749.83  255694.7

Latency Percentile:
  P50     P75     P90      P95      P99      P99.9     P99.99 
  513µs  880µs  1.904ms  4.301ms  10.648ms  18.946ms  28.987ms

Latency Histogram:
  947µs     7052852  97.61%
  4.074ms    136835   1.89%
  10.474ms    30030   0.42%
  15.505ms     4869   0.07%
  22.967ms      895   0.01%
  30.379ms       40   0.00%
  36.023ms       45   0.00%
  40.971ms        4   0.00%
EOF
