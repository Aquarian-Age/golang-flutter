package main

import (
	"encoding/json"
	"fmt"
	"log"
	"os"
	"time"
	"unsafe"
)

// #include <stdio.h>
// #include <stdlib.h>
import "C"

const layout = "2006-01-02 15:04:05"

// go build -o libgets.so -buildmode=c-shared main.go
func main() {
}

//export DartGoType
func DartGoType(str *C.char) *C.char {

	file, err := os.Create("./golib/message.txt")
	if err != nil {
		panic(err)
	}
	defer file.Close()
	if _, err := file.WriteString(fmt.Sprint(C.GoString(str))); err != nil {
		panic(err)
	}
	//
	gostr := "form dartDate:" + C.GoString(str)
	defer C.free(unsafe.Pointer(C.CString(gostr)))
	return C.CString(gostr)
}

//export GetDate
func GetDate(times *C.char, star, door int) *C.char {
	tx, err := time.Parse(layout, C.GoString(times))
	if err != nil {
		log.Println(err)
	}
	txs := tx.String()
	txs = fmt.Sprintf("%s star:%d door:%d", txs, star, door)
	defer C.free(unsafe.Pointer(C.CString(txs)))
	return C.CString(txs)
}

//export add
func add(a, b, c int) int {
	return a + b + c
}

//export gets
func gets() *C.char {
	days := day_week()

	//s := "test  go string to c *char " + days
	s := days
	defer C.free(unsafe.Pointer(C.CString(s)))
	return C.CString(s)
}
func day_week() string {
	group := &Group{
		Id:   "group id",
		Name: "group name",
		Time: time.Now().Local().String(),
	}
	b, err := json.Marshal(group)
	if err != nil {
		log.Println(err)
	}

	return string(b)
}

type Group struct {
	Id   string `json:"id"`
	Name string `json:"name"`
	Time string `json:"time"`
}
