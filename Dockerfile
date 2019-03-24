# FROM ruby:2.5.1-alpine
# RUN \
#   apk update && \
#   apk --no-cache add --update build-base mysql-dev nodejs tzdata ruby-nokogiri && \
#   rm -rf /var/lib/apt/lists/* && \
#   rm -rf /var/cache/apk/*
# FROM ruby:2.5.1

# RUN apt-get update -qq && \
#   apt-get install -y build-essential \
#   default-libmysqlclient-dev \
#   nodejs 

FROM ubuntu:16.04

RUN apt-get update && apt-get install -y curl apt-transport-https && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  ruby -v '2.5.1' \
  ruby-dev \
  tzdata \
  yarn \
  zlib1g-dev

RUN mkdir /webapp

WORKDIR /webapp

COPY Gemfile /webapp/Gemfile

COPY Gemfile.lock /webapp/Gemfile.lock

RUN gem source -a https://gems.ruby-china.com --remove https://rubygems.org/

RUN gem install bundler

RUN gem install sassc -v '2.0.1'

# RUN gem install nokogiri -v '1.10.1' && \
#   gem install mysql2 -v '0.5.2' && \
#   gem install nio4r -v '2.3.1' && \
#   gem install websocket-driver -v '0.7.0' && \
#   gem install bindex -v '0.5.0' && \
#   gem install ffi -v '1.10.0' && \
#   gem install sassc -v '2.0.1' && \
#   gem install byebug -v '11.0.0' && \
#   gem install puma -v '3.12.0'

RUN bundle install

COPY . /webapp

RUN bundle exec rake RAILS_ENV=$RAILS_ENV DATABASE_URL=mysql://$MYSQL_USER:$MYSQL_PASSWORD@$MYSQL_HOST/$MYSQL_DATABASE assets:precompile
# RUN bundle exec rake assets:precompile

RUN mkdir -p tmp/sockets