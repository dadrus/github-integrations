package main

import (
	"fmt"

	"github.com/goccy/go-json"

	"github.com/dadrus/github-integrations/version"
)

func main() {
	fmt.Println("Current Version: ", version.Version) //nolint:forbidigo

	res, err := json.Marshal(map[string]any{"bar": "moo"})
	if err != nil {
		fmt.Println(err)
	}

	fmt.Println(string(res))
}
