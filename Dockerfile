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

FROM ruby:2.5.1-slim

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
    echo "deb http://mirrors.163.com/debian/ jessie main non-free contrib" >/etc/apt/sources.list && \
    echo "deb http://mirrors.163.com/debian/ jessie-proposed-updates main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/debian/ jessie main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/debian/ jessie-proposed-updates main non-free contrib" >>/etc/apt/sources.list

RUN apt-get update -qq && \
    apt-get install -y build-essential \
    default-libmysqlclient-dev \
    nodejs 

RUN mkdir /webapp

WORKDIR /webapp

COPY Gemfile /webapp/Gemfile

COPY Gemfile.lock /webapp/Gemfile.lock

RUN gem source -a https://gems.ruby-china.com --remove https://rubygems.org/

RUN gem install bundler

RUN bundle install

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