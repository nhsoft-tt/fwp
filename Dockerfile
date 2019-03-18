FROM ruby:2.5.1-alpine
RUN \
  apk update && \
  apk --no-cache add --update build-base mysql-dev nodejs tzdata ruby-nokogiri && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/apk/*
# FROM ruby:2.5.1

# RUN apt-get update -qq && \
#   apt-get install -y build-essential \
#   default-libmysqlclient-dev \
#   nodejs 

RUN mkdir /webapp

WORKDIR /webapp

ADD Gemfile /webapp/Gemfile

ADD Gemfile.lock /webapp/Gemfile.lock

RUN gem install nokogiri -v '1.10.1' \
  nio4r -v '2.3.1' \
  websocket-driver -v '0.7.0' \
  bindex -v '0.5.0'

RUN bundle install

ADD . /webapp

# RUN bundle exec rake assets:precompile

RUN mkdir -p tmp/sockets