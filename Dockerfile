# FROM ruby:2.5.1-alpine
# RUN \
#   apk update && \
#   apk --no-cache add --update build-base mysql-dev nodejs tzdata ruby-nokogiri && \
#   rm -rf /var/lib/apt/lists/* && \
#   rm -rf /var/cache/apk/*
FROM ruby:2.5.1

RUN apt-get update -qq && \
  apt-get install -y build-essential \
  default-libmysqlclient-dev \
  nodejs 

RUN mkdir /webapp
WORKDIR /webapp

ADD Gemfile /webapp/Gemfile
# ADD Gemfile.lock /webapp/Gemfile.lock

RUN bundle install

ADD . /webapp

# RUN bundle exec rake assets:precompile

RUN mkdir -p tmp/sockets