package main

import (
	"fmt"
	"maps"

	"github.com/goccy/go-json"
)

var Version = "just test 18"

func main() {
	fmt.Println("Current Version: ", Version)

	raw, _ := json.Marshal(map[string]string{"Foo": "Bar"})
	fmt.Println("json: ", string(raw))

	maps.Equal(map[string]string{"Foo": "Bar"}, map[string]string{"Foo": "Bar"})
}
