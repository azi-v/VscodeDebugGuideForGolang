FROM golang:1.16

ENV APP_NAME VscodeDebugGuide
ENV HTTP_PORT 8080

COPY . /go/src/${APP_NAME}
WORKDIR /go/src/${APP_NAME}

RUN go env -w GO111MODULE=on
RUN go env -w GOPROXY=https://goproxy.cn,direct
RUN go get ./
RUN go build -o ${APP_NAME}
RUN go get -u github.com/go-delve/delve/cmd/dlv
RUN dlv version
# RUN dlv debug --headless --listen ":2345" --log --api-version 2

# CMD ./${APP_NAME}
CMD dlv exec ./${APP_NAME} --headless --listen ":2345" --log --api-version 2

EXPOSE ${HTTP_PORT}
EXPOSE 2345