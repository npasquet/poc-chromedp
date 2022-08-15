package main

import (
	"context"
	"fmt"
	"log"
)
import "github.com/chromedp/chromedp"

func main() {
	ctx, cancel := chromedp.NewContext(context.Background())
	defer cancel()

	url := "https://www.goodreads.com"
	var data string

	if err := chromedp.Run(ctx,

		chromedp.Navigate(url),
		chromedp.OuterHTML("html", &data, chromedp.ByQuery),
	); err != nil {

		log.Fatal(err)
	}

	fmt.Println(data)
}
