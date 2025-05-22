package main

import (
    "fmt"
    "net/http"
)

func sayHello(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Hello World! v2")
}

func main() {
    http.HandleFunc("/", sayHello)
    fmt.Println("Starting...")
    http.ListenAndServe(":8080", nil)
}

