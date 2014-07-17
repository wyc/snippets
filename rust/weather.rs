/**
 * rust network client example updated from
 * http://www.darkcoding.net/software/rust-what-i-learnt-so-far/#connect_to_a_socket
 *
 * rust 0.12.0
 */

extern crate std;

use std::io::{TcpStream, IoResult};
use std::str;

fn fetch(code: &str) -> IoResult<Vec<u8>> {
    let mut stream = TcpStream::connect("205.156.51.232", 80);
    let data_get = format!(
        "GET /pub/data/observations/metar/decoded/{}.TXT HTTP/1.1\n",
        code);
    let data_headers = "Host: weather.noaa.gov\n\n";

    /* we can use try!() here, but for this example we won't use macros */
    match stream.write(data_get.as_bytes()) {
        Ok(_) => (),
        Err(err) => return Err(err)
    }
    match stream.write(data_headers.as_bytes()) {
        Ok(_) => (),
        Err(err) => return Err(err)
    }
    let rv = stream.read_to_end();

    /* just to show how to explicitly close the connection.
     * drop() is called anyway when a variable goes out of scope. */
    drop(stream);

    return rv;
}

fn main() {
    match fetch("KEWR") {
        Ok(v) => println!("{}", match str::from_utf8(v.as_slice()){
            Some(s) => s,
            None => ""
        }),
        Err(err) => println!("error: {}", err)
    }
}
