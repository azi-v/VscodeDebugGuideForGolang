package main

import (
	"io"
	"log"
	"net/http"
	"os"
	"strconv"
)

func main() {
	// Hello world, the web server
	port := os.Getenv("PORT")
    if port == "" {
        port = "8080"
    }

	helloHandler := func(w http.ResponseWriter, req *http.Request) {
		log.Println("我要开始debug了")
		a := 10
		a += 20
		io.WriteString(os.Stdout, strconv.FormatInt(int64(a), 10))
		io.WriteString(w, "Hello, world!\n")
	}

	http.HandleFunc("/hello", helloHandler)
	log.Fatal(http.ListenAndServe(":"+port, nil))
}