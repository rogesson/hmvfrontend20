FROM ruby:2.5.8
RUN apt-get update -qq && apt-get install -y nodejs

WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN gem install bundle && bundle install
COPY . /app

EXPOSE 3000
