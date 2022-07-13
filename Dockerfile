FROM golang:1.19-rc-alpine as build

WORKDIR /app

COPY main.go .

ENV CGO_ENABLED=0

ENV GOOS=linux
ENV GO111MODULE=off

RUN go build -ldflags '-w -s' -a -installsuffix cgo -o codeeducationrocks

FROM scratch as run

COPY --from=build /app .

ENTRYPOINT ["./codeeducationrocks"]