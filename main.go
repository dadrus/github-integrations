package main

import (
	"context"
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

	foo := fmt.Sprintf("%s/bar", "foo")
	fmt.Println(foo)

	Test(context.TODO())
}

func Test(ctx context.Context) error {
	return nil
}
