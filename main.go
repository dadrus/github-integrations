package main

import (
	"fmt"

	"github.com/dadrus/github-integrations/version"
)

func main() {
	fmt.Println("Current Version: ", version.Version)
}
