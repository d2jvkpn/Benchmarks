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
  Count       7082055
    2xx       7082055
  RPS      236060.089
  Reads    35.345MB/s
  Writes   14.184MB/s

Statistics     Min       Mean     StdDev      Max   
  Latency     18µs      2.165ms   2.578ms  147.668ms
  RPS       214654.63  236046.51  8889.08  256044.99

Latency Percentile:
  P50        P75     P90     P95      P99      P99.9     P99.99 
  1.455ms  2.901ms  4.48ms  6.16ms  13.549ms  23.685ms  35.505ms

Latency Histogram:
  1.995ms   6787529  95.84%
  4.982ms    253041   3.57%
  10.815ms    33221   0.47%
  17.747ms     5616   0.08%
  24.749ms     1802   0.03%
  29.099ms      573   0.01%
  32.381ms      179   0.00%
  34.951ms       94   0.00%
EOF

#### go-gin
go run main.go -release -addr=:8000 -threads=8

plow http://127.0.0.1:8000/hello --concurrency=512 --duration=30s --timeout=2s

cat <<EOF
Benchmarking http://127.0.0.1:8000/hello for 30s using 512 connection(s).
@ Real-time charts is listening on http://[::]:18888

Summary:
  Elapsed         30s
  Count       4677756
    2xx       4677756
  RPS      155925.057
  Reads    22.900MB/s
  Writes    9.369MB/s

Statistics     Min       Mean     StdDev      Max   
  Latency     26µs      3.279ms   3.21ms   117.996ms
  RPS       128151.39  155916.61  8155.05  167414.07

Latency Percentile:
  P50       P75      P90      P95      P99      P99.9     P99.99 
  2.518ms  4.61ms  6.835ms  8.739ms  15.069ms  24.996ms  51.511ms

Latency Histogram:
  2.648ms   4095461  87.55%
  6.305ms    438840   9.38%
  10.518ms   111165   2.38%
  16.099ms    25913   0.55%
  21.692ms     5446   0.12%
  25.513ms      886   0.02%
  30.262ms       44   0.00%
  35.702ms        1   0.00%
EOF

#### rust-actix
cargo run --release -- --release --port=8000 --threads=8

plow http://127.0.0.1:8000/hello --concurrency=512 --duration=30s --timeout=2s

cat <<EOF
Benchmarking http://127.0.0.1:8000/hello for 30s using 512 connection(s).
@ Real-time charts is listening on http://[::]:18888

Summary:
  Elapsed         30s
  Count       9253183
    2xx       9253183
  RPS      308428.660
  Reads    42.945MB/s
  Writes   18.532MB/s

Statistics     Min       Mean      StdDev      Max   
  Latency     24µs      1.654ms   2.237ms   60.807ms 
  RPS       268201.89  308432.14  16034.75  334034.27

Latency Percentile:
  P50        P75     P90      P95      P99      P99.9     P99.99 
  1.135ms  1.546ms  3.15ms  5.378ms  12.756ms  20.898ms  31.129ms

Latency Histogram:
  1.551ms   9043684  97.74%
  4.659ms    171013   1.85%
  11.009ms    30543   0.33%
  17.03ms      6253   0.07%
  24.388ms     1401   0.02%
  34.117ms      284   0.00%
  42.732ms        2   0.00%
  54.62ms         3   0.00%
EOF

#### rust-axum
cargo run --release -- --release --port=8000

plow http://127.0.0.1:8000/hello --concurrency=512 --duration=30s --timeout=2s

cat <<EOF
Benchmarking http://127.0.0.1:8000/hello for 30s using 512 connection(s).
@ Real-time charts is listening on http://[::]:18888

Summary:
  Elapsed         30s
  Count       7315399
    2xx       7315399
  RPS      243831.669
  Reads    37.206MB/s
  Writes   14.651MB/s

Statistics     Min       Mean     StdDev      Max   
  Latency     25µs      2.096ms   4.572ms  1.076133s
  RPS       231736.75  244058.47  6740.36  256288.84

Latency Percentile:
  P50        P75      P90      P95      P99     P99.9     P99.99 
  1.797ms  2.698ms  3.772ms  4.573ms  6.498ms  10.836ms  39.277ms

Latency Histogram:
  2.081ms   7271666  99.40%
  4.019ms     36535   0.50%
  6.193ms      6014   0.08%
  9.415ms      1012   0.01%
  12.079ms      134   0.00%
  14.977ms       30   0.00%
  17.607ms        7   0.00%
  19.776ms        1   0.00%
EOF
