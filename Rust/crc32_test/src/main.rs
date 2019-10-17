
use crc::{crc32, Hasher32};
use crc::crc32::make_table;
fn main() {
    println!("Hello, world!");

    let table = make_table(crc32::IEEE);
    let bytes:Vec<u8> = vec![];
    //let bytes = b"123456789".as_bytes();
    let mut value =  0u32;
    value = bytes.iter().fold(value, |acc, &x| {
                (acc << 8) ^ (table[((u32::from(x)) ^ (acc >> 24)) as usize])
            });
    println!("{}", value);
    let mut digest = crc32::Digest::new(crc32::IEEE);
    digest.write(b"123456789");
    assert_eq!(digest.sum32(), 0xcbf43926);

}
