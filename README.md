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
```

## 2. Benchmark 2
- concurrency: 256
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
```
