use std::time::{Duration, SystemTime};

use rand::distributions::{Distribution, Uniform};
use serde_json::Result;
use serde_json::Value;
use serde_json::json;
use std::fs::File;
use std::io;
use std::os;
use std::fs;
use std::io::prelude::*;
fn print_duration(elapsed: Duration,iterations:u128){
    let itf = iterations as f32;
    let secs = elapsed.as_secs() as f32;
    let millis = elapsed.as_millis() as f32;
    println!("Secs {}", secs / itf);
    println!("Millis {}", millis / itf);
    println!("Micros {}", elapsed.as_micros()  / u128::from(iterations));
    println!("Nanos {}", elapsed.as_nanos() / u128::from(iterations));
}
// bubble_sort
fn bubble_sort(numbers: &Vec<i64>) -> Vec<i64> {
    let mut target = numbers.clone();
    let length = numbers.len();
    for _ in 0..length {
        for j in 0..length - 1 {
            if target[j] > target[j+1]  {
                let temp = target[j+1];
                target[j+1] = target[j];
                target[j] = temp;
            }
        }
    }
    target
}

//quick_sort
fn quick_sort<T,F>(v: &mut [T], f: &F) 
    where F: Fn(&T,&T) -> bool
{
    let len = v.len();
    if len >= 2 {
        let pivot_index = partition(v, f);
        quick_sort(&mut v[0..pivot_index], f);
        quick_sort(&mut v[pivot_index + 1..len], f);
    }
}
 
fn partition<T,F>(v: &mut [T], f: &F) -> usize 
    where F: Fn(&T,&T) -> bool
{
    let len = v.len();
    let pivot_index = len / 2;
    let last_index = len - 1;
 
    v.swap(pivot_index, last_index);
 
    let mut store_index = 0;
    for i in 0..last_index {
        if f(&v[i], &v[last_index]) {
            v.swap(i, store_index);
            store_index += 1;
        }
    }
 
    v.swap(store_index, len - 1);
    store_index
}
//heap sort
fn heap_sort<T, F>(array: &mut [T], order: F)
where
    F: Fn(&T, &T) -> bool,
{
    let len = array.len();
    // Create heap
    for start in (0..len / 2).rev() {
        shift_down(array, &order, start, len - 1)
    }
 
    for end in (1..len).rev() {
        array.swap(0, end);
        shift_down(array, &order, 0, end - 1)
    }
}
 
fn shift_down<T, F>(array: &mut [T], order: &F, start: usize, end: usize)
where
    F: Fn(&T, &T) -> bool,
{
    let mut root = start;
    loop {
        let mut child = root * 2 + 1;
        if child > end {
            break;
        }
        if child + 1 <= end && order(&array[child], &array[child + 1]) {
            child += 1;
        }
        if order(&array[root], &array[child]) {
            array.swap(root, child);
            root = child
        } else {
            break;
        }
    }
}

fn gen () {
    let mut vec:Vec<i32> = vec![0;1000];
    let mut rng = rand::thread_rng();
    let die = Uniform::from(1..1000);
    
    for i in 0..1000 {
        vec[i] = die.sample(&mut rng);
    }
    println!("{:?}",vec);
    let out_string: String = serde_json::to_string(&vec).expect("error from string");
    let outpath = "./output.json";
    let mut outfile = File::create(outpath).expect("error from string");
    outfile.write_all(out_string.as_bytes()).expect("error from string");
    outfile.sync_all().expect("write to file");
}

fn main(){

    //gen();
    let path = "./input.json";
    let mut file = File::open(path).expect("Unable to open the file");
    let mut contents = String::new();
    file.read_to_string(&mut contents).expect("Unable to read the file");
        
    let mut vec: Vec<i64> = serde_json::from_str(&contents).expect("error from string");
    //bable sort
    //let mut vec:Vec<i64> = vec![1, 5, 10, 2, 15];
    bubble_sort(&mut vec);
    println!("{}",vec[0]);
    /*quick sort */
    let mut vector:Vec<i64> = vec![4, 6, 8, 1, 0, 3, 2, 2, 9, 5];
    //heap_sort(&mut v, |x, y| x < y);
    quick_sort(&mut vector,&|x, y| x < y);
    bubble_sort(&mut vector);
    /* */
    //heap sort
    let mut v = [4, 6, 8, 1, 0, 3, 2, 2, 9, 5];
    heap_sort(&mut v, |x, y| x < y);
    println!("{:?}", v);
}