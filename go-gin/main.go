/*
#### run

	```bash
	go get github.com/gin-gonic/gin
	go run main.go --addr :8000 --release
	```
*/
package main

import (
	"flag"
	"fmt"
	"net/http"
	"runtime"

	"github.com/gin-gonic/gin"
)

func main() {
	var (
		release bool
		threads int
		addr    string
		engine  *gin.Engine
		router  *gin.RouterGroup
	)

	flag.StringVar(&addr, "addr", ":8080", "http  address to listen to")
	flag.IntVar(&threads, "threads", 0, "threads limit")
	flag.BoolVar(&release, "release", false, "run in release mode")
	flag.Parse()

	if threads > runtime.NumCPU() {
		threads = runtime.NumCPU()
	}
	fmt.Printf("~~~ threads usage: %d/%d\n", threads, runtime.NumCPU())
	if threads > 0 {
		runtime.GOMAXPROCS(threads)
	}

	if release {
		gin.SetMode(gin.ReleaseMode)
		engine = gin.New()
	} else {
		engine = gin.Default()
	}
	router = &engine.RouterGroup

	router.GET("/hello", func(ctx *gin.Context) {
		ctx.JSON(http.StatusOK, gin.H{"code": 0, "msg": "ok", "data": gin.H{}})
		// ctx.Header("Content-Type", "application/json")
		// ctx.Writer.Write([]byte(`{"code":0,"msg":"ok","data":{}}`))
	})

	fmt.Printf(">>> HTTP Listening on %s\n", addr)
	engine.Run(addr)
}
