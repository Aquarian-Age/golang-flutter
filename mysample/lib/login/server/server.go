package main

import (
	"encoding/json"
	"log"
	"net/http"
	"strings"
)

func main() {
	http.HandleFunc("/login", login)
	http.ListenAndServe(":8989", nil)
}

type Input struct {
	Login string `json:"login"`
	Auth  bool   `json:"auth"`
}

func login(w http.ResponseWriter, r *http.Request) {
	var input Input
	// body, err := ioutil.ReadAll(r.Body)
	// if err != nil {
	// 	log.Println(err)
	// }
	// println(string(body))
	// err = json.Unmarshal(body, &input)
	// if err != nil {
	// 	log.Println(err)
	// }

	err := json.NewDecoder(r.Body).Decode(&input)
	if err != nil {
		log.Println(err)
	}
	println(input.Login)
	//resp
	w.Header().Set("content-type", "application/json; charset=utf-8")
	if strings.EqualFold(input.Login, "admin1234") ||
		strings.EqualFold(input.Login, "admin") ||
		strings.EqualFold(input.Login, "1234") {
		input.Auth = true
		json.NewEncoder(w).Encode(&input)
	} else {
		input.Auth = false
		json.NewEncoder(w).Encode(&input)
	}

}
