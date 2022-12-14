/*!
    ```bash
    cargo add actix_web serde_json structopt
    cargo run --release -- --port 8000 --release
    ```
!*/
use actix_web::{http::header::ContentType, web, App, HttpResponse, HttpServer};
use serde_json::json;
use std::{io, thread};
use structopt::StructOpt;

#[allow(dead_code)]
#[derive(Debug, StructOpt)]
#[structopt(name = "rust-actix", about = "actix-web demo")]
struct Opt {
    #[structopt(long, default_value = "0.0.0.0", help = "http server address")]
    addr: String,

    #[structopt(long = "port", default_value = "8000", help = "http server port")]
    port: u16,

    #[structopt(long, default_value = "0", help = "threads limit")]
    threads: usize,

    #[structopt(long, help = "run in release mode")]
    release: bool,
}

#[actix_web::main]
async fn main() -> io::Result<()> {
    let mut opt = Opt::from_args();

    let threads = thread::available_parallelism().unwrap().get();
    if opt.threads > threads {
        opt.threads = threads;
    }
    println!("~~~ threads usage: {}/{}", opt.threads, threads);

    let addr = format!("{}:{}", &opt.addr, opt.port);
    println!(">>> HTTP listening on {}", addr);

    let server = HttpServer::new(|| App::new().route("/hello", web::get().to(hello)));
    let server = if opt.threads > 0 { server.workers(opt.threads) } else { server };
    server.bind(&addr)?.run().await?;

    Ok(())
}

pub async fn hello() -> HttpResponse {
    HttpResponse::Ok()
        .content_type(ContentType::json())
        .body(json!({"code":0,"msg":"not found","data":{}}).to_string())
    // .body(r#"{"code\":0,"msg":"not found","data":{}}"#)
}
