## 1. Benchmark 1
- concurrency: 256
- duration: 30s
- timeout: 2s

#### 1.1 go-fasthttp
```bash
go run main.go -addr=:8000 -threads=8

plow http://127.0.0.1:8000/hello --concurrency=256 --duration=30s --timeout=2s
```

```terminal
Benchmarking http://127.0.0.1:8000/hello for 30s using 256 connection(s).
@ Real-time charts is listening on http://[::]:18888

Summary:
  Elapsed         30s
  Count       9021940
    2xx       9021940
  RPS      300720.990
  Reads    57.613MB/s
  Writes   18.068MB/s

Statistics     Min       Mean     StdDev      Max   
  Latency     25µs       850µs     866µs   106.672ms
  RPS       297145.59  300727.56  1898.58  304254.25

Latency Percentile:
  P50      P75      P90      P95    P99  P99.9    P99.99 
  620µs  1.098ms  1.755ms  2.318ms  4ms  6.99ms  10.529ms

Latency Histogram:
  811µs     8781682  97.34%
  1.838ms    190577   2.11%
  3.36ms      41001   0.45%
  5.16ms       6516   0.07%
  7.42ms       1650   0.02%
  9.664ms       481   0.01%
  10.689ms       29   0.00%
  11.613ms        4   0.00%
```

#### 1.2 go-gin
```bash
go run main.go -release -addr=:8000 -threads=8

plow http://127.0.0.1:8000/hello --concurrency=256 --duration=30s --timeout=2s
```

```terminal
Benchmarking http://127.0.0.1:8000/hello for 30s using 256 connection(s).
@ Real-time charts is listening on http://[::]:18888

Summary:
  Elapsed         30s
  Count       6045793
    2xx       6045793
  RPS      201522.008
  Reads    38.032MB/s
  Writes   12.108MB/s

Statistics    Min       Mean     StdDev      Max   
  Latency     31µs     1.269ms   1.367ms  137.501ms
  RPS       195477.8  201575.89  1628.92  203925.4 

Latency Percentile:
  P50      P75      P90     P95      P99     P99.9    P99.99 
  855µs  1.763ms  2.894ms  3.75ms  5.656ms  9.452ms  13.105ms

Latency Histogram:
  1.157ms   5713473  94.50%
  2.857ms    283644   4.69%
  4.583ms     39092   0.65%
  6.81ms       7625   0.13%
  9.46ms       1681   0.03%
  11.842ms      245   0.00%
  14.915ms       31   0.00%
  17.785ms        2   0.00%
```

#### 1.3 rust-actix
```bash
cargo run --release -- --release --port=8000 --threads=8

plow http://127.0.0.1:8000/hello --concurrency=256 --duration=30s --timeout=2s
```

```terminal
Benchmarking http://127.0.0.1:8000/hello for 30s using 256 connection(s).
@ Real-time charts is listening on http://[::]:18888

Summary:
  Elapsed         30s
  Count      10683520
    2xx      10683520
  RPS      356111.443
  Reads    62.148MB/s
  Writes   21.396MB/s

Statistics     Min       Mean     StdDev      Max   
  Latency     30µs       717µs    1.008ms  58.062ms 
  RPS       339531.63  356113.19  3959.47  362569.95

Latency Percentile:
  P50     P75     P90      P95      P99     P99.9     P99.99 
  539µs  712µs  1.104ms  1.538ms  4.818ms  13.838ms  19.384ms

Latency Histogram:
  688µs     10510158  98.38%
  1.767ms     153890   1.44%
  6.34ms       15206   0.14%
  12.812ms      3502   0.03%
  16.505ms       576   0.01%
  20.829ms       157   0.00%
  23.38ms          5   0.00%
  24.825ms        26   0.00%
```

#### 1.4 rust-axum
```bash
cargo run --release -- --release --port=8000

plow http://127.0.0.1:8000/hello --concurrency=256 --duration=30s --timeout=2s
```

```terminal
Benchmarking http://127.0.0.1:8000/hello for 30s using 256 connection(s).
@ Real-time charts is listening on http://[::]:18888

Summary:
  Elapsed         30s
  Count       9092687
    2xx       9092687
  RPS      303066.140
  Reads    56.937MB/s
  Writes   18.209MB/s

Statistics     Min       Mean     StdDev      Max   
  Latency     30µs       843µs     451µs   48.299ms 
  RPS       298890.02  303016.46  1959.58  306063.56

Latency Percentile:
  P50      P75      P90      P95      P99     P99.9   P99.99 
  776µs  1.057ms  1.378ms  1.604ms  2.209ms  3.461ms  6.036ms

Latency Histogram:
  840µs    9041394  99.44%
  1.321ms    42161   0.46%
  1.913ms     7808   0.09%
  2.934ms     1116   0.01%
  4.564ms      182   0.00%
  5.773ms       18   0.00%
  6.968ms        7   0.00%
  7.864ms        1   0.00%
```

## 2. Benchmark 2
- concurrency: 512
- duration: 30s
- timeout: 2s

#### 2.1 go-fasthttp
```bash
go run main.go -addr=:8000 -threads=8

plow http://127.0.0.1:8000/hello --concurrency=512 --duration=30s --timeout=2s
```

```terminal
Benchmarking http://127.0.0.1:8000/hello for 30s using 512 connection(s).
@ Real-time charts is listening on http://[::]:18888

Summary:
  Elapsed         30s
  Count       9056346
    2xx       9056346
  RPS      301856.256
  Reads    57.830MB/s
  Writes   18.137MB/s

Statistics     Min       Mean     StdDev      Max   
  Latency     23µs      1.693ms   1.557ms  151.919ms
  RPS       283042.27  301864.15  4099.02  307938.54

Latency Percentile:
  P50       P75     P90      P95      P99     P99.9     P99.99 
  1.34ms  2.279ms  3.33ms  4.073ms  6.895ms  12.729ms  20.641ms

Latency Histogram:
  1.635ms   8869766  97.94%
  3.747ms    155020   1.71%
  7.182ms     25374   0.28%
  11.307ms     5424   0.06%
  14.502ms      563   0.01%
  17.72ms       166   0.00%
  19.679ms       25   0.00%
  21.659ms        8   0.00%
```

#### 2.2 go-gin
```bash
go run main.go -release -addr=:8000 -threads=8

plow http://127.0.0.1:8000/hello --concurrency=512 --duration=30s --timeout=2s
```

```terminal
Benchmarking http://127.0.0.1:8000/hello for 30s using 512 connection(s).
@ Real-time charts is listening on http://[::]:18888

Summary:
  Elapsed         30s
  Count       6171985
    2xx       6171985
  RPS      205728.315
  Reads    38.825MB/s
  Writes   12.361MB/s

Statistics     Min       Mean     StdDev      Max   
  Latency     29µs      2.486ms   2.176ms  141.75ms 
  RPS       195944.02  205731.51  2165.04  208793.66

Latency Percentile:
  P50        P75     P90      P95      P99     P99.9     P99.99 
  2.043ms  3.597ms  5.04ms  5.871ms  9.007ms  16.905ms  27.401ms

Latency Histogram:
  2.211ms   5540392  89.77%
  4.512ms    559194   9.06%
  7.081ms     62526   1.01%
  11.461ms     7632   0.12%
  17.065ms     2013   0.03%
  18.88ms        84   0.00%
  21.095ms      143   0.00%
  24.426ms        1   0.00%
```

#### 2.3 rust-actix
```bash
cargo run --release -- --release --port=8000 --threads=8

plow http://127.0.0.1:8000/hello --concurrency=512 --duration=30s --timeout=2s
```

```terminal
Benchmarking http://127.0.0.1:8000/hello for 30s using 512 connection(s).
@ Real-time charts is listening on http://[::]:18888

Summary:
  Elapsed         30s
  Count      10775014
    2xx      10775014
  RPS      359159.321
  Reads    62.680MB/s
  Writes   21.580MB/s

Statistics     Min       Mean     StdDev      Max   
  Latency     35µs      1.422ms   1.761ms  106.906ms
  RPS       333867.41  359140.42  4948.78  363087.45

Latency Percentile:
  P50        P75     P90      P95      P99      P99.9     P99.99 
  1.062ms  1.407ms  2.27ms  3.295ms  10.156ms  18.956ms  33.355ms

Latency Histogram:
  1.334ms   10480208  97.26%
  3.072ms     239784   2.23%
  8.892ms      40702   0.38%
  15.044ms      9621   0.09%
  20.037ms      4032   0.04%
  27.249ms       664   0.01%
  36.294ms         1   0.00%
  38.842ms         2   0.00%
```

#### 2.4 rust-axum
```bash
cargo run --release -- --release --port=8000

plow http://127.0.0.1:8000/hello --concurrency=512 --duration=30s --timeout=2s
```

```terminal
Benchmarking http://127.0.0.1:8000/hello for 30s using 512 connection(s).
@ Real-time charts is listening on http://[::]:18888

Summary:
  Elapsed         30s
  Count       9209513
    2xx       9209513
  RPS      306930.907
  Reads    57.663MB/s
  Writes   18.442MB/s

Statistics     Min       Mean     StdDev      Max   
  Latency     31µs      1.666ms   4.033ms  1.100077s
  RPS       298392.48  306894.01  2343.8   311818.38

Latency Percentile:
  P50        P75      P90      P95      P99    P99.9    P99.99 
  1.449ms  2.129ms  2.883ms  3.441ms  4.779ms  7.82ms  14.601ms

Latency Histogram:
  1.646ms   9064108  98.42%
  2.66ms     119741   1.30%
  3.638ms     20153   0.22%
  4.97ms       4278   0.05%
  6.955ms       909   0.01%
  9.278ms       269   0.00%
  10.522ms       48   0.00%
  14.08ms         7   0.00%
```
