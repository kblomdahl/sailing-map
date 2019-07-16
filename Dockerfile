FROM ruby:2.5.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install && gem install foreman
COPY . /app

# Start the main process.
EXPOSE 5000
CMD ["foreman", "start"]
