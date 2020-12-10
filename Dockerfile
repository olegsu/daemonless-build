FROM alpine:3.12

RUN echo "hello world" > /hello

ENTRYPOINT [ "cat" ]
CMD [ "/hello" ]