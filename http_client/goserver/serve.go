package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"time"

	"github.com/Aquarian-Age/xa/pkg/gz"
)

const layout = "2006-01-02 15:04:05"

var t = time.Now().Local()

// 处理客户端传来的times数据 并返回info到客户端
type ClientData struct {
	Times string `json:"times"`
	Info  string `json:"info"`
}

func main() {
	//http.HandleFunc("/", home)
	http.HandleFunc("/info", info)
	fmt.Println("serve @ 0.0.0.0:6900")
	err := http.ListenAndServe("192.168.199.215:6900", nil)
	if err != nil {
		log.Println(err)
	}
}

func info(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case "GET":
		fmt.Printf("%s %s\n", r.URL.Path, r.Method)
		// d := time.Duration(time.Second * 1) //三分钟
		// timer := time.NewTimer(d)
		// for {
		// 	timer.Reset(d)
		// 	select {
		// 	case tx := <-timer.C:
		// 		fmt.Println(t.String())
		// 		t = tx
		// 		w.Header().Set("content-type", "application/json; charset=utf-8")
		// 		var clientData ClientData
		// 		clientData.Times = t.Format(layout)
		// 		clientData.Info = "infos"
		// 		json.NewEncoder(w).Encode(clientData)
		// 	}
		// }
		//fmt.Println("t:", t.String())

		gzo := gz.NewTMGanZhi(t.Year(), int(t.Month()), t.Day(), t.Hour(), t.Minute())
		info := gzo.Info()
		infos := info.String()

		w.Header().Set("content-type", "application/json; charset=utf-8")

		var clientData ClientData
		clientData.Times = t.Format(layout)
		clientData.Info = infos
		json.NewEncoder(w).Encode(clientData)
	//fmt.Println("info---> ", string(b))
	case "POST":
		var clientData ClientData
		err := json.NewDecoder(r.Body).Decode(&clientData)
		if err != nil {
			http.Error(w, err.Error(), http.StatusBadRequest)

		}
		fmt.Printf("clientData.Times:  %v\n", clientData.Times)
		//返回到客户端
		tx, err := time.Parse(layout, clientData.Times)
		if err != nil {
			tx = t
		}
		gzo := gz.NewTMGanZhi(tx.Year(), int(tx.Month()), tx.Day(), tx.Hour(), tx.Minute())
		info := gzo.Info()
		clientData.Info = info.String()
		json.NewEncoder(w).Encode(clientData)
	}
}
