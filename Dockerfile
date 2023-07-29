FROM alpine:latest


RUN apk add firefox

CMD ["firefox"]