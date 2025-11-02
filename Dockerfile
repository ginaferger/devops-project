FROM python:3.13-slim

WORKDIR /helloapp
COPY . /helloapp
RUN ./build.sh

EXPOSE 8080

CMD ["./run.sh"]