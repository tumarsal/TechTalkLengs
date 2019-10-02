package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"os"
	"strconv"
	"time"
)

func printElapsed(elapsed time.Duration) {
	fmt.Println("Nanoseconds Duration:" + strconv.FormatInt(elapsed.Nanoseconds(), 10))
	fmt.Println("Microseconds Duration:", strconv.FormatInt(elapsed.Microseconds(), 10))
	fmt.Println("Milliseconds Duration:", strconv.FormatInt(elapsed.Milliseconds(), 10))
	fmt.Println("Seconds Duration:", elapsed)

}

type Person struct {
	Name   string   `json:"name"`
	Age    int      `json:"age"`
	Phones []string `json:"phones"`
}

func serialize(bird []Person) string {
	emp, _ := json.Marshal(bird)
	var mystr string = string(emp)
	return mystr
}
func check(e error) {
	if e != nil {
		panic(e)
	}
}
func generateData(dataCount int) []Person {
	persons := make([]Person, dataCount)
	for i := 0; i < dataCount; i++ {
		var ps = [2]string{"+44 1234567", "+44 2345678"}
		var person = Person{
			Name:   "John Doe",
			Age:    43,
			Phones: ps[:],
		}
		persons[i] = person
	}
	return persons
}
func deserealize(str string) []Person {

	//json.Unmarshal([]byte(myJsonString), &myStoredVariable)
	var persons []Person
	json.Unmarshal([]byte(str), &persons)
	return persons
}
func main() {
	dataCount := 1000
	persons := generateData(dataCount)
	start := time.Now()
	var res string
	for i := 0; i < dataCount; i++ {

		res = serialize(persons[:])

	}
	step1 := time.Now()
	elapsed := step1.Sub(start)
	fmt.Println("serealize")
	printElapsed(elapsed)
	f, err := os.OpenFile("./out.json", os.O_APPEND|os.O_WRONLY, 0600)
	check(err)
	w := bufio.NewWriter(f)
	_, err = w.WriteString(res)
	check(err)
	w.Flush()
	step1 = time.Now()
	persons2 := deserealize(res)
	step2 := time.Now()
	fmt.Println("deserealize")
	printElapsed(step2.Sub(step1))
	fmt.Printf("Species: %d", len(persons2))
}
