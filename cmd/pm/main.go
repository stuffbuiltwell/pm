package main

import (
	"flag"
	"log"
	"net/http"
	"strconv"

	"github.com/go-chi/chi"
)

func main() {
	port := flag.Int("port", 3000, "port to listen on")
	static := flag.String("static", "static", "path to folder containing static assets")
	flag.Parse()

	r := chi.NewRouter()
	r.Get("/*", http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		http.FileServer(http.Dir(*static)).ServeHTTP(w, r)
	}))

	log.Printf("Listening on port %d", *port)
	http.ListenAndServe(":"+strconv.Itoa(*port), r)
}
