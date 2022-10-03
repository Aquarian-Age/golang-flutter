package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"net/http"
	"time"

	"github.com/Aquarian-Age/xa/pkg/gz"
)

const layout = "2006-01-02 15:04:05"
const layoutMin = "2006-01-02 15:04"

// 客户端page_jqh页面数据处理
// flutter: {"cliJqh":{"times":"2022-10-01 23:08:00","stargn":8,"doorgn":2}}
type ClientJqh struct {
	ClientData ClientData `json:"cliJqh"`
}

// 获取客户端时间 并返回Info Gzs的值到客户端
type ClientData struct {
	Times  string `json:"times"` // 客户端时间
	Stargn int    `json:"stargn"`
	Doorgn int    `json:"doorgn"`
	tx     time.Time
}

func main() {
	http.HandleFunc("/", routeHome)
	http.HandleFunc("/info", routeInfo)
	http.HandleFunc("/jqh", routeJqh)
	fmt.Println("serve @ localhost:6714")
	err := http.ListenAndServe(":6714", nil)
	if err != nil {
		log.Println(err)
	}
}
func routeHome(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case "GET":
		fmt.Printf("Method:%v\n", r.Method)
	case "POST":
		fmt.Printf("Method:%v\n", r.Method)
	}
}

// 处理客户端传来的数据
func newClientData(w http.ResponseWriter, r *http.Request) (*ClientData, error) {
	switch r.URL.Path {
	case "/info":
		var clientData ClientData
		err := json.NewDecoder(r.Body).Decode(&clientData)
		if err != nil {
			http.Error(w, err.Error(), http.StatusBadRequest)
		}
		fmt.Printf("%s cliData: %+v\n", r.URL.Path, clientData)
		// clientData:  2022-09-29 11:26:25 len(19) 初始时间
		// clientData:  2022-09-30 11:26 len(16) 选择时间
		// 返回到客户端
		var tx time.Time
		if len(clientData.Times) == 19 {
			tx, err = time.Parse(layout, clientData.Times)
			if err != nil {
				tx = time.Now().Local()
			}
		} else {
			tx, err = time.Parse(layoutMin, clientData.Times)
			if err != nil {
				tx = time.Now().Local()
			}
		}
		return &ClientData{
			Times: tx.Format(layoutMin),
			tx:    tx,
		}, nil
	case "/jqh":
		var cliJqh ClientJqh
		err := json.NewDecoder(r.Body).Decode(&cliJqh)
		if err != nil {
			http.Error(w, err.Error(), http.StatusBadRequest)
		}
		fmt.Printf("%s cliJqh: %v\ntimes: %v stargn: %d doorgn: %d\n", r.URL.Path,
			cliJqh, cliJqh.ClientData.Times, cliJqh.ClientData.Stargn, cliJqh.ClientData.Doorgn)

		var tx time.Time
		if len(cliJqh.ClientData.Times) == 19 {
			tx, err = time.Parse(layout, cliJqh.ClientData.Times)
			if err != nil {
				tx = time.Now().Local()
			}
		} else {
			tx, err = time.Parse(layoutMin, cliJqh.ClientData.Times)
			if err != nil {
				tx = time.Now().Local()
			}
		}
		sgn, dgn := cliJqh.ClientData.Stargn, cliJqh.ClientData.Doorgn

		return &ClientData{
			Times:  tx.Format(layoutMin),
			tx:     tx,
			Stargn: sgn,
			Doorgn: dgn,
		}, nil
	}
	return &ClientData{}, errors.New("ClientData Error")
}

// 返回到客户端的数据
type InfoData struct {
	//Times string `json:"times"`
	Info string `json:"info"`
}

// route info
func routeInfo(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case "GET":
		fmt.Printf("routeInfo Method:%v\n", r.Method)
	case "POST":
		fmt.Printf("route to Info Method:%v\n", r.Method)
		clid, err := newClientData(w, r)
		if err != nil {
			log.Println(err)
		}
		clid.respInfo(w)
	}
}
func (clid *ClientData) respInfo(w http.ResponseWriter) {
	var infoData InfoData
	tx := clid.tx
	gzo := gz.NewTMGanZhi(tx.Year(), int(tx.Month()), tx.Day(), tx.Hour(), tx.Minute())
	info := gzo.Info()
	//infoData.Times = clid.Times
	infoData.Info = info.String()
	json.NewEncoder(w).Encode(infoData)
}

// route jqh
func routeJqh(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case "GET":
		fmt.Printf("Route: %s Mehtod: %v\n", r.URL.Path, r.Method)
		tx := time.Now().Local()
		jqho := newJqh(tx, 0, 0)
		bo := jqho.Body()
		w.Header().Set("content-type", "application/json; charset=utf-8")
		json.NewEncoder(w).Encode(bo)
	case "POST":
		fmt.Printf("route to Jqh Method: %v\n", r.Method)
		clid, err := newClientData(w, r)
		if err != nil {
			log.Println(err)
		}
		clid.respJqh(w)
	}
}
func (clid *ClientData) respJqh(w http.ResponseWriter) {
	tx := clid.tx
	stargn := clid.Stargn
	doorgn := clid.Doorgn

	jqho := newJqh(tx, stargn, doorgn)
	bo := jqho.Body()
	json.NewEncoder(w).Encode(bo)

}
