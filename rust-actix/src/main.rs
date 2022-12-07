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
    #[structopt(long = "addr", default_value = "0.0.0.0")]
    addr: String,

    #[structopt(long = "port", default_value = "8000")]
    port: u16,

    #[structopt(long = "threads", default_value = "0")]
    threads: usize,

    #[structopt(long)]
    release: bool,
}

#[actix_web::main]
async fn main() -> io::Result<()> {
    let mut opt = Opt::from_args();

    let addr = format!("{}:{}", &opt.addr, opt.port);
    println!(">>> HTTP listening on {}", addr);

    let threads = thread::available_parallelism().unwrap().get();
    if opt.threads == 0 || opt.threads > threads {
        opt.threads = threads;
    }

    HttpServer::new(|| App::new().route("/hello", web::get().to(hello)))
        .workers(opt.threads)
        .bind(&addr)?
        .run()
        .await?;

    Ok(())
}

pub async fn hello() -> HttpResponse {
    HttpResponse::Ok()
        .content_type(ContentType::json())
        .body(json!({"code":0,"msg":"not found"}).to_string())
}
