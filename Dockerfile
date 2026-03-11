FROM golang:1.22.5 as base

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o main .

#Final Stage - Distroless image
FROM gcr.io/distroless/base

#Copy the binary main from /app dir to curr dir. base is the alias of above stage
COPY --from=base /app/main . 

COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["./main"]