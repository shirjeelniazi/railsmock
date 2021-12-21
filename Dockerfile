FROM ruby:3.0.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /railsmock
WORKDIR /railsmock

ADD Gemfile /railsmock/Gemfile
ADD Gemfile.lock /railsmock/Gemfile.lock

RUN bundle install

ADD . /railsmock
