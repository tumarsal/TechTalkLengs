package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"math/rand"
	"os"
	"strconv"
	"strings"
	"time"
)

func printElapsed(elapsed time.Duration) {
	fmt.Println("Nanoseconds Duration:" + strconv.FormatInt(elapsed.Nanoseconds(), 10))
	fmt.Println("Microseconds Duration:", strconv.FormatInt(elapsed.Microseconds(), 10))
	fmt.Println("Milliseconds Duration:", strconv.FormatInt(elapsed.Milliseconds(), 10))
	fmt.Println("Seconds Duration:", elapsed)

}

//heapsort
func left(i int) int {
	return 2 * i
}

func right(i int) int {
	return 2*i + 1
}

func parent(i int) int {
	return i / 2
}

func maxHeapify(a []int, i int) []int {

	fmt.Printf("Array: %v\n", a)

	l := left(i) + 1
	r := right(i) + 1
	var largest int
	if l < len(a) && l >= 0 && a[l] > a[i] {
		largest = l
	} else {
		largest = i
	}
	if r < len(a) && r >= 0 && a[r] > a[largest] {
		largest = r
	}
	if largest != i {
		fmt.Printf("Exchanging: %d index (%d) with %d index (%d)\n", a[i], i, a[largest], largest)
		a[i], a[largest] = a[largest], a[i]
		a = maxHeapify(a, largest)
	}
	return a
}

func buildMaxHeap(a []int) []int {
	for i := len(a)/2 - 1; i >= 0; i-- {
		fmt.Printf("Building: %d index %d\n", a[i], i)
		a = maxHeapify(a, i)
	}
	return a
}

func heapsort(a []int) []int {

	a = buildMaxHeap(a)
	fmt.Printf("Starting sort ... array is %v\n", a)
	size := len(a)
	for i := size - 1; i >= 1; i-- {
		a[0], a[i] = a[i], a[0]
		size--
		maxHeapify(a[:size], 0)
	}
	return a
}

//qucksort
func quicksort(a []int) []int {
	if len(a) < 2 {
		return a
	}

	left, right := 0, len(a)-1

	pivot := rand.Int() % len(a)

	a[pivot], a[right] = a[right], a[pivot]

	for i, _ := range a {
		if a[i] < a[right] {
			a[left], a[i] = a[i], a[left]
			left++
		}
	}

	a[left], a[right] = a[right], a[left]

	quicksort(a[:left])
	quicksort(a[left+1:])

	return a
}

//Пузырек
func sort(x []int) {
	l := len(x) - 1
	for i := 0; i < l; i++ {
		if x[i] > x[i+1] {
			tmp := x[i]
			x[i] = x[i+1]
			x[i+1] = tmp
			i = -1
		}
	}
}
func cloneArray(x []int) []int {
	xlen := len(x)
	y := make([]int, xlen)
	copy(y[:], x)
	return y
}

func deserealise(str string) ([]int, error) {
	var ints []string
	json.Unmarshal([]byte(str), &ints)
	ia := make([]int, len(ints))
	for i := 0; i < len(ints); i++ {
		ival, _ := strconv.ParseInt(ints[i], 10, 32)
		ia[i] = int(ival)
	}
	return ia, nil
}
func deserealise2(str string) ([]int, error) {
	strlen := len(str)
	var substr = str[1 : strlen-1]
	var ints = strings.Split(substr, ",")
	ia := make([]int, len(ints))
	for i := 0; i < len(ints); i++ {
		ival, _ := strconv.ParseInt(ints[i], 10, 32)
		ia[i] = int(ival)
	}
	return ia, nil
}
func main() {
	file, err := os.Open("./input.json")
	if err != nil {
		fmt.Println(err)
	}
	b, err := ioutil.ReadAll(file)
	if err != nil {
		fmt.Println(err)
	}
	s := string(b)
	ints, err := deserealise2(s)
	var data [900000][]int
	for i := 0; i < 1000; i++ {
		data[i] = cloneArray(ints)
	}
	//fmt.Println(data)
	//fmt.Println(ints)
	start := time.Now()
	for i := 0; i < 900000; i++ {
		sort(ints)

	}
	//time.Sleep(2 * time.Second)
	end := time.Now()
	elapsed := end.Sub(start)
	//var nanoseconds int64 = elapsed.Nanoseconds()
	//dur := strconv.FormatInt(nanoseconds, 10)
	printElapsed(elapsed)
	fmt.Println(ints)
	//fmt.Println(len(b))
}
