use axum::{http::StatusCode, response::IntoResponse, routing::get, Router, Server};
use chrono::prelude::*;
use serde_json::json;
use clap::Parser;

use std::net::SocketAddr;

#[derive(Debug, Parser)]
#[clap(name = "rust-axum", about = "axum demo")]
struct Args {
    #[clap(long, default_value = "0.0.0.0", help = "http server address")]
    addr: String,

    #[clap(long = "port", default_value = "8000", help = "http server port")]
    port: u16,

    #[clap(long, default_value = "0", help = "threads limit")]
    threads: usize,

    #[clap(long, help = "run in release mode")]
    release: bool,
}

#[tokio::main]
async fn main() {
    let args = Args::parse();

    let app = Router::new().route("/hello", get(index_handler));

    // let addr = SocketAddr::from(([127, 0, 0, 1], 8080));
    let addr: SocketAddr =
        format!("{}:{}", args.addr, args.port).parse().expect("Unable to parse socket address");

    println!(">>> Listening on {:?}", addr);

    Server::bind(&addr).serve(app.into_make_service()).await.unwrap();
}

pub async fn index_handler() -> impl IntoResponse {
    let now: DateTime<Local> = Local::now();

    (StatusCode::CREATED, json!({"code":0,"msg":"ok","data":{"time": now}}).to_string())
}
