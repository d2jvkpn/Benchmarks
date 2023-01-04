use axum::{http::StatusCode, response::IntoResponse, routing::get, Router, Server};
use serde_json::json;
use std::net::SocketAddr;
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

#[tokio::main]
async fn main() {
    let opt = Opt::from_args();

    let app = Router::new().route("/hello", get(index_handler));

    // let addr = SocketAddr::from(([127, 0, 0, 1], 8080));
    let addr: SocketAddr =
        format!("{}:{}", opt.addr, opt.port).parse().expect("Unable to parse socket address");

    println!("Listening on {:?}", addr);

    Server::bind(&addr).serve(app.into_make_service()).await.unwrap();
}

pub async fn index_handler() -> impl IntoResponse {
    (StatusCode::CREATED, json!({"code":0,"msg":"not found","data":{}}).to_string())
}
