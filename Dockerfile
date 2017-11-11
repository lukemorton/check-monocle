FROM ruby:2.4-alpine

RUN apk update && apk add g++ make libxml2-dev
