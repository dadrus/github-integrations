package main

import (
	"context"
	"fmt"

	"github.com/dadrus/github-integrations/version"
)

func Foo(ctx context.Context) error {
	return nil
}

func main() {

	fmt.Println("Current Version: ", version.Version) //nolint:forbidigo

	fmt.Println(Foo(context.TODO()))

}
