use std::thread;

fn main() {
    let threads = thread::available_parallelism().unwrap().get();
    println!("threads={}", threads);
}
