package main

import (
	"fmt"
	"hash/crc32"
	"reflect"
)

func crc(message []byte, table [256]uint32) uint32 {
	crc := uint32(0xffffffff)
	for _, v := range message {
		crc = table[byte(crc)^v] ^ (crc >> 8)
	}
	return ^crc
}

func main() {
	var ieeeTable = [256]uint32(*crc32.IEEETable)
	var message = []byte("hello")
	fmt.Println("{}",2^3)
	if reflect.DeepEqual(crc32.Checksum(message, crc32.IEEETable), crc(message, ieeeTable)) {
		fmt.Println("OK")
	} else {
		fmt.Println("NOT OK")
	}
}
