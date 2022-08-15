FROM golang:1.19.0-alpine3.16 as build
WORKDIR $GOPATH/src/app
COPY go.mod ./
COPY go.sum ./
COPY *.go ./
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -o /app/poc-chromedp ./*.go

FROM chromedp/headless-shell:latest
WORKDIR /app
COPY --from=build /app/poc-chromedp /app/poc-chromedp
COPY entrypoint.sh entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]