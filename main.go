package main

import (
	"fmt"

	"github.com/goccy/go-json"
)

var Version = "just test 17"

func main() {
	fmt.Println("Current Version: ", Version)

	raw, _ := json.Marshal(map[string]string{"Foo": "Bar"})
	fmt.Println("json: ", string(raw))
}
