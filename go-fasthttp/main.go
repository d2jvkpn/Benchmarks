package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"log"
	"runtime"

	"github.com/valyala/fasthttp"
)

func main() {
	var (
		threads int
		addr    string
	)

	flag.StringVar(&addr, "addr", ":8000", "TCP address to listen to")
	flag.IntVar(&threads, "threads", 0, "threads limit")
	flag.Parse()

	if threads == 0 || threads > runtime.NumCPU() {
		threads = runtime.NumCPU()
	}

	fmt.Printf("~~~ threads usage: %d/%d\n", threads, runtime.NumCPU())
	runtime.GOMAXPROCS(threads)

	handler := hello
	handler = fasthttp.CompressHandler(handler)

	fmt.Printf(">>> HTTP Listening on %s\n", addr)
	if err := fasthttp.ListenAndServe(addr, handler); err != nil {
		log.Fatalf("Error in ListenAndServe: %v", err)
	}
}

func hello(ctx *fasthttp.RequestCtx) {
	ctx.SetContentType("application/json")
	bts, _ := json.Marshal(map[string]any{"code": 0, "msg": "ok", "data": map[string]any{}})
	_, _ = ctx.Write(bts)
	// _, _ = ctx.Write([]byte(`{"code":0,"msg":"ok","data":{}}`))
}

func requestHandler(ctx *fasthttp.RequestCtx) {
	fmt.Fprintf(ctx, "Hello, world!\n\n")

	fmt.Fprintf(ctx, "Request method is %q\n", ctx.Method())
	fmt.Fprintf(ctx, "RequestURI is %q\n", ctx.RequestURI())
	fmt.Fprintf(ctx, "Requested path is %q\n", ctx.Path())
	fmt.Fprintf(ctx, "Host is %q\n", ctx.Host())
	fmt.Fprintf(ctx, "Query string is %q\n", ctx.QueryArgs())
	fmt.Fprintf(ctx, "User-Agent is %q\n", ctx.UserAgent())
	fmt.Fprintf(ctx, "Connection has been established at %s\n", ctx.ConnTime())
	fmt.Fprintf(ctx, "Request has been started at %s\n", ctx.Time())
	fmt.Fprintf(ctx, "Serial request number for the current connection is %d\n", ctx.ConnRequestNum())
	fmt.Fprintf(ctx, "Your ip is %q\n\n", ctx.RemoteIP())

	fmt.Fprintf(ctx, "Raw request is:\n---CUT---\n%s\n---CUT---", &ctx.Request)

	ctx.SetContentType("text/plain; charset=utf8")

	// Set arbitrary headers
	ctx.Response.Header.Set("X-My-Header", "my-header-value")

	// Set cookies
	var c fasthttp.Cookie
	c.SetKey("cookie-name")
	c.SetValue("cookie-value")
	ctx.Response.Header.SetCookie(&c)
}
