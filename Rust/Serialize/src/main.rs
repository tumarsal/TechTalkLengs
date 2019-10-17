use std::cmp::Ordering;
use std::cmp;
use serde_json::Result;
use serde_json::Value;
use serde_json::json;
use std::fs;
use std::collections::HashMap;
use std::io::prelude::*;
use std::fs::File;
use std::string::String;
use std::io;
use std::os;
use std::path::PathBuf;

use std::str;
use serde::Serialize;
use serde::Deserialize;
use std::time::{Duration, SystemTime};
use std::thread::sleep;
#[derive(Serialize, Deserialize)]
struct Person {
    name: String,
    age: u8,
    phones: Vec<String>,
    address: Address,
}
#[derive(Serialize, Deserialize)]
struct Address {
    street: String,
    city: String,
}
//main
fn print_duration(elapsed: Duration,iterations:u128){
    let itf = iterations as f32;
    let secs = elapsed.as_secs() as f32;
    let millis = elapsed.as_millis() as f32;
    println!("Secs {}", secs / itf);
    println!("Millis {}", millis / itf);
    println!("Micros {}", elapsed.as_micros()  / u128::from(iterations));
    println!("Nanos {}", elapsed.as_nanos() / u128::from(iterations));
}
fn main() {
    let path = "./input.json";
    let mut file = File::open(path).expect("Unable to open the file");
    let mut contents = String::new();
    file.read_to_string(&mut contents).expect("Unable to read the file");
        
    let person: Person = serde_json::from_str(&contents).expect("error from string");
    //print!("{}","myerror" );
   // var ps = String::new()
    let iterations:u128 = 999999;
    let mut persons: Vec<Person> = Vec::new();
    let mut i = 0;
    while i < iterations {
        let person: Person = serde_json::from_str(&contents).expect("error from string");
    
        persons.push(person);
        i += 1;
    }
    let testCollection = serde_json::to_string(&persons).expect("error from string");
    writeFile(String::from("./temp.json"),&testCollection);
    let now = SystemTime::now();
    let persons2: Vec<Person> = serde_json::from_str(&testCollection).expect("error from string");
     match now.elapsed() {
       Ok(elapsed) => {
           println!("Deserialize");
           print_duration(elapsed,iterations)
          
       }
       Err(e) => {
           // an error occurred!
           println!("Error: {:?}", e);
       }
   }
    let now2 = SystemTime::now();
    let outString: String = serde_json::to_string(&persons2).expect("error from string");

     match now2.elapsed() {
       Ok(elapsed) => {
           println!("Serialize");
           print_duration(elapsed,iterations)
          
       }
       Err(e) => {
           // an error occurred!
           println!("Error: {:?}", e);
       }
   }
    let outpath = "./output.json";
    let mut outfile = File::create(outpath).expect("error from string");
    outfile.write_all(outString.as_bytes()).expect("error from string");
    outfile.sync_all().expect("write to file");
}
fn writeFile(path:String,content:&String){
    
    let mut outfile = File::create(path).expect("error from string");
    outfile.write_all(content.as_bytes()).expect("error from string");
    outfile.sync_all().expect("write to file");
}