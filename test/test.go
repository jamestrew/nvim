package main

import "fmt"

func main() {
	fmt.Println("Hello World")
	stmt := `
	SELECT * FROM foobar;
	`
	stmt = `INSERT INTO foobar VALUES (1);`
	stmt = `UPDATE`
	not_a_stmt := `hello world`
}
