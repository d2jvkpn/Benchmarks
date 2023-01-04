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
  Count       8200862
    2xx       8200862
  RPS      273357.211
  Reads    40.929MB/s
  Writes   16.424MB/s

Statistics     Min       Mean      StdDev      Max   
  Latency     19µs       934µs    1.439ms   110.565ms
  RPS       256414.98  273350.15  12062.25  300467.72

Latency Percentile:
  P50      P75      P90      P95      P99     P99.9     P99.99 
  511µs  1.087ms  2.059ms  3.063ms  7.671ms  13.862ms  21.058ms

Latency Histogram:
  811µs     7624328  92.97%
  1.797ms    426251   5.20%
  3.593ms    112526   1.37%
  6.856ms     27436   0.33%
  10.775ms     8380   0.10%
  14ms         1586   0.02%
  19.949ms      334   0.00%
  24.73ms        21   0.00%
EOF

#### go-gin
go run main.go -release -addr=:8000 -threads=8

plow http://127.0.0.1:8000/hello --concurrency=256 --duration=30s --timeout=2s

cat <<EOF
Benchmarking http://127.0.0.1:8000/hello for 30s using 256 connection(s).
@ Real-time charts is listening on http://[::]:18888

Summary:
  Elapsed         30s
  Count       5025724
    2xx       5025724
  RPS      167523.905
  Reads    24.604MB/s
  Writes   10.066MB/s

Statistics     Min       Mean     StdDev      Max   
  Latency     24µs      1.526ms   1.752ms  100.643ms
  RPS       154271.57  167514.11  6981.26  179265.52

Latency Percentile:
  P50     P75      P90      P95     P99     P99.9     P99.99 
  954µs  2.07ms  3.591ms  4.947ms  8.37ms  12.946ms  18.565ms

Latency Histogram:
  1.362ms   4734273  94.20%
  3.339ms    224231   4.46%
  6.17ms      52558   1.05%
  9.106ms     11335   0.23%
  12.115ms     2635   0.05%
  14.309ms      452   0.01%
  16.982ms      227   0.00%
  20.915ms       13   0.00%
EOF

#### rust-actix
cargo run --release -- --release --port=8000 --threads=8

plow http://127.0.0.1:8000/hello --concurrency=256 --duration=30s --timeout=2s

cat <<EOF
Benchmarking http://127.0.0.1:8000/hello for 30s using 256 connection(s).
@ Real-time charts is listening on http://[::]:18888

Summary:
  Elapsed         30s
  Count      10356079
    2xx      10356079
  RPS      345191.383
  Reads    48.063MB/s
  Writes   20.740MB/s

Statistics     Min       Mean     StdDev      Max   
  Latency     22µs      739µs    1.202ms   53.213ms 
  RPS       321798.59  345191.3  16922.87  379446.66

Latency Percentile:
  P50     P75     P90      P95      P99     P99.9     P99.99 
  503µs  630µs  1.138ms  1.949ms  6.881ms  13.314ms  20.685ms

Latency Histogram:
  704µs     10183314  98.33%
  1.879ms     140044   1.35%
  5.22ms       25356   0.24%
  10.267ms      5799   0.06%
  15.394ms      1299   0.01%
  18.741ms       156   0.00%
  22.974ms       103   0.00%
  30.875ms         8   0.00%
EOF

#### rust-axum
cargo run --release -- --release --port=8000

plow http://127.0.0.1:8000/hello --concurrency=256 --duration=30s --timeout=2s

cat <<EOF
Benchmarking http://127.0.0.1:8000/hello for 30s using 256 connection(s).
@ Real-time charts is listening on http://[::]:18888

Summary:
  Elapsed         30s
  Count       7405725
    2xx       7405725
  RPS      246857.202
  Reads    37.667MB/s
  Writes   14.832MB/s

Statistics     Min       Mean    StdDev      Max   
  Latency     24µs     1.035ms    664µs    51.99ms 
  RPS       233527.54  247042.1  7093.51  262404.94

Latency Percentile:
  P50      P75      P90      P95      P99     P99.9   P99.99 
  911µs  1.288ms  1.767ms  2.139ms  3.276ms  5.172ms  9.667ms

Latency Histogram:
  1.029ms   7367236  99.48%
  1.957ms     34392   0.46%
  2.96ms       3518   0.05%
  4.469ms       509   0.01%
  6.097ms        57   0.00%
  11.2ms          9   0.00%
  15.183ms        3   0.00%
  23.582ms        1   0.00%
EOF
