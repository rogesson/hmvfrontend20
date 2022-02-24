FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs

WORKDIR /app
RUN gem install bundle
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app

EXPOSE 3000

