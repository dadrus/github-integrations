package main

import (
	"fmt"

	"github.com/dadrus/github-integrations/version"
)

func main() {
	fmt.Println("Current Version: ", version.Version)

	type Foo struct {
		Foo string `json:"foo" yaml:"foo_bar"`
		Bar string `json:"bar_foo" yaml:"bar"`
	}

	fmt.Println(Foo{Foo: "foo", Bar: "bar"})
}
